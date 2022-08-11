// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : wcmd_gen
// Git hash  : 1ada80d2d659ea5af45b334c0c8b37d14dd88650

`timescale 1ns/1ps

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
  wire       [0:0]    _zz_when_wcmd_gen_l99;
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
  wire       [0:0]    _zz_when_wcmd_gen_l265;
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
  wire                when_wcmd_gen_l99;
  wire                when_wcmd_gen_l101;
  reg                 myArea_buf_err;
  wire                when_wcmd_gen_l142;
  wire       [1:0]    switch_wcmd_gen_l154;
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
  wire       [1:0]    switch_wcmd_gen_l238;
  wire                when_wcmd_gen_l253;
  wire                when_wcmd_gen_l259;
  wire                when_wcmd_gen_l265;

  assign _zz_myArea_end_bcnt = (myArea_dma_addr[1 : 0] + io_cfg_trans_xsize[1 : 0]);
  assign _zz_myArea_fir_wdata = myArea_remain_bnum_send[15 : 0];
  assign _zz_myArea_dma_addr = (myArea_dma_addr + _zz_myArea_dma_addr_1);
  assign _zz_myArea_dma_addr_1 = {16'd0, io_cfg_trans_xsize};
  assign _zz_when_wcmd_gen_l99 = myArea_remain_bnum_send[16];
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
  assign _zz_when_wcmd_gen_l265 = myArea_remain_bnum_rd[16];
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
  assign when_wcmd_gen_l99 = _zz_when_wcmd_gen_l99[0];
  assign when_wcmd_gen_l101 = (myArea_dma_ycnt == 16'h0);
  assign io_buffer_buf_err = myArea_buf_err;
  assign when_wcmd_gen_l142 = ((! io_dma_busy) && (! io_buffer_buf_empty));
  assign switch_wcmd_gen_l154 = myArea_dma_addr[1 : 0];
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

  assign switch_wcmd_gen_l238 = {io_buffer_buf_rd,myArea_send_a_data};
  always @(*) begin
    case(switch_wcmd_gen_l238)
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

  assign when_wcmd_gen_l253 = (! io_rstn);
  assign when_wcmd_gen_l259 = (io_buffer_buf_rd || myArea_send_a_data);
  assign when_wcmd_gen_l265 = (io_buffer_buf_rd || (myArea_send_a_data && _zz_when_wcmd_gen_l265[0]));
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
          if(when_wcmd_gen_l99) begin
            myArea_dma_ycnt <= (myArea_dma_ycnt - 16'h0001);
            if(when_wcmd_gen_l101) begin
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
      if(when_wcmd_gen_l142) begin
        myArea_buf_err <= 1'b1;
      end else begin
        if(io_buffer_clr_buf_err) begin
          myArea_buf_err <= 1'b0;
        end
      end
      if(myArea_send_a_cmd) begin
        myArea_align_model <= myArea_dma_addr[1 : 0];
        case(switch_wcmd_gen_l154)
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
      if(when_wcmd_gen_l253) begin
        myArea_buf_bcnt <= 4'b0000;
      end else begin
        if(myArea_send_a_cmd) begin
          myArea_buf_bcnt <= 4'b0000;
        end else begin
          if(when_wcmd_gen_l259) begin
            myArea_buf_bcnt <= myArea_nxt_buf_bcnt;
          end
        end
      end
      if(when_wcmd_gen_l265) begin
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
