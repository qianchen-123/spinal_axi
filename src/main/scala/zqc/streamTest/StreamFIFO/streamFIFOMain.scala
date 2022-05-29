package zqc.streamTest.StreamFIFO

import spinal.core._

object streamFIFOMain {
  def main(args:Array[String]): Unit ={
    SpinalConfig(targetDirectory =  "streamRtl").generateVerilog(streamFIFO(width = 32,depth = 8))
    SpinalConfig(targetDirectory =  "streamRtl").generateVerilog(streamFIFOCC(width = 32,depth = 8))
  }

}
