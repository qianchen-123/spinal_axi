// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : dma_2_axi
// Git hash  : 9c40920248c54b4106d59045a2d785d7f59e312f

`timescale 1ns/1ps

module dma_2_axi (
  input               io_dma_cmd_sof,
  input               io_dma_busy,
  input               io_cfg_dma_halt,
  input               io_cfg_bf,
  input               io_cfg_cf,
  input      [5:0]    io_buf_buf_word,
  input      [5:0]    io_buf_empty_word,
  input               io_dma_w_req,
  output              io_dma_w_ack,
  input      [31:0]   io_dma_w_addr,
  input      [15:0]   io_dma_w_len,
  input               io_dma_w_dvld,
  input      [31:0]   io_dma_wdata,
  input      [3:0]    io_dma_wbe,
  output              io_dma_w_dack,
  input               io_dma_r_req0,
  output              io_dma_r_ack0,
  input      [31:0]   io_dma_r_addr0,
  input      [15:0]   io_dma_r_len0,
  output              io_dma_dvld0,
  output              io_dma_rd_last0,
  output     [31:0]   io_dma_rdata0,
  output     [3:0]    io_dma_rbe0,
  input               io_dma_dack0,
  input               io_dma_r_req1,
  output              io_dma_r_ack1,
  input      [31:0]   io_dma_r_addr1,
  input      [15:0]   io_dma_r_len1,
  output              io_dma_dvld1,
  output              io_dma_rd_last1,
  output     [31:0]   io_dma_rdata1,
  output     [3:0]    io_dma_rbe1,
  input               io_dma_dack1,
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
  input               io_rstn,
  input               clk,
  input               reset
);

  wire                dmaw_2_axi_arbt_io_gnt0;
  wire                dmaw_2_axi_arbt_io_gnt1;
  wire                dmaw_2_axi_arbt_io_gnt2;
  wire                dmaw_2_axi_arbt_io_gnt3;
  wire       [1:0]    dmaw_2_axi_arbt_io_gnt_id;
  wire                dmar_2_axi_arbt_io_gnt0;
  wire                dmar_2_axi_arbt_io_gnt1;
  wire                dmar_2_axi_arbt_io_gnt2;
  wire                dmar_2_axi_arbt_io_gnt3;
  wire       [1:0]    dmar_2_axi_arbt_io_gnt_id;
  wire       [0:0]    _zz_io_dma_w_ack;
  wire       [31:0]   _zz_dmaw_2_axi_nxt_bt_addr;
  wire       [31:0]   _zz_dmaw_2_axi_nxt_bt_addr_1;
  wire       [16:0]   _zz_dmaw_2_axi_nxt_bt_len;
  wire       [5:0]    _zz_dmaw_2_axi_cur_bt_byte;
  wire       [5:0]    _zz_dmaw_2_axi_cur_bt_byte_1;
  wire       [1:0]    _zz_dmaw_2_axi_cur_bt_byte_2;
  wire       [0:0]    _zz_dmaw_2_axi_cross_4kb_w;
  wire       [16:0]   _zz_dmaw_2_axi_cmd0_len_cross;
  wire       [16:0]   _zz_dmaw_2_axi_cmd1_len_w;
  wire       [1:0]    _zz_dmaw_2_axi_dma_end_bloc;
  wire       [0:0]    _zz_when_dma_2_axi_l171;
  wire       [0:0]    _zz_when_dma_2_axi_l184;
  wire       [5:0]    _zz_dmaw_2_axi_bnum_sub_len;
  wire       [4:0]    _zz_dmaw_2_axi_bnum_sub_len_1;
  wire       [0:0]    _zz_dmaw_2_axi_axi_cmd_go;
  wire       [0:0]    _zz_dmaw_2_axi_axi_cmd_go_1;
  wire       [0:0]    _zz_io_dma_r_ack0;
  wire       [0:0]    _zz_io_dma_r_ack1;
  wire       [31:0]   _zz_dmar_2_axi_nxt_bt_addr;
  wire       [31:0]   _zz_dmar_2_axi_nxt_bt_addr_1;
  wire       [16:0]   _zz_dmar_2_axi_nxt_bt_len;
  wire       [16:0]   _zz_dmar_2_axi_nxt_bt_len_1;
  wire       [16:0]   _zz_dmar_2_axi_nxt_bt_len_2;
  wire       [16:0]   _zz_dmar_2_axi_nxt_bt_len_3;
  wire       [6:0]    _zz_dmar_2_axi_buf_empty_sub_thres;
  wire       [6:0]    _zz_dmar_2_axi_buf_empty_sub_thres_1;
  wire       [0:0]    _zz_dmar_2_axi_buf_has_space;
  wire       [5:0]    _zz_dmar_2_axi_cur_bt_byte;
  wire       [5:0]    _zz_dmar_2_axi_cur_bt_byte_1;
  wire       [1:0]    _zz_dmar_2_axi_cur_bt_byte_2;
  wire       [0:0]    _zz_dmar_2_axi_cross_4kb_w;
  wire       [16:0]   _zz_dmar_2_axi_cmd0_len_cross;
  wire       [16:0]   _zz_dmar_2_axi_cmd1_len_w;
  wire       [1:0]    _zz_dmar_2_axi_dma_end_block;
  wire       [0:0]    _zz_dmar_2_axi_last_rdata;
  wire       [0:0]    _zz_when_dma_2_axi_l515;
  wire       [0:0]    _zz_when_dma_2_axi_l528;
  wire       [11:0]   _zz_dmar_2_axi_cmd0_len;
  wire       [15:0]   _zz_dmar_2_axi_cmd1_len;
  wire       [15:0]   _zz_dmar_2_axi_nxt_byte_remain;
  wire       [15:0]   _zz_dmar_2_axi_nxt_byte_remain_1;
  wire       [15:0]   _zz_dmar_2_axi_nxt_byte_remain_2;
  wire       [2:0]    _zz_dmar_2_axi_nxt_byte_remain_3;
  wire       [15:0]   _zz_dmar_2_axi_nxt_byte_remain_4;
  wire       [15:0]   _zz_dmar_2_axi_nxt_byte_remain_5;
  wire       [15:0]   _zz_dmar_2_axi_nxt_byte_remain_6;
  wire       [15:0]   _zz_dmar_2_axi_dma_byte_remain;
  wire       [0:0]    _zz_dmar_2_axi_axi_r_ch;
  wire       [1:0]    _zz_io_axi_ar_valid;
  wire       [1:0]    _zz_io_axi_ar_valid_1;
  wire       [5:0]    WCMD_THRES;
  reg        [1:0]    dmaw_2_axi_sta;
  wire                dmaw_2_axi_gnt0;
  wire                dmaw_2_axi_gnt1;
  wire                dmaw_2_axi_gnt2;
  wire                dmaw_2_axi_gnt3;
  wire       [3:0]    dmaw_2_axi_gnt;
  wire       [1:0]    dmaw_2_axi_gnt_id;
  reg        [31:0]   dmaw_2_axi_mux_addr;
  reg        [31:0]   dmaw_2_axi_cmd0_addr;
  reg        [11:0]   dmaw_2_axi_cmd0_len;
  reg        [31:0]   dmaw_2_axi_cmd1_addr;
  reg        [15:0]   dmaw_2_axi_cmd1_len;
  reg                 dmaw_2_axi_cross_4kb;
  reg        [5:0]    dmaw_2_axi_cur_bt_byte;
  wire                dmaw_2_axi_bt_cmd_ack;
  wire                dmaw_2_axi_dma_w_req_w;
  wire       [31:0]   dmaw_2_axi_cur_addr;
  wire       [15:0]   dmaw_2_axi_cur_len;
  wire       [31:0]   dmaw_2_axi_nxt_bt_addr;
  wire       [16:0]   dmaw_2_axi_nxt_bt_len;
  wire                dmaw_2_axi_bt_cmd_req;
  wire                dmaw_2_axi_send_bt_cmd;
  wire                when_dma_2_axi_l126;
  wire                when_dma_2_axi_l127;
  wire                when_dma_2_axi_l133;
  wire       [12:0]   dmaw_2_axi_addr_low_addr;
  wire                dmaw_2_axi_cross_4kb_w;
  wire       [16:0]   dmaw_2_axi_cmd0_len_cross;
  wire       [16:0]   dmaw_2_axi_cmd1_len_w;
  wire       [19:0]   dmaw_2_axi_cmd1_addr_h;
  wire       [1:0]    dmaw_2_axi_dma_end_bloc;
  wire                when_dma_2_axi_l149;
  wire                when_dma_2_axi_l152;
  wire                when_dma_2_axi_l157;
  wire                when_dma_2_axi_l171;
  wire                when_dma_2_axi_l184;
  wire                when_dma_2_axi_l194;
  wire                when_dma_2_axi_l198;
  wire                when_dma_2_axi_l202;
  wire                when_dma_2_axi_l209;
  wire                when_dma_2_axi_l213;
  wire                when_dma_2_axi_l217;
  reg        [1:0]    dmaw_2_axi_axi_sta;
  wire                dmaw_2_axi_axi_wr;
  reg                 dmaw_2_axi_axi_w_ch;
  reg        [31:0]   dmaw_2_axi_axi_addr;
  wire       [10:0]   dmaw_2_axi_axi_len_w;
  reg        [3:0]    dmaw_2_axi_axi_len;
  wire                dmaw_2_axi_axi_d_send;
  wire                dmaw_2_axi_axi_cmd_go;
  wire       [5:0]    dmaw_2_axi_bnum_sub_thres;
  wire       [5:0]    dmaw_2_axi_bnum_sub_len;
  wire                when_dma_2_axi_l246;
  wire                io_axi_aw_fire;
  wire                when_dma_2_axi_l268;
  wire       [5:0]    dmar_2_axi_RCMD_THRES;
  reg        [2:0]    dmar_2_axi_sta;
  wire                dmar_2_axi_dma_r_req0_w;
  wire                dmar_2_axi_dma_r_req1_w;
  wire                dmar_2_axi_trans_go;
  wire       [1:0]    dmar_2_axi_gnt_id;
  wire                dmar_2_axi_gnt0;
  wire                dmar_2_axi_gnt1;
  wire                dmar_2_axi_gnt2;
  wire                dmar_2_axi_gnt3;
  wire       [3:0]    dmar_2_axi_gnt;
  reg        [31:0]   dmar_2_axi_mux_addr;
  reg        [15:0]   dmar_2_axi_mux_len;
  reg        [15:0]   dmar_2_axi_dma_byte_remain;
  reg        [16:0]   dmar_2_axi_nxt_byte_remain;
  reg        [3:0]    dmar_2_axi_dma_rbe;
  reg        [31:0]   dmar_2_axi_cmd0_addr;
  reg        [11:0]   dmar_2_axi_cmd0_len;
  reg        [31:0]   dmar_2_axi_cmd1_addr;
  reg        [15:0]   dmar_2_axi_cmd1_len;
  wire       [12:0]   dmar_2_axi_addr_low_add;
  wire                dmar_2_axi_cross_4kb_w;
  reg                 dmar_2_axi_cross_4kb;
  wire       [16:0]   dmar_2_axi_cmd0_len_cross;
  wire       [16:0]   dmar_2_axi_cmd1_len_w;
  wire       [19:0]   dmar_2_axi_cmd1_addr_h;
  wire       [31:0]   dmar_2_axi_cur_addr;
  wire       [15:0]   dmar_2_axi_cur_len;
  reg        [5:0]    dmar_2_axi_cur_bt_byte;
  wire       [31:0]   dmar_2_axi_nxt_bt_addr;
  wire       [16:0]   dmar_2_axi_nxt_bt_len;
  wire                dmar_2_axi_bt_cmd_req;
  wire       [6:0]    dmar_2_axi_buf_empty_sub_thres;
  wire                dmar_2_axi_buf_has_space;
  wire                dmar_2_axi_bt_cmd_ack;
  wire                dmar_2_axi_send_bt_cmd;
  wire       [1:0]    dmar_2_axi_dma_end_block;
  reg        [3:0]    dmar_2_axi_dma_r_fir_be;
  reg        [3:0]    dmar_2_axi_dma_r_last_be;
  reg        [1:0]    dmar_2_axi_last_vld_byte;
  wire                dmar_2_axi_ch0_d_trans;
  wire                dmar_2_axi_ch1_d_trans;
  wire                dmar_2_axi_dma_d_trans;
  wire                dmar_2_axi_last_rdata;
  reg                 dmar_2_axi_first_d_flag;
  reg        [2:0]    dmar_2_axi_first_vld_byte;
  wire                when_dma_2_axi_l405;
  wire                when_dma_2_axi_l413;
  wire                when_dma_2_axi_l427;
  wire                when_dma_2_axi_l428;
  wire                when_dma_2_axi_l434;
  wire                when_dma_2_axi_l451;
  wire                when_dma_2_axi_l458;
  wire       [1:0]    switch_dma_2_axi_l461;
  wire                when_dma_2_axi_l501;
  wire                when_dma_2_axi_l515;
  wire                when_dma_2_axi_l528;
  wire                when_dma_2_axi_l538;
  wire                when_dma_2_axi_l545;
  wire                when_dma_2_axi_l549;
  wire                when_dma_2_axi_l558;
  wire                when_dma_2_axi_l562;
  wire                when_dma_2_axi_l566;
  wire                when_dma_2_axi_l579;
  wire                when_dma_2_axi_l583;
  wire                when_dma_2_axi_l597;
  reg        [1:0]    dmar_2_axi_axi_sta;
  wire                dmar_2_axi_axi_cmd_ack;
  wire                dmar_2_axi_axi_wr;
  reg                 dmar_2_axi_axi_r_ch;
  reg        [31:0]   dmar_2_axi_axi_addr;
  wire       [10:0]   dmar_2_axi_axi_len_w;
  reg        [3:0]    dmar_2_axi_axi_len;
  wire                when_dma_2_axi_l622;

  assign _zz_io_dma_w_ack = dmaw_2_axi_gnt[2];
  assign _zz_dmaw_2_axi_nxt_bt_addr = (dmaw_2_axi_cur_addr + _zz_dmaw_2_axi_nxt_bt_addr_1);
  assign _zz_dmaw_2_axi_nxt_bt_addr_1 = {26'd0, dmaw_2_axi_cur_bt_byte};
  assign _zz_dmaw_2_axi_nxt_bt_len = ({dmaw_2_axi_cur_len,1'b0} - {dmaw_2_axi_cur_bt_byte,11'h0});
  assign _zz_dmaw_2_axi_cur_bt_byte = (6'h20 - _zz_dmaw_2_axi_cur_bt_byte_1);
  assign _zz_dmaw_2_axi_cur_bt_byte_2 = dmaw_2_axi_mux_addr[1 : 0];
  assign _zz_dmaw_2_axi_cur_bt_byte_1 = {4'd0, _zz_dmaw_2_axi_cur_bt_byte_2};
  assign _zz_dmaw_2_axi_cross_4kb_w = dmaw_2_axi_addr_low_addr[12];
  assign _zz_dmaw_2_axi_cmd0_len_cross = (17'h01000 - {dmaw_2_axi_mux_addr[11 : 0],5'h0});
  assign _zz_dmaw_2_axi_cmd1_len_w = ({io_dma_w_len,1'b0} - {dmaw_2_axi_cmd0_len_cross[11 : 0],5'h0});
  assign _zz_dmaw_2_axi_dma_end_bloc = (dmaw_2_axi_mux_addr[1 : 0] + io_dma_w_len[1 : 0]);
  assign _zz_when_dma_2_axi_l171 = dmaw_2_axi_nxt_bt_addr[16];
  assign _zz_when_dma_2_axi_l184 = dmaw_2_axi_nxt_bt_len[16];
  assign _zz_dmaw_2_axi_bnum_sub_len_1 = {dmaw_2_axi_axi_len[3 : 0],1'b0};
  assign _zz_dmaw_2_axi_bnum_sub_len = {1'd0, _zz_dmaw_2_axi_bnum_sub_len_1};
  assign _zz_dmaw_2_axi_axi_cmd_go = dmaw_2_axi_bnum_sub_thres[5];
  assign _zz_dmaw_2_axi_axi_cmd_go_1 = dmaw_2_axi_bnum_sub_len[5];
  assign _zz_io_dma_r_ack0 = dmar_2_axi_gnt[0];
  assign _zz_io_dma_r_ack1 = dmar_2_axi_gnt[1];
  assign _zz_dmar_2_axi_nxt_bt_addr = (dmar_2_axi_cur_addr + _zz_dmar_2_axi_nxt_bt_addr_1);
  assign _zz_dmar_2_axi_nxt_bt_addr_1 = {26'd0, dmar_2_axi_cur_bt_byte};
  assign _zz_dmar_2_axi_nxt_bt_len = ($signed(_zz_dmar_2_axi_nxt_bt_len_1) - $signed(_zz_dmar_2_axi_nxt_bt_len_2));
  assign _zz_dmar_2_axi_nxt_bt_len_1 = {dmar_2_axi_cur_len,1'b0};
  assign _zz_dmar_2_axi_nxt_bt_len_2 = {dmar_2_axi_cur_bt_byte,11'h0};
  assign _zz_dmar_2_axi_nxt_bt_len_3 = 17'h00001;
  assign _zz_dmar_2_axi_buf_empty_sub_thres = {io_buf_empty_word,1'b0};
  assign _zz_dmar_2_axi_buf_empty_sub_thres_1 = {dmar_2_axi_RCMD_THRES,1'b0};
  assign _zz_dmar_2_axi_buf_has_space = dmar_2_axi_buf_empty_sub_thres[6];
  assign _zz_dmar_2_axi_cur_bt_byte = (6'h20 - _zz_dmar_2_axi_cur_bt_byte_1);
  assign _zz_dmar_2_axi_cur_bt_byte_2 = dmar_2_axi_mux_addr[1 : 0];
  assign _zz_dmar_2_axi_cur_bt_byte_1 = {4'd0, _zz_dmar_2_axi_cur_bt_byte_2};
  assign _zz_dmar_2_axi_cross_4kb_w = dmar_2_axi_addr_low_add[12];
  assign _zz_dmar_2_axi_cmd0_len_cross = (17'h01000 - {dmar_2_axi_mux_addr[11 : 0],5'h0});
  assign _zz_dmar_2_axi_cmd1_len_w = ({dmar_2_axi_mux_len,1'b0} - {dmar_2_axi_mux_addr[11 : 0],5'h0});
  assign _zz_dmar_2_axi_dma_end_block = (dmar_2_axi_mux_addr[1 : 0] + dmar_2_axi_mux_len[1 : 0]);
  assign _zz_dmar_2_axi_last_rdata = dmar_2_axi_nxt_byte_remain[16];
  assign _zz_when_dma_2_axi_l515 = dmar_2_axi_nxt_bt_len[16];
  assign _zz_when_dma_2_axi_l528 = dmar_2_axi_nxt_bt_len[16];
  assign _zz_dmar_2_axi_cmd0_len = dmar_2_axi_nxt_bt_len[11 : 0];
  assign _zz_dmar_2_axi_cmd1_len = dmar_2_axi_nxt_bt_len[15 : 0];
  assign _zz_dmar_2_axi_nxt_byte_remain = ($signed(_zz_dmar_2_axi_nxt_byte_remain_1) - $signed(_zz_dmar_2_axi_nxt_byte_remain_2));
  assign _zz_dmar_2_axi_nxt_byte_remain_1 = dmar_2_axi_dma_byte_remain;
  assign _zz_dmar_2_axi_nxt_byte_remain_3 = dmar_2_axi_first_vld_byte;
  assign _zz_dmar_2_axi_nxt_byte_remain_2 = {{13{_zz_dmar_2_axi_nxt_byte_remain_3[2]}}, _zz_dmar_2_axi_nxt_byte_remain_3};
  assign _zz_dmar_2_axi_nxt_byte_remain_4 = ($signed(_zz_dmar_2_axi_nxt_byte_remain_5) - $signed(_zz_dmar_2_axi_nxt_byte_remain_6));
  assign _zz_dmar_2_axi_nxt_byte_remain_5 = dmar_2_axi_dma_byte_remain;
  assign _zz_dmar_2_axi_nxt_byte_remain_6 = 16'h0004;
  assign _zz_dmar_2_axi_dma_byte_remain = dmar_2_axi_nxt_byte_remain[15 : 0];
  assign _zz_dmar_2_axi_axi_r_ch = dmar_2_axi_gnt_id[0];
  assign _zz_io_axi_ar_valid = dmar_2_axi_axi_sta;
  assign _zz_io_axi_ar_valid_1 = 2'b01;
  strict_round_arbt dmaw_2_axi_arbt (
    .io_req0   (1'b0                          ), //i
    .io_req1   (1'b1                          ), //i
    .io_req2   (dmaw_2_axi_dma_w_req_w        ), //i
    .io_req3   (1'b0                          ), //i
    .io_gnt0   (dmaw_2_axi_arbt_io_gnt0       ), //o
    .io_gnt1   (dmaw_2_axi_arbt_io_gnt1       ), //o
    .io_gnt2   (dmaw_2_axi_arbt_io_gnt2       ), //o
    .io_gnt3   (dmaw_2_axi_arbt_io_gnt3       ), //o
    .io_gnt_id (dmaw_2_axi_arbt_io_gnt_id[1:0]), //o
    .io_rstn   (io_rstn                       ), //i
    .clk       (clk                           ), //i
    .reset     (reset                         )  //i
  );
  strict_round_arbt dmar_2_axi_arbt (
    .io_req0   (dmar_2_axi_dma_r_req0_w       ), //i
    .io_req1   (dmar_2_axi_dma_r_req1_w       ), //i
    .io_req2   (1'b0                          ), //i
    .io_req3   (1'b0                          ), //i
    .io_gnt0   (dmar_2_axi_arbt_io_gnt0       ), //o
    .io_gnt1   (dmar_2_axi_arbt_io_gnt1       ), //o
    .io_gnt2   (dmar_2_axi_arbt_io_gnt2       ), //o
    .io_gnt3   (dmar_2_axi_arbt_io_gnt3       ), //o
    .io_gnt_id (dmar_2_axi_arbt_io_gnt_id[1:0]), //o
    .io_rstn   (io_rstn                       ), //i
    .clk       (clk                           ), //i
    .reset     (reset                         )  //i
  );
  assign WCMD_THRES = 6'h0c;
  assign dmaw_2_axi_gnt = {dmaw_2_axi_gnt3,{dmaw_2_axi_gnt2,{dmaw_2_axi_gnt1,dmaw_2_axi_gnt0}}};
  assign dmaw_2_axi_dma_w_req_w = ((io_dma_w_req && (dmaw_2_axi_sta == 2'b00)) && (! io_cfg_dma_halt));
  assign io_dma_w_ack = _zz_io_dma_w_ack[0];
  assign dmaw_2_axi_cur_addr = ((dmaw_2_axi_sta == 2'b10) ? dmaw_2_axi_cmd0_addr : dmaw_2_axi_cmd1_addr);
  assign dmaw_2_axi_cur_len = ((dmaw_2_axi_sta == 2'b10) ? {dmaw_2_axi_cmd0_len,4'b0000} : dmaw_2_axi_cmd1_len);
  assign dmaw_2_axi_nxt_bt_addr = (_zz_dmaw_2_axi_nxt_bt_addr + 32'h00000003);
  assign dmaw_2_axi_nxt_bt_len = (_zz_dmaw_2_axi_nxt_bt_len - 17'h00001);
  assign dmaw_2_axi_bt_cmd_req = ((dmaw_2_axi_sta == 2'b10) || (dmaw_2_axi_sta == 2'b11));
  assign dmaw_2_axi_send_bt_cmd = (dmaw_2_axi_bt_cmd_req && dmaw_2_axi_bt_cmd_ack);
  assign dmaw_2_axi_gnt0 = dmaw_2_axi_arbt_io_gnt0;
  assign dmaw_2_axi_gnt1 = dmaw_2_axi_arbt_io_gnt1;
  assign dmaw_2_axi_gnt2 = dmaw_2_axi_arbt_io_gnt2;
  assign dmaw_2_axi_gnt3 = dmaw_2_axi_arbt_io_gnt3;
  assign dmaw_2_axi_gnt_id = dmaw_2_axi_arbt_io_gnt_id;
  assign when_dma_2_axi_l126 = (dmaw_2_axi_mux_addr[1 : 0] != 2'b00);
  assign when_dma_2_axi_l127 = (dmaw_2_axi_cur_len[15 : 5] != 11'h0);
  assign when_dma_2_axi_l133 = (dmaw_2_axi_cur_len[15 : 6] != 10'h0);
  assign dmaw_2_axi_addr_low_addr = ({dmaw_2_axi_mux_addr[11 : 0],1'b0} + {io_dma_w_len[11 : 0],1'b0});
  assign dmaw_2_axi_cross_4kb_w = (_zz_dmaw_2_axi_cross_4kb_w[0] || (io_dma_w_len[15 : 12] != 4'b0000));
  assign dmaw_2_axi_cmd0_len_cross = (_zz_dmaw_2_axi_cmd0_len_cross - 17'h00001);
  assign dmaw_2_axi_cmd1_len_w = (_zz_dmaw_2_axi_cmd1_len_w - 17'h00001);
  assign dmaw_2_axi_cmd1_addr_h = (dmaw_2_axi_mux_addr[31 : 12] + 20'h00001);
  assign dmaw_2_axi_dma_end_bloc = (_zz_dmaw_2_axi_dma_end_bloc + 2'b01);
  assign when_dma_2_axi_l149 = (! io_rstn);
  assign when_dma_2_axi_l152 = (dmaw_2_axi_sta == 2'b01);
  assign when_dma_2_axi_l157 = (! io_rstn);
  assign when_dma_2_axi_l171 = _zz_when_dma_2_axi_l171[0];
  assign when_dma_2_axi_l184 = _zz_when_dma_2_axi_l184[0];
  assign when_dma_2_axi_l194 = (! io_rstn);
  assign when_dma_2_axi_l198 = (dmaw_2_axi_sta == 2'b01);
  assign when_dma_2_axi_l202 = ((dmaw_2_axi_sta == 2'b10) && dmaw_2_axi_send_bt_cmd);
  assign when_dma_2_axi_l209 = (! io_rstn);
  assign when_dma_2_axi_l213 = ((dmaw_2_axi_sta == 2'b01) && dmaw_2_axi_cross_4kb_w);
  assign when_dma_2_axi_l217 = ((dmaw_2_axi_sta == 2'b01) && dmaw_2_axi_send_bt_cmd);
  assign dmaw_2_axi_axi_wr = 1'b1;
  assign dmaw_2_axi_bt_cmd_ack = (dmaw_2_axi_axi_sta == 2'b00);
  assign dmaw_2_axi_axi_len_w = (dmaw_2_axi_nxt_bt_addr[12 : 2] - {dmaw_2_axi_cur_addr[11 : 2],1'b0});
  assign dmaw_2_axi_axi_d_send = (io_axi_w_valid && io_axi_w_ready);
  assign when_dma_2_axi_l246 = (! io_rstn);
  assign io_axi_aw_fire = (io_axi_aw_valid && io_axi_aw_ready);
  assign when_dma_2_axi_l268 = (dmaw_2_axi_axi_len == 4'b0000);
  assign dmaw_2_axi_bnum_sub_thres = ({io_buf_buf_word[4 : 0],1'b0} - WCMD_THRES);
  assign dmaw_2_axi_bnum_sub_len = ({io_buf_buf_word[4 : 0],1'b0} - _zz_dmaw_2_axi_bnum_sub_len);
  assign dmaw_2_axi_axi_cmd_go = ((! _zz_dmaw_2_axi_axi_cmd_go[0]) || (! _zz_dmaw_2_axi_axi_cmd_go_1[0]));
  assign io_axi_aw_valid = (((dmaw_2_axi_axi_sta == 2'b01) && dmaw_2_axi_axi_wr) && dmaw_2_axi_axi_cmd_go);
  assign io_axi_aw_payload_id = {dmaw_2_axi_axi_w_ch,3'b000};
  assign io_axi_aw_payload_addr = dmaw_2_axi_axi_addr;
  assign io_axi_aw_payload_len = {4'd0, dmaw_2_axi_axi_len};
  assign io_axi_aw_payload_size = 3'b010;
  assign io_axi_aw_payload_burst = 2'b01;
  assign io_axi_aw_payload_lock = 1'b0;
  assign io_axi_aw_payload_cache = {io_cfg_bf,{io_cfg_cf,2'b00}};
  assign io_axi_aw_payload_prot = 3'b010;
  assign io_axi_w_payload_data = io_dma_wdata;
  assign io_axi_w_payload_strb = io_dma_wbe;
  assign io_axi_w_payload_last = (dmaw_2_axi_axi_len == 4'b0000);
  assign io_axi_w_valid = (io_dma_w_dvld && (! io_cfg_dma_halt));
  assign io_dma_w_dack = io_axi_w_ready;
  assign io_axi_b_ready = 1'b1;
  assign dmar_2_axi_RCMD_THRES = 6'h08;
  assign dmar_2_axi_gnt = {dmar_2_axi_gnt3,{dmar_2_axi_gnt2,{dmar_2_axi_gnt1,dmar_2_axi_gnt0}}};
  assign dmar_2_axi_dma_r_req0_w = ((io_dma_r_req0 && (dmar_2_axi_sta == 3'b000)) && (! io_cfg_dma_halt));
  assign dmar_2_axi_dma_r_req1_w = ((io_dma_r_req1 && (dmar_2_axi_sta == 3'b000)) && (! io_cfg_dma_halt));
  assign io_dma_r_ack0 = _zz_io_dma_r_ack0[0];
  assign io_dma_r_ack1 = _zz_io_dma_r_ack1[0];
  assign dmar_2_axi_cur_addr = ((dmar_2_axi_sta == 3'b010) ? dmar_2_axi_cmd0_addr : dmar_2_axi_cmd1_addr);
  assign dmar_2_axi_cur_len = ((dmar_2_axi_sta == 3'b010) ? {dmar_2_axi_cmd0_len,4'b0000} : dmar_2_axi_cmd1_len);
  assign dmar_2_axi_nxt_bt_addr = (_zz_dmar_2_axi_nxt_bt_addr + 32'h00000003);
  assign dmar_2_axi_nxt_bt_len = ($signed(_zz_dmar_2_axi_nxt_bt_len) - $signed(_zz_dmar_2_axi_nxt_bt_len_3));
  assign dmar_2_axi_buf_empty_sub_thres = ($signed(_zz_dmar_2_axi_buf_empty_sub_thres) - $signed(_zz_dmar_2_axi_buf_empty_sub_thres_1));
  assign dmar_2_axi_buf_has_space = (! _zz_dmar_2_axi_buf_has_space[0]);
  assign dmar_2_axi_bt_cmd_req = ((((dmar_2_axi_sta == 3'b010) || (dmar_2_axi_sta == 3'b011)) && (! io_cfg_dma_halt)) && dmar_2_axi_buf_has_space);
  assign dmar_2_axi_send_bt_cmd = (dmar_2_axi_bt_cmd_req && dmar_2_axi_bt_cmd_ack);
  assign io_dma_dvld0 = (io_axi_r_valid && (io_axi_r_payload_id[1 : 0] == 2'b00));
  assign dmar_2_axi_ch0_d_trans = (io_dma_dvld0 && io_dma_dack0);
  assign io_dma_dvld1 = (io_axi_r_valid && (io_axi_r_payload_id[1 : 0] == 2'b01));
  assign dmar_2_axi_ch1_d_trans = (io_dma_dvld1 && io_dma_dack1);
  assign dmar_2_axi_dma_d_trans = (dmar_2_axi_ch0_d_trans || dmar_2_axi_ch1_d_trans);
  assign dmar_2_axi_gnt0 = dmar_2_axi_arbt_io_gnt0;
  assign dmar_2_axi_gnt1 = dmar_2_axi_arbt_io_gnt1;
  assign dmar_2_axi_gnt2 = dmar_2_axi_arbt_io_gnt2;
  assign dmar_2_axi_gnt3 = dmar_2_axi_arbt_io_gnt3;
  assign dmar_2_axi_gnt_id = dmar_2_axi_arbt_io_gnt_id;
  assign dmar_2_axi_trans_go = (dmar_2_axi_dma_r_req0_w || dmar_2_axi_dma_r_req1_w);
  assign when_dma_2_axi_l405 = (dmar_2_axi_gnt_id[0] == 1'b0);
  assign when_dma_2_axi_l413 = (dmar_2_axi_gnt_id[0] == 1'b0);
  assign when_dma_2_axi_l427 = (dmar_2_axi_mux_addr[1 : 0] != 2'b00);
  assign when_dma_2_axi_l428 = (dmar_2_axi_cur_len[15 : 5] != 11'h0);
  assign when_dma_2_axi_l434 = (dmar_2_axi_cur_len[15 : 6] != 10'h0);
  assign dmar_2_axi_addr_low_add = ({dmar_2_axi_mux_addr[11 : 0],1'b0} + {dmar_2_axi_mux_len[11 : 0],1'b0});
  assign dmar_2_axi_cross_4kb_w = (_zz_dmar_2_axi_cross_4kb_w[0] || (dmar_2_axi_mux_len[15 : 12] != 4'b0000));
  assign dmar_2_axi_cmd0_len_cross = (_zz_dmar_2_axi_cmd0_len_cross - 17'h00001);
  assign dmar_2_axi_cmd1_len_w = (_zz_dmar_2_axi_cmd1_len_w - 17'h00001);
  assign dmar_2_axi_cmd1_addr_h = (dmar_2_axi_mux_addr[31 : 12] + 20'h00001);
  assign dmar_2_axi_dma_end_block = (_zz_dmar_2_axi_dma_end_block + 2'b01);
  assign dmar_2_axi_last_rdata = _zz_dmar_2_axi_last_rdata[0];
  assign when_dma_2_axi_l451 = (! io_rstn);
  assign when_dma_2_axi_l458 = (dmar_2_axi_sta == 3'b001);
  assign switch_dma_2_axi_l461 = dmar_2_axi_mux_addr[1 : 0];
  assign when_dma_2_axi_l501 = (! io_rstn);
  assign when_dma_2_axi_l515 = _zz_when_dma_2_axi_l515[0];
  assign when_dma_2_axi_l528 = _zz_when_dma_2_axi_l528[0];
  assign when_dma_2_axi_l538 = (dmar_2_axi_dma_d_trans && dmar_2_axi_last_rdata);
  assign when_dma_2_axi_l545 = (! io_rstn);
  assign when_dma_2_axi_l549 = (dmar_2_axi_sta == 3'b001);
  assign when_dma_2_axi_l558 = (! io_rstn);
  assign when_dma_2_axi_l562 = ((dmar_2_axi_sta == 3'b001) && dmar_2_axi_cross_4kb_w);
  assign when_dma_2_axi_l566 = ((dmar_2_axi_sta == 3'b011) && dmar_2_axi_send_bt_cmd);
  assign when_dma_2_axi_l579 = (! io_rstn);
  assign when_dma_2_axi_l583 = (dmar_2_axi_sta == 3'b001);
  assign when_dma_2_axi_l597 = (dmar_2_axi_dma_byte_remain[15 : 2] == 14'h0);
  assign dmar_2_axi_axi_wr = 1'b0;
  assign dmar_2_axi_bt_cmd_ack = (dmar_2_axi_axi_sta == 2'b00);
  assign dmar_2_axi_axi_len_w = (dmar_2_axi_nxt_bt_addr[12 : 2] - {dmar_2_axi_cur_addr[11 : 2],1'b0});
  assign dmar_2_axi_axi_cmd_ack = io_axi_ar_ready;
  assign io_axi_r_ready = (dmar_2_axi_axi_r_ch ? io_dma_dack1 : io_dma_dack0);
  assign when_dma_2_axi_l622 = (! io_rstn);
  assign io_axi_ar_payload_id = {3'b000,dmar_2_axi_axi_r_ch};
  assign io_axi_ar_payload_addr = dmar_2_axi_axi_addr;
  assign io_axi_ar_payload_len = {4'd0, dmar_2_axi_axi_len};
  assign io_axi_ar_payload_size = 3'b010;
  assign io_axi_ar_payload_burst = 2'b01;
  assign io_axi_ar_payload_lock = 1'b0;
  assign io_axi_ar_payload_cache = {io_cfg_bf,{io_cfg_cf,2'b00}};
  assign io_axi_ar_payload_prot = 3'b010;
  assign io_axi_ar_valid = (($signed(_zz_io_axi_ar_valid) == $signed(_zz_io_axi_ar_valid_1)) && (! dmar_2_axi_axi_wr));
  assign io_dma_rd_last0 = dmar_2_axi_last_rdata;
  assign io_dma_rdata0 = io_axi_r_payload_data;
  assign io_dma_rbe0 = dmar_2_axi_dma_rbe;
  assign io_dma_rd_last1 = dmar_2_axi_last_rdata;
  assign io_dma_rdata1 = io_axi_r_payload_data;
  assign io_dma_rbe1 = dmar_2_axi_dma_rbe;
  always @(posedge clk) begin
    case(dmaw_2_axi_sta)
      2'b00, 2'b01 : begin
        dmaw_2_axi_mux_addr <= io_dma_w_addr;
      end
      2'b10 : begin
        dmaw_2_axi_mux_addr <= dmaw_2_axi_cmd0_addr;
      end
      default : begin
        dmaw_2_axi_mux_addr <= dmaw_2_axi_cmd1_addr;
      end
    endcase
    if(when_dma_2_axi_l126) begin
      if(when_dma_2_axi_l127) begin
        dmaw_2_axi_cur_bt_byte <= (_zz_dmaw_2_axi_cur_bt_byte - 6'h01);
      end else begin
        dmaw_2_axi_cur_bt_byte <= dmaw_2_axi_cur_len[5 : 0];
      end
    end else begin
      if(when_dma_2_axi_l133) begin
        dmaw_2_axi_cur_bt_byte <= 6'h3f;
      end else begin
        dmaw_2_axi_cur_bt_byte <= dmaw_2_axi_cur_len[5 : 0];
      end
    end
    if(when_dma_2_axi_l149) begin
      dmaw_2_axi_cross_4kb <= 1'b0;
    end else begin
      if(when_dma_2_axi_l152) begin
        dmaw_2_axi_cross_4kb <= dmaw_2_axi_cross_4kb_w;
      end
    end
    if(when_dma_2_axi_l157) begin
      dmaw_2_axi_sta <= 2'b00;
    end else begin
      case(dmaw_2_axi_sta)
        2'b00 : begin
          if(dmaw_2_axi_dma_w_req_w) begin
            dmaw_2_axi_sta <= 2'b01;
          end
        end
        2'b01 : begin
          dmaw_2_axi_sta <= 2'b10;
        end
        2'b10 : begin
          if(dmaw_2_axi_send_bt_cmd) begin
            if(when_dma_2_axi_l171) begin
              if(dmaw_2_axi_cross_4kb) begin
                dmaw_2_axi_sta <= 2'b11;
              end else begin
                dmaw_2_axi_sta <= 2'b00;
              end
            end else begin
              dmaw_2_axi_sta <= 2'b10;
            end
          end
        end
        default : begin
          if(dmaw_2_axi_send_bt_cmd) begin
            if(when_dma_2_axi_l184) begin
              dmaw_2_axi_sta <= 2'b00;
            end else begin
              dmaw_2_axi_sta <= 2'b11;
            end
          end
        end
      endcase
    end
    if(when_dma_2_axi_l194) begin
      dmaw_2_axi_cmd0_addr <= 32'h0;
      dmaw_2_axi_cmd0_len <= 12'h0;
    end else begin
      if(when_dma_2_axi_l198) begin
        dmaw_2_axi_cmd0_addr <= dmaw_2_axi_mux_addr;
        dmaw_2_axi_cmd0_len <= (dmaw_2_axi_cross_4kb_w ? dmaw_2_axi_cmd0_len_cross[11 : 0] : io_dma_w_len[11 : 0]);
      end else begin
        if(when_dma_2_axi_l202) begin
          dmaw_2_axi_cmd0_addr <= {2'b00,dmaw_2_axi_nxt_bt_addr[31 : 2]};
          dmaw_2_axi_cmd0_len <= dmaw_2_axi_nxt_bt_len[11 : 0];
        end
      end
    end
    if(when_dma_2_axi_l209) begin
      dmaw_2_axi_cmd1_addr <= 32'h0;
      dmaw_2_axi_cmd1_len <= 16'h0;
    end else begin
      if(when_dma_2_axi_l213) begin
        dmaw_2_axi_cmd1_addr <= {12'h0,dmaw_2_axi_cmd1_addr_h};
        dmaw_2_axi_cmd1_len <= dmaw_2_axi_cmd1_len_w[15 : 0];
      end else begin
        if(when_dma_2_axi_l217) begin
          dmaw_2_axi_cmd1_addr <= {2'b00,dmaw_2_axi_nxt_bt_addr[31 : 2]};
          dmaw_2_axi_cmd1_len <= dmaw_2_axi_nxt_bt_len[15 : 0];
        end
      end
    end
    if(when_dma_2_axi_l246) begin
      dmaw_2_axi_axi_sta <= 2'b00;
      dmaw_2_axi_axi_len <= 4'b0000;
      dmaw_2_axi_axi_addr <= 32'h0;
      dmaw_2_axi_axi_w_ch <= 1'b0;
    end else begin
      case(dmaw_2_axi_axi_sta)
        2'b00 : begin
          if(dmaw_2_axi_bt_cmd_req) begin
            dmaw_2_axi_axi_sta <= 2'b01;
            dmaw_2_axi_axi_len <= dmaw_2_axi_axi_len_w[3 : 0];
            dmaw_2_axi_axi_addr <= {2'b00,dmaw_2_axi_cur_addr[31 : 2]};
            dmaw_2_axi_axi_w_ch <= 1'b0;
          end
        end
        2'b01 : begin
          if(io_axi_aw_fire) begin
            dmaw_2_axi_axi_sta <= 2'b10;
          end
        end
        2'b10 : begin
          if(dmaw_2_axi_axi_d_send) begin
            if(when_dma_2_axi_l268) begin
              dmaw_2_axi_axi_sta <= 2'b00;
            end else begin
              dmaw_2_axi_axi_sta <= 2'b10;
              dmaw_2_axi_axi_len <= (dmaw_2_axi_axi_len - 4'b0001);
            end
          end
        end
        default : begin
          dmaw_2_axi_axi_sta <= 2'b00;
        end
      endcase
    end
    if(when_dma_2_axi_l427) begin
      if(when_dma_2_axi_l428) begin
        dmar_2_axi_cur_bt_byte <= (_zz_dmar_2_axi_cur_bt_byte - 6'h01);
      end else begin
        dmar_2_axi_cur_bt_byte <= dmar_2_axi_cur_len[5 : 0];
      end
    end else begin
      if(when_dma_2_axi_l434) begin
        dmar_2_axi_cur_bt_byte <= 6'h3f;
      end else begin
        dmar_2_axi_cur_bt_byte <= dmar_2_axi_cur_len[5 : 0];
      end
    end
    if(when_dma_2_axi_l451) begin
      dmar_2_axi_cross_4kb <= 1'b0;
    end else begin
      if(when_dma_2_axi_l458) begin
        dmar_2_axi_cross_4kb <= dmar_2_axi_bt_cmd_req;
      end
    end
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      dmar_2_axi_sta <= 3'b000;
      dmar_2_axi_mux_addr <= 32'h0;
      dmar_2_axi_mux_len <= 16'h0;
      dmar_2_axi_dma_byte_remain <= 16'h0;
      dmar_2_axi_nxt_byte_remain <= 17'h0;
      dmar_2_axi_dma_rbe <= 4'b0000;
      dmar_2_axi_cmd0_addr <= 32'h0;
      dmar_2_axi_cmd0_len <= 12'h0;
      dmar_2_axi_cmd1_addr <= 32'h0;
      dmar_2_axi_cmd1_len <= 16'h0;
      dmar_2_axi_dma_r_fir_be <= 4'b0000;
      dmar_2_axi_dma_r_last_be <= 4'b0000;
      dmar_2_axi_last_vld_byte <= 2'b00;
      dmar_2_axi_first_d_flag <= 1'b0;
      dmar_2_axi_first_vld_byte <= 3'b000;
      dmar_2_axi_axi_sta <= 2'b00;
      dmar_2_axi_axi_r_ch <= 1'b0;
      dmar_2_axi_axi_addr <= 32'h0;
      dmar_2_axi_axi_len <= 4'b0000;
    end else begin
      if(when_dma_2_axi_l405) begin
        dmar_2_axi_mux_len <= io_dma_r_len0;
      end else begin
        dmar_2_axi_mux_len <= io_dma_r_len1;
      end
      case(dmar_2_axi_sta)
        3'b000, 3'b001 : begin
          if(when_dma_2_axi_l413) begin
            dmar_2_axi_mux_addr <= io_dma_r_addr0;
          end else begin
            dmar_2_axi_mux_addr <= io_dma_r_addr1;
          end
        end
        3'b010 : begin
          dmar_2_axi_mux_addr <= dmar_2_axi_cmd0_addr;
        end
        default : begin
          dmar_2_axi_mux_addr <= dmar_2_axi_cmd1_addr;
        end
      endcase
      if(when_dma_2_axi_l451) begin
        dmar_2_axi_first_vld_byte <= 3'b000;
        dmar_2_axi_dma_r_fir_be <= 4'b0000;
        dmar_2_axi_dma_r_last_be <= 4'b0000;
        dmar_2_axi_last_vld_byte <= 2'b00;
      end else begin
        if(when_dma_2_axi_l458) begin
          case(switch_dma_2_axi_l461)
            2'b00 : begin
              dmar_2_axi_dma_r_fir_be <= 4'b1111;
              dmar_2_axi_first_vld_byte <= 3'b100;
            end
            2'b01 : begin
              dmar_2_axi_dma_r_fir_be <= 4'b1110;
              dmar_2_axi_first_vld_byte <= 3'b011;
            end
            2'b10 : begin
              dmar_2_axi_dma_r_fir_be <= 4'b1100;
              dmar_2_axi_first_vld_byte <= 3'b010;
            end
            default : begin
              dmar_2_axi_dma_r_fir_be <= 4'b1000;
              dmar_2_axi_first_vld_byte <= 3'b001;
            end
          endcase
          case(dmar_2_axi_dma_end_block)
            2'b00 : begin
              dmar_2_axi_dma_r_last_be <= 4'b1111;
              dmar_2_axi_last_vld_byte <= 2'b11;
            end
            2'b01 : begin
              dmar_2_axi_dma_r_last_be <= 4'b0001;
              dmar_2_axi_last_vld_byte <= 2'b00;
            end
            2'b10 : begin
              dmar_2_axi_dma_r_last_be <= 4'b0011;
              dmar_2_axi_last_vld_byte <= 2'b01;
            end
            default : begin
              dmar_2_axi_dma_r_last_be <= 4'b0111;
              dmar_2_axi_last_vld_byte <= 2'b10;
            end
          endcase
        end
      end
      if(when_dma_2_axi_l501) begin
        dmar_2_axi_sta <= 3'b000;
      end else begin
        case(dmar_2_axi_sta)
          3'b000 : begin
            if(dmar_2_axi_trans_go) begin
              dmar_2_axi_sta <= 3'b001;
            end
          end
          3'b001 : begin
            dmar_2_axi_sta <= 3'b010;
          end
          3'b010 : begin
            if(dmar_2_axi_send_bt_cmd) begin
              if(when_dma_2_axi_l515) begin
                if(dmar_2_axi_cross_4kb) begin
                  dmar_2_axi_sta <= 3'b011;
                end else begin
                  dmar_2_axi_sta <= 3'b100;
                end
              end else begin
                dmar_2_axi_sta <= 3'b010;
              end
            end
          end
          3'b011 : begin
            if(dmar_2_axi_send_bt_cmd) begin
              if(when_dma_2_axi_l528) begin
                dmar_2_axi_sta <= 3'b100;
              end else begin
                dmar_2_axi_sta <= 3'b011;
              end
            end
          end
          3'b100 : begin
            if(when_dma_2_axi_l538) begin
              dmar_2_axi_sta <= 3'b000;
            end
          end
          default : begin
          end
        endcase
      end
      if(when_dma_2_axi_l545) begin
        dmar_2_axi_cmd0_addr <= 32'h0;
        dmar_2_axi_cmd0_len <= 12'h0;
      end else begin
        if(when_dma_2_axi_l549) begin
          dmar_2_axi_cmd0_addr <= dmar_2_axi_mux_addr;
          dmar_2_axi_cmd0_len <= (dmar_2_axi_cross_4kb_w ? dmar_2_axi_cmd0_len_cross[11 : 0] : dmar_2_axi_mux_len[11 : 0]);
        end else begin
          dmar_2_axi_cmd0_addr <= {dmar_2_axi_nxt_bt_addr[31 : 2],2'b00};
          dmar_2_axi_cmd0_len <= _zz_dmar_2_axi_cmd0_len;
        end
      end
      if(when_dma_2_axi_l558) begin
        dmar_2_axi_cmd1_addr <= 32'h0;
        dmar_2_axi_cmd1_len <= 16'h0;
      end else begin
        if(when_dma_2_axi_l562) begin
          dmar_2_axi_cmd1_addr <= {dmar_2_axi_cmd1_addr_h,12'h0};
          dmar_2_axi_cmd1_len <= dmar_2_axi_cmd1_len_w[15 : 0];
        end else begin
          if(when_dma_2_axi_l566) begin
            dmar_2_axi_cmd1_addr <= {dmar_2_axi_nxt_bt_addr[31 : 2],2'b00};
            dmar_2_axi_cmd1_len <= _zz_dmar_2_axi_cmd1_len;
          end
        end
      end
      if(dmar_2_axi_first_d_flag) begin
        dmar_2_axi_nxt_byte_remain <= {{1{_zz_dmar_2_axi_nxt_byte_remain[15]}}, _zz_dmar_2_axi_nxt_byte_remain};
      end else begin
        dmar_2_axi_nxt_byte_remain <= {{1{_zz_dmar_2_axi_nxt_byte_remain_4[15]}}, _zz_dmar_2_axi_nxt_byte_remain_4};
      end
      if(when_dma_2_axi_l579) begin
        dmar_2_axi_dma_byte_remain <= 16'h0;
        dmar_2_axi_first_d_flag <= 1'b1;
      end else begin
        if(when_dma_2_axi_l583) begin
          dmar_2_axi_dma_byte_remain <= dmar_2_axi_mux_len;
          dmar_2_axi_first_d_flag <= 1'b1;
        end else begin
          if(dmar_2_axi_dma_d_trans) begin
            dmar_2_axi_first_d_flag <= 1'b0;
            dmar_2_axi_dma_byte_remain <= _zz_dmar_2_axi_dma_byte_remain;
          end
        end
      end
      if(dmar_2_axi_first_d_flag) begin
        dmar_2_axi_dma_rbe <= dmar_2_axi_dma_r_fir_be;
      end else begin
        if(when_dma_2_axi_l597) begin
          dmar_2_axi_dma_rbe <= dmar_2_axi_dma_r_last_be;
        end else begin
          dmar_2_axi_dma_rbe <= 4'b1111;
        end
      end
      if(when_dma_2_axi_l622) begin
        dmar_2_axi_axi_sta <= 2'b00;
        dmar_2_axi_axi_len <= 4'b0000;
        dmar_2_axi_axi_addr <= 32'h0;
        dmar_2_axi_axi_r_ch <= 1'b0;
      end else begin
        case(dmar_2_axi_axi_sta)
          2'b00 : begin
            if(dmar_2_axi_bt_cmd_req) begin
              dmar_2_axi_axi_sta <= 2'b01;
              dmar_2_axi_axi_len <= dmar_2_axi_axi_len_w[3 : 0];
              dmar_2_axi_axi_addr <= {dmar_2_axi_cur_addr[31 : 2],2'b00};
              dmar_2_axi_axi_r_ch <= _zz_dmar_2_axi_axi_r_ch[0];
            end
          end
          2'b01 : begin
            if(dmar_2_axi_axi_cmd_ack) begin
              dmar_2_axi_axi_sta <= 2'b00;
            end
          end
          default : begin
            dmar_2_axi_axi_sta <= 2'b00;
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
  output reg          io_gnt0,
  output reg          io_gnt1,
  output reg          io_gnt2,
  output reg          io_gnt3,
  output reg [1:0]    io_gnt_id,
  input               io_rstn,
  input               clk,
  input               reset
);

  reg                 arbt_time_d;
  reg        [7:0]    cur_pri;
  reg        [1:0]    gnt_id_w;
  reg        [1:0]    gnt_id_fix;
  reg                 fix_req0;
  reg                 fix_req1;
  reg                 fix_req2;
  reg                 fix_req3;
  wire                arbt_time;
  wire       [1:0]    switch_strict_round_arbt_l36;
  wire       [1:0]    switch_strict_round_arbt_l51;
  wire       [1:0]    switch_strict_round_arbt_l66;
  wire       [1:0]    switch_strict_round_arbt_l81;
  wire                when_strict_round_arbt_l127;
  wire                when_strict_round_arbt_l159;
  wire                when_strict_round_arbt_l167;
  wire                when_strict_round_arbt_l188;

  assign arbt_time = ((! arbt_time_d) && (((io_req0 || io_req1) || io_req2) || io_req3));
  assign switch_strict_round_arbt_l36 = cur_pri[1 : 0];
  assign switch_strict_round_arbt_l51 = cur_pri[3 : 2];
  assign switch_strict_round_arbt_l66 = cur_pri[5 : 4];
  assign switch_strict_round_arbt_l81 = cur_pri[7 : 6];
  assign when_strict_round_arbt_l127 = (! io_rstn);
  always @(*) begin
    io_gnt_id = 2'b00;
    if(when_strict_round_arbt_l159) begin
      io_gnt_id = 2'b00;
    end else begin
      if(arbt_time) begin
        io_gnt_id = gnt_id_w;
      end
    end
  end

  assign when_strict_round_arbt_l159 = (! io_rstn);
  assign when_strict_round_arbt_l167 = (! io_rstn);
  assign when_strict_round_arbt_l188 = (! io_rstn);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_gnt0 <= 1'b0;
      io_gnt1 <= 1'b0;
      io_gnt2 <= 1'b0;
      io_gnt3 <= 1'b0;
      arbt_time_d <= 1'b0;
      cur_pri <= 8'h0;
      gnt_id_w <= 2'b00;
      gnt_id_fix <= 2'b00;
      fix_req0 <= 1'b0;
      fix_req1 <= 1'b0;
      fix_req2 <= 1'b0;
      fix_req3 <= 1'b0;
    end else begin
      case(switch_strict_round_arbt_l36)
        2'b00 : begin
          fix_req0 <= io_req0;
        end
        2'b01 : begin
          fix_req0 <= io_req1;
        end
        2'b10 : begin
          fix_req0 <= io_req2;
        end
        default : begin
          fix_req0 <= io_req3;
        end
      endcase
      case(switch_strict_round_arbt_l51)
        2'b00 : begin
          fix_req1 <= io_req0;
        end
        2'b01 : begin
          fix_req1 <= io_req1;
        end
        2'b10 : begin
          fix_req1 <= io_req2;
        end
        default : begin
          fix_req1 <= io_req3;
        end
      endcase
      case(switch_strict_round_arbt_l66)
        2'b00 : begin
          fix_req2 <= io_req0;
        end
        2'b01 : begin
          fix_req2 <= io_req1;
        end
        2'b10 : begin
          fix_req2 <= io_req2;
        end
        default : begin
          fix_req2 <= io_req3;
        end
      endcase
      case(switch_strict_round_arbt_l81)
        2'b00 : begin
          fix_req3 <= io_req0;
        end
        2'b01 : begin
          fix_req3 <= io_req1;
        end
        2'b10 : begin
          fix_req3 <= io_req2;
        end
        default : begin
          fix_req3 <= io_req3;
        end
      endcase
      if(fix_req0) begin
        gnt_id_fix <= 2'b00;
      end else begin
        if(fix_req1) begin
          gnt_id_fix <= 2'b01;
        end else begin
          if(fix_req2) begin
            gnt_id_fix <= 2'b10;
          end else begin
            if(fix_req3) begin
              gnt_id_fix <= 2'b11;
            end
          end
        end
      end
      case(gnt_id_fix)
        2'b00 : begin
          gnt_id_w <= cur_pri[1 : 0];
        end
        2'b01 : begin
          gnt_id_w <= cur_pri[3 : 2];
        end
        2'b10 : begin
          gnt_id_w <= cur_pri[5 : 4];
        end
        default : begin
          gnt_id_w <= cur_pri[7 : 6];
        end
      endcase
      if(when_strict_round_arbt_l127) begin
        io_gnt0 <= 1'b0;
        io_gnt1 <= 1'b0;
        io_gnt2 <= 1'b0;
        io_gnt3 <= 1'b0;
      end else begin
        if(arbt_time) begin
          case(gnt_id_w)
            2'b00 : begin
              io_gnt0 <= 1'b1;
            end
            2'b01 : begin
              io_gnt1 <= 1'b1;
            end
            2'b10 : begin
              io_gnt2 <= 1'b1;
            end
            default : begin
              io_gnt3 <= 1'b1;
            end
          endcase
        end else begin
          if(arbt_time_d) begin
            io_gnt0 <= 1'b0;
            io_gnt1 <= 1'b0;
            io_gnt2 <= 1'b0;
            io_gnt3 <= 1'b0;
          end
        end
      end
      if(when_strict_round_arbt_l167) begin
        cur_pri <= {2'b00,{2'b01,{2'b10,2'b11}}};
      end else begin
        if(arbt_time) begin
          case(gnt_id_fix)
            2'b00 : begin
              cur_pri <= {cur_pri[1 : 0],cur_pri[7 : 2]};
            end
            2'b01 : begin
              cur_pri <= {cur_pri[3 : 2],{cur_pri[7 : 4],cur_pri[1 : 0]}};
            end
            2'b10 : begin
              cur_pri <= {cur_pri[5 : 4],{cur_pri[7 : 6],cur_pri[3 : 0]}};
            end
            default : begin
              cur_pri <= {cur_pri[5 : 0],cur_pri[7 : 6]};
            end
          endcase
        end
      end
      if(when_strict_round_arbt_l188) begin
        arbt_time_d <= 1'b0;
      end else begin
        arbt_time_d <= arbt_time;
      end
    end
  end


endmodule
