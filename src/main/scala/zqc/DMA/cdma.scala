package zqc.DMA

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.apb.{Apb3, Apb3Config}
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config}

case class cdma(apb_cfg : Apb3Config, axi_cfg: Axi4Config) extends Component{
  val io = new Bundle{
    val apb = slave(Apb3(apb_cfg))
    val axi = master(Axi4(axi_cfg))

    val intr = out Bool()

    //--- Global Signal
    val clk = in Bool()
    val rstn = in Bool()
  }

  val dma_cfg = new dma_cfg(Apb3Config(8,32,1,false),dma_cfg_bundle_Config(32,32,16,16,16,16,32,1),
    dma_ll_bundle_Config(32,32,3),dma_status_bundle_Config(8,1))
  io.apb <> dma_cfg.io.apb
  io.clk <> dma_cfg.io.clk
  io.rstn <> dma_cfg.io.rstn

  io.intr <> dma_cfg.io.dma.intr


  val cmd_fetch = new cmd_fetch(dma_ll_bundle_Config
  (32,32,3),dmaInfBundleConfig(32,16,32,4,32,16,32,4,true))
  io.clk <> cmd_fetch.io.clk
  io.rstn <> cmd_fetch.io.rstn

  dma_cfg.io.ll <> cmd_fetch.io.ll

  val rcmd_gen = new rcmd_gen(dmaInfBundleConfig(32,16,32,4,32,16,32,4,true)
    ,bufferBundleConfig(32,6,32,6,false),dma_cfg_bundle_Config(32,32,16,16,16,16,32,2),dma_status_bundle_Config(8,2))
  io.clk <> rcmd_gen.io.clk
  io.rstn <> rcmd_gen.io.rstn

  //dma_cfg.io.cfg <> rcmd_gen.io.cfg
  dma_cfg.io.cfg.sar <> rcmd_gen.io.cfg.sar
  dma_cfg.io.cfg.trans_xsize <> rcmd_gen.io.cfg.trans_xsize
  dma_cfg.io.cfg.trans_ysize <> rcmd_gen.io.cfg.trans_ysize
  dma_cfg.io.cfg.sa_ystep <> rcmd_gen.io.cfg.sa_ystep

  //dma_cfg.io.dma <> rcmd_gen.io.dma
  dma_cfg.io.dma.cmd_sof <> rcmd_gen.io.dma.cmd_sof

  val wcmd_gen = new wcmd_gen(dmaInfBundleConfig(32,16,32,4,32,16,32,4,false)
    ,bufferBundleConfig(32,6,32,6,true),dma_cfg_bundle_Config(32,32,16,16,16,16,32,3),dma_status_bundle_Config(8,3))
  io.clk <> wcmd_gen.io.clk
  io.rstn <> wcmd_gen.io.rstn

  //dma_cfg.io.cfg <> wcmd_gen.io.cfg
  dma_cfg.io.cfg.dar <> wcmd_gen.io.cfg.dar
  dma_cfg.io.cfg.trans_xsize <> wcmd_gen.io.cfg.trans_xsize
  dma_cfg.io.cfg.trans_ysize <> wcmd_gen.io.cfg.trans_ysize
  dma_cfg.io.cfg.da_ystep <> wcmd_gen.io.cfg.da_ystep

  //dma_cfg.io.dma <> wcmd_gen.io.dma
  dma_cfg.io.dma.cmd_sof <> wcmd_gen.io.dma.cmd_sof
  dma_cfg.io.dma.cmd_end <> wcmd_gen.io.dma.cmd_end
  dma_cfg.io.dma.busy <> wcmd_gen.io.dma.busy

  dma_cfg.io.cfg.buf_err <> wcmd_gen.io.buffer.buf_err

  val dma_buf = new dma_buf(bufferBundleConfig(32,6,32,6,false)
    ,bufferBundleConfig(32,6,32,6,true))
  io.clk <> dma_buf.io.clk
  io.rstn <> dma_buf.io.rstn

  rcmd_gen.io.buffer <> dma_buf.io.wr
  wcmd_gen.io.buffer <> dma_buf.io.rd

  val dma_2_axi = new dma_2_axi(Axi4Config(32,32,4,true,false,true,true,true,true,
    false,true,true,true,true,true),dmaInfBundleConfig(32,16,32,4,32,16,32,4,false),
    dmaInfBundleConfig(32,16,32,4,32,16,32,4,true),dmaInfBundleConfig(32,16,32,4,32,16,32,4,true),
    dma_cfg_bundle_Config(32,32,16,16,16,16,32,4),dma_status_bundle_Config(8,4))
  io.axi <> dma_2_axi.io.axi
  io.clk <> dma_2_axi.io.clk
  io.rstn <> dma_2_axi.io.rstn

  //dma_cfg.io.dma <> dma_2_axi.io.dma
  dma_cfg.io.dma.cmd_sof <> dma_2_axi.io.dma.cmd_sof
  dma_cfg.io.dma.busy <> dma_2_axi.io.dma.busy

  //dma_cfg.io.cfg <> dma_2_axi.io.cfg
  dma_cfg.io.cfg.dma_halt <> dma_2_axi.io.cfg.dma_halt
  dma_cfg.io.cfg.bf <> dma_2_axi.io.cfg.bf
  dma_cfg.io.cfg.cf <> dma_2_axi.io.cfg.cf

  dma_buf.io.rd.buf_buf_word <>dma_2_axi.io.buf_buf_word
  dma_buf.io.wr.buf_empty_word <> dma_2_axi.io.buf_empty_word

  wcmd_gen.io.dma_inf <> dma_2_axi.io.dma_inf_w

  rcmd_gen.io.dma_inf <> dma_2_axi.io.dma_inf_r_1
  cmd_fetch.io.dma_inf <> dma_2_axi.io.dma_inf_r_2

}
