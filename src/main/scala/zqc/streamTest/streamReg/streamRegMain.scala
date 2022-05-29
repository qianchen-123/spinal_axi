package zqc.streamTest.streamReg

import spinal.core._


object streamRegMain {
  def main(args:Array[String]) : Unit = {
    SpinalConfig(targetDirectory = "streamRtl").generateVerilog(streamReg(width = 32))
    SpinalConfig(targetDirectory = "streamRtl").generateVerilog(streamReg_m2s(width = 32))
    SpinalConfig(targetDirectory = "streamRtl").generateVerilog(streamReg_s2m(width = 32))
    SpinalConfig(targetDirectory = "streamRtl").generateVerilog(streamReg_halfPipe(width = 32))
  }
}
