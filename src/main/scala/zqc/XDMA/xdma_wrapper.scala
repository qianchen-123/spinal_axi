package zqc.XDMA

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config}


case class xdma_wrapper(axi4Config: Axi4Config) extends Component{
  val io = new Bundle{
    val cfg_mgmt = slave(pcie_mgt_bundle())

    val sys_clk = in Bool()
    val sys_clk_gt = in Bool()
    val sys_rst_n = in Bool()

    val user_lnk_up = out Bool()

    val pci_exp = master(pcie_mgt_bundle())

    val axi_aclk = out Bool()
    val axi_aresetn = out Bool()

    val usr_irq_req = in Bits (1 bits)
    val usr_irq_ack = out Bits (1 bits)

    val msi_enable = out Bool()
    val msi_vector_width = out Bits (3 bits)

    val m_axi = master(Axi4(axi4Config))
  }

  val xdma_0 = new xdma(axi4Config)
  io.cfg_mgmt <> xdma_0.io.cfg_mgmt
  io.sys_clk <> xdma_0.io.sys_clk
  io.sys_clk_gt <> xdma_0.io.sys_clk_gt
  io.sys_rst_n <> xdma_0.io.sys_rst_n
  io.user_lnk_up <> xdma_0.io.user_lnk_up
  io.pci_exp <> xdma_0.io.pci_exp
  io.axi_aclk <> xdma_0.io.axi_aclk
  io.axi_aresetn <> xdma_0.io.axi_aresetn
  io.usr_irq_req <> xdma_0.io.usr_irq_req
  io.usr_irq_ack <> xdma_0.io.usr_irq_ack
  io.msi_enable <> xdma_0.io.msi_enable
  io.msi_vector_width <> xdma_0.io.msi_vector_width
  io.m_axi <> xdma_0.io.m_axi

}
