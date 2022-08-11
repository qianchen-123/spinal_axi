package zqc.DMA

import spinal.core._
import spinal.lib._

case class rcmd_gen(dmaInfConfig: dmaInfBundleConfig, bufferConfig : bufferBundleConfig,
                    cfg_cfg : dma_cfg_bundle_Config,status_cfg:dma_status_bundle_Config) extends Component{
  val io = new Bundle{
    //--- cfg regs
    val cfg = slave(dma_cfg_bundle(cfg_cfg))
    //--- dma status
    val dma = slave(dma_status_bundle(status_cfg))
//    val dma_cmd_sof = in(Bool())

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

  val myArea = new ClockingArea(clkDomain) {

    //---1 : divide 2D DMA cmd to 1D DMA req

    val s_idle = 0
    val s_req = 1
    val s_chk = 2
    val cmd_sta = Reg(UInt(2 bits)) init (s_idle)


    val dma_ycnt = Reg(UInt(16 bits)) init (0)
    val dma_addr = Reg(UInt(32 bits)) init (0)

    io.dma_inf.r_req := (cmd_sta === s_idle) ? True | False
    io.dma_inf.r_addr := dma_addr
    io.dma_inf.r_len := io.cfg.trans_xsize


    switch(cmd_sta) {
      is(s_idle) {
        when(io.dma.cmd_sof) {
          cmd_sta := s_req
          dma_addr := io.cfg.sar
        }
      }
      is(s_req) {
        when(io.dma_inf.r_ack) {
          cmd_sta := s_chk
          dma_addr := dma_addr + io.cfg.trans_xsize + 1
        }
      }
      is(s_chk) {
        dma_addr := dma_addr + io.cfg.sa_ystep
        when(dma_ycnt =/= io.cfg.trans_ysize) {
          cmd_sta := s_req
        } otherwise {
          cmd_sta := s_idle
        }
      }
      default {
        cmd_sta := s_idle
      }
    }

    when(io.dma.cmd_sof) {
      dma_ycnt := 0
    } otherwise {
      when(cmd_sta === s_chk) {
        dma_ycnt := dma_ycnt + 1
      }
    }


    //--- 2: recv 1D DMA read data & write in fifo
    //--- Note : all data in fifo are valid bytes, except the last data of a 1D cmd

    val dbuf0 = Reg(Bits(8 bits)) init (0)
    val dbuf1 = Reg(Bits(8 bits)) init (0)
    val dbuf2 = Reg(Bits(8 bits)) init (0)
    val buf_byte = Reg(UInt(3 bits)) init (0)
    val dma_dlast_r = Reg(Bool()) init (False)

    val dma_rdata_sf = Bits(32 bits)

    val dma_dack = (io.buffer.buf_empty_word =/= 0) & (!dma_dlast_r)
    io.dma_inf.dack := dma_dack

    val dma_d_recv = io.dma_inf.dvld & io.dma_inf.dack

    val nxt_buf_byte0 = Vec(buf_byte(0, 2 bits).asBits.asUInt, U(1, 1 bits)).asBits.asUInt + Vec(io.dma_inf.rbe(0).asBits.asUInt, U(0, 2 bits)).asBits.asUInt
    val nxt_buf_byte1 = nxt_buf_byte0 + Vec(io.dma_inf.rbe(1).asBits.asUInt, U(0, 2 bits)).asBits.asUInt
    val nxt_buf_byte2 = nxt_buf_byte1 + Vec(io.dma_inf.rbe(2).asBits.asUInt, U(0, 2 bits)).asBits.asUInt
    val nxt_buf_byte3 = nxt_buf_byte2 + Vec(io.dma_inf.rbe(3).asBits.asUInt, U(0, 2 bits)).asBits.asUInt
    val nxt_buf_byte = nxt_buf_byte3


    when(dma_d_recv) {
      when(io.dma_inf.rbe(0) && (buf_byte(0, 2 bits) === 0)) {
        dbuf0 := io.dma_inf.rdata(0 * 8, 8 bits)
      } otherwise {
        when(io.dma_inf.rbe(1) && (nxt_buf_byte0(0, 2 bits) === 0)) {
          dbuf0 := io.dma_inf.rdata(1 * 8, 8 bits)
        } otherwise {
          when(io.dma_inf.rbe(2) && (nxt_buf_byte0(0, 2 bits) === 0)) {
            dbuf0 := io.dma_inf.rdata(2 * 8, 8 bits)
          } otherwise {
            when(io.dma_inf.rbe(3) && (nxt_buf_byte0(0, 2 bits) === 0)) {
              dbuf0 := io.dma_inf.rdata(3 * 8, 8 bits)
            } otherwise {
            }
          }
        }
      }
    }



    when(dma_d_recv) {
      when(io.dma_inf.rbe(0) && (buf_byte(0, 2 bits) === 1)) {
        dbuf1 := io.dma_inf.rdata(0 * 8, 8 bits)
      } otherwise {
        when(io.dma_inf.rbe(1) && (nxt_buf_byte0(0, 2 bits) === 1)) {
          dbuf1 := io.dma_inf.rdata(1 * 8, 8 bits)
        } otherwise {
          when(io.dma_inf.rbe(2) && (nxt_buf_byte0(0, 2 bits) === 1)) {
            dbuf1 := io.dma_inf.rdata(2 * 8, 8 bits)
          } otherwise {
            when(io.dma_inf.rbe(3) && (nxt_buf_byte0(0, 2 bits) === 1)) {
              dbuf1 := io.dma_inf.rdata(3 * 8, 8 bits)
            } otherwise {
            }
          }
        }
      }
    }


    when(dma_d_recv) {
      when(io.dma_inf.rbe(0) && (buf_byte(0, 2 bits) === 2)) {
        dbuf2 := io.dma_inf.rdata(0 * 8, 8 bits)
      } otherwise {
        when(io.dma_inf.rbe(1) && (nxt_buf_byte0(0, 2 bits) === 2)) {
          dbuf2 := io.dma_inf.rdata(1 * 8, 8 bits)
        } otherwise {
          when(io.dma_inf.rbe(2) && (nxt_buf_byte0(0, 2 bits) === 2)) {
            dbuf2 := io.dma_inf.rdata(2 * 8, 8 bits)
          } otherwise {
            when(io.dma_inf.rbe(3) && (nxt_buf_byte0(0, 2 bits) === 2)) {
              dbuf2 := io.dma_inf.rdata(3 * 8, 8 bits)
            } otherwise {
            }
          }
        }
      }
    }



    when(dma_d_recv && io.dma_inf.rd_last) {
      dma_dlast_r := True
    } otherwise {
      dma_dlast_r := False
    }



    when(dma_d_recv) {
      buf_byte := Vec(nxt_buf_byte(0, 2 bits), U(0, 1 bits)).asBits.asUInt
    } otherwise {
      when(dma_dlast_r) {
        buf_byte := 0
      }
    }


    switch(buf_byte(0, 2 bits)) {
      is(0) {
        dma_rdata_sf := io.dma_inf.rdata(0 * 8, 32 bits).asBits
      }
      is(1) {
        dma_rdata_sf := Vec(dbuf0, io.dma_inf.rdata(0 * 8, 24 bits)).asBits
      }
      is(2) {
        dma_rdata_sf := Vec(dbuf0, dbuf1, io.dma_inf.rdata(0 * 8, 16 bits)).asBits
      }
      is(3) {
        dma_rdata_sf := Vec(dbuf0, dbuf1, dbuf2, io.dma_inf.rdata(0 * 8, 8 bits)).asBits
      }
    }

    val last_wr_1d = dma_dlast_r & (buf_byte(0, 2 bits) =/= 0)
    val last_wdata = Vec(dbuf0.asUInt, dbuf1.asUInt, dbuf2.asUInt, U(0, 8 bits)).asBits

    io.buffer.buf_wr := (dma_d_recv & nxt_buf_byte(2).asBits.asBool) | last_wr_1d
    io.buffer.buf_wdata := (last_wr_1d) ? last_wdata | dma_rdata_sf
  }

}
