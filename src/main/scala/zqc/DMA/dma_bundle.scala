package zqc.DMA

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.apb.{Apb3, Apb3Config}

//-------------------------------------------------------------------------------------------------------
case class dma_cfg_bundle_Config (
                                   //---cfg regs
                                   sar_Width : Int = 32,
                                   dar_Width : Int = 32,
                                   trans_xsize_Width : Int = 16,
                                   trans_ysize_Width : Int = 16,
                                   sa_ystep_Width : Int = 16,
                                   da_ystep_Width : Int = 16,
                                   llr_Width : Int = 32,
                                   user_id : Int = 1
                                 )
case class dma_cfg_bundle(config : dma_cfg_bundle_Config) extends Bundle with IMasterSlave{
  val dma_cfg_id = 1
  val rcmd_gen_id = 2
  val wcmd_gen_id = 3
  val dma_2_axi_id = 4
  //--- cfg regs
  val sar = if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id) UInt(config.sar_Width bits) else null
  val dar = if(config.user_id == dma_cfg_id | config.user_id == wcmd_gen_id) UInt(config.dar_Width bits) else null
  val trans_xsize = if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id | config.user_id == wcmd_gen_id) UInt(config.trans_xsize_Width bits) else null
  val trans_ysize = if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id | config.user_id == wcmd_gen_id) UInt(config.trans_ysize_Width bits) else null
  val sa_ystep = if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id) UInt(config.sa_ystep_Width bits) else null
  val da_ystep = if(config.user_id == dma_cfg_id | config.user_id == wcmd_gen_id) UInt(config.da_ystep_Width bits) else null
  val llr = if(config.user_id == dma_cfg_id) UInt(config.llr_Width bits) else null
  val dma_halt = if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) Bool() else null
  val bf = if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) Bool() else null
  val cf = if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) Bool() else null

  val buf_err = if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) Bool() else null
  val clr_bur_err = if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) Bool() else null
  override def asMaster(): Unit = {
    //--- cfg regs
    if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id) out(sar)
    if(config.user_id == dma_cfg_id | config.user_id == wcmd_gen_id) out(dar)
    if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id | config.user_id == wcmd_gen_id) out(trans_xsize)
    if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id | config.user_id == wcmd_gen_id) out(trans_ysize)
    if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id) out(sa_ystep)
    if(config.user_id == dma_cfg_id | config.user_id == wcmd_gen_id) out(da_ystep)
    if(config.user_id == dma_cfg_id) out(llr)
    if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) out(dma_halt)
    if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) out(bf)
    if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) out(cf)

    if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) in(buf_err)
    if(config.user_id == dma_cfg_id | config.user_id == dma_2_axi_id) out(clr_bur_err)
  }
}

//-------------------------------------------------------------------------------------------------------


case class dma_ll_bundle_Config(
                                 //--- cmd link list regs
                                 llr_Width : Int = 32,
                                 ll_rdata_Width : Int = 32,
                                 ll_dcnt_Width : Int = 3
                               )

case class dma_ll_bundle(config : dma_ll_bundle_Config) extends Bundle with IMasterSlave{

  //--- cmd linked list req and ack
  val req = Bool()
  val addr = UInt(config.llr_Width bits)
  val ack = Bool()
  val dvld = Bool()
  val rdata = Bits(config.ll_rdata_Width bits) // Bits
  val dcnt = UInt(config.ll_dcnt_Width bits)

  override def asMaster(): Unit ={
    //--- cmd linked list
    out(req,addr)
    in(ack,dvld,rdata,dcnt)
  }
}

//-------------------------------------------------------------------------------------------------------

case class dma_status_bundle_Config(
                                     cmd_num_Width : Int = 8,
                                     user_id : Int = 1
                                   )

case class dma_status_bundle(config : dma_status_bundle_Config) extends Bundle with IMasterSlave{
  val dma_cfg_id = 1
  val rcmd_gen_id = 2
  val wcmd_gen_id = 3
  val dma_2_axi_id = 4
  //--- dma status
  val cmd_sof = if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id | config.user_id == wcmd_gen_id | config.user_id == dma_2_axi_id) Bool() else null
  val cmd_end = if(config.user_id == dma_cfg_id | config.user_id == wcmd_gen_id) Bool() else null
  val cmd_num = if(config.user_id == dma_cfg_id) UInt(config.cmd_num_Width bits) else null
  val busy = if(config.user_id == dma_cfg_id | config.user_id == wcmd_gen_id | config.user_id == dma_2_axi_id) Bool() else null
  val intr = if(config.user_id == dma_cfg_id) Bool() else null
  override def asMaster(): Unit ={
    //--- dma status
    if(config.user_id == dma_cfg_id | config.user_id == rcmd_gen_id | config.user_id == wcmd_gen_id | config.user_id == dma_2_axi_id) out(cmd_sof)
    if(config.user_id == dma_cfg_id | config.user_id == wcmd_gen_id) in(cmd_end)
    if(config.user_id == dma_cfg_id) out(cmd_num)
    if(config.user_id == dma_cfg_id | config.user_id == wcmd_gen_id | config.user_id == dma_2_axi_id) out(busy)
    if(config.user_id == dma_cfg_id) out(intr)
  }
}

