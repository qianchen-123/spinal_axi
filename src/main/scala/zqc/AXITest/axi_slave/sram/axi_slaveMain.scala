package zqc.AXITest.axi_slave.sram

import spinal.core.SpinalConfig
import spinal.lib.bus.amba4.axi.Axi4Config

object axi_slaveMain {
  def main(args:Array[String]): Unit ={
    SpinalConfig(targetDirectory =  "axiRtl").generateVerilog(axi_slave(
        axi4Config = Axi4Config(
          addressWidth = 32,
          dataWidth = 32,
          idWidth = 4,
          rUserWidth = 4,
          bUserWidth = 4
        )
      ))

  }
}
