// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : cdma
// Git hash  : 46d47d45b18d8abaa36a2d58097b9a7e224736f3

`timescale 1ns/1ps

module cdma (
  input      [7:0]    io_apb_PADDR,
  input      [0:0]    io_apb_PSEL,
  input               io_apb_PENABLE,
  output              io_apb_PREADY,
  input               io_apb_PWRITE,
  input      [31:0]   io_apb_PWDATA,
  output     [31:0]   io_apb_PRDATA,
  output              io_axi_aw_valid,
  input               io_axi_aw_ready,
  output     [31:0]   io_axi_aw_payload_addr,
  output     [3:0]    io_axi_aw_payload_id,
  output     [7:0]    io_axi_aw_payload_len,
  output     [2:0]    io_axi_aw_payload_size,
  output     [1:0]    io_axi_aw_payload_burst,
  output     [0:0]    io_axi_aw_payload_lock,
  output     [3:0]    io_axi_aw_payload_cache,
  output     [2:0]    io_axi_aw_payload_prot,
  output              io_axi_w_valid,
  input               io_axi_w_ready,
  output     [31:0]   io_axi_w_payload_data,
  output     [3:0]    io_axi_w_payload_strb,
  output              io_axi_w_payload_last,
  input               io_axi_b_valid,
  output              io_axi_b_ready,
  input      [3:0]    io_axi_b_payload_id,
  input      [1:0]    io_axi_b_payload_resp,
  output              io_axi_ar_valid,
  input               io_axi_ar_ready,
  output     [31:0]   io_axi_ar_payload_addr,
  output     [3:0]    io_axi_ar_payload_id,
  output     [7:0]    io_axi_ar_payload_len,
  output     [2:0]    io_axi_ar_payload_size,
  output     [1:0]    io_axi_ar_payload_burst,
  output     [0:0]    io_axi_ar_payload_lock,
  output     [3:0]    io_axi_ar_payload_cache,
  output     [2:0]    io_axi_ar_payload_prot,
  input               io_axi_r_valid,
  output              io_axi_r_ready,
  input      [31:0]   io_axi_r_payload_data,
  input      [3:0]    io_axi_r_payload_id,
  input      [1:0]    io_axi_r_payload_resp,
  input               io_axi_r_payload_last,
  output              io_intr,
  input               io_clk,
  input               io_rstn
);

  wire                dma_2_axi_1_io_cfg_clr_bur_err;
  wire                dma_cfg_1_io_apb_PREADY;
  wire       [31:0]   dma_cfg_1_io_apb_PRDATA;
  wire       [31:0]   dma_cfg_1_io_cfg_sar;
  wire       [31:0]   dma_cfg_1_io_cfg_dar;
  wire       [15:0]   dma_cfg_1_io_cfg_trans_xsize;
  wire       [15:0]   dma_cfg_1_io_cfg_trans_ysize;
  wire       [15:0]   dma_cfg_1_io_cfg_sa_ystep;
  wire       [15:0]   dma_cfg_1_io_cfg_da_ystep;
  wire       [31:0]   dma_cfg_1_io_cfg_llr;
  wire                dma_cfg_1_io_cfg_dma_halt;
  wire                dma_cfg_1_io_cfg_bf;
  wire                dma_cfg_1_io_cfg_cf;
  wire                dma_cfg_1_io_cfg_clr_bur_err;
  wire                dma_cfg_1_io_ll_req;
  wire       [31:0]   dma_cfg_1_io_ll_addr;
  wire                dma_cfg_1_io_dma_cmd_sof;
  wire       [7:0]    dma_cfg_1_io_dma_cmd_num;
  wire                dma_cfg_1_io_dma_busy;
  wire                dma_cfg_1_io_dma_intr;
  wire                cmd_fetch_1_io_ll_ack;
  wire                cmd_fetch_1_io_ll_dvld;
  wire       [31:0]   cmd_fetch_1_io_ll_rdata;
  wire       [2:0]    cmd_fetch_1_io_ll_dcnt;
  wire                cmd_fetch_1_io_dma_inf_r_req;
  wire       [31:0]   cmd_fetch_1_io_dma_inf_r_addr;
  wire       [15:0]   cmd_fetch_1_io_dma_inf_r_len;
  wire                cmd_fetch_1_io_dma_inf_dack;
  wire                rcmd_gen_1_io_dma_inf_r_req;
  wire       [31:0]   rcmd_gen_1_io_dma_inf_r_addr;
  wire       [15:0]   rcmd_gen_1_io_dma_inf_r_len;
  wire                rcmd_gen_1_io_dma_inf_dack;
  wire                rcmd_gen_1_io_buffer_buf_wr;
  wire       [31:0]   rcmd_gen_1_io_buffer_buf_wdata;
  wire                wcmd_gen_1_io_dma_cmd_end;
  wire                wcmd_gen_1_io_dma_inf_w_req;
  wire       [31:0]   wcmd_gen_1_io_dma_inf_w_addr;
  wire       [15:0]   wcmd_gen_1_io_dma_inf_w_len;
  wire                wcmd_gen_1_io_dma_inf_w_dvld;
  wire       [31:0]   wcmd_gen_1_io_dma_inf_wdata;
  wire       [3:0]    wcmd_gen_1_io_dma_inf_wbe;
  wire                wcmd_gen_1_io_buffer_buf_rd;
  wire                wcmd_gen_1_io_buffer_buf_err;
  wire       [5:0]    dma_buf_1_io_wr_buf_empty_word;
  wire       [31:0]   dma_buf_1_io_rd_buf_rdata;
  wire       [5:0]    dma_buf_1_io_rd_buf_buf_word;
  wire                dma_buf_1_io_rd_buf_empty;
  wire                dma_buf_1_io_rd_clr_buf_err;
  wire                dma_2_axi_1_io_cfg_buf_err;
  wire                dma_2_axi_1_io_dma_inf_w_w_ack;
  wire                dma_2_axi_1_io_dma_inf_w_w_dack;
  wire                dma_2_axi_1_io_dma_inf_r_1_r_ack;
  wire                dma_2_axi_1_io_dma_inf_r_1_dvld;
  wire                dma_2_axi_1_io_dma_inf_r_1_rd_last;
  wire       [31:0]   dma_2_axi_1_io_dma_inf_r_1_rdata;
  wire       [3:0]    dma_2_axi_1_io_dma_inf_r_1_rbe;
  wire                dma_2_axi_1_io_dma_inf_r_2_r_ack;
  wire                dma_2_axi_1_io_dma_inf_r_2_dvld;
  wire                dma_2_axi_1_io_dma_inf_r_2_rd_last;
  wire       [31:0]   dma_2_axi_1_io_dma_inf_r_2_rdata;
  wire       [3:0]    dma_2_axi_1_io_dma_inf_r_2_rbe;
  wire                dma_2_axi_1_io_axi_ar_valid;
  wire       [31:0]   dma_2_axi_1_io_axi_ar_payload_addr;
  wire       [3:0]    dma_2_axi_1_io_axi_ar_payload_id;
  wire       [7:0]    dma_2_axi_1_io_axi_ar_payload_len;
  wire       [2:0]    dma_2_axi_1_io_axi_ar_payload_size;
  wire       [1:0]    dma_2_axi_1_io_axi_ar_payload_burst;
  wire       [0:0]    dma_2_axi_1_io_axi_ar_payload_lock;
  wire       [3:0]    dma_2_axi_1_io_axi_ar_payload_cache;
  wire       [2:0]    dma_2_axi_1_io_axi_ar_payload_prot;
  wire                dma_2_axi_1_io_axi_aw_valid;
  wire       [31:0]   dma_2_axi_1_io_axi_aw_payload_addr;
  wire       [3:0]    dma_2_axi_1_io_axi_aw_payload_id;
  wire       [7:0]    dma_2_axi_1_io_axi_aw_payload_len;
  wire       [2:0]    dma_2_axi_1_io_axi_aw_payload_size;
  wire       [1:0]    dma_2_axi_1_io_axi_aw_payload_burst;
  wire       [0:0]    dma_2_axi_1_io_axi_aw_payload_lock;
  wire       [3:0]    dma_2_axi_1_io_axi_aw_payload_cache;
  wire       [2:0]    dma_2_axi_1_io_axi_aw_payload_prot;
  wire                dma_2_axi_1_io_axi_w_valid;
  wire       [31:0]   dma_2_axi_1_io_axi_w_payload_data;
  wire       [3:0]    dma_2_axi_1_io_axi_w_payload_strb;
  wire                dma_2_axi_1_io_axi_w_payload_last;
  wire                dma_2_axi_1_io_axi_r_ready;
  wire                dma_2_axi_1_io_axi_b_ready;

  dma_cfg dma_cfg_1 (
    .io_apb_PADDR       (io_apb_PADDR[7:0]                 ), //i
    .io_apb_PSEL        (io_apb_PSEL                       ), //i
    .io_apb_PENABLE     (io_apb_PENABLE                    ), //i
    .io_apb_PREADY      (dma_cfg_1_io_apb_PREADY           ), //o
    .io_apb_PWRITE      (io_apb_PWRITE                     ), //i
    .io_apb_PWDATA      (io_apb_PWDATA[31:0]               ), //i
    .io_apb_PRDATA      (dma_cfg_1_io_apb_PRDATA[31:0]     ), //o
    .io_cfg_sar         (dma_cfg_1_io_cfg_sar[31:0]        ), //o
    .io_cfg_dar         (dma_cfg_1_io_cfg_dar[31:0]        ), //o
    .io_cfg_trans_xsize (dma_cfg_1_io_cfg_trans_xsize[15:0]), //o
    .io_cfg_trans_ysize (dma_cfg_1_io_cfg_trans_ysize[15:0]), //o
    .io_cfg_sa_ystep    (dma_cfg_1_io_cfg_sa_ystep[15:0]   ), //o
    .io_cfg_da_ystep    (dma_cfg_1_io_cfg_da_ystep[15:0]   ), //o
    .io_cfg_llr         (dma_cfg_1_io_cfg_llr[31:0]        ), //o
    .io_cfg_dma_halt    (dma_cfg_1_io_cfg_dma_halt         ), //o
    .io_cfg_bf          (dma_cfg_1_io_cfg_bf               ), //o
    .io_cfg_cf          (dma_cfg_1_io_cfg_cf               ), //o
    .io_cfg_buf_err     (wcmd_gen_1_io_buffer_buf_err      ), //i
    .io_cfg_clr_bur_err (dma_cfg_1_io_cfg_clr_bur_err      ), //o
    .io_ll_req          (dma_cfg_1_io_ll_req               ), //o
    .io_ll_addr         (dma_cfg_1_io_ll_addr[31:0]        ), //o
    .io_ll_ack          (cmd_fetch_1_io_ll_ack             ), //i
    .io_ll_dvld         (cmd_fetch_1_io_ll_dvld            ), //i
    .io_ll_rdata        (cmd_fetch_1_io_ll_rdata[31:0]     ), //i
    .io_ll_dcnt         (cmd_fetch_1_io_ll_dcnt[2:0]       ), //i
    .io_dma_cmd_sof     (dma_cfg_1_io_dma_cmd_sof          ), //o
    .io_dma_cmd_end     (wcmd_gen_1_io_dma_cmd_end         ), //i
    .io_dma_cmd_num     (dma_cfg_1_io_dma_cmd_num[7:0]     ), //o
    .io_dma_busy        (dma_cfg_1_io_dma_busy             ), //o
    .io_dma_intr        (dma_cfg_1_io_dma_intr             ), //o
    .io_clk             (io_clk                            ), //i
    .io_rstn            (io_rstn                           )  //i
  );
  cmd_fetch cmd_fetch_1 (
    .io_ll_req          (dma_cfg_1_io_ll_req                   ), //i
    .io_ll_addr         (dma_cfg_1_io_ll_addr[31:0]            ), //i
    .io_ll_ack          (cmd_fetch_1_io_ll_ack                 ), //o
    .io_ll_dvld         (cmd_fetch_1_io_ll_dvld                ), //o
    .io_ll_rdata        (cmd_fetch_1_io_ll_rdata[31:0]         ), //o
    .io_ll_dcnt         (cmd_fetch_1_io_ll_dcnt[2:0]           ), //o
    .io_dma_inf_r_req   (cmd_fetch_1_io_dma_inf_r_req          ), //o
    .io_dma_inf_r_ack   (dma_2_axi_1_io_dma_inf_r_2_r_ack      ), //i
    .io_dma_inf_r_addr  (cmd_fetch_1_io_dma_inf_r_addr[31:0]   ), //o
    .io_dma_inf_r_len   (cmd_fetch_1_io_dma_inf_r_len[15:0]    ), //o
    .io_dma_inf_dvld    (dma_2_axi_1_io_dma_inf_r_2_dvld       ), //i
    .io_dma_inf_rd_last (dma_2_axi_1_io_dma_inf_r_2_rd_last    ), //i
    .io_dma_inf_rdata   (dma_2_axi_1_io_dma_inf_r_2_rdata[31:0]), //i
    .io_dma_inf_rbe     (dma_2_axi_1_io_dma_inf_r_2_rbe[3:0]   ), //i
    .io_dma_inf_dack    (cmd_fetch_1_io_dma_inf_dack           ), //o
    .io_clk             (io_clk                                ), //i
    .io_rstn            (io_rstn                               )  //i
  );
  rcmd_gen rcmd_gen_1 (
    .io_cfg_sar               (dma_cfg_1_io_cfg_sar[31:0]            ), //i
    .io_cfg_trans_xsize       (dma_cfg_1_io_cfg_trans_xsize[15:0]    ), //i
    .io_cfg_trans_ysize       (dma_cfg_1_io_cfg_trans_ysize[15:0]    ), //i
    .io_cfg_sa_ystep          (dma_cfg_1_io_cfg_sa_ystep[15:0]       ), //i
    .io_dma_cmd_sof           (dma_cfg_1_io_dma_cmd_sof              ), //i
    .io_dma_inf_r_req         (rcmd_gen_1_io_dma_inf_r_req           ), //o
    .io_dma_inf_r_ack         (dma_2_axi_1_io_dma_inf_r_1_r_ack      ), //i
    .io_dma_inf_r_addr        (rcmd_gen_1_io_dma_inf_r_addr[31:0]    ), //o
    .io_dma_inf_r_len         (rcmd_gen_1_io_dma_inf_r_len[15:0]     ), //o
    .io_dma_inf_dvld          (dma_2_axi_1_io_dma_inf_r_1_dvld       ), //i
    .io_dma_inf_rd_last       (dma_2_axi_1_io_dma_inf_r_1_rd_last    ), //i
    .io_dma_inf_rdata         (dma_2_axi_1_io_dma_inf_r_1_rdata[31:0]), //i
    .io_dma_inf_rbe           (dma_2_axi_1_io_dma_inf_r_1_rbe[3:0]   ), //i
    .io_dma_inf_dack          (rcmd_gen_1_io_dma_inf_dack            ), //o
    .io_buffer_buf_wr         (rcmd_gen_1_io_buffer_buf_wr           ), //o
    .io_buffer_buf_wdata      (rcmd_gen_1_io_buffer_buf_wdata[31:0]  ), //o
    .io_buffer_buf_empty_word (dma_buf_1_io_wr_buf_empty_word[5:0]   ), //i
    .io_clk                   (io_clk                                ), //i
    .io_rstn                  (io_rstn                               )  //i
  );
  wcmd_gen wcmd_gen_1 (
    .io_cfg_dar             (dma_cfg_1_io_cfg_dar[31:0]        ), //i
    .io_cfg_trans_xsize     (dma_cfg_1_io_cfg_trans_xsize[15:0]), //i
    .io_cfg_trans_ysize     (dma_cfg_1_io_cfg_trans_ysize[15:0]), //i
    .io_cfg_da_ystep        (dma_cfg_1_io_cfg_da_ystep[15:0]   ), //i
    .io_dma_cmd_sof         (dma_cfg_1_io_dma_cmd_sof          ), //i
    .io_dma_cmd_end         (wcmd_gen_1_io_dma_cmd_end         ), //o
    .io_dma_busy            (dma_cfg_1_io_dma_busy             ), //i
    .io_dma_inf_w_req       (wcmd_gen_1_io_dma_inf_w_req       ), //o
    .io_dma_inf_w_ack       (dma_2_axi_1_io_dma_inf_w_w_ack    ), //i
    .io_dma_inf_w_addr      (wcmd_gen_1_io_dma_inf_w_addr[31:0]), //o
    .io_dma_inf_w_len       (wcmd_gen_1_io_dma_inf_w_len[15:0] ), //o
    .io_dma_inf_w_dvld      (wcmd_gen_1_io_dma_inf_w_dvld      ), //o
    .io_dma_inf_wdata       (wcmd_gen_1_io_dma_inf_wdata[31:0] ), //o
    .io_dma_inf_wbe         (wcmd_gen_1_io_dma_inf_wbe[3:0]    ), //o
    .io_dma_inf_w_dack      (dma_2_axi_1_io_dma_inf_w_w_dack   ), //i
    .io_buffer_buf_rd       (wcmd_gen_1_io_buffer_buf_rd       ), //o
    .io_buffer_buf_rdata    (dma_buf_1_io_rd_buf_rdata[31:0]   ), //i
    .io_buffer_buf_buf_word (dma_buf_1_io_rd_buf_buf_word[5:0] ), //i
    .io_buffer_buf_empty    (dma_buf_1_io_rd_buf_empty         ), //i
    .io_buffer_buf_err      (wcmd_gen_1_io_buffer_buf_err      ), //o
    .io_buffer_clr_buf_err  (dma_buf_1_io_rd_clr_buf_err       ), //i
    .io_clk                 (io_clk                            ), //i
    .io_rstn                (io_rstn                           )  //i
  );
  dma_buf dma_buf_1 (
    .io_wr_buf_wr         (rcmd_gen_1_io_buffer_buf_wr         ), //i
    .io_wr_buf_wdata      (rcmd_gen_1_io_buffer_buf_wdata[31:0]), //i
    .io_wr_buf_empty_word (dma_buf_1_io_wr_buf_empty_word[5:0] ), //o
    .io_rd_buf_rd         (wcmd_gen_1_io_buffer_buf_rd         ), //i
    .io_rd_buf_rdata      (dma_buf_1_io_rd_buf_rdata[31:0]     ), //o
    .io_rd_buf_buf_word   (dma_buf_1_io_rd_buf_buf_word[5:0]   ), //o
    .io_rd_buf_empty      (dma_buf_1_io_rd_buf_empty           ), //o
    .io_rd_buf_err        (wcmd_gen_1_io_buffer_buf_err        ), //i
    .io_rd_clr_buf_err    (dma_buf_1_io_rd_clr_buf_err         ), //o
    .io_clk               (io_clk                              ), //i
    .io_rstn              (io_rstn                             )  //i
  );
  dma_2_axi dma_2_axi_1 (
    .io_cfg_dma_halt         (dma_cfg_1_io_cfg_dma_halt               ), //i
    .io_cfg_bf               (dma_cfg_1_io_cfg_bf                     ), //i
    .io_cfg_cf               (dma_cfg_1_io_cfg_cf                     ), //i
    .io_cfg_buf_err          (dma_2_axi_1_io_cfg_buf_err              ), //o
    .io_cfg_clr_bur_err      (dma_2_axi_1_io_cfg_clr_bur_err          ), //i
    .io_dma_cmd_sof          (dma_cfg_1_io_dma_cmd_sof                ), //i
    .io_dma_busy             (dma_cfg_1_io_dma_busy                   ), //i
    .io_buf_buf_word         (dma_buf_1_io_rd_buf_buf_word[5:0]       ), //i
    .io_buf_empty_word       (dma_buf_1_io_wr_buf_empty_word[5:0]     ), //i
    .io_dma_inf_w_w_req      (wcmd_gen_1_io_dma_inf_w_req             ), //i
    .io_dma_inf_w_w_ack      (dma_2_axi_1_io_dma_inf_w_w_ack          ), //o
    .io_dma_inf_w_w_addr     (wcmd_gen_1_io_dma_inf_w_addr[31:0]      ), //i
    .io_dma_inf_w_w_len      (wcmd_gen_1_io_dma_inf_w_len[15:0]       ), //i
    .io_dma_inf_w_w_dvld     (wcmd_gen_1_io_dma_inf_w_dvld            ), //i
    .io_dma_inf_w_wdata      (wcmd_gen_1_io_dma_inf_wdata[31:0]       ), //i
    .io_dma_inf_w_wbe        (wcmd_gen_1_io_dma_inf_wbe[3:0]          ), //i
    .io_dma_inf_w_w_dack     (dma_2_axi_1_io_dma_inf_w_w_dack         ), //o
    .io_dma_inf_r_1_r_req    (rcmd_gen_1_io_dma_inf_r_req             ), //i
    .io_dma_inf_r_1_r_ack    (dma_2_axi_1_io_dma_inf_r_1_r_ack        ), //o
    .io_dma_inf_r_1_r_addr   (rcmd_gen_1_io_dma_inf_r_addr[31:0]      ), //i
    .io_dma_inf_r_1_r_len    (rcmd_gen_1_io_dma_inf_r_len[15:0]       ), //i
    .io_dma_inf_r_1_dvld     (dma_2_axi_1_io_dma_inf_r_1_dvld         ), //o
    .io_dma_inf_r_1_rd_last  (dma_2_axi_1_io_dma_inf_r_1_rd_last      ), //o
    .io_dma_inf_r_1_rdata    (dma_2_axi_1_io_dma_inf_r_1_rdata[31:0]  ), //o
    .io_dma_inf_r_1_rbe      (dma_2_axi_1_io_dma_inf_r_1_rbe[3:0]     ), //o
    .io_dma_inf_r_1_dack     (rcmd_gen_1_io_dma_inf_dack              ), //i
    .io_dma_inf_r_2_r_req    (cmd_fetch_1_io_dma_inf_r_req            ), //i
    .io_dma_inf_r_2_r_ack    (dma_2_axi_1_io_dma_inf_r_2_r_ack        ), //o
    .io_dma_inf_r_2_r_addr   (cmd_fetch_1_io_dma_inf_r_addr[31:0]     ), //i
    .io_dma_inf_r_2_r_len    (cmd_fetch_1_io_dma_inf_r_len[15:0]      ), //i
    .io_dma_inf_r_2_dvld     (dma_2_axi_1_io_dma_inf_r_2_dvld         ), //o
    .io_dma_inf_r_2_rd_last  (dma_2_axi_1_io_dma_inf_r_2_rd_last      ), //o
    .io_dma_inf_r_2_rdata    (dma_2_axi_1_io_dma_inf_r_2_rdata[31:0]  ), //o
    .io_dma_inf_r_2_rbe      (dma_2_axi_1_io_dma_inf_r_2_rbe[3:0]     ), //o
    .io_dma_inf_r_2_dack     (cmd_fetch_1_io_dma_inf_dack             ), //i
    .io_axi_aw_valid         (dma_2_axi_1_io_axi_aw_valid             ), //o
    .io_axi_aw_ready         (io_axi_aw_ready                         ), //i
    .io_axi_aw_payload_addr  (dma_2_axi_1_io_axi_aw_payload_addr[31:0]), //o
    .io_axi_aw_payload_id    (dma_2_axi_1_io_axi_aw_payload_id[3:0]   ), //o
    .io_axi_aw_payload_len   (dma_2_axi_1_io_axi_aw_payload_len[7:0]  ), //o
    .io_axi_aw_payload_size  (dma_2_axi_1_io_axi_aw_payload_size[2:0] ), //o
    .io_axi_aw_payload_burst (dma_2_axi_1_io_axi_aw_payload_burst[1:0]), //o
    .io_axi_aw_payload_lock  (dma_2_axi_1_io_axi_aw_payload_lock      ), //o
    .io_axi_aw_payload_cache (dma_2_axi_1_io_axi_aw_payload_cache[3:0]), //o
    .io_axi_aw_payload_prot  (dma_2_axi_1_io_axi_aw_payload_prot[2:0] ), //o
    .io_axi_w_valid          (dma_2_axi_1_io_axi_w_valid              ), //o
    .io_axi_w_ready          (io_axi_w_ready                          ), //i
    .io_axi_w_payload_data   (dma_2_axi_1_io_axi_w_payload_data[31:0] ), //o
    .io_axi_w_payload_strb   (dma_2_axi_1_io_axi_w_payload_strb[3:0]  ), //o
    .io_axi_w_payload_last   (dma_2_axi_1_io_axi_w_payload_last       ), //o
    .io_axi_b_valid          (io_axi_b_valid                          ), //i
    .io_axi_b_ready          (dma_2_axi_1_io_axi_b_ready              ), //o
    .io_axi_b_payload_id     (io_axi_b_payload_id[3:0]                ), //i
    .io_axi_b_payload_resp   (io_axi_b_payload_resp[1:0]              ), //i
    .io_axi_ar_valid         (dma_2_axi_1_io_axi_ar_valid             ), //o
    .io_axi_ar_ready         (io_axi_ar_ready                         ), //i
    .io_axi_ar_payload_addr  (dma_2_axi_1_io_axi_ar_payload_addr[31:0]), //o
    .io_axi_ar_payload_id    (dma_2_axi_1_io_axi_ar_payload_id[3:0]   ), //o
    .io_axi_ar_payload_len   (dma_2_axi_1_io_axi_ar_payload_len[7:0]  ), //o
    .io_axi_ar_payload_size  (dma_2_axi_1_io_axi_ar_payload_size[2:0] ), //o
    .io_axi_ar_payload_burst (dma_2_axi_1_io_axi_ar_payload_burst[1:0]), //o
    .io_axi_ar_payload_lock  (dma_2_axi_1_io_axi_ar_payload_lock      ), //o
    .io_axi_ar_payload_cache (dma_2_axi_1_io_axi_ar_payload_cache[3:0]), //o
    .io_axi_ar_payload_prot  (dma_2_axi_1_io_axi_ar_payload_prot[2:0] ), //o
    .io_axi_r_valid          (io_axi_r_valid                          ), //i
    .io_axi_r_ready          (dma_2_axi_1_io_axi_r_ready              ), //o
    .io_axi_r_payload_data   (io_axi_r_payload_data[31:0]             ), //i
    .io_axi_r_payload_id     (io_axi_r_payload_id[3:0]                ), //i
    .io_axi_r_payload_resp   (io_axi_r_payload_resp[1:0]              ), //i
    .io_axi_r_payload_last   (io_axi_r_payload_last                   ), //i
    .io_clk                  (io_clk                                  ), //i
    .io_rstn                 (io_rstn                                 )  //i
  );
  assign io_apb_PREADY = dma_cfg_1_io_apb_PREADY;
  assign io_apb_PRDATA = dma_cfg_1_io_apb_PRDATA;
  assign io_intr = dma_cfg_1_io_dma_intr;
  assign io_axi_aw_valid = dma_2_axi_1_io_axi_aw_valid;
  assign io_axi_aw_payload_addr = dma_2_axi_1_io_axi_aw_payload_addr;
  assign io_axi_aw_payload_id = dma_2_axi_1_io_axi_aw_payload_id;
  assign io_axi_aw_payload_len = dma_2_axi_1_io_axi_aw_payload_len;
  assign io_axi_aw_payload_size = dma_2_axi_1_io_axi_aw_payload_size;
  assign io_axi_aw_payload_burst = dma_2_axi_1_io_axi_aw_payload_burst;
  assign io_axi_aw_payload_lock = dma_2_axi_1_io_axi_aw_payload_lock;
  assign io_axi_aw_payload_cache = dma_2_axi_1_io_axi_aw_payload_cache;
  assign io_axi_aw_payload_prot = dma_2_axi_1_io_axi_aw_payload_prot;
  assign io_axi_w_valid = dma_2_axi_1_io_axi_w_valid;
  assign io_axi_w_payload_data = dma_2_axi_1_io_axi_w_payload_data;
  assign io_axi_w_payload_strb = dma_2_axi_1_io_axi_w_payload_strb;
  assign io_axi_w_payload_last = dma_2_axi_1_io_axi_w_payload_last;
  assign io_axi_b_ready = dma_2_axi_1_io_axi_b_ready;
  assign io_axi_ar_valid = dma_2_axi_1_io_axi_ar_valid;
  assign io_axi_ar_payload_addr = dma_2_axi_1_io_axi_ar_payload_addr;
  assign io_axi_ar_payload_id = dma_2_axi_1_io_axi_ar_payload_id;
  assign io_axi_ar_payload_len = dma_2_axi_1_io_axi_ar_payload_len;
  assign io_axi_ar_payload_size = dma_2_axi_1_io_axi_ar_payload_size;
  assign io_axi_ar_payload_burst = dma_2_axi_1_io_axi_ar_payload_burst;
  assign io_axi_ar_payload_lock = dma_2_axi_1_io_axi_ar_payload_lock;
  assign io_axi_ar_payload_cache = dma_2_axi_1_io_axi_ar_payload_cache;
  assign io_axi_ar_payload_prot = dma_2_axi_1_io_axi_ar_payload_prot;
  assign io_axi_r_ready = dma_2_axi_1_io_axi_r_ready;

endmodule

module dma_2_axi (
  input               io_cfg_dma_halt,
  input               io_cfg_bf,
  input               io_cfg_cf,
  output              io_cfg_buf_err,
  input               io_cfg_clr_bur_err,
  input               io_dma_cmd_sof,
  input               io_dma_busy,
  input      [5:0]    io_buf_buf_word,
  input      [5:0]    io_buf_empty_word,
  input               io_dma_inf_w_w_req,
  output              io_dma_inf_w_w_ack,
  input      [31:0]   io_dma_inf_w_w_addr,
  input      [15:0]   io_dma_inf_w_w_len,
  input               io_dma_inf_w_w_dvld,
  input      [31:0]   io_dma_inf_w_wdata,
  input      [3:0]    io_dma_inf_w_wbe,
  output              io_dma_inf_w_w_dack,
  input               io_dma_inf_r_1_r_req,
  output              io_dma_inf_r_1_r_ack,
  input      [31:0]   io_dma_inf_r_1_r_addr,
  input      [15:0]   io_dma_inf_r_1_r_len,
  output              io_dma_inf_r_1_dvld,
  output              io_dma_inf_r_1_rd_last,
  output     [31:0]   io_dma_inf_r_1_rdata,
  output     [3:0]    io_dma_inf_r_1_rbe,
  input               io_dma_inf_r_1_dack,
  input               io_dma_inf_r_2_r_req,
  output              io_dma_inf_r_2_r_ack,
  input      [31:0]   io_dma_inf_r_2_r_addr,
  input      [15:0]   io_dma_inf_r_2_r_len,
  output              io_dma_inf_r_2_dvld,
  output              io_dma_inf_r_2_rd_last,
  output     [31:0]   io_dma_inf_r_2_rdata,
  output     [3:0]    io_dma_inf_r_2_rbe,
  input               io_dma_inf_r_2_dack,
  output              io_axi_aw_valid,
  input               io_axi_aw_ready,
  output     [31:0]   io_axi_aw_payload_addr,
  output     [3:0]    io_axi_aw_payload_id,
  output     [7:0]    io_axi_aw_payload_len,
  output     [2:0]    io_axi_aw_payload_size,
  output     [1:0]    io_axi_aw_payload_burst,
  output     [0:0]    io_axi_aw_payload_lock,
  output     [3:0]    io_axi_aw_payload_cache,
  output     [2:0]    io_axi_aw_payload_prot,
  output              io_axi_w_valid,
  input               io_axi_w_ready,
  output     [31:0]   io_axi_w_payload_data,
  output     [3:0]    io_axi_w_payload_strb,
  output              io_axi_w_payload_last,
  input               io_axi_b_valid,
  output              io_axi_b_ready,
  input      [3:0]    io_axi_b_payload_id,
  input      [1:0]    io_axi_b_payload_resp,
  output              io_axi_ar_valid,
  input               io_axi_ar_ready,
  output     [31:0]   io_axi_ar_payload_addr,
  output     [3:0]    io_axi_ar_payload_id,
  output     [7:0]    io_axi_ar_payload_len,
  output     [2:0]    io_axi_ar_payload_size,
  output     [1:0]    io_axi_ar_payload_burst,
  output     [0:0]    io_axi_ar_payload_lock,
  output     [3:0]    io_axi_ar_payload_cache,
  output     [2:0]    io_axi_ar_payload_prot,
  input               io_axi_r_valid,
  output              io_axi_r_ready,
  input      [31:0]   io_axi_r_payload_data,
  input      [3:0]    io_axi_r_payload_id,
  input      [1:0]    io_axi_r_payload_resp,
  input               io_axi_r_payload_last,
  input               io_clk,
  input               io_rstn
);

  wire                myArea_dmaw_2_axi_arbt_io_gnt0;
  wire                myArea_dmaw_2_axi_arbt_io_gnt1;
  wire                myArea_dmaw_2_axi_arbt_io_gnt2;
  wire                myArea_dmaw_2_axi_arbt_io_gnt3;
  wire       [1:0]    myArea_dmaw_2_axi_arbt_io_gnt_id;
  wire                myArea_dmar_2_axi_arbt_io_gnt0;
  wire                myArea_dmar_2_axi_arbt_io_gnt1;
  wire                myArea_dmar_2_axi_arbt_io_gnt2;
  wire                myArea_dmar_2_axi_arbt_io_gnt3;
  wire       [1:0]    myArea_dmar_2_axi_arbt_io_gnt_id;
  wire       [0:0]    _zz_io_dma_inf_w_w_ack;
  wire       [31:0]   _zz_myArea_dmaw_2_axi_nxt_bt_addr;
  wire       [31:0]   _zz_myArea_dmaw_2_axi_nxt_bt_addr_1;
  wire       [16:0]   _zz_myArea_dmaw_2_axi_nxt_bt_len;
  wire       [5:0]    _zz_myArea_dmaw_2_axi_cur_bt_byte;
  wire       [5:0]    _zz_myArea_dmaw_2_axi_cur_bt_byte_1;
  wire       [1:0]    _zz_myArea_dmaw_2_axi_cur_bt_byte_2;
  wire       [0:0]    _zz_myArea_dmaw_2_axi_cross_4kb_w;
  wire       [16:0]   _zz_myArea_dmaw_2_axi_cmd0_len_cross;
  wire       [16:0]   _zz_myArea_dmaw_2_axi_cmd1_len_w;
  wire       [1:0]    _zz_myArea_dmaw_2_axi_dma_end_bloc;
  wire       [0:0]    _zz_when_dma_2_axi_l159;
  wire       [0:0]    _zz_when_dma_2_axi_l172;
  wire       [5:0]    _zz_myArea_dmaw_2_axi_bnum_sub_len;
  wire       [4:0]    _zz_myArea_dmaw_2_axi_bnum_sub_len_1;
  wire       [0:0]    _zz_myArea_dmaw_2_axi_axi_cmd_go;
  wire       [0:0]    _zz_myArea_dmaw_2_axi_axi_cmd_go_1;
  wire       [0:0]    _zz_io_dma_inf_r_1_r_ack;
  wire       [0:0]    _zz_io_dma_inf_r_2_r_ack;
  wire       [31:0]   _zz_myArea_dmar_2_axi_nxt_bt_addr;
  wire       [31:0]   _zz_myArea_dmar_2_axi_nxt_bt_addr_1;
  wire       [16:0]   _zz_myArea_dmar_2_axi_nxt_bt_len;
  wire       [16:0]   _zz_myArea_dmar_2_axi_nxt_bt_len_1;
  wire       [16:0]   _zz_myArea_dmar_2_axi_nxt_bt_len_2;
  wire       [16:0]   _zz_myArea_dmar_2_axi_nxt_bt_len_3;
  wire       [6:0]    _zz_myArea_dmar_2_axi_buf_empty_sub_thres;
  wire       [6:0]    _zz_myArea_dmar_2_axi_buf_empty_sub_thres_1;
  wire       [0:0]    _zz_myArea_dmar_2_axi_buf_has_space;
  wire       [5:0]    _zz_myArea_dmar_2_axi_cur_bt_byte;
  wire       [5:0]    _zz_myArea_dmar_2_axi_cur_bt_byte_1;
  wire       [1:0]    _zz_myArea_dmar_2_axi_cur_bt_byte_2;
  wire       [0:0]    _zz_myArea_dmar_2_axi_cross_4kb_w;
  wire       [16:0]   _zz_myArea_dmar_2_axi_cmd0_len_cross;
  wire       [16:0]   _zz_myArea_dmar_2_axi_cmd1_len_w;
  wire       [1:0]    _zz_myArea_dmar_2_axi_dma_end_block;
  wire       [0:0]    _zz_myArea_dmar_2_axi_last_rdata;
  wire       [0:0]    _zz_when_dma_2_axi_l491;
  wire       [0:0]    _zz_when_dma_2_axi_l504;
  wire       [11:0]   _zz_myArea_dmar_2_axi_cmd0_len;
  wire       [15:0]   _zz_myArea_dmar_2_axi_cmd1_len;
  wire       [15:0]   _zz_myArea_dmar_2_axi_nxt_byte_remain;
  wire       [15:0]   _zz_myArea_dmar_2_axi_nxt_byte_remain_1;
  wire       [15:0]   _zz_myArea_dmar_2_axi_nxt_byte_remain_2;
  wire       [2:0]    _zz_myArea_dmar_2_axi_nxt_byte_remain_3;
  wire       [15:0]   _zz_myArea_dmar_2_axi_nxt_byte_remain_4;
  wire       [15:0]   _zz_myArea_dmar_2_axi_nxt_byte_remain_5;
  wire       [15:0]   _zz_myArea_dmar_2_axi_nxt_byte_remain_6;
  wire       [15:0]   _zz_myArea_dmar_2_axi_dma_byte_remain;
  wire       [0:0]    _zz_myArea_dmar_2_axi_axi_r_ch;
  wire       [1:0]    _zz_io_axi_ar_valid;
  wire       [1:0]    _zz_io_axi_ar_valid_1;
  wire       [5:0]    myArea_WCMD_THRES;
  reg        [1:0]    myArea_dmaw_2_axi_sta;
  wire                myArea_dmaw_2_axi_gnt0;
  wire                myArea_dmaw_2_axi_gnt1;
  wire                myArea_dmaw_2_axi_gnt2;
  wire                myArea_dmaw_2_axi_gnt3;
  wire       [3:0]    myArea_dmaw_2_axi_gnt;
  wire       [1:0]    myArea_dmaw_2_axi_gnt_id;
  reg        [31:0]   myArea_dmaw_2_axi_mux_addr;
  reg        [31:0]   myArea_dmaw_2_axi_cmd0_addr;
  reg        [11:0]   myArea_dmaw_2_axi_cmd0_len;
  reg        [31:0]   myArea_dmaw_2_axi_cmd1_addr;
  reg        [15:0]   myArea_dmaw_2_axi_cmd1_len;
  reg                 myArea_dmaw_2_axi_cross_4kb;
  reg        [5:0]    myArea_dmaw_2_axi_cur_bt_byte;
  wire                myArea_dmaw_2_axi_bt_cmd_ack;
  wire                myArea_dmaw_2_axi_dma_w_req_w;
  wire       [31:0]   myArea_dmaw_2_axi_cur_addr;
  wire       [15:0]   myArea_dmaw_2_axi_cur_len;
  wire       [31:0]   myArea_dmaw_2_axi_nxt_bt_addr;
  wire       [16:0]   myArea_dmaw_2_axi_nxt_bt_len;
  wire                myArea_dmaw_2_axi_bt_cmd_req;
  wire                myArea_dmaw_2_axi_send_bt_cmd;
  wire                when_dma_2_axi_l118;
  wire                when_dma_2_axi_l119;
  wire                when_dma_2_axi_l125;
  wire       [12:0]   myArea_dmaw_2_axi_addr_low_addr;
  wire                myArea_dmaw_2_axi_cross_4kb_w;
  wire       [16:0]   myArea_dmaw_2_axi_cmd0_len_cross;
  wire       [16:0]   myArea_dmaw_2_axi_cmd1_len_w;
  wire       [19:0]   myArea_dmaw_2_axi_cmd1_addr_h;
  wire       [1:0]    myArea_dmaw_2_axi_dma_end_bloc;
  wire                when_dma_2_axi_l142;
  wire                when_dma_2_axi_l159;
  wire                when_dma_2_axi_l172;
  wire                when_dma_2_axi_l183;
  wire                when_dma_2_axi_l187;
  wire                when_dma_2_axi_l195;
  wire                when_dma_2_axi_l199;
  reg        [1:0]    myArea_dmaw_2_axi_axi_sta;
  wire                myArea_dmaw_2_axi_axi_wr;
  reg                 myArea_dmaw_2_axi_axi_w_ch;
  reg        [31:0]   myArea_dmaw_2_axi_axi_addr;
  wire       [10:0]   myArea_dmaw_2_axi_axi_len_w;
  reg        [3:0]    myArea_dmaw_2_axi_axi_len;
  wire                myArea_dmaw_2_axi_axi_d_send;
  wire                myArea_dmaw_2_axi_axi_cmd_go;
  wire       [5:0]    myArea_dmaw_2_axi_bnum_sub_thres;
  wire       [5:0]    myArea_dmaw_2_axi_bnum_sub_len;
  wire                io_axi_aw_fire;
  wire                when_dma_2_axi_l245;
  wire       [5:0]    myArea_dmar_2_axi_RCMD_THRES;
  reg        [2:0]    myArea_dmar_2_axi_sta;
  wire                myArea_dmar_2_axi_dma_r_req0_w;
  wire                myArea_dmar_2_axi_dma_r_req1_w;
  wire                myArea_dmar_2_axi_trans_go;
  wire       [1:0]    myArea_dmar_2_axi_gnt_id;
  wire                myArea_dmar_2_axi_gnt0;
  wire                myArea_dmar_2_axi_gnt1;
  wire                myArea_dmar_2_axi_gnt2;
  wire                myArea_dmar_2_axi_gnt3;
  wire       [3:0]    myArea_dmar_2_axi_gnt;
  reg        [31:0]   myArea_dmar_2_axi_mux_addr;
  reg        [15:0]   myArea_dmar_2_axi_mux_len;
  reg        [15:0]   myArea_dmar_2_axi_dma_byte_remain;
  reg        [16:0]   myArea_dmar_2_axi_nxt_byte_remain;
  reg        [3:0]    myArea_dmar_2_axi_dma_rbe;
  reg        [31:0]   myArea_dmar_2_axi_cmd0_addr;
  reg        [11:0]   myArea_dmar_2_axi_cmd0_len;
  reg        [31:0]   myArea_dmar_2_axi_cmd1_addr;
  reg        [15:0]   myArea_dmar_2_axi_cmd1_len;
  wire       [12:0]   myArea_dmar_2_axi_addr_low_add;
  wire                myArea_dmar_2_axi_cross_4kb_w;
  reg                 myArea_dmar_2_axi_cross_4kb;
  wire       [16:0]   myArea_dmar_2_axi_cmd0_len_cross;
  wire       [16:0]   myArea_dmar_2_axi_cmd1_len_w;
  wire       [19:0]   myArea_dmar_2_axi_cmd1_addr_h;
  wire       [31:0]   myArea_dmar_2_axi_cur_addr;
  wire       [15:0]   myArea_dmar_2_axi_cur_len;
  reg        [5:0]    myArea_dmar_2_axi_cur_bt_byte;
  wire       [31:0]   myArea_dmar_2_axi_nxt_bt_addr;
  wire       [16:0]   myArea_dmar_2_axi_nxt_bt_len;
  wire                myArea_dmar_2_axi_bt_cmd_req;
  wire       [6:0]    myArea_dmar_2_axi_buf_empty_sub_thres;
  wire                myArea_dmar_2_axi_buf_has_space;
  wire                myArea_dmar_2_axi_bt_cmd_ack;
  wire                myArea_dmar_2_axi_send_bt_cmd;
  wire       [1:0]    myArea_dmar_2_axi_dma_end_block;
  reg        [3:0]    myArea_dmar_2_axi_dma_r_fir_be;
  reg        [3:0]    myArea_dmar_2_axi_dma_r_last_be;
  reg        [1:0]    myArea_dmar_2_axi_last_vld_byte;
  wire                myArea_dmar_2_axi_ch0_d_trans;
  wire                myArea_dmar_2_axi_ch1_d_trans;
  wire                myArea_dmar_2_axi_dma_d_trans;
  wire                myArea_dmar_2_axi_last_rdata;
  reg                 myArea_dmar_2_axi_first_d_flag;
  reg        [2:0]    myArea_dmar_2_axi_first_vld_byte;
  wire                when_dma_2_axi_l389;
  wire                when_dma_2_axi_l397;
  wire                when_dma_2_axi_l411;
  wire                when_dma_2_axi_l412;
  wire                when_dma_2_axi_l418;
  wire                when_dma_2_axi_l436;
  wire       [1:0]    switch_dma_2_axi_l439;
  wire                when_dma_2_axi_l491;
  wire                when_dma_2_axi_l504;
  wire                when_dma_2_axi_l514;
  wire                when_dma_2_axi_l522;
  wire                when_dma_2_axi_l532;
  wire                when_dma_2_axi_l536;
  wire                when_dma_2_axi_l550;
  wire                when_dma_2_axi_l564;
  reg        [1:0]    myArea_dmar_2_axi_axi_sta;
  wire                myArea_dmar_2_axi_axi_cmd_ack;
  wire                myArea_dmar_2_axi_axi_wr;
  reg                 myArea_dmar_2_axi_axi_r_ch;
  reg        [31:0]   myArea_dmar_2_axi_axi_addr;
  wire       [10:0]   myArea_dmar_2_axi_axi_len_w;
  reg        [3:0]    myArea_dmar_2_axi_axi_len;

  assign _zz_io_dma_inf_w_w_ack = myArea_dmaw_2_axi_gnt[2];
  assign _zz_myArea_dmaw_2_axi_nxt_bt_addr = (myArea_dmaw_2_axi_cur_addr + _zz_myArea_dmaw_2_axi_nxt_bt_addr_1);
  assign _zz_myArea_dmaw_2_axi_nxt_bt_addr_1 = {26'd0, myArea_dmaw_2_axi_cur_bt_byte};
  assign _zz_myArea_dmaw_2_axi_nxt_bt_len = ({myArea_dmaw_2_axi_cur_len,1'b0} - {myArea_dmaw_2_axi_cur_bt_byte,11'h0});
  assign _zz_myArea_dmaw_2_axi_cur_bt_byte = (6'h20 - _zz_myArea_dmaw_2_axi_cur_bt_byte_1);
  assign _zz_myArea_dmaw_2_axi_cur_bt_byte_2 = myArea_dmaw_2_axi_mux_addr[1 : 0];
  assign _zz_myArea_dmaw_2_axi_cur_bt_byte_1 = {4'd0, _zz_myArea_dmaw_2_axi_cur_bt_byte_2};
  assign _zz_myArea_dmaw_2_axi_cross_4kb_w = myArea_dmaw_2_axi_addr_low_addr[12];
  assign _zz_myArea_dmaw_2_axi_cmd0_len_cross = (17'h01000 - {myArea_dmaw_2_axi_mux_addr[11 : 0],5'h0});
  assign _zz_myArea_dmaw_2_axi_cmd1_len_w = ({io_dma_inf_w_w_len,1'b0} - {myArea_dmaw_2_axi_cmd0_len_cross[11 : 0],5'h0});
  assign _zz_myArea_dmaw_2_axi_dma_end_bloc = (myArea_dmaw_2_axi_mux_addr[1 : 0] + io_dma_inf_w_w_len[1 : 0]);
  assign _zz_when_dma_2_axi_l159 = myArea_dmaw_2_axi_nxt_bt_addr[16];
  assign _zz_when_dma_2_axi_l172 = myArea_dmaw_2_axi_nxt_bt_len[16];
  assign _zz_myArea_dmaw_2_axi_bnum_sub_len_1 = {myArea_dmaw_2_axi_axi_len[3 : 0],1'b0};
  assign _zz_myArea_dmaw_2_axi_bnum_sub_len = {1'd0, _zz_myArea_dmaw_2_axi_bnum_sub_len_1};
  assign _zz_myArea_dmaw_2_axi_axi_cmd_go = myArea_dmaw_2_axi_bnum_sub_thres[5];
  assign _zz_myArea_dmaw_2_axi_axi_cmd_go_1 = myArea_dmaw_2_axi_bnum_sub_len[5];
  assign _zz_io_dma_inf_r_1_r_ack = myArea_dmar_2_axi_gnt[0];
  assign _zz_io_dma_inf_r_2_r_ack = myArea_dmar_2_axi_gnt[1];
  assign _zz_myArea_dmar_2_axi_nxt_bt_addr = (myArea_dmar_2_axi_cur_addr + _zz_myArea_dmar_2_axi_nxt_bt_addr_1);
  assign _zz_myArea_dmar_2_axi_nxt_bt_addr_1 = {26'd0, myArea_dmar_2_axi_cur_bt_byte};
  assign _zz_myArea_dmar_2_axi_nxt_bt_len = ($signed(_zz_myArea_dmar_2_axi_nxt_bt_len_1) - $signed(_zz_myArea_dmar_2_axi_nxt_bt_len_2));
  assign _zz_myArea_dmar_2_axi_nxt_bt_len_1 = {1'b0,myArea_dmar_2_axi_cur_len};
  assign _zz_myArea_dmar_2_axi_nxt_bt_len_2 = {11'h0,myArea_dmar_2_axi_cur_bt_byte};
  assign _zz_myArea_dmar_2_axi_nxt_bt_len_3 = 17'h00001;
  assign _zz_myArea_dmar_2_axi_buf_empty_sub_thres = {1'b0,io_buf_empty_word};
  assign _zz_myArea_dmar_2_axi_buf_empty_sub_thres_1 = {1'b0,myArea_dmar_2_axi_RCMD_THRES};
  assign _zz_myArea_dmar_2_axi_buf_has_space = myArea_dmar_2_axi_buf_empty_sub_thres[6];
  assign _zz_myArea_dmar_2_axi_cur_bt_byte = (6'h20 - _zz_myArea_dmar_2_axi_cur_bt_byte_1);
  assign _zz_myArea_dmar_2_axi_cur_bt_byte_2 = myArea_dmar_2_axi_mux_addr[1 : 0];
  assign _zz_myArea_dmar_2_axi_cur_bt_byte_1 = {4'd0, _zz_myArea_dmar_2_axi_cur_bt_byte_2};
  assign _zz_myArea_dmar_2_axi_cross_4kb_w = myArea_dmar_2_axi_addr_low_add[12];
  assign _zz_myArea_dmar_2_axi_cmd0_len_cross = (17'h01000 - {myArea_dmar_2_axi_mux_addr[11 : 0],5'h0});
  assign _zz_myArea_dmar_2_axi_cmd1_len_w = ({1'b0,myArea_dmar_2_axi_mux_len} - {5'h0,myArea_dmar_2_axi_mux_addr[11 : 0]});
  assign _zz_myArea_dmar_2_axi_dma_end_block = (myArea_dmar_2_axi_mux_addr[1 : 0] + myArea_dmar_2_axi_mux_len[1 : 0]);
  assign _zz_myArea_dmar_2_axi_last_rdata = myArea_dmar_2_axi_nxt_byte_remain[16];
  assign _zz_when_dma_2_axi_l491 = myArea_dmar_2_axi_nxt_bt_len[16];
  assign _zz_when_dma_2_axi_l504 = myArea_dmar_2_axi_nxt_bt_len[16];
  assign _zz_myArea_dmar_2_axi_cmd0_len = myArea_dmar_2_axi_nxt_bt_len[11 : 0];
  assign _zz_myArea_dmar_2_axi_cmd1_len = myArea_dmar_2_axi_nxt_bt_len[15 : 0];
  assign _zz_myArea_dmar_2_axi_nxt_byte_remain = ($signed(_zz_myArea_dmar_2_axi_nxt_byte_remain_1) - $signed(_zz_myArea_dmar_2_axi_nxt_byte_remain_2));
  assign _zz_myArea_dmar_2_axi_nxt_byte_remain_1 = myArea_dmar_2_axi_dma_byte_remain;
  assign _zz_myArea_dmar_2_axi_nxt_byte_remain_3 = myArea_dmar_2_axi_first_vld_byte;
  assign _zz_myArea_dmar_2_axi_nxt_byte_remain_2 = {{13{_zz_myArea_dmar_2_axi_nxt_byte_remain_3[2]}}, _zz_myArea_dmar_2_axi_nxt_byte_remain_3};
  assign _zz_myArea_dmar_2_axi_nxt_byte_remain_4 = ($signed(_zz_myArea_dmar_2_axi_nxt_byte_remain_5) - $signed(_zz_myArea_dmar_2_axi_nxt_byte_remain_6));
  assign _zz_myArea_dmar_2_axi_nxt_byte_remain_5 = myArea_dmar_2_axi_dma_byte_remain;
  assign _zz_myArea_dmar_2_axi_nxt_byte_remain_6 = 16'h0004;
  assign _zz_myArea_dmar_2_axi_dma_byte_remain = myArea_dmar_2_axi_nxt_byte_remain[15 : 0];
  assign _zz_myArea_dmar_2_axi_axi_r_ch = myArea_dmar_2_axi_gnt_id[0];
  assign _zz_io_axi_ar_valid = myArea_dmar_2_axi_axi_sta;
  assign _zz_io_axi_ar_valid_1 = 2'b01;
  strict_round_arbt myArea_dmaw_2_axi_arbt (
    .io_req0   (1'b0                                 ), //i
    .io_req1   (1'b1                                 ), //i
    .io_req2   (myArea_dmaw_2_axi_dma_w_req_w        ), //i
    .io_req3   (1'b0                                 ), //i
    .io_gnt0   (myArea_dmaw_2_axi_arbt_io_gnt0       ), //o
    .io_gnt1   (myArea_dmaw_2_axi_arbt_io_gnt1       ), //o
    .io_gnt2   (myArea_dmaw_2_axi_arbt_io_gnt2       ), //o
    .io_gnt3   (myArea_dmaw_2_axi_arbt_io_gnt3       ), //o
    .io_gnt_id (myArea_dmaw_2_axi_arbt_io_gnt_id[1:0]), //o
    .io_clk    (io_clk                               ), //i
    .io_rstn   (io_rstn                              )  //i
  );
  strict_round_arbt myArea_dmar_2_axi_arbt (
    .io_req0   (myArea_dmar_2_axi_dma_r_req0_w       ), //i
    .io_req1   (myArea_dmar_2_axi_dma_r_req1_w       ), //i
    .io_req2   (1'b0                                 ), //i
    .io_req3   (1'b0                                 ), //i
    .io_gnt0   (myArea_dmar_2_axi_arbt_io_gnt0       ), //o
    .io_gnt1   (myArea_dmar_2_axi_arbt_io_gnt1       ), //o
    .io_gnt2   (myArea_dmar_2_axi_arbt_io_gnt2       ), //o
    .io_gnt3   (myArea_dmar_2_axi_arbt_io_gnt3       ), //o
    .io_gnt_id (myArea_dmar_2_axi_arbt_io_gnt_id[1:0]), //o
    .io_clk    (io_clk                               ), //i
    .io_rstn   (io_rstn                              )  //i
  );
  assign myArea_WCMD_THRES = 6'h0c;
  assign myArea_dmaw_2_axi_gnt = {myArea_dmaw_2_axi_gnt3,{myArea_dmaw_2_axi_gnt2,{myArea_dmaw_2_axi_gnt1,myArea_dmaw_2_axi_gnt0}}};
  always @(*) begin
    myArea_dmaw_2_axi_cur_bt_byte = 6'h0;
    if(when_dma_2_axi_l118) begin
      if(when_dma_2_axi_l119) begin
        myArea_dmaw_2_axi_cur_bt_byte = (_zz_myArea_dmaw_2_axi_cur_bt_byte - 6'h01);
      end else begin
        myArea_dmaw_2_axi_cur_bt_byte = myArea_dmaw_2_axi_cur_len[5 : 0];
      end
    end else begin
      if(when_dma_2_axi_l125) begin
        myArea_dmaw_2_axi_cur_bt_byte = 6'h3f;
      end else begin
        myArea_dmaw_2_axi_cur_bt_byte = myArea_dmaw_2_axi_cur_len[5 : 0];
      end
    end
  end

  assign myArea_dmaw_2_axi_dma_w_req_w = ((io_dma_inf_w_w_req && (myArea_dmaw_2_axi_sta == 2'b00)) && (! io_cfg_dma_halt));
  assign io_dma_inf_w_w_ack = _zz_io_dma_inf_w_w_ack[0];
  assign myArea_dmaw_2_axi_cur_addr = ((myArea_dmaw_2_axi_sta == 2'b10) ? myArea_dmaw_2_axi_cmd0_addr : myArea_dmaw_2_axi_cmd1_addr);
  assign myArea_dmaw_2_axi_cur_len = ((myArea_dmaw_2_axi_sta == 2'b10) ? {myArea_dmaw_2_axi_cmd0_len,4'b0000} : myArea_dmaw_2_axi_cmd1_len);
  assign myArea_dmaw_2_axi_nxt_bt_addr = (_zz_myArea_dmaw_2_axi_nxt_bt_addr + 32'h00000003);
  assign myArea_dmaw_2_axi_nxt_bt_len = (_zz_myArea_dmaw_2_axi_nxt_bt_len - 17'h00001);
  assign myArea_dmaw_2_axi_bt_cmd_req = ((myArea_dmaw_2_axi_sta == 2'b10) || (myArea_dmaw_2_axi_sta == 2'b11));
  assign myArea_dmaw_2_axi_send_bt_cmd = (myArea_dmaw_2_axi_bt_cmd_req && myArea_dmaw_2_axi_bt_cmd_ack);
  assign myArea_dmaw_2_axi_gnt0 = myArea_dmaw_2_axi_arbt_io_gnt0;
  assign myArea_dmaw_2_axi_gnt1 = myArea_dmaw_2_axi_arbt_io_gnt1;
  assign myArea_dmaw_2_axi_gnt2 = myArea_dmaw_2_axi_arbt_io_gnt2;
  assign myArea_dmaw_2_axi_gnt3 = myArea_dmaw_2_axi_arbt_io_gnt3;
  assign myArea_dmaw_2_axi_gnt_id = myArea_dmaw_2_axi_arbt_io_gnt_id;
  always @(*) begin
    case(myArea_dmaw_2_axi_sta)
      2'b00, 2'b01 : begin
        myArea_dmaw_2_axi_mux_addr = io_dma_inf_w_w_addr;
      end
      2'b10 : begin
        myArea_dmaw_2_axi_mux_addr = myArea_dmaw_2_axi_cmd0_addr;
      end
      default : begin
        myArea_dmaw_2_axi_mux_addr = myArea_dmaw_2_axi_cmd1_addr;
      end
    endcase
  end

  assign when_dma_2_axi_l118 = (myArea_dmaw_2_axi_mux_addr[1 : 0] != 2'b00);
  assign when_dma_2_axi_l119 = (myArea_dmaw_2_axi_cur_len[15 : 5] != 11'h0);
  assign when_dma_2_axi_l125 = (myArea_dmaw_2_axi_cur_len[15 : 6] != 10'h0);
  assign myArea_dmaw_2_axi_addr_low_addr = ({myArea_dmaw_2_axi_mux_addr[11 : 0],1'b0} + {io_dma_inf_w_w_len[11 : 0],1'b0});
  assign myArea_dmaw_2_axi_cross_4kb_w = (_zz_myArea_dmaw_2_axi_cross_4kb_w[0] || (io_dma_inf_w_w_len[15 : 12] != 4'b0000));
  assign myArea_dmaw_2_axi_cmd0_len_cross = (_zz_myArea_dmaw_2_axi_cmd0_len_cross - 17'h00001);
  assign myArea_dmaw_2_axi_cmd1_len_w = (_zz_myArea_dmaw_2_axi_cmd1_len_w - 17'h00001);
  assign myArea_dmaw_2_axi_cmd1_addr_h = (myArea_dmaw_2_axi_mux_addr[31 : 12] + 20'h00001);
  assign myArea_dmaw_2_axi_dma_end_bloc = (_zz_myArea_dmaw_2_axi_dma_end_bloc + 2'b01);
  assign when_dma_2_axi_l142 = (myArea_dmaw_2_axi_sta == 2'b01);
  assign when_dma_2_axi_l159 = _zz_when_dma_2_axi_l159[0];
  assign when_dma_2_axi_l172 = _zz_when_dma_2_axi_l172[0];
  assign when_dma_2_axi_l183 = (myArea_dmaw_2_axi_sta == 2'b01);
  assign when_dma_2_axi_l187 = ((myArea_dmaw_2_axi_sta == 2'b10) && myArea_dmaw_2_axi_send_bt_cmd);
  assign when_dma_2_axi_l195 = ((myArea_dmaw_2_axi_sta == 2'b01) && myArea_dmaw_2_axi_cross_4kb_w);
  assign when_dma_2_axi_l199 = ((myArea_dmaw_2_axi_sta == 2'b01) && myArea_dmaw_2_axi_send_bt_cmd);
  assign myArea_dmaw_2_axi_axi_wr = 1'b1;
  assign myArea_dmaw_2_axi_bt_cmd_ack = (myArea_dmaw_2_axi_axi_sta == 2'b00);
  assign myArea_dmaw_2_axi_axi_len_w = (myArea_dmaw_2_axi_nxt_bt_addr[12 : 2] - {myArea_dmaw_2_axi_cur_addr[11 : 2],1'b0});
  assign myArea_dmaw_2_axi_axi_d_send = (io_axi_w_valid && io_axi_w_ready);
  assign io_axi_aw_fire = (io_axi_aw_valid && io_axi_aw_ready);
  assign when_dma_2_axi_l245 = (myArea_dmaw_2_axi_axi_len == 4'b0000);
  assign myArea_dmaw_2_axi_bnum_sub_thres = ({io_buf_buf_word[4 : 0],1'b0} - myArea_WCMD_THRES);
  assign myArea_dmaw_2_axi_bnum_sub_len = ({io_buf_buf_word[4 : 0],1'b0} - _zz_myArea_dmaw_2_axi_bnum_sub_len);
  assign myArea_dmaw_2_axi_axi_cmd_go = ((! _zz_myArea_dmaw_2_axi_axi_cmd_go[0]) || (! _zz_myArea_dmaw_2_axi_axi_cmd_go_1[0]));
  assign io_axi_aw_valid = (((myArea_dmaw_2_axi_axi_sta == 2'b01) && myArea_dmaw_2_axi_axi_wr) && myArea_dmaw_2_axi_axi_cmd_go);
  assign io_axi_aw_payload_id = {myArea_dmaw_2_axi_axi_w_ch,3'b000};
  assign io_axi_aw_payload_addr = myArea_dmaw_2_axi_axi_addr;
  assign io_axi_aw_payload_len = {4'd0, myArea_dmaw_2_axi_axi_len};
  assign io_axi_aw_payload_size = 3'b010;
  assign io_axi_aw_payload_burst = 2'b01;
  assign io_axi_aw_payload_lock = 1'b0;
  assign io_axi_aw_payload_cache = {io_cfg_bf,{io_cfg_cf,2'b00}};
  assign io_axi_aw_payload_prot = 3'b010;
  assign io_axi_w_payload_data = io_dma_inf_w_wdata;
  assign io_axi_w_payload_strb = io_dma_inf_w_wbe;
  assign io_axi_w_payload_last = (myArea_dmaw_2_axi_axi_len == 4'b0000);
  assign io_axi_w_valid = (io_dma_inf_w_w_dvld && (! io_cfg_dma_halt));
  assign io_dma_inf_w_w_dack = io_axi_w_ready;
  assign io_axi_b_ready = 1'b1;
  assign myArea_dmar_2_axi_RCMD_THRES = 6'h08;
  assign myArea_dmar_2_axi_gnt = {myArea_dmar_2_axi_gnt0,{myArea_dmar_2_axi_gnt1,{myArea_dmar_2_axi_gnt2,myArea_dmar_2_axi_gnt3}}};
  always @(*) begin
    myArea_dmar_2_axi_mux_len = 16'h0;
    if(when_dma_2_axi_l389) begin
      myArea_dmar_2_axi_mux_len = io_dma_inf_r_1_r_len;
    end else begin
      myArea_dmar_2_axi_mux_len = io_dma_inf_r_2_r_len;
    end
  end

  always @(*) begin
    myArea_dmar_2_axi_nxt_byte_remain = 17'h0;
    if(myArea_dmar_2_axi_first_d_flag) begin
      myArea_dmar_2_axi_nxt_byte_remain = {{1{_zz_myArea_dmar_2_axi_nxt_byte_remain[15]}}, _zz_myArea_dmar_2_axi_nxt_byte_remain};
    end else begin
      myArea_dmar_2_axi_nxt_byte_remain = {{1{_zz_myArea_dmar_2_axi_nxt_byte_remain_4[15]}}, _zz_myArea_dmar_2_axi_nxt_byte_remain_4};
    end
  end

  always @(*) begin
    myArea_dmar_2_axi_dma_rbe = 4'b0000;
    if(myArea_dmar_2_axi_first_d_flag) begin
      myArea_dmar_2_axi_dma_rbe = myArea_dmar_2_axi_dma_r_fir_be;
    end else begin
      if(when_dma_2_axi_l564) begin
        myArea_dmar_2_axi_dma_rbe = myArea_dmar_2_axi_dma_r_last_be;
      end else begin
        myArea_dmar_2_axi_dma_rbe = 4'b1111;
      end
    end
  end

  always @(*) begin
    myArea_dmar_2_axi_cur_bt_byte = 6'h0;
    if(when_dma_2_axi_l411) begin
      if(when_dma_2_axi_l412) begin
        myArea_dmar_2_axi_cur_bt_byte = (_zz_myArea_dmar_2_axi_cur_bt_byte - 6'h01);
      end else begin
        myArea_dmar_2_axi_cur_bt_byte = myArea_dmar_2_axi_cur_len[5 : 0];
      end
    end else begin
      if(when_dma_2_axi_l418) begin
        myArea_dmar_2_axi_cur_bt_byte = 6'h3f;
      end else begin
        myArea_dmar_2_axi_cur_bt_byte = myArea_dmar_2_axi_cur_len[5 : 0];
      end
    end
  end

  assign myArea_dmar_2_axi_dma_r_req0_w = ((io_dma_inf_r_1_r_req && (myArea_dmar_2_axi_sta == 3'b000)) && (! io_cfg_dma_halt));
  assign myArea_dmar_2_axi_dma_r_req1_w = ((io_dma_inf_r_2_r_req && (myArea_dmar_2_axi_sta == 3'b000)) && (! io_cfg_dma_halt));
  assign io_dma_inf_r_1_r_ack = _zz_io_dma_inf_r_1_r_ack[0];
  assign io_dma_inf_r_2_r_ack = _zz_io_dma_inf_r_2_r_ack[0];
  assign myArea_dmar_2_axi_cur_addr = ((myArea_dmar_2_axi_sta == 3'b010) ? myArea_dmar_2_axi_cmd0_addr : myArea_dmar_2_axi_cmd1_addr);
  assign myArea_dmar_2_axi_cur_len = ((myArea_dmar_2_axi_sta == 3'b010) ? {4'b0000,myArea_dmar_2_axi_cmd0_len} : myArea_dmar_2_axi_cmd1_len);
  assign myArea_dmar_2_axi_nxt_bt_addr = (_zz_myArea_dmar_2_axi_nxt_bt_addr + 32'h00000003);
  assign myArea_dmar_2_axi_nxt_bt_len = ($signed(_zz_myArea_dmar_2_axi_nxt_bt_len) - $signed(_zz_myArea_dmar_2_axi_nxt_bt_len_3));
  assign myArea_dmar_2_axi_buf_empty_sub_thres = ($signed(_zz_myArea_dmar_2_axi_buf_empty_sub_thres) - $signed(_zz_myArea_dmar_2_axi_buf_empty_sub_thres_1));
  assign myArea_dmar_2_axi_buf_has_space = (! _zz_myArea_dmar_2_axi_buf_has_space[0]);
  assign myArea_dmar_2_axi_bt_cmd_req = ((((myArea_dmar_2_axi_sta == 3'b010) || (myArea_dmar_2_axi_sta == 3'b011)) && (! io_cfg_dma_halt)) && myArea_dmar_2_axi_buf_has_space);
  assign myArea_dmar_2_axi_send_bt_cmd = (myArea_dmar_2_axi_bt_cmd_req && myArea_dmar_2_axi_bt_cmd_ack);
  assign io_dma_inf_r_1_dvld = (io_axi_r_valid && (io_axi_r_payload_id[1 : 0] == 2'b00));
  assign myArea_dmar_2_axi_ch0_d_trans = (io_dma_inf_r_1_dvld && io_dma_inf_r_1_dack);
  assign io_dma_inf_r_2_dvld = (io_axi_r_valid && (io_axi_r_payload_id[1 : 0] == 2'b01));
  assign myArea_dmar_2_axi_ch1_d_trans = (io_dma_inf_r_2_dvld && io_dma_inf_r_2_dack);
  assign myArea_dmar_2_axi_dma_d_trans = (myArea_dmar_2_axi_ch0_d_trans || myArea_dmar_2_axi_ch1_d_trans);
  assign myArea_dmar_2_axi_gnt0 = myArea_dmar_2_axi_arbt_io_gnt0;
  assign myArea_dmar_2_axi_gnt1 = myArea_dmar_2_axi_arbt_io_gnt1;
  assign myArea_dmar_2_axi_gnt2 = myArea_dmar_2_axi_arbt_io_gnt2;
  assign myArea_dmar_2_axi_gnt3 = myArea_dmar_2_axi_arbt_io_gnt3;
  assign myArea_dmar_2_axi_gnt_id = myArea_dmar_2_axi_arbt_io_gnt_id;
  assign myArea_dmar_2_axi_trans_go = (myArea_dmar_2_axi_dma_r_req0_w || myArea_dmar_2_axi_dma_r_req1_w);
  assign when_dma_2_axi_l389 = (myArea_dmar_2_axi_gnt_id[0] == 1'b0);
  assign when_dma_2_axi_l397 = (myArea_dmar_2_axi_gnt_id[0] == 1'b0);
  always @(*) begin
    case(myArea_dmar_2_axi_sta)
      3'b000, 3'b001 : begin
        if(when_dma_2_axi_l397) begin
          myArea_dmar_2_axi_mux_addr = io_dma_inf_r_1_r_addr;
        end else begin
          myArea_dmar_2_axi_mux_addr = io_dma_inf_r_2_r_addr;
        end
      end
      3'b010 : begin
        myArea_dmar_2_axi_mux_addr = myArea_dmar_2_axi_cmd0_addr;
      end
      default : begin
        myArea_dmar_2_axi_mux_addr = myArea_dmar_2_axi_cmd1_addr;
      end
    endcase
  end

  assign when_dma_2_axi_l411 = (myArea_dmar_2_axi_mux_addr[1 : 0] != 2'b00);
  assign when_dma_2_axi_l412 = (myArea_dmar_2_axi_cur_len[15 : 5] != 11'h0);
  assign when_dma_2_axi_l418 = (myArea_dmar_2_axi_cur_len[15 : 6] != 10'h0);
  assign myArea_dmar_2_axi_addr_low_add = ({1'b0,myArea_dmar_2_axi_mux_addr[11 : 0]} + {1'b0,myArea_dmar_2_axi_mux_len[11 : 0]});
  assign myArea_dmar_2_axi_cross_4kb_w = (_zz_myArea_dmar_2_axi_cross_4kb_w[0] || (myArea_dmar_2_axi_mux_len[15 : 12] != 4'b0000));
  assign myArea_dmar_2_axi_cmd0_len_cross = (_zz_myArea_dmar_2_axi_cmd0_len_cross - 17'h00001);
  assign myArea_dmar_2_axi_cmd1_len_w = (_zz_myArea_dmar_2_axi_cmd1_len_w - 17'h00001);
  assign myArea_dmar_2_axi_cmd1_addr_h = (myArea_dmar_2_axi_mux_addr[31 : 12] + 20'h00001);
  assign myArea_dmar_2_axi_dma_end_block = (_zz_myArea_dmar_2_axi_dma_end_block + 2'b01);
  assign myArea_dmar_2_axi_last_rdata = _zz_myArea_dmar_2_axi_last_rdata[0];
  assign when_dma_2_axi_l436 = (myArea_dmar_2_axi_sta == 3'b001);
  assign switch_dma_2_axi_l439 = myArea_dmar_2_axi_mux_addr[1 : 0];
  assign when_dma_2_axi_l491 = _zz_when_dma_2_axi_l491[0];
  assign when_dma_2_axi_l504 = _zz_when_dma_2_axi_l504[0];
  assign when_dma_2_axi_l514 = (myArea_dmar_2_axi_dma_d_trans && myArea_dmar_2_axi_last_rdata);
  assign when_dma_2_axi_l522 = (myArea_dmar_2_axi_sta == 3'b001);
  assign when_dma_2_axi_l532 = ((myArea_dmar_2_axi_sta == 3'b001) && myArea_dmar_2_axi_cross_4kb_w);
  assign when_dma_2_axi_l536 = ((myArea_dmar_2_axi_sta == 3'b011) && myArea_dmar_2_axi_send_bt_cmd);
  assign when_dma_2_axi_l550 = (myArea_dmar_2_axi_sta == 3'b001);
  assign when_dma_2_axi_l564 = (myArea_dmar_2_axi_dma_byte_remain[15 : 2] == 14'h0);
  assign myArea_dmar_2_axi_axi_wr = 1'b0;
  assign myArea_dmar_2_axi_bt_cmd_ack = (myArea_dmar_2_axi_axi_sta == 2'b00);
  assign myArea_dmar_2_axi_axi_len_w = (myArea_dmar_2_axi_nxt_bt_addr[12 : 2] - {1'b0,myArea_dmar_2_axi_cur_addr[11 : 2]});
  assign myArea_dmar_2_axi_axi_cmd_ack = io_axi_ar_ready;
  assign io_axi_r_ready = (myArea_dmar_2_axi_axi_r_ch ? io_dma_inf_r_2_dack : io_dma_inf_r_1_dack);
  assign io_axi_ar_payload_id = {3'b000,myArea_dmar_2_axi_axi_r_ch};
  assign io_axi_ar_payload_addr = myArea_dmar_2_axi_axi_addr;
  assign io_axi_ar_payload_len = {4'd0, myArea_dmar_2_axi_axi_len};
  assign io_axi_ar_payload_size = 3'b010;
  assign io_axi_ar_payload_burst = 2'b01;
  assign io_axi_ar_payload_lock = 1'b0;
  assign io_axi_ar_payload_cache = {2'b00,{io_cfg_cf,io_cfg_bf}};
  assign io_axi_ar_payload_prot = 3'b010;
  assign io_axi_ar_valid = (($signed(_zz_io_axi_ar_valid) == $signed(_zz_io_axi_ar_valid_1)) && (! myArea_dmar_2_axi_axi_wr));
  assign io_dma_inf_r_1_rd_last = myArea_dmar_2_axi_last_rdata;
  assign io_dma_inf_r_1_rdata = io_axi_r_payload_data;
  assign io_dma_inf_r_1_rbe = myArea_dmar_2_axi_dma_rbe;
  assign io_dma_inf_r_2_rd_last = myArea_dmar_2_axi_last_rdata;
  assign io_dma_inf_r_2_rdata = io_axi_r_payload_data;
  assign io_dma_inf_r_2_rbe = myArea_dmar_2_axi_dma_rbe;
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_dmaw_2_axi_sta <= 2'b00;
      myArea_dmaw_2_axi_cmd0_addr <= 32'h0;
      myArea_dmaw_2_axi_cmd0_len <= 12'h0;
      myArea_dmaw_2_axi_cmd1_addr <= 32'h0;
      myArea_dmaw_2_axi_cmd1_len <= 16'h0;
      myArea_dmaw_2_axi_cross_4kb <= 1'b0;
      myArea_dmaw_2_axi_axi_sta <= 2'b00;
      myArea_dmaw_2_axi_axi_w_ch <= 1'b0;
      myArea_dmaw_2_axi_axi_addr <= 32'h0;
      myArea_dmaw_2_axi_axi_len <= 4'b0000;
      myArea_dmar_2_axi_sta <= 3'b000;
      myArea_dmar_2_axi_dma_byte_remain <= 16'h0;
      myArea_dmar_2_axi_cmd0_addr <= 32'h0;
      myArea_dmar_2_axi_cmd0_len <= 12'h0;
      myArea_dmar_2_axi_cmd1_addr <= 32'h0;
      myArea_dmar_2_axi_cmd1_len <= 16'h0;
      myArea_dmar_2_axi_cross_4kb <= 1'b0;
      myArea_dmar_2_axi_dma_r_fir_be <= 4'b0000;
      myArea_dmar_2_axi_dma_r_last_be <= 4'b0000;
      myArea_dmar_2_axi_last_vld_byte <= 2'b00;
      myArea_dmar_2_axi_first_d_flag <= 1'b1;
      myArea_dmar_2_axi_first_vld_byte <= 3'b000;
      myArea_dmar_2_axi_axi_sta <= 2'b00;
      myArea_dmar_2_axi_axi_r_ch <= 1'b0;
      myArea_dmar_2_axi_axi_addr <= 32'h0;
      myArea_dmar_2_axi_axi_len <= 4'b0000;
    end else begin
      if(when_dma_2_axi_l142) begin
        myArea_dmaw_2_axi_cross_4kb <= myArea_dmaw_2_axi_cross_4kb_w;
      end
      case(myArea_dmaw_2_axi_sta)
        2'b00 : begin
          if(myArea_dmaw_2_axi_dma_w_req_w) begin
            myArea_dmaw_2_axi_sta <= 2'b01;
          end
        end
        2'b01 : begin
          myArea_dmaw_2_axi_sta <= 2'b10;
        end
        2'b10 : begin
          if(myArea_dmaw_2_axi_send_bt_cmd) begin
            if(when_dma_2_axi_l159) begin
              if(myArea_dmaw_2_axi_cross_4kb) begin
                myArea_dmaw_2_axi_sta <= 2'b11;
              end else begin
                myArea_dmaw_2_axi_sta <= 2'b00;
              end
            end else begin
              myArea_dmaw_2_axi_sta <= 2'b10;
            end
          end
        end
        default : begin
          if(myArea_dmaw_2_axi_send_bt_cmd) begin
            if(when_dma_2_axi_l172) begin
              myArea_dmaw_2_axi_sta <= 2'b00;
            end else begin
              myArea_dmaw_2_axi_sta <= 2'b11;
            end
          end
        end
      endcase
      if(when_dma_2_axi_l183) begin
        myArea_dmaw_2_axi_cmd0_addr <= myArea_dmaw_2_axi_mux_addr;
        myArea_dmaw_2_axi_cmd0_len <= (myArea_dmaw_2_axi_cross_4kb_w ? myArea_dmaw_2_axi_cmd0_len_cross[11 : 0] : io_dma_inf_w_w_len[11 : 0]);
      end else begin
        if(when_dma_2_axi_l187) begin
          myArea_dmaw_2_axi_cmd0_addr <= {myArea_dmaw_2_axi_nxt_bt_addr[31 : 2],2'b00};
          myArea_dmaw_2_axi_cmd0_len <= myArea_dmaw_2_axi_nxt_bt_len[11 : 0];
        end
      end
      if(when_dma_2_axi_l195) begin
        myArea_dmaw_2_axi_cmd1_addr <= {myArea_dmaw_2_axi_cmd1_addr_h,12'h0};
        myArea_dmaw_2_axi_cmd1_len <= myArea_dmaw_2_axi_cmd1_len_w[15 : 0];
      end else begin
        if(when_dma_2_axi_l199) begin
          myArea_dmaw_2_axi_cmd1_addr <= {myArea_dmaw_2_axi_nxt_bt_addr[31 : 2],2'b00};
          myArea_dmaw_2_axi_cmd1_len <= myArea_dmaw_2_axi_nxt_bt_len[15 : 0];
        end
      end
      case(myArea_dmaw_2_axi_axi_sta)
        2'b00 : begin
          if(myArea_dmaw_2_axi_bt_cmd_req) begin
            myArea_dmaw_2_axi_axi_sta <= 2'b01;
            myArea_dmaw_2_axi_axi_len <= myArea_dmaw_2_axi_axi_len_w[3 : 0];
            myArea_dmaw_2_axi_axi_addr <= {myArea_dmaw_2_axi_cur_addr[31 : 2],2'b00};
            myArea_dmaw_2_axi_axi_w_ch <= 1'b0;
          end
        end
        2'b01 : begin
          if(io_axi_aw_fire) begin
            myArea_dmaw_2_axi_axi_sta <= 2'b10;
          end
        end
        2'b10 : begin
          if(myArea_dmaw_2_axi_axi_d_send) begin
            if(when_dma_2_axi_l245) begin
              myArea_dmaw_2_axi_axi_sta <= 2'b00;
            end else begin
              myArea_dmaw_2_axi_axi_sta <= 2'b10;
              myArea_dmaw_2_axi_axi_len <= (myArea_dmaw_2_axi_axi_len - 4'b0001);
            end
          end
        end
        default : begin
          myArea_dmaw_2_axi_axi_sta <= 2'b00;
        end
      endcase
      if(when_dma_2_axi_l436) begin
        myArea_dmar_2_axi_cross_4kb <= myArea_dmar_2_axi_cross_4kb_w;
        case(switch_dma_2_axi_l439)
          2'b00 : begin
            myArea_dmar_2_axi_dma_r_fir_be <= 4'b1111;
            myArea_dmar_2_axi_first_vld_byte <= 3'b100;
          end
          2'b01 : begin
            myArea_dmar_2_axi_dma_r_fir_be <= 4'b1110;
            myArea_dmar_2_axi_first_vld_byte <= 3'b011;
          end
          2'b10 : begin
            myArea_dmar_2_axi_dma_r_fir_be <= 4'b1100;
            myArea_dmar_2_axi_first_vld_byte <= 3'b010;
          end
          default : begin
            myArea_dmar_2_axi_dma_r_fir_be <= 4'b1000;
            myArea_dmar_2_axi_first_vld_byte <= 3'b001;
          end
        endcase
        case(myArea_dmar_2_axi_dma_end_block)
          2'b00 : begin
            myArea_dmar_2_axi_dma_r_last_be <= 4'b1111;
            myArea_dmar_2_axi_last_vld_byte <= 2'b11;
          end
          2'b01 : begin
            myArea_dmar_2_axi_dma_r_last_be <= 4'b0001;
            myArea_dmar_2_axi_last_vld_byte <= 2'b00;
          end
          2'b10 : begin
            myArea_dmar_2_axi_dma_r_last_be <= 4'b0011;
            myArea_dmar_2_axi_last_vld_byte <= 2'b01;
          end
          default : begin
            myArea_dmar_2_axi_dma_r_last_be <= 4'b0111;
            myArea_dmar_2_axi_last_vld_byte <= 2'b10;
          end
        endcase
      end
      case(myArea_dmar_2_axi_sta)
        3'b000 : begin
          if(myArea_dmar_2_axi_trans_go) begin
            myArea_dmar_2_axi_sta <= 3'b001;
          end
        end
        3'b001 : begin
          myArea_dmar_2_axi_sta <= 3'b010;
        end
        3'b010 : begin
          if(myArea_dmar_2_axi_send_bt_cmd) begin
            if(when_dma_2_axi_l491) begin
              if(myArea_dmar_2_axi_cross_4kb) begin
                myArea_dmar_2_axi_sta <= 3'b011;
              end else begin
                myArea_dmar_2_axi_sta <= 3'b100;
              end
            end else begin
              myArea_dmar_2_axi_sta <= 3'b010;
            end
          end
        end
        3'b011 : begin
          if(myArea_dmar_2_axi_send_bt_cmd) begin
            if(when_dma_2_axi_l504) begin
              myArea_dmar_2_axi_sta <= 3'b100;
            end else begin
              myArea_dmar_2_axi_sta <= 3'b011;
            end
          end
        end
        3'b100 : begin
          if(when_dma_2_axi_l514) begin
            myArea_dmar_2_axi_sta <= 3'b000;
          end
        end
        default : begin
        end
      endcase
      if(when_dma_2_axi_l522) begin
        myArea_dmar_2_axi_cmd0_addr <= myArea_dmar_2_axi_mux_addr;
        myArea_dmar_2_axi_cmd0_len <= (myArea_dmar_2_axi_cross_4kb_w ? myArea_dmar_2_axi_cmd0_len_cross[11 : 0] : myArea_dmar_2_axi_mux_len[11 : 0]);
      end else begin
        myArea_dmar_2_axi_cmd0_addr <= {myArea_dmar_2_axi_nxt_bt_addr[31 : 2],2'b00};
        myArea_dmar_2_axi_cmd0_len <= _zz_myArea_dmar_2_axi_cmd0_len;
      end
      if(when_dma_2_axi_l532) begin
        myArea_dmar_2_axi_cmd1_addr <= {myArea_dmar_2_axi_cmd1_addr_h,12'h0};
        myArea_dmar_2_axi_cmd1_len <= myArea_dmar_2_axi_cmd1_len_w[15 : 0];
      end else begin
        if(when_dma_2_axi_l536) begin
          myArea_dmar_2_axi_cmd1_addr <= {myArea_dmar_2_axi_nxt_bt_addr[31 : 2],2'b00};
          myArea_dmar_2_axi_cmd1_len <= _zz_myArea_dmar_2_axi_cmd1_len;
        end
      end
      if(when_dma_2_axi_l550) begin
        myArea_dmar_2_axi_dma_byte_remain <= myArea_dmar_2_axi_mux_len;
        myArea_dmar_2_axi_first_d_flag <= 1'b1;
      end else begin
        if(myArea_dmar_2_axi_dma_d_trans) begin
          myArea_dmar_2_axi_first_d_flag <= 1'b0;
          myArea_dmar_2_axi_dma_byte_remain <= _zz_myArea_dmar_2_axi_dma_byte_remain;
        end
      end
      case(myArea_dmar_2_axi_axi_sta)
        2'b00 : begin
          if(myArea_dmar_2_axi_bt_cmd_req) begin
            myArea_dmar_2_axi_axi_sta <= 2'b01;
            myArea_dmar_2_axi_axi_len <= myArea_dmar_2_axi_axi_len_w[3 : 0];
            myArea_dmar_2_axi_axi_addr <= {myArea_dmar_2_axi_cur_addr[31 : 2],2'b00};
            myArea_dmar_2_axi_axi_r_ch <= _zz_myArea_dmar_2_axi_axi_r_ch[0];
          end
        end
        2'b01 : begin
          if(myArea_dmar_2_axi_axi_cmd_ack) begin
            myArea_dmar_2_axi_axi_sta <= 2'b00;
          end
        end
        default : begin
          myArea_dmar_2_axi_axi_sta <= 2'b00;
        end
      endcase
    end
  end


endmodule

module dma_buf (
  input               io_wr_buf_wr,
  input      [31:0]   io_wr_buf_wdata,
  output     [5:0]    io_wr_buf_empty_word,
  input               io_rd_buf_rd,
  output     [31:0]   io_rd_buf_rdata,
  output     [5:0]    io_rd_buf_buf_word,
  output              io_rd_buf_empty,
  input               io_rd_buf_err,
  output              io_rd_clr_buf_err,
  input               io_clk,
  input               io_rstn
);

  wire       [31:0]   _zz_myArea_mem_port0;
  wire       [4:0]    _zz_myArea_mem_port;
  wire       [0:0]    _zz_myArea_wptr;
  wire       [0:0]    _zz_myArea_rptr;
  reg                 _zz_1;
  reg        [5:0]    myArea_buf_empty_word;
  reg        [5:0]    myArea_buf_buf_word;
  reg        [5:0]    myArea_rptr;
  reg        [5:0]    myArea_wptr;
  wire       [4:0]    _zz_io_rd_buf_rdata;
  wire                when_dma_buf_l40;
  wire                when_dma_buf_l43;
  wire       [1:0]    switch_dma_buf_l44;
  wire                when_dma_buf_l61;
  wire                when_dma_buf_l64;
  wire       [1:0]    switch_dma_buf_l65;
  wire                when_dma_buf_l86;
  wire                when_dma_buf_l96;
  wire                when_dma_buf_l100;
  (* ram_style = "distributed" *) reg [31:0] myArea_mem [0:23];

  assign _zz_myArea_wptr = myArea_wptr[5];
  assign _zz_myArea_rptr = myArea_rptr[5];
  assign _zz_myArea_mem_port = myArea_wptr[4 : 0];
  assign _zz_myArea_mem_port0 = myArea_mem[_zz_io_rd_buf_rdata];
  always @(posedge io_clk) begin
    if(_zz_1) begin
      myArea_mem[_zz_myArea_mem_port] <= io_wr_buf_wdata;
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(io_wr_buf_wr) begin
      _zz_1 = 1'b1;
    end
  end

  assign io_rd_clr_buf_err = 1'b0;
  assign io_wr_buf_empty_word = myArea_buf_empty_word;
  assign io_rd_buf_buf_word = myArea_buf_buf_word;
  assign io_rd_buf_empty = (myArea_rptr == myArea_wptr);
  assign _zz_io_rd_buf_rdata = myArea_rptr[4 : 0];
  assign io_rd_buf_rdata = _zz_myArea_mem_port0;
  assign when_dma_buf_l40 = (! io_rstn);
  assign when_dma_buf_l43 = (io_wr_buf_wr || io_rd_buf_rd);
  assign switch_dma_buf_l44 = {io_rd_buf_rd,io_wr_buf_wr};
  assign when_dma_buf_l61 = (! io_rstn);
  assign when_dma_buf_l64 = (io_wr_buf_wr || io_rd_buf_rd);
  assign switch_dma_buf_l65 = {io_rd_buf_rd,io_wr_buf_wr};
  assign when_dma_buf_l86 = (! io_rstn);
  assign when_dma_buf_l96 = (! io_rstn);
  assign when_dma_buf_l100 = (myArea_rptr[4 : 0] == 5'h17);
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_buf_empty_word <= 6'h0;
      myArea_buf_buf_word <= 6'h0;
      myArea_rptr <= 6'h0;
      myArea_wptr <= 6'h0;
    end else begin
      if(when_dma_buf_l40) begin
        myArea_buf_empty_word <= 6'h18;
      end else begin
        if(when_dma_buf_l43) begin
          case(switch_dma_buf_l44)
            2'b00 : begin
              myArea_buf_empty_word <= myArea_buf_empty_word;
            end
            2'b01 : begin
              myArea_buf_empty_word <= (myArea_buf_empty_word + 6'h01);
            end
            2'b10 : begin
              myArea_buf_empty_word <= (myArea_buf_empty_word - 6'h01);
            end
            default : begin
              myArea_buf_empty_word <= myArea_buf_empty_word;
            end
          endcase
        end
      end
      if(when_dma_buf_l61) begin
        myArea_buf_buf_word <= 6'h0;
      end else begin
        if(when_dma_buf_l64) begin
          case(switch_dma_buf_l65)
            2'b00 : begin
              myArea_buf_buf_word <= myArea_buf_buf_word;
            end
            2'b01 : begin
              myArea_buf_buf_word <= (myArea_buf_buf_word - 6'h01);
            end
            2'b10 : begin
              myArea_buf_buf_word <= (myArea_buf_buf_word + 6'h01);
            end
            default : begin
              myArea_buf_buf_word <= myArea_buf_buf_word;
            end
          endcase
        end
      end
      if(when_dma_buf_l86) begin
        myArea_wptr <= 6'h0;
      end else begin
        if(io_wr_buf_wr) begin
          myArea_wptr <= {5'h0,(! _zz_myArea_wptr[0])};
        end else begin
          myArea_wptr <= (myArea_wptr + 6'h01);
        end
      end
      if(when_dma_buf_l96) begin
        myArea_rptr <= 6'h0;
      end else begin
        if(io_rd_buf_rd) begin
          if(when_dma_buf_l100) begin
            myArea_rptr <= {5'h0,(! _zz_myArea_rptr[0])};
          end else begin
            myArea_rptr <= (myArea_rptr + 6'h01);
          end
        end
      end
    end
  end


endmodule

module wcmd_gen (
  input      [31:0]   io_cfg_dar,
  input      [15:0]   io_cfg_trans_xsize,
  input      [15:0]   io_cfg_trans_ysize,
  input      [15:0]   io_cfg_da_ystep,
  input               io_dma_cmd_sof,
  output              io_dma_cmd_end,
  input               io_dma_busy,
  output              io_dma_inf_w_req,
  input               io_dma_inf_w_ack,
  output     [31:0]   io_dma_inf_w_addr,
  output     [15:0]   io_dma_inf_w_len,
  output              io_dma_inf_w_dvld,
  output     [31:0]   io_dma_inf_wdata,
  output reg [3:0]    io_dma_inf_wbe,
  input               io_dma_inf_w_dack,
  output              io_buffer_buf_rd,
  input      [31:0]   io_buffer_buf_rdata,
  input      [5:0]    io_buffer_buf_buf_word,
  input               io_buffer_buf_empty,
  output              io_buffer_buf_err,
  input               io_buffer_clr_buf_err,
  input               io_clk,
  input               io_rstn
);

  wire       [1:0]    _zz_myArea_end_bcnt;
  wire       [15:0]   _zz_myArea_fir_wdata;
  wire       [31:0]   _zz_myArea_dma_addr;
  wire       [31:0]   _zz_myArea_dma_addr_1;
  wire       [0:0]    _zz_when_wcmd_gen_l95;
  wire       [16:0]   _zz_myArea_remain_bnum_send;
  wire       [16:0]   _zz_myArea_remain_bnum_send_1;
  wire       [16:0]   _zz_myArea_remain_bnum_send_2;
  wire       [16:0]   _zz_myArea_remain_bnum_send_3;
  wire       [16:0]   _zz_myArea_remain_bnum_send_4;
  wire       [31:0]   _zz_myArea_dma_addr_2;
  wire       [15:0]   _zz_myArea_remain_bnum_rd;
  wire       [16:0]   _zz_myArea_remain_bnum_rd_1;
  wire       [0:0]    _zz_myArea_buf_4b;
  wire       [0:0]    _zz_myArea_buf_4b_1;
  wire       [0:0]    _zz_io_buffer_buf_rd;
  wire       [13:0]   _zz_myArea_dma_wd_last;
  wire       [13:0]   _zz_myArea_dma_wd_last_1;
  wire       [1:0]    _zz_myArea_last_best_vld;
  wire       [1:0]    _zz_myArea_last_best_vld_1;
  wire       [0:0]    _zz_myArea_last_best_vld_2;
  wire       [3:0]    _zz_myArea_nxt_buf_bcnt;
  wire       [3:0]    _zz_myArea_nxt_buf_bcnt_1;
  wire       [3:0]    _zz_myArea_nxt_buf_bcnt_2;
  wire       [3:0]    _zz_myArea_nxt_buf_bcnt_3;
  wire       [3:0]    _zz_myArea_nxt_buf_bcnt_4;
  wire       [0:0]    _zz_when_wcmd_gen_l261;
  reg        [1:0]    myArea_dma_sta;
  reg        [15:0]   myArea_dma_ycnt;
  reg        [31:0]   myArea_dma_addr;
  reg        [3:0]    myArea_fir_wbe;
  reg        [3:0]    myArea_last_wbe;
  reg        [1:0]    myArea_align_model;
  reg        [16:0]   myArea_remain_bnum_rd;
  reg        [16:0]   myArea_remain_bnum_send;
  wire       [1:0]    myArea_end_bcnt;
  wire                myArea_dma_1d_go;
  wire                myArea_dma_w_req;
  wire                myArea_send_a_cmd;
  wire                myArea_send_a_data;
  wire                myArea_fir_wdata;
  reg                 myArea_dma_cmd_end;
  wire                when_wcmd_gen_l95;
  wire                when_wcmd_gen_l97;
  reg                 myArea_buf_err;
  wire                when_wcmd_gen_l138;
  wire       [1:0]    switch_wcmd_gen_l150;
  reg        [3:0]    myArea_buf_bcnt;
  reg        [3:0]    myArea_nxt_buf_bcnt;
  reg        [2:0]    myArea_sub_bcnt;
  reg        [7:0]    myArea_wd0;
  reg        [7:0]    myArea_wd1;
  reg        [7:0]    myArea_wd2;
  reg        [7:0]    myArea_wd3;
  reg        [7:0]    myArea_ed0;
  reg        [7:0]    myArea_ed1;
  reg        [7:0]    myArea_ed2;
  wire                myArea_buf_4b;
  wire                myArea_dma_wd_last;
  wire                myArea_last_best_vld;
  wire       [1:0]    switch_wcmd_gen_l234;
  wire                when_wcmd_gen_l249;
  wire                when_wcmd_gen_l255;
  wire                when_wcmd_gen_l261;

  assign _zz_myArea_end_bcnt = (myArea_dma_addr[1 : 0] + io_cfg_trans_xsize[1 : 0]);
  assign _zz_myArea_fir_wdata = myArea_remain_bnum_send[15 : 0];
  assign _zz_myArea_dma_addr = (myArea_dma_addr + _zz_myArea_dma_addr_1);
  assign _zz_myArea_dma_addr_1 = {16'd0, io_cfg_trans_xsize};
  assign _zz_when_wcmd_gen_l95 = myArea_remain_bnum_send[16];
  assign _zz_myArea_remain_bnum_send = 17'h00004;
  assign _zz_myArea_remain_bnum_send_1 = 17'h00003;
  assign _zz_myArea_remain_bnum_send_2 = 17'h00002;
  assign _zz_myArea_remain_bnum_send_3 = 17'h00001;
  assign _zz_myArea_remain_bnum_send_4 = 17'h00004;
  assign _zz_myArea_dma_addr_2 = {16'd0, io_cfg_da_ystep};
  assign _zz_myArea_remain_bnum_rd = io_cfg_trans_xsize;
  assign _zz_myArea_remain_bnum_rd_1 = 17'h00004;
  assign _zz_myArea_buf_4b = myArea_buf_bcnt[3];
  assign _zz_myArea_buf_4b_1 = myArea_buf_bcnt[2];
  assign _zz_io_buffer_buf_rd = myArea_remain_bnum_rd[16];
  assign _zz_myArea_dma_wd_last = myArea_remain_bnum_send[15 : 2];
  assign _zz_myArea_dma_wd_last_1 = 14'h0;
  assign _zz_myArea_last_best_vld = myArea_remain_bnum_send[1 : 0];
  assign _zz_myArea_last_best_vld_1 = myArea_buf_bcnt[1 : 0];
  assign _zz_myArea_last_best_vld_2 = myArea_buf_bcnt[3];
  assign _zz_myArea_nxt_buf_bcnt = {myArea_sub_bcnt,1'b0};
  assign _zz_myArea_nxt_buf_bcnt_1 = 4'b0100;
  assign _zz_myArea_nxt_buf_bcnt_2 = ($signed(myArea_buf_bcnt) - $signed(_zz_myArea_nxt_buf_bcnt_3));
  assign _zz_myArea_nxt_buf_bcnt_3 = {myArea_sub_bcnt,1'b0};
  assign _zz_myArea_nxt_buf_bcnt_4 = 4'b0100;
  assign _zz_when_wcmd_gen_l261 = myArea_remain_bnum_rd[16];
  assign myArea_end_bcnt = (_zz_myArea_end_bcnt + 2'b01);
  assign myArea_dma_1d_go = (io_dma_busy && (io_buffer_buf_buf_word[4 : 0] != 5'h0));
  assign myArea_dma_w_req = (myArea_dma_sta == 2'b01);
  assign io_dma_inf_w_req = myArea_dma_w_req;
  assign io_dma_inf_w_addr = myArea_dma_addr;
  assign io_dma_inf_w_len = io_cfg_trans_xsize;
  assign myArea_send_a_cmd = (myArea_dma_w_req && io_dma_inf_w_ack);
  assign myArea_send_a_data = (io_dma_inf_w_dvld && io_dma_inf_w_dack);
  assign myArea_fir_wdata = (myArea_send_a_data && (_zz_myArea_fir_wdata == io_cfg_trans_xsize));
  assign io_dma_cmd_end = myArea_dma_cmd_end;
  assign when_wcmd_gen_l95 = _zz_when_wcmd_gen_l95[0];
  assign when_wcmd_gen_l97 = (myArea_dma_ycnt == 16'h0);
  assign io_buffer_buf_err = myArea_buf_err;
  assign when_wcmd_gen_l138 = ((! io_dma_busy) && (! io_buffer_buf_empty));
  assign switch_wcmd_gen_l150 = myArea_dma_addr[1 : 0];
  assign myArea_buf_4b = ((! _zz_myArea_buf_4b[0]) && _zz_myArea_buf_4b_1[0]);
  assign io_buffer_buf_rd = ((((! myArea_buf_4b) || myArea_send_a_data) && (! io_buffer_buf_empty)) && (! _zz_io_buffer_buf_rd[0]));
  assign myArea_dma_wd_last = ($signed(_zz_myArea_dma_wd_last) == $signed(_zz_myArea_dma_wd_last_1));
  assign myArea_last_best_vld = ((myArea_dma_wd_last && ($signed(_zz_myArea_last_best_vld) < $signed(_zz_myArea_last_best_vld_1))) && (! _zz_myArea_last_best_vld_2[0]));
  assign io_dma_inf_w_dvld = (myArea_buf_4b || myArea_last_best_vld);
  assign io_dma_inf_wdata = {myArea_wd3,{myArea_wd2,{myArea_wd1,myArea_wd0}}};
  always @(*) begin
    if(myArea_fir_wdata) begin
      io_dma_inf_wbe = myArea_fir_wbe;
    end else begin
      if(myArea_dma_wd_last) begin
        io_dma_inf_wbe = myArea_last_wbe;
      end else begin
        io_dma_inf_wbe = 4'b1111;
      end
    end
  end

  always @(*) begin
    if(myArea_fir_wdata) begin
      case(myArea_align_model)
        2'b00 : begin
          myArea_sub_bcnt = 3'b100;
        end
        2'b01 : begin
          myArea_sub_bcnt = 3'b011;
        end
        2'b10 : begin
          myArea_sub_bcnt = 3'b010;
        end
        default : begin
          myArea_sub_bcnt = 3'b001;
        end
      endcase
    end else begin
      myArea_sub_bcnt = 3'b100;
    end
  end

  assign switch_wcmd_gen_l234 = {io_buffer_buf_rd,myArea_send_a_data};
  always @(*) begin
    case(switch_wcmd_gen_l234)
      2'b00 : begin
        myArea_nxt_buf_bcnt = myArea_buf_bcnt;
      end
      2'b01 : begin
        myArea_nxt_buf_bcnt = ($signed(myArea_buf_bcnt) - $signed(_zz_myArea_nxt_buf_bcnt));
      end
      2'b10 : begin
        myArea_nxt_buf_bcnt = ($signed(myArea_buf_bcnt) + $signed(_zz_myArea_nxt_buf_bcnt_1));
      end
      default : begin
        myArea_nxt_buf_bcnt = ($signed(_zz_myArea_nxt_buf_bcnt_2) + $signed(_zz_myArea_nxt_buf_bcnt_4));
      end
    endcase
  end

  assign when_wcmd_gen_l249 = (! io_rstn);
  assign when_wcmd_gen_l255 = (io_buffer_buf_rd || myArea_send_a_data);
  assign when_wcmd_gen_l261 = (io_buffer_buf_rd || (myArea_send_a_data && _zz_when_wcmd_gen_l261[0]));
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_dma_sta <= 2'b00;
      myArea_dma_ycnt <= 16'h0;
      myArea_dma_addr <= 32'h0;
      myArea_fir_wbe <= 4'b0000;
      myArea_last_wbe <= 4'b0000;
      myArea_align_model <= 2'b00;
      myArea_remain_bnum_rd <= 17'h10000;
      myArea_remain_bnum_send <= 17'h0;
      myArea_dma_cmd_end <= 1'b0;
      myArea_buf_err <= 1'b0;
      myArea_buf_bcnt <= 4'b0000;
      myArea_wd0 <= 8'h0;
      myArea_wd1 <= 8'h0;
      myArea_wd2 <= 8'h0;
      myArea_wd3 <= 8'h0;
      myArea_ed0 <= 8'h0;
      myArea_ed1 <= 8'h0;
      myArea_ed2 <= 8'h0;
    end else begin
      case(myArea_dma_sta)
        2'b00 : begin
          myArea_dma_cmd_end <= 1'b0;
          if(myArea_dma_1d_go) begin
            myArea_dma_sta <= 2'b01;
            myArea_dma_addr <= io_cfg_dar;
            myArea_dma_ycnt <= io_cfg_trans_ysize;
          end
        end
        2'b01 : begin
          if(io_dma_inf_w_ack) begin
            myArea_dma_sta <= 2'b10;
            myArea_dma_addr <= (_zz_myArea_dma_addr + 32'h00000001);
            myArea_remain_bnum_send <= {1'b0,io_cfg_trans_xsize};
          end
        end
        2'b10 : begin
          if(when_wcmd_gen_l95) begin
            myArea_dma_ycnt <= (myArea_dma_ycnt - 16'h0001);
            if(when_wcmd_gen_l97) begin
              myArea_dma_sta <= 2'b00;
              myArea_dma_cmd_end <= 1'b1;
            end else begin
              myArea_dma_sta <= 2'b11;
            end
          end
          if(myArea_send_a_data) begin
            if(myArea_fir_wdata) begin
              case(myArea_align_model)
                2'b00 : begin
                  myArea_remain_bnum_send <= ($signed(myArea_remain_bnum_send) - $signed(_zz_myArea_remain_bnum_send));
                end
                2'b01 : begin
                  myArea_remain_bnum_send <= ($signed(myArea_remain_bnum_send) - $signed(_zz_myArea_remain_bnum_send_1));
                end
                2'b10 : begin
                  myArea_remain_bnum_send <= ($signed(myArea_remain_bnum_send) - $signed(_zz_myArea_remain_bnum_send_2));
                end
                default : begin
                  myArea_remain_bnum_send <= ($signed(myArea_remain_bnum_send) - $signed(_zz_myArea_remain_bnum_send_3));
                end
              endcase
            end else begin
              myArea_remain_bnum_send <= ($signed(myArea_remain_bnum_send) - $signed(_zz_myArea_remain_bnum_send_4));
            end
          end
        end
        default : begin
          if(myArea_dma_1d_go) begin
            myArea_dma_addr <= (myArea_dma_addr + _zz_myArea_dma_addr_2);
            myArea_dma_sta <= 2'b01;
          end
        end
      endcase
      if(when_wcmd_gen_l138) begin
        myArea_buf_err <= 1'b1;
      end else begin
        if(io_buffer_clr_buf_err) begin
          myArea_buf_err <= 1'b0;
        end
      end
      if(myArea_send_a_cmd) begin
        myArea_align_model <= myArea_dma_addr[1 : 0];
        case(switch_wcmd_gen_l150)
          2'b00 : begin
            myArea_fir_wbe <= 4'b1111;
          end
          2'b01 : begin
            myArea_fir_wbe <= 4'b1110;
          end
          2'b10 : begin
            myArea_fir_wbe <= 4'b1100;
          end
          default : begin
            myArea_fir_wbe <= 4'b1000;
          end
        endcase
        case(myArea_end_bcnt)
          2'b00 : begin
            myArea_last_wbe <= 4'b1111;
          end
          2'b01 : begin
            myArea_last_wbe <= 4'b0001;
          end
          2'b10 : begin
            myArea_last_wbe <= 4'b0011;
          end
          default : begin
            myArea_last_wbe <= 4'b0111;
          end
        endcase
      end
      if(myArea_send_a_cmd) begin
        myArea_remain_bnum_rd <= {{1{_zz_myArea_remain_bnum_rd[15]}}, _zz_myArea_remain_bnum_rd};
      end else begin
        myArea_remain_bnum_rd <= ($signed(myArea_remain_bnum_rd) - $signed(_zz_myArea_remain_bnum_rd_1));
      end
      if(when_wcmd_gen_l249) begin
        myArea_buf_bcnt <= 4'b0000;
      end else begin
        if(myArea_send_a_cmd) begin
          myArea_buf_bcnt <= 4'b0000;
        end else begin
          if(when_wcmd_gen_l255) begin
            myArea_buf_bcnt <= myArea_nxt_buf_bcnt;
          end
        end
      end
      if(when_wcmd_gen_l261) begin
        case(myArea_align_model)
          2'b00 : begin
            myArea_wd0 <= io_buffer_buf_rdata[7 : 0];
            myArea_wd1 <= io_buffer_buf_rdata[15 : 8];
            myArea_wd2 <= io_buffer_buf_rdata[23 : 16];
            myArea_wd3 <= io_buffer_buf_rdata[31 : 24];
            myArea_ed0 <= myArea_ed0;
            myArea_ed1 <= myArea_ed1;
            myArea_ed2 <= myArea_ed2;
          end
          2'b01 : begin
            myArea_wd0 <= myArea_ed0;
            myArea_wd1 <= io_buffer_buf_rdata[7 : 0];
            myArea_wd2 <= io_buffer_buf_rdata[15 : 8];
            myArea_wd3 <= io_buffer_buf_rdata[23 : 16];
            myArea_ed0 <= io_buffer_buf_rdata[31 : 24];
            myArea_ed1 <= myArea_ed1;
            myArea_ed2 <= myArea_ed2;
          end
          2'b10 : begin
            myArea_wd0 <= myArea_ed0;
            myArea_wd1 <= myArea_ed1;
            myArea_wd2 <= io_buffer_buf_rdata[7 : 0];
            myArea_wd3 <= io_buffer_buf_rdata[15 : 8];
            myArea_ed0 <= io_buffer_buf_rdata[23 : 16];
            myArea_ed1 <= io_buffer_buf_rdata[31 : 24];
            myArea_ed2 <= myArea_ed2;
          end
          default : begin
            myArea_wd0 <= myArea_ed0;
            myArea_wd1 <= myArea_ed1;
            myArea_wd2 <= myArea_ed2;
            myArea_wd3 <= io_buffer_buf_rdata[7 : 0];
            myArea_ed0 <= io_buffer_buf_rdata[15 : 8];
            myArea_ed1 <= io_buffer_buf_rdata[23 : 16];
            myArea_ed2 <= io_buffer_buf_rdata[31 : 24];
          end
        endcase
      end
    end
  end


endmodule

module rcmd_gen (
  input      [31:0]   io_cfg_sar,
  input      [15:0]   io_cfg_trans_xsize,
  input      [15:0]   io_cfg_trans_ysize,
  input      [15:0]   io_cfg_sa_ystep,
  input               io_dma_cmd_sof,
  output              io_dma_inf_r_req,
  input               io_dma_inf_r_ack,
  output     [31:0]   io_dma_inf_r_addr,
  output     [15:0]   io_dma_inf_r_len,
  input               io_dma_inf_dvld,
  input               io_dma_inf_rd_last,
  input      [31:0]   io_dma_inf_rdata,
  input      [3:0]    io_dma_inf_rbe,
  output              io_dma_inf_dack,
  output              io_buffer_buf_wr,
  output     [31:0]   io_buffer_buf_wdata,
  input      [5:0]    io_buffer_buf_empty_word,
  input               io_clk,
  input               io_rstn
);

  wire       [31:0]   _zz_myArea_dma_addr;
  wire       [31:0]   _zz_myArea_dma_addr_1;
  wire       [31:0]   _zz_myArea_dma_addr_2;
  wire       [0:0]    _zz_io_buffer_buf_wr;
  reg        [1:0]    myArea_cmd_sta;
  reg        [15:0]   myArea_dma_ycnt;
  reg        [31:0]   myArea_dma_addr;
  wire                when_rcmd_gen_l70;
  wire                when_rcmd_gen_l84;
  reg        [7:0]    myArea_dbuf0;
  reg        [7:0]    myArea_dbuf1;
  reg        [7:0]    myArea_dbuf2;
  reg        [2:0]    myArea_buf_byte;
  reg                 myArea_dma_dlast_r;
  reg        [31:0]   myArea_dma_rdata_sf;
  wire                myArea_dma_dack;
  wire                myArea_dma_d_recv;
  wire       [2:0]    myArea_nxt_buf_byte0;
  wire       [2:0]    myArea_nxt_buf_byte1;
  wire       [2:0]    myArea_nxt_buf_byte2;
  wire       [2:0]    myArea_nxt_buf_byte3;
  wire                when_rcmd_gen_l114;
  wire                when_rcmd_gen_l117;
  wire                when_rcmd_gen_l120;
  wire                when_rcmd_gen_l123;
  wire                when_rcmd_gen_l135;
  wire                when_rcmd_gen_l138;
  wire                when_rcmd_gen_l141;
  wire                when_rcmd_gen_l144;
  wire                when_rcmd_gen_l155;
  wire                when_rcmd_gen_l158;
  wire                when_rcmd_gen_l161;
  wire                when_rcmd_gen_l164;
  wire                when_rcmd_gen_l175;
  wire       [1:0]    switch_rcmd_gen_l192;
  wire                myArea_last_wr_1d;
  wire       [31:0]   myArea_last_wdata;

  assign _zz_myArea_dma_addr = (myArea_dma_addr + _zz_myArea_dma_addr_1);
  assign _zz_myArea_dma_addr_1 = {16'd0, io_cfg_trans_xsize};
  assign _zz_myArea_dma_addr_2 = {16'd0, io_cfg_sa_ystep};
  assign _zz_io_buffer_buf_wr = myArea_nxt_buf_byte3[2];
  assign io_dma_inf_r_req = ((myArea_cmd_sta == 2'b00) ? 1'b1 : 1'b0);
  assign io_dma_inf_r_addr = myArea_dma_addr;
  assign io_dma_inf_r_len = io_cfg_trans_xsize;
  assign when_rcmd_gen_l70 = (myArea_dma_ycnt != io_cfg_trans_ysize);
  assign when_rcmd_gen_l84 = (myArea_cmd_sta == 2'b10);
  assign myArea_dma_dack = ((io_buffer_buf_empty_word != 6'h0) && (! myArea_dma_dlast_r));
  assign io_dma_inf_dack = myArea_dma_dack;
  assign myArea_dma_d_recv = (io_dma_inf_dvld && io_dma_inf_dack);
  assign myArea_nxt_buf_byte0 = ({1'b1,myArea_buf_byte[1 : 0]} + {2'b00,io_dma_inf_rbe[0]});
  assign myArea_nxt_buf_byte1 = (myArea_nxt_buf_byte0 + {2'b00,io_dma_inf_rbe[1]});
  assign myArea_nxt_buf_byte2 = (myArea_nxt_buf_byte1 + {2'b00,io_dma_inf_rbe[2]});
  assign myArea_nxt_buf_byte3 = (myArea_nxt_buf_byte2 + {2'b00,io_dma_inf_rbe[3]});
  assign when_rcmd_gen_l114 = (io_dma_inf_rbe[0] && (myArea_buf_byte[1 : 0] == 2'b00));
  assign when_rcmd_gen_l117 = (io_dma_inf_rbe[1] && (myArea_nxt_buf_byte0[1 : 0] == 2'b00));
  assign when_rcmd_gen_l120 = (io_dma_inf_rbe[2] && (myArea_nxt_buf_byte0[1 : 0] == 2'b00));
  assign when_rcmd_gen_l123 = (io_dma_inf_rbe[3] && (myArea_nxt_buf_byte0[1 : 0] == 2'b00));
  assign when_rcmd_gen_l135 = (io_dma_inf_rbe[0] && (myArea_buf_byte[1 : 0] == 2'b01));
  assign when_rcmd_gen_l138 = (io_dma_inf_rbe[1] && (myArea_nxt_buf_byte0[1 : 0] == 2'b01));
  assign when_rcmd_gen_l141 = (io_dma_inf_rbe[2] && (myArea_nxt_buf_byte0[1 : 0] == 2'b01));
  assign when_rcmd_gen_l144 = (io_dma_inf_rbe[3] && (myArea_nxt_buf_byte0[1 : 0] == 2'b01));
  assign when_rcmd_gen_l155 = (io_dma_inf_rbe[0] && (myArea_buf_byte[1 : 0] == 2'b10));
  assign when_rcmd_gen_l158 = (io_dma_inf_rbe[1] && (myArea_nxt_buf_byte0[1 : 0] == 2'b10));
  assign when_rcmd_gen_l161 = (io_dma_inf_rbe[2] && (myArea_nxt_buf_byte0[1 : 0] == 2'b10));
  assign when_rcmd_gen_l164 = (io_dma_inf_rbe[3] && (myArea_nxt_buf_byte0[1 : 0] == 2'b10));
  assign when_rcmd_gen_l175 = (myArea_dma_d_recv && io_dma_inf_rd_last);
  assign switch_rcmd_gen_l192 = myArea_buf_byte[1 : 0];
  always @(*) begin
    case(switch_rcmd_gen_l192)
      2'b00 : begin
        myArea_dma_rdata_sf = io_dma_inf_rdata[31 : 0];
      end
      2'b01 : begin
        myArea_dma_rdata_sf = {io_dma_inf_rdata[23 : 0],myArea_dbuf0};
      end
      2'b10 : begin
        myArea_dma_rdata_sf = {io_dma_inf_rdata[15 : 0],{myArea_dbuf1,myArea_dbuf0}};
      end
      default : begin
        myArea_dma_rdata_sf = {io_dma_inf_rdata[7 : 0],{myArea_dbuf2,{myArea_dbuf1,myArea_dbuf0}}};
      end
    endcase
  end

  assign myArea_last_wr_1d = (myArea_dma_dlast_r && (myArea_buf_byte[1 : 0] != 2'b00));
  assign myArea_last_wdata = {8'h0,{myArea_dbuf2,{myArea_dbuf1,myArea_dbuf0}}};
  assign io_buffer_buf_wr = ((myArea_dma_d_recv && _zz_io_buffer_buf_wr[0]) || myArea_last_wr_1d);
  assign io_buffer_buf_wdata = (myArea_last_wr_1d ? myArea_last_wdata : myArea_dma_rdata_sf);
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_cmd_sta <= 2'b00;
      myArea_dma_ycnt <= 16'h0;
      myArea_dma_addr <= 32'h0;
      myArea_dbuf0 <= 8'h0;
      myArea_dbuf1 <= 8'h0;
      myArea_dbuf2 <= 8'h0;
      myArea_buf_byte <= 3'b000;
      myArea_dma_dlast_r <= 1'b0;
    end else begin
      case(myArea_cmd_sta)
        2'b00 : begin
          if(io_dma_cmd_sof) begin
            myArea_cmd_sta <= 2'b01;
            myArea_dma_addr <= io_cfg_sar;
          end
        end
        2'b01 : begin
          if(io_dma_inf_r_ack) begin
            myArea_cmd_sta <= 2'b10;
            myArea_dma_addr <= (_zz_myArea_dma_addr + 32'h00000001);
          end
        end
        2'b10 : begin
          myArea_dma_addr <= (myArea_dma_addr + _zz_myArea_dma_addr_2);
          if(when_rcmd_gen_l70) begin
            myArea_cmd_sta <= 2'b01;
          end else begin
            myArea_cmd_sta <= 2'b00;
          end
        end
        default : begin
          myArea_cmd_sta <= 2'b00;
        end
      endcase
      if(io_dma_cmd_sof) begin
        myArea_dma_ycnt <= 16'h0;
      end else begin
        if(when_rcmd_gen_l84) begin
          myArea_dma_ycnt <= (myArea_dma_ycnt + 16'h0001);
        end
      end
      if(myArea_dma_d_recv) begin
        if(when_rcmd_gen_l114) begin
          myArea_dbuf0 <= io_dma_inf_rdata[7 : 0];
        end else begin
          if(when_rcmd_gen_l117) begin
            myArea_dbuf0 <= io_dma_inf_rdata[15 : 8];
          end else begin
            if(when_rcmd_gen_l120) begin
              myArea_dbuf0 <= io_dma_inf_rdata[23 : 16];
            end else begin
              if(when_rcmd_gen_l123) begin
                myArea_dbuf0 <= io_dma_inf_rdata[31 : 24];
              end
            end
          end
        end
      end
      if(myArea_dma_d_recv) begin
        if(when_rcmd_gen_l135) begin
          myArea_dbuf1 <= io_dma_inf_rdata[7 : 0];
        end else begin
          if(when_rcmd_gen_l138) begin
            myArea_dbuf1 <= io_dma_inf_rdata[15 : 8];
          end else begin
            if(when_rcmd_gen_l141) begin
              myArea_dbuf1 <= io_dma_inf_rdata[23 : 16];
            end else begin
              if(when_rcmd_gen_l144) begin
                myArea_dbuf1 <= io_dma_inf_rdata[31 : 24];
              end
            end
          end
        end
      end
      if(myArea_dma_d_recv) begin
        if(when_rcmd_gen_l155) begin
          myArea_dbuf2 <= io_dma_inf_rdata[7 : 0];
        end else begin
          if(when_rcmd_gen_l158) begin
            myArea_dbuf2 <= io_dma_inf_rdata[15 : 8];
          end else begin
            if(when_rcmd_gen_l161) begin
              myArea_dbuf2 <= io_dma_inf_rdata[23 : 16];
            end else begin
              if(when_rcmd_gen_l164) begin
                myArea_dbuf2 <= io_dma_inf_rdata[31 : 24];
              end
            end
          end
        end
      end
      if(when_rcmd_gen_l175) begin
        myArea_dma_dlast_r <= 1'b1;
      end else begin
        myArea_dma_dlast_r <= 1'b0;
      end
      if(myArea_dma_d_recv) begin
        myArea_buf_byte <= {1'b0,myArea_nxt_buf_byte3[1 : 0]};
      end else begin
        if(myArea_dma_dlast_r) begin
          myArea_buf_byte <= 3'b000;
        end
      end
    end
  end


endmodule

module cmd_fetch (
  input               io_ll_req,
  input      [31:0]   io_ll_addr,
  output              io_ll_ack,
  output              io_ll_dvld,
  output     [31:0]   io_ll_rdata,
  output     [2:0]    io_ll_dcnt,
  output              io_dma_inf_r_req,
  input               io_dma_inf_r_ack,
  output     [31:0]   io_dma_inf_r_addr,
  output     [15:0]   io_dma_inf_r_len,
  input               io_dma_inf_dvld,
  input               io_dma_inf_rd_last,
  input      [31:0]   io_dma_inf_rdata,
  input      [3:0]    io_dma_inf_rbe,
  output              io_dma_inf_dack,
  input               io_clk,
  input               io_rstn
);

  reg        [2:0]    myArea_ll_dcnt;
  wire                when_cmd_fetch_l38;

  assign io_dma_inf_r_req = io_ll_req;
  assign io_dma_inf_r_addr = io_ll_addr;
  assign io_dma_inf_r_len = 16'h0017;
  assign io_dma_inf_dack = 1'b1;
  assign io_ll_ack = io_dma_inf_r_ack;
  assign io_ll_dvld = io_dma_inf_dvld;
  assign io_ll_rdata = io_dma_inf_rdata;
  assign io_ll_dcnt = myArea_ll_dcnt;
  assign when_cmd_fetch_l38 = (io_ll_req && io_ll_ack);
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_ll_dcnt <= 3'b000;
    end else begin
      if(when_cmd_fetch_l38) begin
        myArea_ll_dcnt <= 3'b000;
      end else begin
        if(io_ll_dvld) begin
          myArea_ll_dcnt <= (myArea_ll_dcnt + 3'b001);
        end
      end
    end
  end


endmodule

module dma_cfg (
  input      [7:0]    io_apb_PADDR,
  input      [0:0]    io_apb_PSEL,
  input               io_apb_PENABLE,
  output              io_apb_PREADY,
  input               io_apb_PWRITE,
  input      [31:0]   io_apb_PWDATA,
  output     [31:0]   io_apb_PRDATA,
  output     [31:0]   io_cfg_sar,
  output     [31:0]   io_cfg_dar,
  output     [15:0]   io_cfg_trans_xsize,
  output     [15:0]   io_cfg_trans_ysize,
  output     [15:0]   io_cfg_sa_ystep,
  output     [15:0]   io_cfg_da_ystep,
  output     [31:0]   io_cfg_llr,
  output              io_cfg_dma_halt,
  output              io_cfg_bf,
  output              io_cfg_cf,
  input               io_cfg_buf_err,
  output              io_cfg_clr_bur_err,
  output              io_ll_req,
  output     [31:0]   io_ll_addr,
  input               io_ll_ack,
  input               io_ll_dvld,
  input      [31:0]   io_ll_rdata,
  input      [2:0]    io_ll_dcnt,
  output              io_dma_cmd_sof,
  input               io_dma_cmd_end,
  output     [7:0]    io_dma_cmd_num,
  output              io_dma_busy,
  output              io_dma_intr,
  input               io_clk,
  input               io_rstn
);

  reg        [31:0]   myArea_prdata;
  reg        [31:0]   myArea_cfg_sar;
  reg        [31:0]   myArea_cfg_dar;
  reg        [15:0]   myArea_cfg_trans_xsize;
  reg        [15:0]   myArea_cfg_trans_ysize;
  reg        [15:0]   myArea_cfg_sa_ystep;
  reg        [15:0]   myArea_cfg_da_ystep;
  reg        [31:0]   myArea_cfg_llr;
  reg                 myArea_cfg_dma_halt;
  reg                 myArea_cfg_bf;
  reg                 myArea_cfg_cf;
  reg                 myArea_dma_cmd_sof;
  reg        [7:0]    myArea_cmd_num;
  reg                 myArea_dma_busy;
  reg                 myArea_cfg_intr_en;
  wire                myArea_apb_wr;
  wire                myArea_apb_write;
  wire                myArea_apb_read;
  wire       [3:0]    myArea_apb_addr;
  wire                myArea_clr_intr;
  wire                myArea_dma_sof_w;
  wire                myArea_cmd_update;
  wire       [3:0]    myArea_cmd_update_addr;
  wire       [31:0]   myArea_cmd_update_wd;
  wire       [3:0]    switch_dma_cfg_l91;
  wire                when_dma_cfg_l116;
  reg        [0:0]    myArea_ll_sta;
  reg                 myArea_dma_end_flag;
  wire                myArea_dma_end_w;
  wire                when_dma_cfg_l138;
  wire                myArea_dma_cmd_goon;
  wire                when_dma_cfg_l185;
  wire       [3:0]    switch_dma_cfg_l194;

  assign io_apb_PRDATA = myArea_prdata;
  assign io_cfg_sar = myArea_cfg_sar;
  assign io_cfg_dar = myArea_cfg_dar;
  assign io_cfg_trans_xsize = myArea_cfg_trans_xsize;
  assign io_cfg_trans_ysize = myArea_cfg_trans_ysize;
  assign io_cfg_sa_ystep = myArea_cfg_sa_ystep;
  assign io_cfg_da_ystep = myArea_cfg_da_ystep;
  assign io_cfg_llr = myArea_cfg_llr;
  assign io_cfg_dma_halt = myArea_cfg_dma_halt;
  assign io_cfg_bf = myArea_cfg_bf;
  assign io_cfg_cf = myArea_cfg_cf;
  assign io_dma_cmd_sof = myArea_dma_cmd_sof;
  assign io_dma_cmd_num = myArea_cmd_num;
  assign io_dma_busy = myArea_dma_busy;
  assign myArea_apb_wr = ((io_apb_PSEL[0] && io_apb_PWRITE) && io_apb_PENABLE);
  assign myArea_apb_write = ((io_apb_PSEL[0] && io_apb_PWRITE) && io_apb_PENABLE);
  assign myArea_apb_read = (io_apb_PSEL[0] && (! io_apb_PWRITE));
  assign myArea_apb_addr = io_apb_PADDR[5 : 2];
  assign io_apb_PREADY = 1'b1;
  assign myArea_clr_intr = (((myArea_apb_write && io_apb_PENABLE) && (myArea_apb_addr == 4'b0110)) && (! io_apb_PWDATA[0]));
  assign myArea_dma_sof_w = (((myArea_apb_write && io_apb_PENABLE) && (myArea_apb_addr == 4'b1000)) && io_apb_PWDATA[0]);
  assign io_cfg_clr_bur_err = (((myArea_apb_write && io_apb_PENABLE) && (myArea_apb_addr == 4'b0110)) && (! io_apb_PWDATA[4]));
  assign myArea_cmd_update = (myArea_apb_write || io_ll_dvld);
  assign myArea_cmd_update_addr = (myArea_apb_write ? myArea_apb_addr : {io_ll_dcnt,1'b0});
  assign myArea_cmd_update_wd = (myArea_apb_write ? io_apb_PWDATA : io_ll_rdata);
  assign switch_dma_cfg_l91 = myArea_cmd_update_addr[3 : 0];
  assign when_dma_cfg_l116 = (myArea_apb_write && (myArea_apb_addr == 4'b0111));
  assign io_ll_addr = myArea_cfg_llr;
  assign io_ll_req = (myArea_ll_sta == 1'b1);
  assign myArea_dma_end_w = (io_dma_cmd_end && (myArea_cfg_llr[31 : 2] == 30'h0));
  assign when_dma_cfg_l138 = (io_dma_cmd_end && (myArea_cfg_llr[31 : 2] != 30'h0));
  assign myArea_dma_cmd_goon = (io_ll_dvld && (io_ll_dcnt == 3'b101));
  assign io_dma_intr = (myArea_dma_end_flag && myArea_cfg_intr_en);
  assign when_dma_cfg_l185 = (myArea_dma_sof_w || myArea_dma_cmd_goon);
  assign switch_dma_cfg_l194 = myArea_apb_addr[3 : 0];
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_prdata <= 32'h0;
      myArea_cfg_sar <= 32'h0;
      myArea_cfg_dar <= 32'h0;
      myArea_cfg_trans_xsize <= 16'h0;
      myArea_cfg_trans_ysize <= 16'h0;
      myArea_cfg_sa_ystep <= 16'h0;
      myArea_cfg_da_ystep <= 16'h0;
      myArea_cfg_llr <= 32'h0;
      myArea_cfg_dma_halt <= 1'b0;
      myArea_cfg_bf <= 1'b0;
      myArea_cfg_cf <= 1'b0;
      myArea_dma_cmd_sof <= 1'b0;
      myArea_cmd_num <= 8'h0;
      myArea_dma_busy <= 1'b0;
      myArea_cfg_intr_en <= 1'b0;
      myArea_ll_sta <= 1'b0;
      myArea_dma_end_flag <= 1'b0;
    end else begin
      if(myArea_cmd_update) begin
        case(switch_dma_cfg_l91)
          4'b0000 : begin
            myArea_cfg_sar <= myArea_cmd_update_wd;
          end
          4'b0001 : begin
            myArea_cfg_dar <= myArea_cmd_update_wd;
          end
          4'b0010 : begin
            myArea_cfg_trans_xsize <= myArea_cmd_update_wd[15 : 0];
          end
          4'b0011 : begin
            myArea_cfg_trans_ysize <= myArea_cmd_update_wd[15 : 0];
          end
          4'b0100 : begin
            myArea_cfg_sa_ystep <= myArea_cmd_update_wd[15 : 0];
            myArea_cfg_da_ystep <= myArea_cmd_update_wd[31 : 16];
          end
          4'b0101 : begin
            myArea_cfg_llr <= myArea_cmd_update_wd;
          end
          default : begin
          end
        endcase
      end
      if(when_dma_cfg_l116) begin
        myArea_cfg_intr_en <= io_apb_PWDATA[0];
        myArea_cfg_dma_halt <= io_apb_PWDATA[4];
        myArea_cfg_bf <= io_apb_PWDATA[8];
        myArea_cfg_cf <= io_apb_PWDATA[9];
      end
      case(myArea_ll_sta)
        1'b0 : begin
          if(when_dma_cfg_l138) begin
            myArea_ll_sta <= 1'b1;
          end
        end
        default : begin
          if(io_ll_ack) begin
            myArea_ll_sta <= 1'b0;
          end
        end
      endcase
      if(myArea_dma_sof_w) begin
        myArea_cmd_num <= 8'h0;
      end else begin
        if(io_dma_cmd_end) begin
          myArea_cmd_num <= (myArea_cmd_num + 8'h01);
        end
      end
      if(myArea_dma_sof_w) begin
        myArea_dma_busy <= 1'b1;
      end else begin
        if(myArea_dma_end_w) begin
          myArea_dma_busy <= 1'b1;
        end
      end
      if(myArea_dma_end_w) begin
        myArea_dma_end_flag <= 1'b1;
      end else begin
        if(myArea_clr_intr) begin
          myArea_dma_end_flag <= 1'b1;
        end
      end
      if(when_dma_cfg_l185) begin
        myArea_dma_cmd_sof <= 1'b1;
      end else begin
        myArea_dma_cmd_sof <= 1'b1;
      end
      if(myArea_apb_read) begin
        case(switch_dma_cfg_l194)
          4'b0000 : begin
            myArea_prdata <= myArea_cfg_sar;
          end
          4'b0001 : begin
            myArea_prdata <= myArea_cfg_dar;
          end
          4'b0010 : begin
            myArea_prdata <= {16'h0,myArea_cfg_trans_xsize};
          end
          4'b0011 : begin
            myArea_prdata <= {16'h0,myArea_cfg_trans_ysize};
          end
          4'b0100 : begin
            myArea_prdata <= {myArea_cfg_da_ystep,myArea_cfg_sa_ystep};
          end
          4'b0101 : begin
            myArea_prdata <= myArea_cfg_llr;
          end
          4'b0110 : begin
            myArea_prdata <= {16'h0,{myArea_cmd_num,{3'b000,{io_cfg_buf_err,{2'b00,{myArea_dma_busy,myArea_dma_end_flag}}}}}};
          end
          4'b0111 : begin
            myArea_prdata <= {22'h0,{myArea_cfg_cf,{myArea_cfg_bf,{3'b000,{myArea_cfg_dma_halt,{3'b000,myArea_cfg_intr_en}}}}}};
          end
          4'b1000 : begin
            myArea_prdata <= 32'h0;
          end
          4'b1001 : begin
            myArea_prdata <= 32'h0;
          end
          4'b1010 : begin
            myArea_prdata <= 32'h0;
          end
          4'b1011 : begin
            myArea_prdata <= {16'h0,16'h5310};
          end
          default : begin
            myArea_prdata <= 32'h0;
          end
        endcase
      end
    end
  end


endmodule

//strict_round_arbt replaced by strict_round_arbt

module strict_round_arbt (
  input               io_req0,
  input               io_req1,
  input               io_req2,
  input               io_req3,
  output              io_gnt0,
  output              io_gnt1,
  output              io_gnt2,
  output              io_gnt3,
  output     [1:0]    io_gnt_id,
  input               io_clk,
  input               io_rstn
);

  reg                 myArea_arbt_time_d;
  reg        [7:0]    myArea_cur_pri;
  reg        [1:0]    myArea_gnt_id_w;
  reg        [1:0]    myArea_gnt_id_fix;
  reg                 myArea_fix_req0;
  reg                 myArea_fix_req1;
  reg                 myArea_fix_req2;
  reg                 myArea_fix_req3;
  wire                myArea_arbt_time;
  wire       [1:0]    switch_strict_round_arbt_l49;
  wire       [1:0]    switch_strict_round_arbt_l64;
  wire       [1:0]    switch_strict_round_arbt_l79;
  wire       [1:0]    switch_strict_round_arbt_l94;
  reg                 myArea_gnt0;
  reg                 myArea_gnt1;
  reg                 myArea_gnt2;
  reg                 myArea_gnt3;
  reg        [1:0]    myArea_gnt_id;

  always @(*) begin
    myArea_gnt_id_fix = 2'b00;
    if(myArea_fix_req0) begin
      myArea_gnt_id_fix = 2'b00;
    end else begin
      if(myArea_fix_req1) begin
        myArea_gnt_id_fix = 2'b01;
      end else begin
        if(myArea_fix_req2) begin
          myArea_gnt_id_fix = 2'b10;
        end else begin
          if(myArea_fix_req3) begin
            myArea_gnt_id_fix = 2'b11;
          end
        end
      end
    end
  end

  assign myArea_arbt_time = ((! myArea_arbt_time_d) && (((io_req0 || io_req1) || io_req2) || io_req3));
  assign switch_strict_round_arbt_l49 = myArea_cur_pri[1 : 0];
  always @(*) begin
    case(switch_strict_round_arbt_l49)
      2'b00 : begin
        myArea_fix_req0 = io_req0;
      end
      2'b01 : begin
        myArea_fix_req0 = io_req1;
      end
      2'b10 : begin
        myArea_fix_req0 = io_req2;
      end
      default : begin
        myArea_fix_req0 = io_req3;
      end
    endcase
  end

  assign switch_strict_round_arbt_l64 = myArea_cur_pri[3 : 2];
  always @(*) begin
    case(switch_strict_round_arbt_l64)
      2'b00 : begin
        myArea_fix_req1 = io_req0;
      end
      2'b01 : begin
        myArea_fix_req1 = io_req1;
      end
      2'b10 : begin
        myArea_fix_req1 = io_req2;
      end
      default : begin
        myArea_fix_req1 = io_req3;
      end
    endcase
  end

  assign switch_strict_round_arbt_l79 = myArea_cur_pri[5 : 4];
  always @(*) begin
    case(switch_strict_round_arbt_l79)
      2'b00 : begin
        myArea_fix_req2 = io_req0;
      end
      2'b01 : begin
        myArea_fix_req2 = io_req1;
      end
      2'b10 : begin
        myArea_fix_req2 = io_req2;
      end
      default : begin
        myArea_fix_req2 = io_req3;
      end
    endcase
  end

  assign switch_strict_round_arbt_l94 = myArea_cur_pri[7 : 6];
  always @(*) begin
    case(switch_strict_round_arbt_l94)
      2'b00 : begin
        myArea_fix_req3 = io_req0;
      end
      2'b01 : begin
        myArea_fix_req3 = io_req1;
      end
      2'b10 : begin
        myArea_fix_req3 = io_req2;
      end
      default : begin
        myArea_fix_req3 = io_req3;
      end
    endcase
  end

  always @(*) begin
    case(myArea_gnt_id_fix)
      2'b00 : begin
        myArea_gnt_id_w = myArea_cur_pri[1 : 0];
      end
      2'b01 : begin
        myArea_gnt_id_w = myArea_cur_pri[3 : 2];
      end
      2'b10 : begin
        myArea_gnt_id_w = myArea_cur_pri[5 : 4];
      end
      default : begin
        myArea_gnt_id_w = myArea_cur_pri[7 : 6];
      end
    endcase
  end

  assign io_gnt0 = myArea_gnt0;
  assign io_gnt1 = myArea_gnt1;
  assign io_gnt2 = myArea_gnt2;
  assign io_gnt3 = myArea_gnt3;
  assign io_gnt_id = myArea_gnt_id;
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_arbt_time_d <= 1'b0;
      myArea_cur_pri <= {2'b11,{2'b10,{2'b01,2'b00}}};
      myArea_gnt0 <= 1'b0;
      myArea_gnt1 <= 1'b0;
      myArea_gnt2 <= 1'b0;
      myArea_gnt3 <= 1'b0;
      myArea_gnt_id <= 2'b00;
    end else begin
      if(myArea_arbt_time) begin
        case(myArea_gnt_id_w)
          2'b00 : begin
            myArea_gnt0 <= 1'b1;
          end
          2'b01 : begin
            myArea_gnt1 <= 1'b1;
          end
          2'b10 : begin
            myArea_gnt2 <= 1'b1;
          end
          default : begin
            myArea_gnt3 <= 1'b1;
          end
        endcase
      end else begin
        if(myArea_arbt_time_d) begin
          myArea_gnt0 <= 1'b0;
          myArea_gnt1 <= 1'b0;
          myArea_gnt2 <= 1'b0;
          myArea_gnt3 <= 1'b0;
        end
      end
      if(myArea_arbt_time) begin
        myArea_gnt_id <= myArea_gnt_id_w;
      end
      if(myArea_arbt_time) begin
        case(myArea_gnt_id_fix)
          2'b00 : begin
            myArea_cur_pri <= {myArea_cur_pri[1 : 0],myArea_cur_pri[7 : 2]};
          end
          2'b01 : begin
            myArea_cur_pri <= {myArea_cur_pri[3 : 2],{myArea_cur_pri[7 : 4],myArea_cur_pri[1 : 0]}};
          end
          2'b10 : begin
            myArea_cur_pri <= {myArea_cur_pri[5 : 4],{myArea_cur_pri[7 : 6],myArea_cur_pri[3 : 0]}};
          end
          default : begin
            myArea_cur_pri <= {myArea_cur_pri[7 : 6],myArea_cur_pri[5 : 0]};
          end
        endcase
      end
      myArea_arbt_time_d <= myArea_arbt_time;
    end
  end


endmodule
