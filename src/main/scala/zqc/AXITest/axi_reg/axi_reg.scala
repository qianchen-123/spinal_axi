package zqc.AXITest.axi_reg

import spinal.core.{Bundle, Component}
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config}
import spinal.lib.{master, slave}

case class axi_reg(axi4Config: Axi4Config) extends Component{
  val io = new Bundle{
    val axi_in = slave(Axi4(axi4Config))
    val axi_out = master(Axi4(axi4Config))
  }

  io.axi_out.ar <-/< io.axi_in.ar
  io.axi_out.aw <-/< io.axi_in.aw
  io.axi_out.w <-/< io.axi_in.w
  io.axi_out.r >/-> io.axi_in.r
  io.axi_out.b >/-> io.axi_in.b
}
