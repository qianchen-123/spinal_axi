package zqc.QDMA

import spinal.core._
import spinal.core.internals.Operator
import spinal.lib._
import spinal.lib.bus.amba4.axi.{Axi4, Axi4Config}

import scala.tools.cmd.gen.AnyVals

case class qdma(axi_cfg : Axi4Config) extends BlackBox{
  //TODO define Generics
  //TODO define IO
  val io = new Bundle{

    //PCI Express Interface
    val sys_clk = in Bool()
    val sys_clk_gt = in Bool()
    val sys_rst_n = in Bool()

    val user_lnk_up = out Bool()

    val pci_exp_txp = out Bits(16 bits)
    val pci_exp_txn = out Bits(16 bits)
    val pci_exp_rxp = in Bits(16 bits)
    val pci_exp_rxn = in Bits(16 bits)

    //AXI Global
    val axi_aclk = out Bool()
    val axi_aresetn = out Bool()


    val usr_irq_in_vld = in Bool()
    val usr_irq_in_vec = in UInt(11 bits)
    val usr_irq_in_fnc = in UInt(8 bits)
    val usr_irq_out_ack =out Bool()
    val usr_irq_out_fail = out Bool()

    val tm_dsc_sts_vld = out Bool()
    val tm_dsc_sts_port_id = out UInt(3 bits)
    val tm_dsc_sts_qen = out Bool()
    val tm_dsc_sts_byp = out Bool()
    val tm_dsc_sts_dir = out Bool()
    val tm_dsc_sts_mm = out Bool()
    val tm_dsc_sts_error = out Bool()
    val tm_dsc_sts_qid = out UInt(11 bits)
    val tm_dsc_sts_avl = out UInt(16 bits)
    val tm_dsc_sts_qinv = out Bool()
    val tm_dsc_sts_irq_arm = out Bool()
    val tm_dsc_sts_rdy = in Bool()
    val tm_dsc_sts_pidx = out UInt(16 bits)

    val dsc_crdt_in_crdt = in UInt(16 bits)
    val dsc_crdt_in_qid = in UInt(11 bits)
    val dsc_crdt_in_dir = in Bool()
    val dsc_crdt_in_fence = in Bool()
    val dsc_crdt_in_vld = in Bool()
    val dsc_crdt_in_rdy = out Bool()

    //AXI Interface

    //AXI LITE interface
    //--- AW Channel
    val m_axil_awaddr = out UInt(32 bits)
    val m_axil_awuser = out UInt(55 bits)
    val m_axil_awprot = out UInt(3 bits)
    val m_axil_awvalid = out Bool()
    val m_axil_awready =  in Bool()
    //--- W Channel
    val m_axil_wdata = out Bits(32 bits)
    val m_axil_wstrb = out UInt(4 bits)
    val m_axil_wvalid = out Bool()
    val m_axil_wready = in Bool()
    //--- B Channel
    val m_axil_bvalid = in Bool()
    val m_axil_bresp = in UInt (2 bits)
    val m_axil_bready = out Bool()

    //--- AR Channel
    val m_axil_araddr = out UInt(32 bits)
    val m_axil_aruser = out UInt(55 bits)
    val m_axil_arprot = out UInt(3 bits)
    val m_axil_arvalid = in Bool()
    val m_axil_arready = in Bool()

    //--- R Channel
    val m_axil_rdata = in Bits(32 bits)
    val m_axil_rresp = in UInt(2 bits)
    val m_axil_rvalid = in Bool()
    val m_axil_rready = out Bool()

    val m_axis_h2c_tdata = out Bits(512 bits)
    val m_axis_h2c_tcrc = out UInt(32 bits)
    val m_axis_h2c_tuser_qid = out UInt(11 bits)
    val m_axis_h2c_tuser_port_id = out UInt(3 bits)
    val m_axis_h2c_tuser_err = out Bool()
    val m_axis_h2c_tuser_mdata = out Bits(32 bits)
    val m_axis_h2c_tuser_mty = out UInt(6 bits)
    val m_axis_h2c_tuser_zero_byte = out Bool()
    val m_axis_h2c_tvalid = out Bool()
    val m_axis_h2c_tlast = out Bool()
    val m_axis_h2c_tready = in Bool()

    val s_axis_c2h_tdata = in Bits(512 bits)
    val s_axis_c2h_tcrc = in UInt(32 bits)
    val s_axis_c2h_ctrl_marker = in Bool()
    val s_axis_c2h_ctrl_port_id = in UInt(3 bits)
    val s_axis_c2h_ctrl_ecc = in UInt(7 bits)
    val s_axis_c2h_ctrl_len = in UInt(16 bits)
    val s_axis_c2h_ctrl_qid = in UInt(11 bits)
    val s_axis_c2h_ctrl_has_cmpt = in Bool()
    val s_axis_c2h_mty = in UInt(6 bits)
    val s_axis_c2h_tvalid = in Bool()
    val s_axis_c2h_tlast = in Bool()
    val s_axis_c2h_tready = out Bool()
    val s_axis_c2h_cmpt_tdata = in Bits(512 bits)
    val s_axis_c2h_cmpt_size = in UInt(2 bits)
    val s_axis_c2h_cmpt_dpar = in UInt(16 bits)
    val s_axis_c2h_cmpt_tvalid = in Bool()
    val s_axis_c2h_cmpt_ctrl_qid = in UInt(11 bits)
    val s_axis_c2h_cmpt_ctrl_cmpt_type = in UInt(2 bits)
    val s_axis_c2h_cmpt_ctrl_wait_pld_pkt_id = in UInt(16 bits)
    val s_axis_c2h_cmpt_ctrl_port_id = in UInt(3 bits)
    val s_axis_c2h_cmpt_ctrl_marker = in Bool()
    val s_axis_c2h_cmpt_ctrl_user_trig = in Bool()
    val s_axis_c2h_cmpt_ctrl_col_idx = in UInt(3 bits)
    val s_axis_c2h_cmpt_ctrl_err_idx = in UInt(3 bits)
    val s_axis_c2h_cmpt_tready = out Bool()
    val s_axis_c2h_cmpt_ctrl_no_wrb_marker = in Bool()

    val axis_c2h_status_drop = out Bool()
    val axis_c2h_status_valid = out Bool()
    val axis_c2h_status_cmp = out Bool()
    val axis_c2h_status_error = out Bool()
    val axis_c2h_status_last = out Bool()
    val axis_c2h_status_qid = out UInt(11 bits)
    val axis_c2h_dmawr_cmp = out Bool()
    val soft_reset_n = in Bool()
    val phy_ready = out Bool()
    val qsts_out_op = out UInt(8 bits)
    val qsts_out_data = out UInt(64 bits)
    val qsts_out_port_id = out UInt(3 bits)
    val qsts_out_qid = out UInt(13 bits)
    val qsts_out_vld = out Bool()
    val qsts_out_rdy = in Bool()

  }

  //TODO define ClockDomains mappings
  mapClockDomain(clock = io.sys_clk,reset = io.sys_rst_n,resetActiveLevel = LOW)
  mapClockDomain(clock = io.axi_aclk,reset = io.axi_aresetn,resetActiveLevel = LOW)
}
