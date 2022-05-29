package zqc.streamTest.basicStream

import spinal.core._
import spinal.lib._

case class basicStream(width : Int) extends Component{
  val io = new Bundle{
    val s_in = slave Stream(Bits(width bits))
    val m_out = master Stream(Bits(width bits))
  }

  io.m_out << io.s_in


}
