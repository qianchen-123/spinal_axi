package zqc.memTest

import spinal.core._

object memTestMain {
  def main(args:Array[String]): Unit ={
    SpinalConfig(targetDirectory =  "memRtl").generateVerilog(memTest(width = 32 , depth = 6))
  }

}