//---------------------------------------------------------------

case class dmaInfBundleConfig(
                               //--- DMA read inf
                               dma_r_addr_Width : Int = 32,
                               dma_r_len_Width : Int = 16,
                               dma_rdata_Width : Int = 32,
                               dma_rbe_Width : Int = 4,

                               //--- DMA write inf
                               dma_w_addr_Width : Int = 32,
                               dma_w_len_Width : Int = 16,
                               dma_wdata_Width : Int = 32,
                               dma_wbe_Width : Int = 4,

                               read_model : Boolean = true

                             ){

}

case class DMA_inf_bundle (config : dmaInfBundleConfig) extends Bundle with IMasterSlave{

  //--- DMA read inf
  val r_req = if(config.read_model) Bool() else null
  val r_ack = if(config.read_model) Bool() else null
  val r_addr = if(config.read_model) UInt(config.dma_r_addr_Width bits) else null
  val r_len = if(config.read_model) UInt(config.dma_r_len_Width bits) else null

  val dvld = if(config.read_model) Bool() else null
  val rd_last = if(config.read_model) Bool() else null
  val rdata = if(config.read_model) Bits(config.dma_rdata_Width bits) else null
  val rbe = if(config.read_model) UInt(config.dma_rbe_Width bits) else null
  val dack =if(config.read_model) Bool() else null

  ///--- DMA write inf
  val w_req = if(!config.read_model) Bool() else null
  val w_ack = if(!config.read_model) Bool() else null
  val w_addr = if(!config.read_model) UInt(config.dma_w_addr_Width bits) else null
  val w_len = if(!config.read_model) UInt(config.dma_w_len_Width bits) else null

  val w_dvld = if(!config.read_model) Bool() else null
  val wdata = if(!config.read_model) Bits(config.dma_wdata_Width bits) else null
  val wbe = if(!config.read_model) UInt(config.dma_wbe_Width bits) else null
  val w_dack = if(!config.read_model) Bool() else null


  override def asMaster(): Unit ={
    //--- DMA read inf
    if(config.read_model) out(r_req)
    if(config.read_model) in(r_ack)
    if(config.read_model) out(r_addr,r_len)

    if(config.read_model) in(dvld,rd_last,rdata,rbe)
    if(config.read_model) out(dack)

    //--- DMA write inf
    if(!config.read_model) out(w_req)
    if(!config.read_model) in(w_ack)
    if(!config.read_model) out(w_addr,w_len)

    if(!config.read_model) out(w_dvld,wdata,wbe)
    if(!config.read_model) in(w_dack)

  }

}



//---------------------------------------------------------------


case class bufferBundleConfig(
                             //--- data buffer rd & sta
                             buf_rdata_Width : Int = 32,
                             buf_buf_word_Width : Int = 6,

                             //--- data buffer wr & sta
                             buf_wdata_Width : Int = 32,
                             buf_empty_word_Width : Int = 6,

                             read_data : Boolean = true
                             ){}

case class buffer_bundle(config : bufferBundleConfig) extends Bundle with  IMasterSlave{
  //--- data buffer rd & sta
  val buf_rd = if(config.read_data) Bool() else null
  val buf_rdata = if(config.read_data) Bits(config.buf_rdata_Width bits) else null
  val buf_buf_word = if(config.read_data) UInt(config.buf_buf_word_Width bits) else null
  val buf_empty = if(config.read_data) Bool() else null
  val buf_err = if(config.read_data) Bool() else null
  val clr_buf_err = if(config.read_data) Bool() else null

  //--- data buffer wr & sta
  val buf_wr = if(!config.read_data) Bool() else null
  val buf_wdata = if(!config.read_data) Bits(config.buf_wdata_Width bits) else null
  val buf_empty_word = if(!config.read_data) UInt(config.buf_empty_word_Width bits) else null


  override def asMaster(): Unit = {
    //--- data buffer rd & sta
    if(config.read_data) out(buf_rd)
    if(config.read_data) in(buf_rdata,buf_buf_word,buf_empty)
    if(config.read_data) out(buf_err)
    if(config.read_data) in(clr_buf_err)

    //--- data buffer wr & sta
    if(!config.read_data) out(buf_wr,buf_wdata)
    if(!config.read_data) in(buf_empty_word)
  }
}




