package zqc.DMA


import spinal.core._
import spinal.lib._

case class wcmd_gen(dmaInfConfig: dmaInfBundleConfig, bufferConfig : bufferBundleConfig,
                    cfg_cfg : dma_cfg_bundle_Config,status_cfg:dma_status_bundle_Config) extends Component{
  val io = new Bundle{
    //--- cfg regs
    val cfg = slave(dma_cfg_bundle(cfg_cfg))

    //--- dma status
    val dma = slave(dma_status_bundle(status_cfg))

    //--- DMA inf
    val dma_inf = master(DMA_inf_bundle(dmaInfConfig))

    //--- data buffer wr & sta
    val buffer = master(buffer_bundle(bufferConfig))

    //--- Global Signal
    val clk = in Bool()
    val rstn = in Bool()
  }

  val clkDomain = ClockDomain(
    clock = io.clk,
    reset = io.rstn,
    config = ClockDomainConfig(
      clockEdge = RISING,
      resetKind = ASYNC,
      resetActiveLevel = LOW
    )
  )

  val myArea = new ClockingArea(clkDomain){
    //---1 : divide 2D DMA to 1D DMA req

    val s_idle = 0
    val s_req = 1
    val s_data = 2
    val s_chk = 3
    val dma_sta = Reg(UInt(2 bits)) init(s_idle)


    val dma_ycnt = Reg(UInt(16 bits)) init(0)
    val dma_addr = Reg(UInt(32 bits)) init(0)

    val fir_wbe = Reg(Bits(4 bits)) init(0)
    val last_wbe = Reg(Bits(4 bits)) init(0)
    val align_model = Reg(UInt(2 bits)) init(0)

    val remain_bnum_rd = Reg(SInt(17 bits)) init(S"17'h1_0000")
    val remain_bnum_send = Reg(SInt(17 bits)) init(0)

    val end_bcnt = dma_addr(0,2 bits) + io.cfg.trans_xsize(0,2 bits) + 1

    val dma_1d_go = io.dma.busy & (io.buffer.buf_buf_word(0,5 bits) =/=0)

    val dma_w_req = (dma_sta === s_req)
    io.dma_inf.w_req := dma_w_req

    val dma_w_addr = dma_addr
    io.dma_inf.w_addr := dma_w_addr

    val dma_w_len = io.cfg.trans_xsize
    io.dma_inf.w_len := dma_w_len

    val send_a_cmd = dma_w_req & io.dma_inf.w_ack
    val send_a_data = io.dma_inf.w_dvld & io.dma_inf.w_dack
    val fir_wdata = send_a_data & (remain_bnum_send(0,16 bits).asUInt === io.cfg.trans_xsize)

    val dma_cmd_end = Reg(Bool()) init(False)
    io.dma.cmd_end := dma_cmd_end


    switch(dma_sta){
      is(s_idle){
        dma_cmd_end := False
        when(dma_1d_go){
          dma_sta := s_req
          dma_addr := io.cfg.dar
          dma_ycnt := io.cfg.trans_ysize
        }
      }
      is(s_req){
        when(io.dma_inf.w_ack){
          dma_sta := s_data
          dma_addr := dma_addr + io.cfg.trans_xsize + 1
          remain_bnum_send := Vec(io.cfg.trans_xsize,U(0,1 bits)).asBits.asSInt
        }
      }
      is(s_data){
        when(remain_bnum_send(16).asBits.asBool){
          dma_ycnt := dma_ycnt - 1
          when(dma_ycnt === 0){
            dma_sta := s_idle
            dma_cmd_end := True
          }otherwise{
            dma_sta := s_chk
          }
        }

        when(send_a_data){
          when(fir_wdata){
            switch(align_model){
              is(0){
                remain_bnum_send := remain_bnum_send - 4
              }
              is(1){
                remain_bnum_send := remain_bnum_send - 3
              }
              is(2){
                remain_bnum_send := remain_bnum_send - 2
              }
              is(3){
                remain_bnum_send := remain_bnum_send - 1
              }
            }
          }otherwise{
            remain_bnum_send := remain_bnum_send - 4
          }
        }
      }
      is(s_chk){
        when(dma_1d_go){
          dma_addr := dma_addr + io.cfg.da_ystep
          dma_sta := s_req
        }
      }
    }


    val buf_err = Reg(Bool()) init(False)
    io.buffer.buf_err := buf_err

    when((!io.dma.busy) &&(!io.buffer.buf_empty)){
      buf_err := True
    }otherwise{
      when(io.buffer.clr_buf_err){
        buf_err := False
      }
    }


    when(send_a_cmd){
      align_model := dma_addr(0,2 bits)

      switch(dma_addr(0,2 bits)){
        is(0){
          fir_wbe := B"1111"
        }
        is(1){
          fir_wbe := B"1110"
        }
        is(2){
          fir_wbe := B"1100"
        }
        is(3){
          fir_wbe := B"1000"
        }
      }

      switch(end_bcnt){
        is(0){
          last_wbe := B"1111"
        }
        is(1){
          last_wbe := B"0001"
        }
        is(2){
          last_wbe := B"0011"
        }
        is(3){
          last_wbe := B"0111"
        }
      }
    }


    when(send_a_cmd){
      remain_bnum_rd := io.cfg.trans_xsize.asSInt.resize(17)
    }otherwise{
      remain_bnum_rd := remain_bnum_rd - 4
    }


    //--- 2: buf read and data shift
    val buf_bcnt = Reg(SInt(4 bits)) init(0)
    val nxt_buf_bcnt  = SInt(4 bits)

    val sub_bcnt = UInt(3 bits)
    val wd0,wd1,wd2,wd3 = Reg(UInt(8 bits)) init(0)
    val ed0,ed1,ed2 = Reg(UInt(8 bits)) init(0)

    val buf_4b = (!buf_bcnt(3).asBits.asBool) & buf_bcnt(2).asBits.asBool
    io.buffer.buf_rd := ((!buf_4b) | send_a_data) & (!io.buffer.buf_empty) & (!remain_bnum_rd(16).asBits.asBool)

    val dma_wd_last = (remain_bnum_send(2,14 bits) === 0)
    val last_best_vld = dma_wd_last & (buf_bcnt(0,2 bits) > remain_bnum_send(0,2 bits)) & (!buf_bcnt(3).asBits.asBool)
    io.dma_inf.w_dvld := buf_4b | last_best_vld
    io.dma_inf.wdata := Vec(wd0,wd1,wd2,wd3).asBits

    when(fir_wdata){
      io.dma_inf.wbe := fir_wbe.asUInt
    }otherwise{
      when(dma_wd_last){
        io.dma_inf.wbe := last_wbe.asUInt
      }otherwise{
        io.dma_inf.wbe := U"4'b1111"
      }
    }

    when(fir_wdata){
      switch(align_model){
        is(0){
          sub_bcnt := 4
        }
        is(1){
          sub_bcnt := 3
        }
        is(2){
          sub_bcnt := 2
        }
        is(3){
          sub_bcnt := 1
        }
      }
    }otherwise{
      sub_bcnt := 4
    }

    switch(Vec(send_a_data,io.buffer.buf_rd).asBits.asUInt){
      is(0){
        nxt_buf_bcnt := buf_bcnt
      }
      is(1){
        nxt_buf_bcnt := buf_bcnt - Vec(U(0,1 bits), sub_bcnt).asBits.asSInt
      }
      is(2){
        nxt_buf_bcnt := buf_bcnt + 4
      }
      is(3){
        nxt_buf_bcnt := buf_bcnt - Vec(U(0,1 bits), sub_bcnt).asBits.asSInt + 4
      }
    }

    when(!io.rstn){
      buf_bcnt := 0
    }otherwise{
      when(send_a_cmd){
        buf_bcnt := 0
      }otherwise{
        when(io.buffer.buf_rd | send_a_data){
          buf_bcnt := nxt_buf_bcnt
        }
      }
    }

    when(io.buffer.buf_rd | (send_a_data & remain_bnum_rd(16).asBits.asBool)){
      switch(align_model){
        is(0){
          wd0 := io.buffer.buf_rdata(0*8,8 bits).asUInt
          wd1 := io.buffer.buf_rdata(1*8,8 bits).asUInt
          wd2 := io.buffer.buf_rdata(2*8,8 bits).asUInt
          wd3 := io.buffer.buf_rdata(3*8,8 bits).asUInt

          ed0 := ed0
          ed1 := ed1
          ed2 := ed2
        }

        is(1){
          wd0 := ed0
          wd1 := io.buffer.buf_rdata(0*8,8 bits).asUInt
          wd2 := io.buffer.buf_rdata(1*8,8 bits).asUInt
          wd3 := io.buffer.buf_rdata(2*8,8 bits).asUInt


          ed0 := io.buffer.buf_rdata(3*8,8 bits).asUInt
          ed1 := ed1
          ed2 := ed2
        }

        is(2){
          wd0 := ed0
          wd1 := ed1
          wd2 := io.buffer.buf_rdata(0*8,8 bits).asUInt
          wd3 := io.buffer.buf_rdata(1*8,8 bits).asUInt



          ed0 := io.buffer.buf_rdata(2*8,8 bits).asUInt
          ed1 := io.buffer.buf_rdata(3*8,8 bits).asUInt
          ed2 := ed2
        }

        is(3){
          wd0 := ed0
          wd1 := ed1
          wd2 := ed2
          wd3 := io.buffer.buf_rdata(0*8,8 bits).asUInt

          ed0 := io.buffer.buf_rdata(1*8,8 bits).asUInt
          ed1 := io.buffer.buf_rdata(2*8,8 bits).asUInt
          ed2 := io.buffer.buf_rdata(3*8,8 bits).asUInt
        }
      }
    }
  }
}

