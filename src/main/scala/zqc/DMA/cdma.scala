package zqc.DMA

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.apb.Apb3Config
import spinal.lib.bus.amba4.axi.Axi4Config

case class cdma(apb_cfg : Apb3Config, axi_cfg: Axi4Config) extends Component{
  val io = new Bundle{
    val apb = slave(apb(apb_cfg))
    val axi = master(axi(axi_cfg))
  }

  val cfg_sar = UInt(32 bits) // source byte addr
  val cfg_dar = UInt(32 bits) // destination byte addr
  val cfg_trans_xsize = UInt(16 bits) // 2D DMA x-dir transfer byte size, cnt from 0
  val cfg_trans_ysize = UInt(16 bits) // 2D DMA y-dir transfer lines, cnt from 0
  val cfg_sa_ystep = UInt(16 bits) // source byte addr offset between each line, cnt from 1
  val cfg_da_ystep = UInt(16 bits) // destination byte addr offset between each line, cnt from 1
  val cfg_llr = UInt(32 bits) //DMA cmd linked list base addr(adddr pointer)
  val cfg_dma_halt = Bool() //1 : halt AXI transfer
  val cfg_bf = Bool() //bufferable flag in AXI cmd
  val cfg_cf = Bool() //cacheable flag in AXI cmd

  //--- cmd linked list request and ack
  val ll_req = Bool() // linked list request, high level active
  val ll_Addr = UInt(32 bits) // 32 bit aligned address
  val ll_ack = Bool() //linked list demand acknowledge
  val ll_dvld = Bool() //linked list data valid
  val ll_rdata = Bits(32 bits) //linked list read data
  val ll_dcnt = UInt(3 bits) //linked list read data cnt : 0~7

  //---dma status
  val dma_cmd_sof = Bool()
  val dma_cmd_end = Bool()
  val cmd_num = UInt(8 bits)
  val dma_busy = Bool()

  val dma_r_req0 = Bool()
  val dma_r_ack0 = Bool()
  val dma_r_addr0 = UInt(32 bits)
  val dma_r_len0 = UInt(16 bits)

  val dma_dvld0 = Bool()
  val dma_rd_last0 = Bool()
  val dma_rdata0 = UInt(32 bits)
  val dma_rbe0 = UInt(4 bits)
  val dma_dack0 = Bool()

  val dma_r_req1 = Bool()
  val dma_r_ack1 = Bool()
  val dma_r_addr1 = UInt(32 bits)
  val dma_r_len1 = UInt(16 bits)

  val dma_dvld1 = Bool()
  val dma_rd_last1 = Bool()
  val dma_rdata1 = UInt(32 bits)
  val dma_rbe1 = UInt(4 bits)
  val dma_dack1 = Bool()

  //--- DMA INF
  val dma_w_req = Bool()
  val dma_w_ack = Bool()
  val dma_w_addr = UInt(32 bits)
  val dma_w_len = UInt(16 bits)
  val dma_w_dvld = Bool()
  val dma_wdata = Bits(32 bits)
  val dma_wbe = UInt(4 bits)
  val dma_w_ack = Bool()

  //--- data buffer wr & sta
  val buf_wr = Bool()
  val buf_wdata = Bits(32 bits)
  val buf_empty_word = UInt(6 bits)
  val buf_rd = Bool()
  val buf_rdata = Bits(32 bits)
  val buf_buf_word = UInt(6 bits)
  val buf_empty = Bool()
  val buf_err = Bool()
  val clr_buff_err = Bool()

  val cdma_cfg = new dma_cfg(dmaBundleConfig(32,32,16,16,16,16,32,32,3,8),
    Apb3Config(8,32,1,false))
  io.apb >> cdma_cfg.io.cfg.dma_apb



  val cmd_fetch = new cmd_fetch(dmaLinkedListBundleConfig
  (32,32,3),dmaInfBundleConfig(32,16,32,4,32,16,32,4,true))

  val rcmd_gen = new rcmd_gen(dmaInfBundleConfig(32,16,32,4,32,16,32,4,true)
    ,bufferBundleConfig(32,6,32,6,false))

  val wcmd_gen = new wcmd_gen(dmaInfBundleConfig(32,16,32,4,32,16,32,4,false)
    ,bufferBundleConfig(32,6,32,6,true))

  val dma_buf = new dma_buf(bufferBundleConfig(32,6,32,6,false)
    ,bufferBundleConfig(32,6,32,6,true))

  val dma_2_axi = new dma_2_axi(Axi4Config(32,32,4,true,false,true,true,true,true,
    false,true,true,true,true,true))


}
