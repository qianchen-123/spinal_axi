package zqc.streamTest.streamReg

import spinal.core._
import spinal.lib._

case class streamReg(width : Int) extends  Component{
  val io = new Bundle{
    val s_in = slave Stream(Bits(width bits))
    val m_out = master Stream(Bits(width bits))
  }

  io.m_out <-/< io.s_in
}


case class streamReg_m2s(width : Int) extends Component{
  val io = new Bundle{
    val s_in = slave Stream(Bits(width bits))
    val m_out = master Stream(Bits(width bits))
  }

  io.m_out <-< io.s_in
}


case class streamReg_s2m(width : Int) extends Component{
  val io = new Bundle{
    val s_in = slave Stream(Bits(width bits))
    val m_out = master Stream(Bits(width bits))
  }

  io.m_out </< io.s_in
}

case class streamReg_halfPipe(width : Int) extends Component{
  val io = new Bundle{
    val s_in = slave Stream(Bits(width bits))
    val m_out = master Stream(Bits(width bits))
  }

  io.m_out << io.s_in.halfPipe()
}
