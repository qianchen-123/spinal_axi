package zqc.DMA

import spinal.core._
import spinal.lib._

case class cmd_fetch(ll_cfg : dma_ll_bundle_Config, dma_inf_cfg : dmaInfBundleConfig) extends Component{
  val io = new Bundle{
    val ll = slave(dma_ll_bundle(ll_cfg))
    val dma_inf = master(DMA_inf_bundle(dma_inf_cfg))

    //--- Global Signal
    val clk = in Bool()
    val rstn = in Bool()
  }

  val clkDomain = ClockDomain(clock = io.clk,
    reset = io.rstn,
    config = ClockDomainConfig(
      clockEdge = RISING,
      resetKind = ASYNC,
      resetActiveLevel = LOW
    )
  )

  val myArea = new ClockingArea(clkDomain){
    io.dma_inf.r_req := io.ll.req
    io.dma_inf.r_addr := io.ll.addr
    io.dma_inf.r_len := 4*6 - 1
    io.dma_inf.dack := True

    io.ll.ack := io.dma_inf.r_ack
    io.ll.dvld := io.dma_inf.dvld
    io.ll.rdata := io.dma_inf.rdata

    val ll_dcnt = Reg(UInt(ll_cfg.ll_dcnt_Width bits)) init(0)
    io.ll.dcnt := ll_dcnt

    when(io.ll.req && io.ll.ack){
      ll_dcnt := 0
    }otherwise{
      when(io.ll.dvld){
        ll_dcnt := ll_dcnt + 1
      }
    }
  }

}
