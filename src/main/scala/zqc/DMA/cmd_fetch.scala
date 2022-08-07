package zqc.DMA

import spinal.core.{Bool, Bundle, Component, IntToBuilder, Reg, True, UInt, in, when}
import spinal.lib.{master, slave}


case class cmd_fetch(llConfig : dmaLinkedListBundleConfig, dmaInfConfig : dmaInfBundleConfig) extends Component{
  val io = new Bundle{
    val ll = slave(cmd_linked_list_bundle(llConfig))
    val dma_inf = master(DMA_inf_bundle(dmaInfConfig))

    val rstn = in(Bool())
  }



  io.dma_inf.dma_r_req := io.ll.ll_req
  io.dma_inf.dma_r_addr := io.ll.ll_addr
  io.dma_inf.dma_r_len := 4*6 - 1
  io.dma_inf.dma_dack := True

  io.ll.ll_ack := io.dma_inf.dma_r_ack
  io.ll.ll_dvld := io.dma_inf.dma_dvld
  io.ll.ll_rdata := io.dma_inf.dma_rdata

  val ll_dcnt = Reg(UInt(llConfig.ll_dcnt_Width bits)) init(0)
  io.ll.ll_dcnt := ll_dcnt

  when(!io.rstn){
    ll_dcnt := 0
  }otherwise{
    when(io.ll.ll_req && io.ll.ll_ack){
      ll_dcnt := 0
    }otherwise{
      when(io.ll.ll_dvld){
       ll_dcnt := ll_dcnt + 1
      }
    }
  }
}
