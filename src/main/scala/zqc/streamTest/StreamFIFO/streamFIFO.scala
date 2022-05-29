package zqc.streamTest.StreamFIFO

import spinal.core._
import spinal.lib._

case class streamFIFO(width : Int , depth : Int) extends Component{
  val io = new Bundle{
    val s_in = slave Stream(Bits(width bits))
    val m_out = master Stream(Bits(width bits))
  }

  val FIFO = StreamFifo(
    dataType = Bits(width bits),
    depth = depth
  )

  FIFO.io.push << io.s_in
  FIFO.io.pop >> io.m_out
}



case class streamFIFOCC(width : Int, depth : Int) extends Component{
  val io = new Bundle{
    val s_in = slave Stream(Bits(width bits))
    val m_out = master Stream(Bits(width bits))
    val s_clk = in Bool()
    val s_rst = in Bool()
    val m_clk = in Bool()
    val m_rst = in Bool()
  }

  val defaultCC = ClockDomainConfig(
    clockEdge =  RISING,
    resetKind =  ASYNC,
    resetActiveLevel = HIGH
  )

  val clkDomainA = ClockDomain(
    clock = io.s_clk,
    reset = io.s_rst,
    config = defaultCC
  )

  val clkDomainB = ClockDomain(
    clock = io.m_clk,
    reset = io.m_rst,
    config = defaultCC
  )

  val FIFOCC = StreamFifoCC(
    dataType = Bits(width bits),
    depth = depth,
    pushClock = clkDomainA,
    popClock = clkDomainB
  )

  FIFOCC.io.push << io.s_in
  FIFOCC.io.pop >> io.m_out



}
