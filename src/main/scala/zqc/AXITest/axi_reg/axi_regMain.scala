package zqc.AXITest.axi_reg

import spinal.core.SpinalConfig
import spinal.lib.bus.amba4.axi.Axi4Config
//import zqc.AXITest.axi_slave.sram.axi_sram

object axi_regMain {
  def main(args:Array[String]): Unit ={
        SpinalConfig(targetDirectory =  "axiRtl").generateVerilog(axi_reg(Axi4Config(
          addressWidth = 32,
          dataWidth = 32,
          idWidth = 4
        )))
  }

}
