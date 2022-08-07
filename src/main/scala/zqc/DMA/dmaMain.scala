package zqc.DMA


import spinal.core
import spinal.core.SpinalConfig
import spinal.lib.bus.amba3.apb.Apb3Config
import spinal.lib.bus.amba4.axi.Axi4Config

import scala.reflect.internal.util.TriState.True

object dmaMain {
  val apb3Config = Apb3Config(8,32,1,true)
  def main(args:Array[String]):Unit = {
    SpinalConfig(targetDirectory =  "dma").generateVerilog(dma_cfg(dmaBundleConfig
    (32,32,16,16,16,16,32,32,3,8),Apb3Config(8,32,1,false)))

    SpinalConfig(targetDirectory =  "dma").generateVerilog(cmd_fetch(dmaLinkedListBundleConfig
    (32,32,3),dmaInfBundleConfig(32,16,32,4,32,16,32,4,true)))

    SpinalConfig(targetDirectory =  "dma").generateVerilog(rcmd_gen(dmaInfBundleConfig(32,16,32,4,32,16,32,4,true)
    ,bufferBundleConfig(32,6,32,6,false)))

    SpinalConfig(targetDirectory =  "dma").generateVerilog(wcmd_gen(dmaInfBundleConfig(32,16,32,4,32,16,32,4,false)
      ,bufferBundleConfig(32,6,32,6,true)))

    SpinalConfig(targetDirectory =  "dma").generateVerilog(strict_round_arbt())

    SpinalConfig(targetDirectory =  "dma").generateVerilog(dma_buf(bufferBundleConfig(32,6,32,6,false)
      ,bufferBundleConfig(32,6,32,6,true)))

    SpinalConfig(targetDirectory =  "dma").generateVerilog(dma_2_axi(Axi4Config(32,32,4,true,false,true,true,true,true,
      false,true,true,true,true,true)))
  }
}
