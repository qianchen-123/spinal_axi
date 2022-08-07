package zqc.DMA

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba3.apb.{Apb3, Apb3Config}

case class dmaLinkedListBundleConfig(
                                      //--- cmd link list regs
                                      llr_Width : Int = 32,
                                      ll_rdata_Width : Int = 32,
                                      ll_dcnt_Width : Int = 3
                                    ){

}

case class cmd_linked_list_bundle(config : dmaLinkedListBundleConfig) extends Bundle with IMasterSlave{

  //--- cmd linked list req and ack
  val ll_req = Bool()
  val ll_addr = UInt(config.llr_Width bits)
  val ll_ack = Bool()
  val ll_dvld = Bool()
  val ll_rdata = Bits(config.ll_rdata_Width bits) // Bits
  val ll_dcnt = UInt(config.ll_dcnt_Width bits)

  override def asMaster(): Unit ={
    //--- cmd linked list
    out(ll_req,ll_addr)
    in(ll_ack,ll_dvld,ll_rdata,ll_dcnt)
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
  val dma_r_req = if(config.read_model) Bool() else null
  val dma_r_ack = if(config.read_model) Bool() else null
  val dma_r_addr = if(config.read_model) UInt(config.dma_r_addr_Width bits) else null
  val dma_r_len = if(config.read_model) UInt(config.dma_r_len_Width bits) else null

  val dma_dvld = if(config.read_model) Bool() else null
  val dma_rd_last = if(config.read_model) Bool() else null
  val dma_rdata = if(config.read_model) Bits(config.dma_rdata_Width bits) else null
  val dma_rbe = if(config.read_model) UInt(config.dma_rbe_Width bits) else null
  val dma_dack =if(config.read_model) Bool() else null

  ///--- DMA write inf
  val dma_w_req = if(!config.read_model) Bool() else null
  val dma_w_ack = if(!config.read_model) Bool() else null
  val dma_w_addr = if(!config.read_model) UInt(config.dma_w_addr_Width bits) else null
  val dma_w_len = if(!config.read_model) UInt(config.dma_w_len_Width bits) else null

  val dma_w_dvld = if(!config.read_model) Bool() else null
  val dma_wdata = if(!config.read_model) Bits(config.dma_wdata_Width bits) else null
  val dma_wbe = if(!config.read_model) UInt(config.dma_wbe_Width bits) else null
  val dma_w_dack = if(!config.read_model) Bool() else null


  override def asMaster(): Unit ={
    //--- DMA read inf
    if(config.read_model) out(dma_r_req)
    if(config.read_model) in(dma_r_ack)
    if(config.read_model) out(dma_r_addr,dma_r_len)

    if(config.read_model) in(dma_dvld,dma_rd_last,dma_rdata,dma_rbe)
    if(config.read_model) out(dma_dack)

    //--- DMA write inf
    if(!config.read_model) out(dma_w_req)
    if(!config.read_model) in(dma_w_ack)
    if(!config.read_model) out(dma_w_addr,dma_w_len)

    if(!config.read_model) out(dma_w_dvld,dma_wdata,dma_wbe)
    if(!config.read_model) in(dma_w_dack)

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


//---------------------------------------------------------------


case class dmaBundleConfig(

                            //---cfg regs
                            sar_Width : Int = 32,
                            dar_Width : Int = 32,
                            trans_xsize_Width : Int = 16,
                            trans_ysize_Width : Int = 16,
                            sa_ystep_Width : Int = 16,
                            da_ystep_Width : Int = 16,

                            //--- cmd link list regs
                            llr_Width : Int = 32,
                            ll_rdata_Width : Int = 32,
                            ll_dcnt_Width : Int = 3,

                            cmd_num_Width : Int = 8
                          ){

}

case class dma_bundle(val config : dmaBundleConfig, apb3Config: Apb3Config) extends Bundle with IMasterSlave{

  //--- APB configure inf
  val dma_apb = Apb3(apb3Config)

  //--- cfg regs
  val sar = UInt(config.sar_Width bits)
  val dar = UInt(config.dar_Width bits)
  val trans_xsize = UInt(config.trans_xsize_Width bits)
  val trans_ysize = UInt(config.trans_ysize_Width bits)
  val sa_ystep = UInt(config.sa_ystep_Width bits)
  val da_ystep = UInt(config.da_ystep_Width bits)
  val llr = UInt(config.llr_Width bits)
  val dma_halt = Bool()
  val bf = Bool()
  val cf = Bool()

  val buf_err = Bool()
  val clr_bur_err = Bool()

  //--- cmd linked list req and ack
  val ll_req = Bool()
  val ll_addr = UInt(config.llr_Width bits)
  val ll_ack = Bool()
  val ll_dvld = Bool()
  val ll_rdata = Bits(config.ll_rdata_Width bits) // Bits
  val ll_dcnt = UInt(config.ll_dcnt_Width bits)

  //--- dma status
  val dma_cmd_sof = Bool()
  val dma_cmd_end = Bool()
  val cmd_num = UInt(config.cmd_num_Width bits)
  val dma_busy = Bool()
  val intr = Bool()

  //--- basic signal
  val clk = Bool()
  val rstn = Bool()

  override def asMaster(): Unit = {

    //--- apb
    slave(dma_apb)

    //--- cfg regs
    out(sar,dar,trans_xsize,trans_ysize,sa_ystep,da_ystep,llr)
    out(dma_halt,bf,cf)

    in(buf_err)
    out(clr_bur_err)

    //--- cmd linked list
    out(ll_req,ll_addr)
    in(ll_ack,ll_dvld,ll_rdata,ll_dcnt)

    //--- dma status
    out(dma_cmd_sof)
    in(dma_cmd_end)
    out(cmd_num,dma_busy,intr)

    //---basic signal
    in(clk,rstn)
  }
}
