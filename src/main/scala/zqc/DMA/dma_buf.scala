package zqc.DMA

import spinal.core._
import spinal.lib._

case class dma_buf(wr_config: bufferBundleConfig, rd_config: bufferBundleConfig) extends Component{
  val io = new Bundle{
    val wr = slave(buffer_bundle(wr_config))
    val rd = slave(buffer_bundle(rd_config))

    val rstn = in(Bool())
  }

  io.rd.clr_buf_err := False

  val buf_empty_word = Reg(UInt(wr_config.buf_empty_word_Width bits)) init(0)
  io.wr.buf_empty_word := buf_empty_word

  val buf_buf_word = Reg(UInt(rd_config.buf_buf_word_Width bits)) init(0)
  io.rd.buf_buf_word := buf_buf_word

  val mem = Mem(Bits(32 bits),wordCount = 24)

  val rptr,wptr = Reg(UInt(6 bits)) init(0)

  io.rd.buf_empty := (rptr === wptr)
  io.rd.buf_rdata := mem.readAsync(rptr(0,5 bits))

  when(!io.rstn){
    buf_empty_word := 24
  }otherwise{
    when(io.wr.buf_wr || io.rd.buf_rd){
      switch(Vec(io.wr.buf_wr,io.rd.buf_rd).asBits.asUInt){
        is(0){
          buf_empty_word := buf_empty_word
        }
        is(1){
          buf_empty_word := buf_empty_word + 1
        }
        is(2){
          buf_empty_word := buf_empty_word - 1
        }
        is(3){
          buf_empty_word := buf_empty_word
        }
      }
    }
  }

  when(!io.rstn){
    buf_buf_word := 0
  }otherwise{
    when(io.wr.buf_wr || io.rd.buf_rd){
      switch(Vec(io.wr.buf_wr,io.rd.buf_rd).asBits.asUInt){
        is(0){
          buf_buf_word := buf_buf_word
        }
        is(1){
          buf_buf_word := buf_buf_word - 1
        }
        is(2){
          buf_buf_word := buf_buf_word + 1
        }
        is(3){
          buf_buf_word := buf_buf_word
        }
      }
    }
  }

  when(io.wr.buf_wr){
    mem.write(wptr(0,5 bits), io.wr.buf_wdata)
  }

  when(!io.rstn){
    wptr := 0
  }otherwise{
    when(io.wr.buf_wr){
      wptr := Vec((!(wptr(5).asBits.asBool)).asUInt,U"5'h0").asBits.asUInt
    }otherwise{
      wptr := wptr + 1
    }
  }

  when(!io.rstn){
    rptr := 0
  }otherwise{
    when(io.rd.buf_rd){
      when(rptr(0,5 bits) === 23){
        rptr := Vec((!(rptr(5).asBits.asBool)).asUInt,U"5'h0").asBits.asUInt
      }otherwise{
        rptr := rptr + 1
      }
    }
  }
}
