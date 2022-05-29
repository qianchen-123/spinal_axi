package zqc.memTest

import spinal.core._
import spinal.lib._


case class memTest(width : Int, depth : Int) extends  Component{
  val  io = new Bundle{
    val enable = in Bool()
    val addr = in Bits(log2Up(depth) bits)
    val din = in Bits(width bits)
    val dout = out Bits(width bits)
  }

  val rom = Mem(Bits(width bits), depth)
  io.dout := 0
  when(io.enable){
    io.dout := rom.readSync(io.addr.asUInt)
  }otherwise{
    rom.write(
      io.addr.asUInt,
      io.din
    )
  }



}
