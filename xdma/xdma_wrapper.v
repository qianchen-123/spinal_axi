// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : xdma_wrapper
// Git hash  : 46d47d45b18d8abaa36a2d58097b9a7e224736f3

`timescale 1ns/1ps

module xdma_wrapper (
  output     [3:0]    io_cfg_mgmt_rxn,
  output     [3:0]    io_cfg_mgmt_rxp,
  input      [3:0]    io_cfg_mgmt_txn,
  input      [3:0]    io_cfg_mgmt_txp,
  input               io_sys_clk,
  input               io_sys_clk_gt,
  input               io_sys_rst_n,
  output              io_user_lnk_up,
  input      [3:0]    io_pci_exp_rxn,
  input      [3:0]    io_pci_exp_rxp,
  output     [3:0]    io_pci_exp_txn,
  output     [3:0]    io_pci_exp_txp,
  output              io_axi_aclk,
  output              io_axi_aresetn,
  input      [0:0]    io_usr_irq_req,
  output     [0:0]    io_usr_irq_ack,
  output              io_msi_enable,
  output     [2:0]    io_msi_vector_width,
  output              io_m_axi_aw_valid,
  input               io_m_axi_aw_ready,
  output     [31:0]   io_m_axi_aw_payload_addr,
  output     [3:0]    io_m_axi_aw_payload_id,
  output     [7:0]    io_m_axi_aw_payload_len,
  output     [2:0]    io_m_axi_aw_payload_size,
  output     [1:0]    io_m_axi_aw_payload_burst,
  output     [0:0]    io_m_axi_aw_payload_lock,
  output     [3:0]    io_m_axi_aw_payload_cache,
  output     [2:0]    io_m_axi_aw_payload_prot,
  output              io_m_axi_w_valid,
  input               io_m_axi_w_ready,
  output     [31:0]   io_m_axi_w_payload_data,
  output     [3:0]    io_m_axi_w_payload_strb,
  output              io_m_axi_w_payload_last,
  input               io_m_axi_b_valid,
  output              io_m_axi_b_ready,
  input      [3:0]    io_m_axi_b_payload_id,
  input      [1:0]    io_m_axi_b_payload_resp,
  output              io_m_axi_ar_valid,
  input               io_m_axi_ar_ready,
  output     [31:0]   io_m_axi_ar_payload_addr,
  output     [3:0]    io_m_axi_ar_payload_id,
  output     [7:0]    io_m_axi_ar_payload_len,
  output     [2:0]    io_m_axi_ar_payload_size,
  output     [1:0]    io_m_axi_ar_payload_burst,
  output     [0:0]    io_m_axi_ar_payload_lock,
  output     [3:0]    io_m_axi_ar_payload_cache,
  output     [2:0]    io_m_axi_ar_payload_prot,
  input               io_m_axi_r_valid,
  output              io_m_axi_r_ready,
  input      [31:0]   io_m_axi_r_payload_data,
  input      [3:0]    io_m_axi_r_payload_id,
  input      [1:0]    io_m_axi_r_payload_resp,
  input               io_m_axi_r_payload_last
);

  wire       [3:0]    xdma_0_cfg_mgmt_rxn;
  wire       [3:0]    xdma_0_cfg_mgmt_rxp;
  wire                xdma_0_user_lnk_up;
  wire       [3:0]    xdma_0_pci_exp_txn;
  wire       [3:0]    xdma_0_pci_exp_txp;
  wire                xdma_0_axi_aclk;
  wire                xdma_0_axi_aresetn;
  wire       [0:0]    xdma_0_usr_irq_ack;
  wire                xdma_0_msi_enable;
  wire       [2:0]    xdma_0_msi_vector_width;
  wire                xdma_0_m_axi_ar_valid;
  wire       [31:0]   xdma_0_m_axi_ar_payload_addr;
  wire       [3:0]    xdma_0_m_axi_ar_payload_id;
  wire       [7:0]    xdma_0_m_axi_ar_payload_len;
  wire       [2:0]    xdma_0_m_axi_ar_payload_size;
  wire       [1:0]    xdma_0_m_axi_ar_payload_burst;
  wire       [0:0]    xdma_0_m_axi_ar_payload_lock;
  wire       [3:0]    xdma_0_m_axi_ar_payload_cache;
  wire       [2:0]    xdma_0_m_axi_ar_payload_prot;
  wire                xdma_0_m_axi_aw_valid;
  wire       [31:0]   xdma_0_m_axi_aw_payload_addr;
  wire       [3:0]    xdma_0_m_axi_aw_payload_id;
  wire       [7:0]    xdma_0_m_axi_aw_payload_len;
  wire       [2:0]    xdma_0_m_axi_aw_payload_size;
  wire       [1:0]    xdma_0_m_axi_aw_payload_burst;
  wire       [0:0]    xdma_0_m_axi_aw_payload_lock;
  wire       [3:0]    xdma_0_m_axi_aw_payload_cache;
  wire       [2:0]    xdma_0_m_axi_aw_payload_prot;
  wire                xdma_0_m_axi_w_valid;
  wire       [31:0]   xdma_0_m_axi_w_payload_data;
  wire       [3:0]    xdma_0_m_axi_w_payload_strb;
  wire                xdma_0_m_axi_w_payload_last;
  wire                xdma_0_m_axi_r_ready;
  wire                xdma_0_m_axi_b_ready;

  xdma xdma_0 (
    .cfg_mgmt_rxn           (xdma_0_cfg_mgmt_rxn[3:0]          ), //o
    .cfg_mgmt_rxp           (xdma_0_cfg_mgmt_rxp[3:0]          ), //o
    .cfg_mgmt_txn           (io_cfg_mgmt_txn[3:0]              ), //i
    .cfg_mgmt_txp           (io_cfg_mgmt_txp[3:0]              ), //i
    .sys_clk                (io_sys_clk                        ), //i
    .sys_clk_gt             (io_sys_clk_gt                     ), //i
    .sys_rst_n              (io_sys_rst_n                      ), //i
    .user_lnk_up            (xdma_0_user_lnk_up                ), //o
    .pci_exp_rxn            (io_pci_exp_rxn[3:0]               ), //i
    .pci_exp_rxp            (io_pci_exp_rxp[3:0]               ), //i
    .pci_exp_txn            (xdma_0_pci_exp_txn[3:0]           ), //o
    .pci_exp_txp            (xdma_0_pci_exp_txp[3:0]           ), //o
    .axi_aclk               (xdma_0_axi_aclk                   ), //o
    .axi_aresetn            (xdma_0_axi_aresetn                ), //o
    .usr_irq_req            (io_usr_irq_req                    ), //i
    .usr_irq_ack            (xdma_0_usr_irq_ack                ), //o
    .msi_enable             (xdma_0_msi_enable                 ), //o
    .msi_vector_width       (xdma_0_msi_vector_width[2:0]      ), //o
    .m_axi_aw_valid         (xdma_0_m_axi_aw_valid             ), //o
    .m_axi_aw_ready         (io_m_axi_aw_ready                 ), //i
    .m_axi_aw_payload_addr  (xdma_0_m_axi_aw_payload_addr[31:0]), //o
    .m_axi_aw_payload_id    (xdma_0_m_axi_aw_payload_id[3:0]   ), //o
    .m_axi_aw_payload_len   (xdma_0_m_axi_aw_payload_len[7:0]  ), //o
    .m_axi_aw_payload_size  (xdma_0_m_axi_aw_payload_size[2:0] ), //o
    .m_axi_aw_payload_burst (xdma_0_m_axi_aw_payload_burst[1:0]), //o
    .m_axi_aw_payload_lock  (xdma_0_m_axi_aw_payload_lock      ), //o
    .m_axi_aw_payload_cache (xdma_0_m_axi_aw_payload_cache[3:0]), //o
    .m_axi_aw_payload_prot  (xdma_0_m_axi_aw_payload_prot[2:0] ), //o
    .m_axi_w_valid          (xdma_0_m_axi_w_valid              ), //o
    .m_axi_w_ready          (io_m_axi_w_ready                  ), //i
    .m_axi_w_payload_data   (xdma_0_m_axi_w_payload_data[31:0] ), //o
    .m_axi_w_payload_strb   (xdma_0_m_axi_w_payload_strb[3:0]  ), //o
    .m_axi_w_payload_last   (xdma_0_m_axi_w_payload_last       ), //o
    .m_axi_b_valid          (io_m_axi_b_valid                  ), //i
    .m_axi_b_ready          (xdma_0_m_axi_b_ready              ), //o
    .m_axi_b_payload_id     (io_m_axi_b_payload_id[3:0]        ), //i
    .m_axi_b_payload_resp   (io_m_axi_b_payload_resp[1:0]      ), //i
    .m_axi_ar_valid         (xdma_0_m_axi_ar_valid             ), //o
    .m_axi_ar_ready         (io_m_axi_ar_ready                 ), //i
    .m_axi_ar_payload_addr  (xdma_0_m_axi_ar_payload_addr[31:0]), //o
    .m_axi_ar_payload_id    (xdma_0_m_axi_ar_payload_id[3:0]   ), //o
    .m_axi_ar_payload_len   (xdma_0_m_axi_ar_payload_len[7:0]  ), //o
    .m_axi_ar_payload_size  (xdma_0_m_axi_ar_payload_size[2:0] ), //o
    .m_axi_ar_payload_burst (xdma_0_m_axi_ar_payload_burst[1:0]), //o
    .m_axi_ar_payload_lock  (xdma_0_m_axi_ar_payload_lock      ), //o
    .m_axi_ar_payload_cache (xdma_0_m_axi_ar_payload_cache[3:0]), //o
    .m_axi_ar_payload_prot  (xdma_0_m_axi_ar_payload_prot[2:0] ), //o
    .m_axi_r_valid          (io_m_axi_r_valid                  ), //i
    .m_axi_r_ready          (xdma_0_m_axi_r_ready              ), //o
    .m_axi_r_payload_data   (io_m_axi_r_payload_data[31:0]     ), //i
    .m_axi_r_payload_id     (io_m_axi_r_payload_id[3:0]        ), //i
    .m_axi_r_payload_resp   (io_m_axi_r_payload_resp[1:0]      ), //i
    .m_axi_r_payload_last   (io_m_axi_r_payload_last           )  //i
  );
  assign io_cfg_mgmt_rxn = xdma_0_cfg_mgmt_rxn;
  assign io_cfg_mgmt_rxp = xdma_0_cfg_mgmt_rxp;
  assign io_user_lnk_up = xdma_0_user_lnk_up;
  assign io_pci_exp_txn = xdma_0_pci_exp_txn;
  assign io_pci_exp_txp = xdma_0_pci_exp_txp;
  assign io_axi_aclk = xdma_0_axi_aclk;
  assign io_axi_aresetn = xdma_0_axi_aresetn;
  assign io_usr_irq_ack = xdma_0_usr_irq_ack;
  assign io_msi_enable = xdma_0_msi_enable;
  assign io_msi_vector_width = xdma_0_msi_vector_width;
  assign io_m_axi_aw_valid = xdma_0_m_axi_aw_valid;
  assign io_m_axi_aw_payload_addr = xdma_0_m_axi_aw_payload_addr;
  assign io_m_axi_aw_payload_id = xdma_0_m_axi_aw_payload_id;
  assign io_m_axi_aw_payload_len = xdma_0_m_axi_aw_payload_len;
  assign io_m_axi_aw_payload_size = xdma_0_m_axi_aw_payload_size;
  assign io_m_axi_aw_payload_burst = xdma_0_m_axi_aw_payload_burst;
  assign io_m_axi_aw_payload_lock = xdma_0_m_axi_aw_payload_lock;
  assign io_m_axi_aw_payload_cache = xdma_0_m_axi_aw_payload_cache;
  assign io_m_axi_aw_payload_prot = xdma_0_m_axi_aw_payload_prot;
  assign io_m_axi_w_valid = xdma_0_m_axi_w_valid;
  assign io_m_axi_w_payload_data = xdma_0_m_axi_w_payload_data;
  assign io_m_axi_w_payload_strb = xdma_0_m_axi_w_payload_strb;
  assign io_m_axi_w_payload_last = xdma_0_m_axi_w_payload_last;
  assign io_m_axi_b_ready = xdma_0_m_axi_b_ready;
  assign io_m_axi_ar_valid = xdma_0_m_axi_ar_valid;
  assign io_m_axi_ar_payload_addr = xdma_0_m_axi_ar_payload_addr;
  assign io_m_axi_ar_payload_id = xdma_0_m_axi_ar_payload_id;
  assign io_m_axi_ar_payload_len = xdma_0_m_axi_ar_payload_len;
  assign io_m_axi_ar_payload_size = xdma_0_m_axi_ar_payload_size;
  assign io_m_axi_ar_payload_burst = xdma_0_m_axi_ar_payload_burst;
  assign io_m_axi_ar_payload_lock = xdma_0_m_axi_ar_payload_lock;
  assign io_m_axi_ar_payload_cache = xdma_0_m_axi_ar_payload_cache;
  assign io_m_axi_ar_payload_prot = xdma_0_m_axi_ar_payload_prot;
  assign io_m_axi_r_ready = xdma_0_m_axi_r_ready;

endmodule
