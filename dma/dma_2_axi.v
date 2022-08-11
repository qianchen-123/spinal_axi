// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : dma_2_axi
// Git hash  : 1ada80d2d659ea5af45b334c0c8b37d14dd88650

`timescale 1ns/1ps

module dma_2_axi (
  input               io_dma_cmd_sof,
  input               io_dma_busy,
  input               io_cfg_dma_halt,
  input               io_cfg_bf,
  input               io_cfg_cf,
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
  wire       [0:0]    _zz_when_dma_2_axi_l190;
  wire       [0:0]    _zz_when_dma_2_axi_l203;
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
  wire       [0:0]    _zz_when_dma_2_axi_l522;
  wire       [0:0]    _zz_when_dma_2_axi_l535;
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
  wire                when_dma_2_axi_l149;
  wire                when_dma_2_axi_l150;
  wire                when_dma_2_axi_l156;
  wire       [12:0]   myArea_dmaw_2_axi_addr_low_addr;
  wire                myArea_dmaw_2_axi_cross_4kb_w;
  wire       [16:0]   myArea_dmaw_2_axi_cmd0_len_cross;
  wire       [16:0]   myArea_dmaw_2_axi_cmd1_len_w;
  wire       [19:0]   myArea_dmaw_2_axi_cmd1_addr_h;
  wire       [1:0]    myArea_dmaw_2_axi_dma_end_bloc;
  wire                when_dma_2_axi_l173;
  wire                when_dma_2_axi_l190;
  wire                when_dma_2_axi_l203;
  wire                when_dma_2_axi_l214;
  wire                when_dma_2_axi_l218;
  wire                when_dma_2_axi_l226;
  wire                when_dma_2_axi_l230;
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
  wire                when_dma_2_axi_l276;
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
  wire                when_dma_2_axi_l420;
  wire                when_dma_2_axi_l428;
  wire                when_dma_2_axi_l442;
  wire                when_dma_2_axi_l443;
  wire                when_dma_2_axi_l449;
  wire                when_dma_2_axi_l467;
  wire       [1:0]    switch_dma_2_axi_l470;
  wire                when_dma_2_axi_l522;
  wire                when_dma_2_axi_l535;
  wire                when_dma_2_axi_l545;
  wire                when_dma_2_axi_l553;
  wire                when_dma_2_axi_l563;
  wire                when_dma_2_axi_l567;
  wire                when_dma_2_axi_l581;
  wire                when_dma_2_axi_l595;
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
  assign _zz_when_dma_2_axi_l190 = myArea_dmaw_2_axi_nxt_bt_addr[16];
  assign _zz_when_dma_2_axi_l203 = myArea_dmaw_2_axi_nxt_bt_len[16];
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
  assign _zz_when_dma_2_axi_l522 = myArea_dmar_2_axi_nxt_bt_len[16];
  assign _zz_when_dma_2_axi_l535 = myArea_dmar_2_axi_nxt_bt_len[16];
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
    if(when_dma_2_axi_l149) begin
      if(when_dma_2_axi_l150) begin
        myArea_dmaw_2_axi_cur_bt_byte = (_zz_myArea_dmaw_2_axi_cur_bt_byte - 6'h01);
      end else begin
        myArea_dmaw_2_axi_cur_bt_byte = myArea_dmaw_2_axi_cur_len[5 : 0];
      end
    end else begin
      if(when_dma_2_axi_l156) begin
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

  assign when_dma_2_axi_l149 = (myArea_dmaw_2_axi_mux_addr[1 : 0] != 2'b00);
  assign when_dma_2_axi_l150 = (myArea_dmaw_2_axi_cur_len[15 : 5] != 11'h0);
  assign when_dma_2_axi_l156 = (myArea_dmaw_2_axi_cur_len[15 : 6] != 10'h0);
  assign myArea_dmaw_2_axi_addr_low_addr = ({myArea_dmaw_2_axi_mux_addr[11 : 0],1'b0} + {io_dma_inf_w_w_len[11 : 0],1'b0});
  assign myArea_dmaw_2_axi_cross_4kb_w = (_zz_myArea_dmaw_2_axi_cross_4kb_w[0] || (io_dma_inf_w_w_len[15 : 12] != 4'b0000));
  assign myArea_dmaw_2_axi_cmd0_len_cross = (_zz_myArea_dmaw_2_axi_cmd0_len_cross - 17'h00001);
  assign myArea_dmaw_2_axi_cmd1_len_w = (_zz_myArea_dmaw_2_axi_cmd1_len_w - 17'h00001);
  assign myArea_dmaw_2_axi_cmd1_addr_h = (myArea_dmaw_2_axi_mux_addr[31 : 12] + 20'h00001);
  assign myArea_dmaw_2_axi_dma_end_bloc = (_zz_myArea_dmaw_2_axi_dma_end_bloc + 2'b01);
  assign when_dma_2_axi_l173 = (myArea_dmaw_2_axi_sta == 2'b01);
  assign when_dma_2_axi_l190 = _zz_when_dma_2_axi_l190[0];
  assign when_dma_2_axi_l203 = _zz_when_dma_2_axi_l203[0];
  assign when_dma_2_axi_l214 = (myArea_dmaw_2_axi_sta == 2'b01);
  assign when_dma_2_axi_l218 = ((myArea_dmaw_2_axi_sta == 2'b10) && myArea_dmaw_2_axi_send_bt_cmd);
  assign when_dma_2_axi_l226 = ((myArea_dmaw_2_axi_sta == 2'b01) && myArea_dmaw_2_axi_cross_4kb_w);
  assign when_dma_2_axi_l230 = ((myArea_dmaw_2_axi_sta == 2'b01) && myArea_dmaw_2_axi_send_bt_cmd);
  assign myArea_dmaw_2_axi_axi_wr = 1'b1;
  assign myArea_dmaw_2_axi_bt_cmd_ack = (myArea_dmaw_2_axi_axi_sta == 2'b00);
  assign myArea_dmaw_2_axi_axi_len_w = (myArea_dmaw_2_axi_nxt_bt_addr[12 : 2] - {myArea_dmaw_2_axi_cur_addr[11 : 2],1'b0});
  assign myArea_dmaw_2_axi_axi_d_send = (io_axi_w_valid && io_axi_w_ready);
  assign io_axi_aw_fire = (io_axi_aw_valid && io_axi_aw_ready);
  assign when_dma_2_axi_l276 = (myArea_dmaw_2_axi_axi_len == 4'b0000);
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
    if(when_dma_2_axi_l420) begin
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
      if(when_dma_2_axi_l595) begin
        myArea_dmar_2_axi_dma_rbe = myArea_dmar_2_axi_dma_r_last_be;
      end else begin
        myArea_dmar_2_axi_dma_rbe = 4'b1111;
      end
    end
  end

  always @(*) begin
    myArea_dmar_2_axi_cur_bt_byte = 6'h0;
    if(when_dma_2_axi_l442) begin
      if(when_dma_2_axi_l443) begin
        myArea_dmar_2_axi_cur_bt_byte = (_zz_myArea_dmar_2_axi_cur_bt_byte - 6'h01);
      end else begin
        myArea_dmar_2_axi_cur_bt_byte = myArea_dmar_2_axi_cur_len[5 : 0];
      end
    end else begin
      if(when_dma_2_axi_l449) begin
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
  assign when_dma_2_axi_l420 = (myArea_dmar_2_axi_gnt_id[0] == 1'b0);
  assign when_dma_2_axi_l428 = (myArea_dmar_2_axi_gnt_id[0] == 1'b0);
  always @(*) begin
    case(myArea_dmar_2_axi_sta)
      3'b000, 3'b001 : begin
        if(when_dma_2_axi_l428) begin
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

  assign when_dma_2_axi_l442 = (myArea_dmar_2_axi_mux_addr[1 : 0] != 2'b00);
  assign when_dma_2_axi_l443 = (myArea_dmar_2_axi_cur_len[15 : 5] != 11'h0);
  assign when_dma_2_axi_l449 = (myArea_dmar_2_axi_cur_len[15 : 6] != 10'h0);
  assign myArea_dmar_2_axi_addr_low_add = ({1'b0,myArea_dmar_2_axi_mux_addr[11 : 0]} + {1'b0,myArea_dmar_2_axi_mux_len[11 : 0]});
  assign myArea_dmar_2_axi_cross_4kb_w = (_zz_myArea_dmar_2_axi_cross_4kb_w[0] || (myArea_dmar_2_axi_mux_len[15 : 12] != 4'b0000));
  assign myArea_dmar_2_axi_cmd0_len_cross = (_zz_myArea_dmar_2_axi_cmd0_len_cross - 17'h00001);
  assign myArea_dmar_2_axi_cmd1_len_w = (_zz_myArea_dmar_2_axi_cmd1_len_w - 17'h00001);
  assign myArea_dmar_2_axi_cmd1_addr_h = (myArea_dmar_2_axi_mux_addr[31 : 12] + 20'h00001);
  assign myArea_dmar_2_axi_dma_end_block = (_zz_myArea_dmar_2_axi_dma_end_block + 2'b01);
  assign myArea_dmar_2_axi_last_rdata = _zz_myArea_dmar_2_axi_last_rdata[0];
  assign when_dma_2_axi_l467 = (myArea_dmar_2_axi_sta == 3'b001);
  assign switch_dma_2_axi_l470 = myArea_dmar_2_axi_mux_addr[1 : 0];
  assign when_dma_2_axi_l522 = _zz_when_dma_2_axi_l522[0];
  assign when_dma_2_axi_l535 = _zz_when_dma_2_axi_l535[0];
  assign when_dma_2_axi_l545 = (myArea_dmar_2_axi_dma_d_trans && myArea_dmar_2_axi_last_rdata);
  assign when_dma_2_axi_l553 = (myArea_dmar_2_axi_sta == 3'b001);
  assign when_dma_2_axi_l563 = ((myArea_dmar_2_axi_sta == 3'b001) && myArea_dmar_2_axi_cross_4kb_w);
  assign when_dma_2_axi_l567 = ((myArea_dmar_2_axi_sta == 3'b011) && myArea_dmar_2_axi_send_bt_cmd);
  assign when_dma_2_axi_l581 = (myArea_dmar_2_axi_sta == 3'b001);
  assign when_dma_2_axi_l595 = (myArea_dmar_2_axi_dma_byte_remain[15 : 2] == 14'h0);
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
      if(when_dma_2_axi_l173) begin
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
            if(when_dma_2_axi_l190) begin
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
            if(when_dma_2_axi_l203) begin
              myArea_dmaw_2_axi_sta <= 2'b00;
            end else begin
              myArea_dmaw_2_axi_sta <= 2'b11;
            end
          end
        end
      endcase
      if(when_dma_2_axi_l214) begin
        myArea_dmaw_2_axi_cmd0_addr <= myArea_dmaw_2_axi_mux_addr;
        myArea_dmaw_2_axi_cmd0_len <= (myArea_dmaw_2_axi_cross_4kb_w ? myArea_dmaw_2_axi_cmd0_len_cross[11 : 0] : io_dma_inf_w_w_len[11 : 0]);
      end else begin
        if(when_dma_2_axi_l218) begin
          myArea_dmaw_2_axi_cmd0_addr <= {myArea_dmaw_2_axi_nxt_bt_addr[31 : 2],2'b00};
          myArea_dmaw_2_axi_cmd0_len <= myArea_dmaw_2_axi_nxt_bt_len[11 : 0];
        end
      end
      if(when_dma_2_axi_l226) begin
        myArea_dmaw_2_axi_cmd1_addr <= {myArea_dmaw_2_axi_cmd1_addr_h,12'h0};
        myArea_dmaw_2_axi_cmd1_len <= myArea_dmaw_2_axi_cmd1_len_w[15 : 0];
      end else begin
        if(when_dma_2_axi_l230) begin
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
            if(when_dma_2_axi_l276) begin
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
      if(when_dma_2_axi_l467) begin
        myArea_dmar_2_axi_cross_4kb <= myArea_dmar_2_axi_cross_4kb_w;
        case(switch_dma_2_axi_l470)
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
            if(when_dma_2_axi_l522) begin
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
            if(when_dma_2_axi_l535) begin
              myArea_dmar_2_axi_sta <= 3'b100;
            end else begin
              myArea_dmar_2_axi_sta <= 3'b011;
            end
          end
        end
        3'b100 : begin
          if(when_dma_2_axi_l545) begin
            myArea_dmar_2_axi_sta <= 3'b000;
          end
        end
        default : begin
        end
      endcase
      if(when_dma_2_axi_l553) begin
        myArea_dmar_2_axi_cmd0_addr <= myArea_dmar_2_axi_mux_addr;
        myArea_dmar_2_axi_cmd0_len <= (myArea_dmar_2_axi_cross_4kb_w ? myArea_dmar_2_axi_cmd0_len_cross[11 : 0] : myArea_dmar_2_axi_mux_len[11 : 0]);
      end else begin
        myArea_dmar_2_axi_cmd0_addr <= {myArea_dmar_2_axi_nxt_bt_addr[31 : 2],2'b00};
        myArea_dmar_2_axi_cmd0_len <= _zz_myArea_dmar_2_axi_cmd0_len;
      end
      if(when_dma_2_axi_l563) begin
        myArea_dmar_2_axi_cmd1_addr <= {myArea_dmar_2_axi_cmd1_addr_h,12'h0};
        myArea_dmar_2_axi_cmd1_len <= myArea_dmar_2_axi_cmd1_len_w[15 : 0];
      end else begin
        if(when_dma_2_axi_l567) begin
          myArea_dmar_2_axi_cmd1_addr <= {myArea_dmar_2_axi_nxt_bt_addr[31 : 2],2'b00};
          myArea_dmar_2_axi_cmd1_len <= _zz_myArea_dmar_2_axi_cmd1_len;
        end
      end
      if(when_dma_2_axi_l581) begin
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
