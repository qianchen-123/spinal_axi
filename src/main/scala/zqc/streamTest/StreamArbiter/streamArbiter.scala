package zqc.streamTest.StreamArbiter

import spinal.core._
import spinal.lib._

case class streamArbiterRoundRobin(width : Int) extends Component{
  val io = new Bundle{
    val s_in = Vec(slave Stream(Bits(width bits)),4)
    val m_out = master Stream(Bits(width bits))
  }

  io.m_out <-/< StreamArbiterFactory.roundRobin.onArgs(io.s_in(0),io.s_in(1),io.s_in(2),io.s_in(3))

}


case class streamArbiterLowerFirst(width : Int) extends Component{
  val io = new Bundle{
    val s_in = Vec(slave Stream(Bits(width bits)),4)
    val m_out = master Stream(Bits(width bits))
  }

  io.m_out <-/< StreamArbiterFactory.lowerFirst.onArgs(io.s_in(0),io.s_in(1),io.s_in(2),io.s_in(3))

}

case class streamArbiterSequencialOrder(width : Int) extends Component{
  val io = new Bundle{
    val s_in = Vec(slave Stream(Bits(width bits)),4)
    val m_out = master Stream(Bits(width bits))
  }

  io.m_out <-/< StreamArbiterFactory.sequentialOrder.onArgs(io.s_in(0),io.s_in(1),io.s_in(2),io.s_in(3))

}
