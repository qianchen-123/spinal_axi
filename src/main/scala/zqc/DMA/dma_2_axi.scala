package zqc.DMA

import spinal.core.{Vec, _}
import spinal.lib._
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config}

case class dma_2_axi(axi_config:Axi4Config,dmaInfConfig_w:dmaInfBundleConfig,
                     dmaInfConfig_r_1:dmaInfBundleConfig,dmaInfConfig_r_2:dmaInfBundleConfig,
                      cfg_cfg : dma_cfg_bundle_Config,status_cfg:dma_status_bundle_Config) extends Component{
  val io = new Bundle{
    //--- cfg regs
    val cfg = slave(dma_cfg_bundle(cfg_cfg))

    //---dma status
    val dma = slave(dma_status_bundle(status_cfg))

    //--- buffer status
    val buf_buf_word = in(UInt(6 bits))
    val buf_empty_word = in(UInt(6 bits))

    //--- DMA write inf
    val dma_inf_w = slave(DMA_inf_bundle(dmaInfConfig_w))
    //--- DMA read inf_0
    val dma_inf_r_1 = slave(DMA_inf_bundle(dmaInfConfig_r_1))


    //--- DMA read inf_1
    val dma_inf_r_2 = slave(DMA_inf_bundle(dmaInfConfig_r_2))

    //-- AXI master inf
    val axi = master(Axi4(axi_config))

    //--- Global Signal
    val clk = in Bool()
    val rstn = in Bool()
  }


  val clkDomain = ClockDomain(clock = io.clk,
    reset = io.rstn,
    config = ClockDomainConfig(
      clockEdge = RISING,
      resetKind = ASYNC,
      resetActiveLevel = LOW
    )
  )

  val myArea = new ClockingArea(clkDomain) {

    val WCMD_THRES = U"6'd12"

    val dmaw_2_axi = new Area {
      //--- 1: dma req arbt and change to AXI burst transfer
      //--- check for 4kB boundary
      val s_idle = 0
      val s_arbt = 1
      val s_cmd0 = 2
      val s_cmd1 = 3
      val sta = Reg(UInt(2 bits)) init(s_idle)

      val gnt0, gnt1, gnt2, gnt3 = Bool()
      val gnt = Vec(gnt0, gnt1, gnt2, gnt3).asBits.asUInt
      val gnt_id = UInt(2 bits)
      val mux_addr = UInt(32 bits)
//      mux_addr := 0
      val cmd0_addr = Reg(UInt(32 bits)) init(0)
      val cmd0_len = Reg(UInt(12 bits)) init(0)
      val cmd1_addr = Reg(UInt(32 bits)) init(0)
      val cmd1_len = Reg(UInt(16 bits)) init(0)
      val cross_4kb = Reg(Bool()) init(False)

      val cur_bt_byte = UInt(6 bits)
      cur_bt_byte := 0
      val bt_cmd_ack = Bool()

      val dma_w_req_w = io.dma_inf_w.w_req & (sta === s_idle) & (!io.cfg.dma_halt)
      io.dma_inf_w.w_ack := gnt(2).asBits.asBool

      val cur_addr = (sta === s_cmd0) ? cmd0_addr | cmd1_addr
      val cur_len = (sta === s_cmd0) ? Vec(U"4'h0", cmd0_len).asBits.asUInt | cmd1_len
      val nxt_bt_addr = cur_addr + cur_bt_byte + 3
      val nxt_bt_len = Vec(U"1'b0", cur_len).asBits.asUInt - Vec(U"11'h0", cur_bt_byte).asBits.asUInt - 1

      val bt_cmd_req = (sta === s_cmd0) | (sta === s_cmd1)
      val send_bt_cmd = bt_cmd_req & bt_cmd_ack

      //--- keep it as read channel, can support multi-channel DMA later
      val arbt = new strict_round_arbt
      False <> arbt.io.req0
      True <> arbt.io.req1
      dma_w_req_w <> arbt.io.req2
      False <> arbt.io.req3

      gnt0 <> arbt.io.gnt0
      gnt1 <> arbt.io.gnt1
      gnt2 <> arbt.io.gnt2
      gnt3 <> arbt.io.gnt3
      gnt_id <> arbt.io.gnt_id
      io.clk <> arbt.io.clk
      io.rstn <> arbt.io.rstn


      val trans_go = dma_w_req_w
      val mux_len = io.dma_inf_w.w_len

      switch(sta) {
        is(s_idle, s_arbt) {
          mux_addr := io.dma_inf_w.w_addr
        }
        is(s_cmd0) {
          mux_addr := cmd0_addr
        }
        default {
          mux_addr := cmd1_addr
        }
      }

      when(mux_addr(0, 2 bits) =/= 0) {
        when(cur_len(5, 11 bits) =/= 0) {
          cur_bt_byte := U"6'd32" - mux_addr(0, 2 bits) - 1
        } otherwise {
          cur_bt_byte := cur_len(5 downto 0)
        }
      } otherwise {
        when(cur_len(6, 10 bits) =/= 0) {
          cur_bt_byte := U"6'd63"
        } otherwise {
          cur_bt_byte := cur_len(5 downto 0)
        }
      }

      val addr_low_addr = Vec(U"1'b0", mux_addr(0, 12 bits)).asBits.asUInt + Vec(U"1'b0", mux_len(0, 12 bits)).asBits.asUInt
      val cross_4kb_w = addr_low_addr(12).asBits.asBool | (mux_len(12, 4 bits) =/= 0)
      val cmd0_len_cross = U"17'd4096" - Vec(U"5'b0", mux_addr(0, 12 bits)).asBits.asUInt - 1
      val cmd1_len_w = UInt(17 bits)
      cmd1_len_w := Vec(U"1'b0", mux_len).asBits.asUInt - Vec(U"5'h0", cmd0_len_cross(0, 12 bits)).asBits.asUInt - 1
      val cmd1_addr_h = mux_addr(12, 20 bits) + 1

      val dma_end_bloc = mux_addr(0, 2 bits) + mux_len(0, 2 bits) + 1


      when(sta === s_arbt) {
        cross_4kb := cross_4kb_w
      }



      switch(sta) {
        is(s_idle) {
          when(trans_go) {
            sta := s_arbt
          }
        }
        is(s_arbt) {
          sta := s_cmd0
        }
        is(s_cmd0) {
          when(send_bt_cmd) {
            when(nxt_bt_addr(16).asBits.asBool) {
              when(cross_4kb) {
                sta := s_cmd1
              } otherwise {
                sta := s_idle
              }
            } otherwise {
              sta := s_cmd0
            }
          }
        }
        is(s_cmd1) {
          when(send_bt_cmd) {
            when(nxt_bt_len(16).asBits.asBool) {
              sta := s_idle
            } otherwise {
              sta := s_cmd1
            }
          }
        }
      }



      when(sta === s_arbt) {
        cmd0_addr := mux_addr
        cmd0_len := (cross_4kb_w) ? cmd0_len_cross(11 downto 0).asBits.asUInt | mux_len(11 downto 0)
      } otherwise {
        when((sta === s_cmd0) && send_bt_cmd) {
          cmd0_addr := Vec(U"2'h0",nxt_bt_addr(31 downto 2)).asBits.asUInt
          cmd0_len := nxt_bt_len(11 downto 0)
        }
      }



      when((sta === s_arbt) && cross_4kb_w) {
        cmd1_addr := Vec(U"12'h0",cmd1_addr_h).asBits.asUInt
        cmd1_len := cmd1_len_w(15 downto 0)
      } otherwise {
        when((sta === s_arbt) && send_bt_cmd) {
          cmd1_addr := Vec(U"2'h0",nxt_bt_addr(31 downto 2)).asBits.asUInt
          cmd1_len := Vec(nxt_bt_len(15 downto 0)).asBits.asUInt
        }
      }


      //--- 2: change burst cmd to AXI inf burst cmd ---//
      val axi_idle = 0
      val axi_cmd = 1
      val axi_wd = 2
      val axi_sta = Reg(UInt(2 bits)) init(axi_idle)

      val axi_wr = Bool()
      val axi_w_ch = Reg(Bool()) init(False)
      val axi_addr = Reg(UInt(32 bits)) init(0)
      val axi_len_w = UInt(11 bits)
      val axi_len = Reg(UInt(4 bits)) init(0)
      val axi_d_send = Bool()
      val axi_cmd_go = Bool()

      val bnum_sub_thres = UInt(6 bits)
      val bnum_sub_len = UInt(6 bits)

      axi_wr := True
      bt_cmd_ack := (axi_sta === axi_idle)
      axi_len_w := nxt_bt_addr(2, 11 bits) - Vec(U"1'b0", cur_addr(2, 10 bits)).asBits.asUInt
      axi_d_send := io.axi.w.valid & io.axi.w.ready


      switch(axi_sta) {
        is(axi_idle) {
          when(bt_cmd_req) {
            axi_sta := axi_cmd
            axi_len := axi_len_w(3 downto 0)
            axi_addr := Vec(U"2'h0",cur_addr(31 downto (2))).asBits.asUInt
            axi_w_ch := False
          }
        }
        is(axi_cmd) {
          when(io.axi.aw.fire) {
            axi_sta := axi_wd
          }
        }
        is(axi_wd) {
          when(axi_d_send) {
            when(axi_len === 0) {
              axi_sta := axi_idle
            } otherwise {
              axi_sta := axi_wd
              axi_len := axi_len - 1
            }
          }
        }
        default {
          axi_sta := axi_idle
        }
      }


      bnum_sub_thres := Vec(U"1'b0", io.buf_buf_word(4 downto 0)).asBits.asUInt - WCMD_THRES
      bnum_sub_len := Vec(U"1'b0", io.buf_buf_word(4 downto 0)).asBits.asUInt - Vec(U"1'b0", axi_len(3 downto 0)).asBits.asUInt
      axi_cmd_go := (!bnum_sub_thres(5).asBits.asBool) | (!bnum_sub_len(5).asBits.asBool)
      io.axi.aw.valid := (axi_sta === axi_cmd) & axi_wr & axi_cmd_go

      io.axi.aw.id := Vec(U"3'h0", axi_w_ch.asUInt).asBits.asUInt
      io.axi.aw.addr := axi_addr
      io.axi.aw.len := axi_len.resize(8)
      io.axi.aw.size := U"3'h2"
      io.axi.aw.burst := B"2'b1"
      io.axi.aw.lock := B"1'b0"
      io.axi.aw.cache := Vec(U"2'b00", io.cfg.cf.asUInt, io.cfg.bf.asUInt).asBits
      io.axi.aw.prot := B"3'b010"

      io.axi.w.data := io.dma_inf_w.wdata
      io.axi.w.strb := io.dma_inf_w.wbe.asBits
      io.axi.w.last := (axi_len === 0)
      io.axi.w.valid := io.dma_inf_w.w_dvld & (!io.cfg.dma_halt)
      io.dma_inf_w.w_dack := io.axi.w.ready

      io.axi.b.ready := True


    }

    val dmar_2_axi = new Area {

      val RCMD_THRES = U"6'd8"

      //---1 : dma req arbt and change to AXI burst transfer
      //--- check for 4KB boundary

      val s_idle = 0
      val s_arbt = 1
      val s_cmd0 = 2
      val s_cmd1 = 3
      val s_d_end = 4
      val sta = Reg(UInt(3 bits)) init (s_idle)


      val dma_r_req0_w = Bool()
      val dma_r_req1_w = Bool()
      val trans_go = Bool()
      val gnt_id = UInt(2 bits)
      val gnt0, gnt1, gnt2, gnt3 = Bool()
      val gnt = Vec(gnt3,gnt2,gnt1,gnt0).asBits
      val mux_addr = UInt(32 bits)
//      mux_addr := 0
      val mux_len = UInt(16 bits)
      mux_len := 0
      val dma_byte_remain = Reg(UInt(16 bits)) init (0)
      val nxt_byte_remain = SInt(17 bits)
      nxt_byte_remain := 0
      val dma_rbe = UInt(4 bits)
      dma_rbe := 0
      val cmd0_addr = Reg(UInt(32 bits)) init (0)
      val cmd0_len = Reg(UInt(12 bits)) init (0)
      val cmd1_addr = Reg(UInt(32 bits)) init (0)
      val cmd1_len = Reg(UInt(16 bits)) init (0)
      val addr_low_add = UInt(13 bits)

      val cross_4kb_w = Bool()
      val cross_4kb = Reg(Bool) init(False)
      val cmd0_len_cross = UInt(17 bits)
      val cmd1_len_w = UInt(17 bits)
      val cmd1_addr_h = UInt(20 bits)

      val cur_addr = UInt(32 bits)
      val cur_len = UInt(16 bits)
      val cur_bt_byte = UInt(6 bits)
      cur_bt_byte := 0

      val nxt_bt_addr = UInt(32 bits)
      val nxt_bt_len = SInt(17 bits)
      val bt_cmd_req = Bool()
      val buf_empty_sub_thres = SInt(7 bits)
      val buf_has_space = Bool()
      val bt_cmd_ack = Bool()
      val send_bt_cmd = Bool()

      val dma_end_block = UInt(2 bits)
      val dma_r_fir_be = Reg(UInt(4 bits)) init (0)
      val dma_r_last_be = Reg(UInt(4 bits)) init (0)
      val last_vld_byte = Reg(UInt(2 bits)) init (0)

      val ch0_d_trans = Bool()
      val ch1_d_trans = Bool()
      val dma_d_trans = Bool()
      val last_rdata = Bool()
      val first_d_flag = Reg(Bool()) init (True)
      val first_vld_byte = Reg(UInt(3 bits)) init (0)

      dma_r_req0_w := io.dma_inf_r_1.r_req & (sta === s_idle) & (!io.cfg.dma_halt)
      dma_r_req1_w := io.dma_inf_r_2.r_req & (sta === s_idle) & (!io.cfg.dma_halt)

      io.dma_inf_r_1.r_ack := gnt(0).asBits.asBool
      io.dma_inf_r_2.r_ack := gnt(1).asBits.asBool

      cur_addr := (sta === s_cmd0) ? cmd0_addr | cmd1_addr
      cur_len := (sta === s_cmd0) ? Vec( cmd0_len,U"4'h0").asBits.asUInt | cmd1_len
      nxt_bt_addr := cur_addr + cur_bt_byte + 3
      nxt_bt_len := Vec(cur_len,U"1'b0").asBits.asSInt - Vec( cur_bt_byte,U"11'h0").asBits.asSInt - 1

      buf_empty_sub_thres := Vec(io.buf_empty_word,U"1'b0").asBits.asSInt - Vec(RCMD_THRES,U"1'b0").asBits.asSInt
      buf_has_space := !buf_empty_sub_thres(6).asBits.asBool
      bt_cmd_req := ((sta === s_cmd0) | (sta === s_cmd1)) & (!io.cfg.dma_halt) & buf_has_space
      send_bt_cmd := bt_cmd_req & bt_cmd_ack

      io.dma_inf_r_1.dvld := io.axi.r.valid & (io.axi.r.id(0, 2 bits) === 0)
      ch0_d_trans := io.dma_inf_r_1.dvld & io.dma_inf_r_1.dack
      io.dma_inf_r_2.dvld := io.axi.r.valid & (io.axi.r.id(0, 2 bits) === 1)
      ch1_d_trans := io.dma_inf_r_2.dvld & io.dma_inf_r_2.dack
      dma_d_trans := ch0_d_trans | ch1_d_trans

      val arbt = new strict_round_arbt
      dma_r_req0_w <> arbt.io.req0
      dma_r_req1_w <> arbt.io.req1
      False <> arbt.io.req2
      False <> arbt.io.req3

      gnt0 <> arbt.io.gnt0
      gnt1 <> arbt.io.gnt1
      gnt2 <> arbt.io.gnt2
      gnt3 <> arbt.io.gnt3
      gnt_id <> arbt.io.gnt_id
      io.clk <> arbt.io.clk
      io.rstn <> arbt.io.rstn

      trans_go := dma_r_req0_w | dma_r_req1_w

      when(gnt_id(0).asUInt === 0) {
        mux_len := io.dma_inf_r_1.r_len
      } otherwise {
        mux_len := io.dma_inf_r_2.r_len
      }

      switch(sta) {
        is(s_idle, s_arbt) {
          when(gnt_id(0).asUInt === 0) {
            mux_addr := io.dma_inf_r_1.r_addr
          } otherwise {
            mux_addr := io.dma_inf_r_2.r_addr
          }
        }
        is(s_cmd0) {
          mux_addr := cmd0_addr
        }
        default {
          mux_addr := cmd1_addr
        }
      }

      when(mux_addr(0, 2 bits) =/= 0) {
        when(cur_len(15 downto 5) =/= 0) {
          cur_bt_byte := U"6'd32" - mux_addr(1 downto 0) - 1
        } otherwise {
          cur_bt_byte := cur_len(5 downto 0)
        }
      } otherwise {
        when(cur_len(15 downto 6) =/= 0) {
          cur_bt_byte := U"6'd63"
        } otherwise {
          cur_bt_byte := cur_len(5 downto 0)
        }
      }

      addr_low_add := Vec(mux_addr(11 downto 0),U"1'b0").asBits.asUInt + Vec(mux_len(11 downto 0),U"1'b0").asBits.asUInt
      cross_4kb_w := addr_low_add(12).asBits.asBool | (mux_len(15 downto 12) =/= 0)
      cmd0_len_cross := U"17'd4096" - Vec(U"5'b0", mux_addr(11 downto 0)).asBits.asUInt - 1
      cmd1_len_w := Vec(mux_len,U"1'b0").asBits.asUInt - Vec(mux_addr(11 downto 0),U"5'b0").asBits.asUInt - 1
      cmd1_addr_h := mux_addr(31 downto 12) + 1

      dma_end_block := mux_addr(1 downto 0) + mux_len(1 downto 0) + 1

      last_rdata := nxt_byte_remain(16).asBits.asBool


      when(sta === s_arbt) {
        cross_4kb := cross_4kb_w

        switch(mux_addr(1 downto 0)) {
          is(0) {
            dma_r_fir_be := U"4'b1111"
            first_vld_byte := U"3'd4"
          }
          is(1) {
            dma_r_fir_be := U"4'b1110"
            first_vld_byte := U"3'd3"
          }
          is(2) {
            dma_r_fir_be := U"4'b1100"
            first_vld_byte := U"3'd2"
          }
          is(3) {
            dma_r_fir_be := U"4'b1000"
            first_vld_byte := U"3'd1"
          }
        }

        switch(dma_end_block) {
          is(0) {
            dma_r_last_be := U"4'b1111"
            last_vld_byte := U"2'd3"
          }
          is(1) {
            dma_r_last_be := U"4'b0001"
            last_vld_byte := U"2'd0"
          }
          is(2) {
            dma_r_last_be := U"4'b0011"
            last_vld_byte := U"2'd1"
          }
          is(3) {
            dma_r_last_be := U"4'b0111"
            last_vld_byte := U"2'd2"
          }
        }
      }



    switch(sta) {
      is(s_idle) {
        when(trans_go) {
          sta := s_arbt
        }
      }
      is(s_arbt) {
        sta := s_cmd0
      }
      is(s_cmd0) {
        when(send_bt_cmd) {
          when(nxt_bt_len(16).asBits.asBool) {
            when(cross_4kb) {
              sta := s_cmd1
            } otherwise {
              sta := s_d_end
            }
          } otherwise {
            sta := s_cmd0
          }
        }
      }
      is(s_cmd1) {
        when(send_bt_cmd) {
          when(nxt_bt_len(16).asBits.asBool) {
            sta := s_d_end
          } otherwise {
            sta := s_cmd1
          }
        }
      }

      //--- wait read all the data of current 1D read DMA
      is(s_d_end) {
        when(dma_d_trans && last_rdata) {
          sta := s_idle
        }
      }
    }



      when(sta === s_arbt) {
        cmd0_addr := mux_addr
        cmd0_len := (cross_4kb_w) ? cmd0_len_cross(11 downto 0).asBits.asUInt | mux_len(11 downto 0)
      } otherwise {
        cmd0_addr := Vec(U"2'h0", nxt_bt_addr(31 downto 2)).asBits.asUInt
        cmd0_len := nxt_bt_len(11 downto 0).asUInt
      }



      when((sta === s_arbt) && cross_4kb_w) {
        cmd1_addr := Vec(U"12'h0", cmd1_addr_h).asBits.asUInt
        cmd1_len := cmd1_len_w(15 downto 0)
      } otherwise {
        when((sta === s_cmd1) && send_bt_cmd) {
          cmd1_addr := Vec(U"2'h0", nxt_bt_addr(31 downto 2)).asBits.asUInt
          cmd1_len := nxt_bt_len(15 downto 0).asBits.asUInt
        }
      }


      when(first_d_flag) {
        nxt_byte_remain := (dma_byte_remain.asSInt - first_vld_byte.asSInt).resize(17)
      } otherwise {
        nxt_byte_remain := (dma_byte_remain.asSInt - 4).resize(17)
      }


      when(sta === s_arbt) {
        dma_byte_remain := mux_len
        first_d_flag := True
      } otherwise {
        when(dma_d_trans) {
          first_d_flag := False
          dma_byte_remain := nxt_byte_remain(15 downto 0).asUInt
        }
      }


      when(first_d_flag) {
        dma_rbe := dma_r_fir_be
      } otherwise {
        when(dma_byte_remain(15 downto 2) === 0) {
          dma_rbe := dma_r_last_be
        } otherwise {
          dma_rbe := U"4'b1111"
        }
      }

      //--- 2: change burst cmd to AXI inf burst cmd ---//
      val axi_idle = 0
      val axi_cmd = 1
      val axi_sta = Reg(UInt(2 bits)) init (axi_idle)

      val axi_cmd_ack = Bool()
      val axi_wr = Bool()
      val axi_r_ch = Reg(Bool()) init (False)
      val axi_addr = Reg(UInt(32 bits)) init (0)
      val axi_len_w = UInt(11 bits)
      val axi_len = Reg(UInt(4 bits)) init (0)

      axi_wr := False
      bt_cmd_ack := (axi_sta === axi_idle)
      axi_len_w := nxt_bt_addr(12 downto 2) - Vec(cur_addr(11 downto 2),U"1'b0").asBits.asUInt
      axi_cmd_ack := io.axi.ar.ready
      io.axi.r.ready := axi_r_ch ? io.dma_inf_r_2.dack | io.dma_inf_r_1.dack


      switch(axi_sta) {
        is(axi_idle) {
          when(bt_cmd_req) {
            axi_sta := axi_cmd
            axi_len := axi_len_w(3 downto 0)
            axi_addr := Vec(U"2'h0", cur_addr(31 downto 2)).asBits.asUInt
            axi_r_ch := gnt_id(0).asBits.asBool
          }
        }
        is(axi_cmd) {
          when(axi_cmd_ack) {
            axi_sta := axi_idle
          }
        }
        default {
          axi_sta := axi_idle
        }
      }


      io.axi.ar.id := Vec(axi_r_ch.asUInt, U"3'h0").asBits.asUInt
      io.axi.ar.addr := axi_addr
      io.axi.ar.len := axi_len.resize(8)
      io.axi.ar.size := U"3'h2"
      io.axi.ar.burst := B"2'b01"
      io.axi.ar.lock := B"1'b0"
      io.axi.ar.cache := Vec(io.cfg.bf.asUInt,io.cfg.cf.asUInt,U"2'b00").asBits
      io.axi.ar.prot := B"3'b010"
      io.axi.ar.valid := (axi_sta.asSInt === axi_cmd) & (!axi_wr)

      io.dma_inf_r_1.rd_last := last_rdata
      io.dma_inf_r_1.rdata := io.axi.r.data
      io.dma_inf_r_1.rbe := dma_rbe

      io.dma_inf_r_2.rd_last := last_rdata
      io.dma_inf_r_2.rdata := io.axi.r.data
      io.dma_inf_r_2.rbe := dma_rbe
    }
  }
}
