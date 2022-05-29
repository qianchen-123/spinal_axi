package zqc.streamTest.StreamArbiter

import spinal.core._

object streamArbiterMain {
  def main(args:Array[String]): Unit = {
    SpinalConfig(targetDirectory = "streamRtl").generateVerilog(streamArbiterRoundRobin(width = 32))
    SpinalConfig(targetDirectory = "streamRtl").generateVerilog(streamArbiterLowerFirst(width = 32))
    SpinalConfig(targetDirectory = "streamRtl").generateVerilog(streamArbiterSequencialOrder(width = 32))
  }
}
