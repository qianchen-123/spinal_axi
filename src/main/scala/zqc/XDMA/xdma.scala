package zqc.XDMA

import spinal.core._
import spinal.lib._
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config}


case class pcie_cfg_mgmt() extends  Bundle with IMasterSlave{
  val addr = Bits(19 bits)
  val byte_enable = Bits(4 bits)
  val read_data = Bits(32 bits)
  val read = Bool()
  val read_write_done = Bool()
  val write_data = Bits(32 bits)
  val write = Bool()
  override def asMaster(): Unit = {
    out(addr)
    out(byte_enable)
    in(read_data)
    out(read)
    in(read_write_done)
    out(write_data)
    out(write)
  }
}

case class pcie_mgt_bundle() extends Bundle with IMasterSlave{
  val rxn = Bits(4 bits)
  val rxp = Bits(4 bits)
  val txn = Bits(4 bits)
  val txp = Bits(4 bits)
  override def asMaster(): Unit = {
    in(rxn,rxp)
    out(txn,txp)
  }
}

case class xdma(axi_cfg : Axi4Config) extends BlackBox{
  //TODO define Generics
  //TODO define IO
  val io = new Bundle{
    val cfg_mgmt = slave(pcie_mgt_bundle())

    val sys_clk = in Bool()
    val sys_clk_gt = in Bool()
    val sys_rst_n = in Bool()

    val user_lnk_up = out Bool()

    val pci_exp = master(pcie_mgt_bundle())

    val axi_aclk = out Bool()
    val axi_aresetn = out Bool()

    val usr_irq_req = in Bits(1 bits)
    val usr_irq_ack = out Bits(1 bits)

    val msi_enable = out Bool()
    val msi_vector_width = out Bits(3 bits)

    val m_axi = master(Axi4(axi_cfg))

  }

  noIoPrefix()

  private  def renameIO(): Unit = {
    io.flatten.foreach(bt =>{
      if(bt.getName().contains("payload_")) bt.setName(bt.getName().replace("payload_",""))
      if(bt.getName().contains("m_axi_ar_")) bt.setName(bt.getName().replace("m_axi_ar_","m_axi_ar"))
      if(bt.getName().contains("m_axi_r_")) bt.setName(bt.getName().replace("m_axi_r_","m_axi_r"))
      if(bt.getName().contains("m_axi_aw_")) bt.setName(bt.getName().replace("m_axi_aw_","m_axi_aw"))
      if(bt.getName().contains("m_axi_w_")) bt.setName(bt.getName().replace("m_axi_w_","m_axi_w"))
      if(bt.getName().contains("m_axi_b_")) bt.setName(bt.getName().replace("m_axi_b_","m_axi_b"))

    })
  }

  addPrePopTask(() => renameIO())

  // TODO define ClockDomains mappings
//  mapClockDomain(clock = io.sys_clk,reset = io.sys_rst_n,resetActiveLevel = LOW)
//  mapClockDomain(clock = io.sys_clk_gt,reset = io.sys_rst_n,resetActiveLevel = LOW)
//  mapClockDomain(clock = io.axi_aclk)

}
