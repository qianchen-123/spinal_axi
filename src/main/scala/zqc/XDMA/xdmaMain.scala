package zqc.XDMA

import spinal.core.SpinalConfig
import spinal.lib.bus.amba4.axi.Axi4Config

object xdmaMain {
  def main(args: Array[String]): Unit = {
    SpinalConfig(targetDirectory = "xdma").generateVerilog(xdma_wrapper(Axi4Config(32, 32, 4, true, false, true, true, true, true,
      false, true, true, true, true, true)))
  }
}
