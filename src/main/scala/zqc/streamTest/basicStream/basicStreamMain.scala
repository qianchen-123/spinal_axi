package zqc.streamTest.basicStream

import spinal.core._


object basicStreamMain {
  def main(args:Array[String]): Unit ={
    SpinalConfig(targetDirectory =  "streamRtl").generateVerilog(basicStream(width = 32))
  }
}
