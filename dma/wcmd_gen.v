// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : wcmd_gen
// Git hash  : 9c40920248c54b4106d59045a2d785d7f59e312f

`timescale 1ns/1ps

module wcmd_gen (
  input      [31:0]   io_cfg_dar,
  input      [15:0]   io_cfg_trans_xsize,
  input      [15:0]   io_cfg_trans_ysize,
  input      [15:0]   io_cfg_da_ystep,
  input               io_dma_cmd_sof,
  output reg          io_dma_cmd_end,
  input               io_dma_busy,
  output              io_dma_inf_dma_w_req,
  input               io_dma_inf_dma_w_ack,
  output     [31:0]   io_dma_inf_dma_w_addr,
  output     [15:0]   io_dma_inf_dma_w_len,
  output              io_dma_inf_dma_w_dvld,
  output     [31:0]   io_dma_inf_dma_wdata,
  output reg [3:0]    io_dma_inf_dma_wbe,
  input               io_dma_inf_dma_w_dack,
  output              io_buffer_buf_rd,
  input      [31:0]   io_buffer_buf_rdata,
  input      [5:0]    io_buffer_buf_buf_word,
  input               io_buffer_buf_empty,
  output reg          io_buffer_buf_err,
  input               io_buffer_clr_buf_err,
  input               io_rstn,
  input               clk,
  input               reset
);

  wire       [1:0]    _zz_end_bcnt;
  wire       [15:0]   _zz_fir_wdata;
  wire       [31:0]   _zz_dma_addr;
  wire       [31:0]   _zz_dma_addr_1;
  wire       [0:0]    _zz_when_wcmd_gen_l90;
  wire       [16:0]   _zz_remain_bnum_send;
  wire       [16:0]   _zz_remain_bnum_send_1;
  wire       [16:0]   _zz_remain_bnum_send_2;
  wire       [16:0]   _zz_remain_bnum_send_3;
  wire       [16:0]   _zz_remain_bnum_send_4;
  wire       [31:0]   _zz_dma_addr_2;
  wire       [15:0]   _zz_remain_bnum_rd;
  wire       [16:0]   _zz_remain_bnum_rd_1;
  wire       [0:0]    _zz_buf_4b;
  wire       [0:0]    _zz_buf_4b_1;
  wire       [0:0]    _zz_io_buffer_buf_rd;
  wire       [13:0]   _zz_dma_wd_last;
  wire       [13:0]   _zz_dma_wd_last_1;
  wire       [1:0]    _zz_last_best_vld;
  wire       [1:0]    _zz_last_best_vld_1;
  wire       [0:0]    _zz_last_best_vld_2;
  wire       [3:0]    _zz_nxt_buf_bcnt;
  wire       [3:0]    _zz_nxt_buf_bcnt_1;
  wire       [3:0]    _zz_nxt_buf_bcnt_2;
  wire       [3:0]    _zz_nxt_buf_bcnt_3;
  wire       [3:0]    _zz_nxt_buf_bcnt_4;
  wire       [0:0]    _zz_when_wcmd_gen_l259;
  reg        [1:0]    dma_sta;
  reg        [15:0]   dma_ycnt;
  reg        [31:0]   dma_addr;
  reg        [3:0]    fir_wbe;
  reg        [3:0]    last_wbe;
  reg        [1:0]    align_model;
  reg        [16:0]   remain_bnum_rd;
  reg        [16:0]   remain_bnum_send;
  wire       [1:0]    end_bcnt;
  wire                dma_1d_go;
  wire                dma_w_req;
  wire                send_a_cmd;
  wire                send_a_data;
  wire                fir_wdata;
  wire                when_wcmd_gen_l66;
  wire                when_wcmd_gen_l90;
  wire                when_wcmd_gen_l92;
  wire                when_wcmd_gen_l131;
  wire                when_wcmd_gen_l134;
  wire       [1:0]    switch_wcmd_gen_l146;
  wire                when_wcmd_gen_l177;
  reg        [3:0]    buf_bcnt;
  reg        [3:0]    nxt_buf_bcnt;
  reg        [2:0]    sub_bcnt;
  reg        [7:0]    wd0;
  reg        [7:0]    wd1;
  reg        [7:0]    wd2;
  reg        [7:0]    wd3;
  reg        [7:0]    ed0;
  reg        [7:0]    ed1;
  reg        [7:0]    ed2;
  wire                buf_4b;
  wire                dma_wd_last;
  wire                last_best_vld;
  wire       [1:0]    switch_wcmd_gen_l232;
  wire                when_wcmd_gen_l247;
  wire                when_wcmd_gen_l253;
  wire                when_wcmd_gen_l259;

  assign _zz_end_bcnt = (dma_addr[1 : 0] + io_cfg_trans_xsize[1 : 0]);
  assign _zz_fir_wdata = remain_bnum_send[15 : 0];
  assign _zz_dma_addr = (dma_addr + _zz_dma_addr_1);
  assign _zz_dma_addr_1 = {16'd0, io_cfg_trans_xsize};
  assign _zz_when_wcmd_gen_l90 = remain_bnum_send[16];
  assign _zz_remain_bnum_send = 17'h00004;
  assign _zz_remain_bnum_send_1 = 17'h00003;
  assign _zz_remain_bnum_send_2 = 17'h00002;
  assign _zz_remain_bnum_send_3 = 17'h00001;
  assign _zz_remain_bnum_send_4 = 17'h00004;
  assign _zz_dma_addr_2 = {16'd0, io_cfg_da_ystep};
  assign _zz_remain_bnum_rd = io_cfg_trans_xsize;
  assign _zz_remain_bnum_rd_1 = 17'h00004;
  assign _zz_buf_4b = buf_bcnt[3];
  assign _zz_buf_4b_1 = buf_bcnt[2];
  assign _zz_io_buffer_buf_rd = remain_bnum_rd[16];
  assign _zz_dma_wd_last = remain_bnum_send[15 : 2];
  assign _zz_dma_wd_last_1 = 14'h0;
  assign _zz_last_best_vld = remain_bnum_send[1 : 0];
  assign _zz_last_best_vld_1 = buf_bcnt[1 : 0];
  assign _zz_last_best_vld_2 = buf_bcnt[3];
  assign _zz_nxt_buf_bcnt = {sub_bcnt,1'b0};
  assign _zz_nxt_buf_bcnt_1 = 4'b0100;
  assign _zz_nxt_buf_bcnt_2 = ($signed(buf_bcnt) - $signed(_zz_nxt_buf_bcnt_3));
  assign _zz_nxt_buf_bcnt_3 = {sub_bcnt,1'b0};
  assign _zz_nxt_buf_bcnt_4 = 4'b0100;
  assign _zz_when_wcmd_gen_l259 = remain_bnum_rd[16];
  assign end_bcnt = (_zz_end_bcnt + 2'b01);
  assign dma_1d_go = (io_dma_busy && (io_buffer_buf_buf_word[4 : 0] != 5'h0));
  assign dma_w_req = (dma_sta == 2'b01);
  assign io_dma_inf_dma_w_req = dma_w_req;
  assign io_dma_inf_dma_w_addr = dma_addr;
  assign io_dma_inf_dma_w_len = io_cfg_trans_xsize;
  assign send_a_cmd = (dma_w_req && io_dma_inf_dma_w_ack);
  assign send_a_data = (io_dma_inf_dma_w_dvld && io_dma_inf_dma_w_dack);
  assign fir_wdata = (send_a_data && (_zz_fir_wdata == io_cfg_trans_xsize));
  always @(*) begin
    io_dma_cmd_end = 1'b0;
    if(when_wcmd_gen_l66) begin
      io_dma_cmd_end = 1'b0;
    end else begin
      case(dma_sta)
        2'b00 : begin
          io_dma_cmd_end = 1'b0;
        end
        2'b01 : begin
        end
        2'b10 : begin
          if(when_wcmd_gen_l90) begin
            if(when_wcmd_gen_l92) begin
              io_dma_cmd_end = 1'b1;
            end
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign when_wcmd_gen_l66 = (! io_rstn);
  assign when_wcmd_gen_l90 = _zz_when_wcmd_gen_l90[0];
  assign when_wcmd_gen_l92 = (dma_ycnt == 16'h0);
  always @(*) begin
    io_buffer_buf_err = 1'b0;
    if(when_wcmd_gen_l131) begin
      io_buffer_buf_err = 1'b0;
    end else begin
      if(when_wcmd_gen_l134) begin
        io_buffer_buf_err = 1'b1;
      end else begin
        if(io_buffer_clr_buf_err) begin
          io_buffer_buf_err = 1'b0;
        end
      end
    end
  end

  assign when_wcmd_gen_l131 = (! io_rstn);
  assign when_wcmd_gen_l134 = ((! io_dma_busy) && (! io_buffer_buf_empty));
  assign switch_wcmd_gen_l146 = dma_addr[1 : 0];
  assign when_wcmd_gen_l177 = (! io_rstn);
  assign buf_4b = ((! _zz_buf_4b[0]) && _zz_buf_4b_1[0]);
  assign io_buffer_buf_rd = ((((! buf_4b) || send_a_data) && (! io_buffer_buf_empty)) && (! _zz_io_buffer_buf_rd[0]));
  assign dma_wd_last = ($signed(_zz_dma_wd_last) == $signed(_zz_dma_wd_last_1));
  assign last_best_vld = ((dma_wd_last && ($signed(_zz_last_best_vld) < $signed(_zz_last_best_vld_1))) && (! _zz_last_best_vld_2[0]));
  assign io_dma_inf_dma_w_dvld = (buf_4b || last_best_vld);
  assign io_dma_inf_dma_wdata = {wd3,{wd2,{wd1,wd0}}};
  always @(*) begin
    if(fir_wdata) begin
      io_dma_inf_dma_wbe = fir_wbe;
    end else begin
      if(dma_wd_last) begin
        io_dma_inf_dma_wbe = last_wbe;
      end else begin
        io_dma_inf_dma_wbe = 4'b1111;
      end
    end
  end

  assign switch_wcmd_gen_l232 = {io_buffer_buf_rd,send_a_data};
  assign when_wcmd_gen_l247 = (! io_rstn);
  assign when_wcmd_gen_l253 = (io_buffer_buf_rd || send_a_data);
  assign when_wcmd_gen_l259 = (io_buffer_buf_rd || (send_a_data && _zz_when_wcmd_gen_l259[0]));
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      dma_sta <= 2'b00;
      dma_ycnt <= 16'h0;
      dma_addr <= 32'h0;
      fir_wbe <= 4'b0000;
      last_wbe <= 4'b0000;
      align_model <= 2'b00;
      remain_bnum_rd <= 17'h0;
      remain_bnum_send <= 17'h0;
      buf_bcnt <= 4'b0000;
      nxt_buf_bcnt <= 4'b0000;
      sub_bcnt <= 3'b000;
      wd0 <= 8'h0;
      wd1 <= 8'h0;
      wd2 <= 8'h0;
      wd3 <= 8'h0;
      ed0 <= 8'h0;
      ed1 <= 8'h0;
      ed2 <= 8'h0;
    end else begin
      if(when_wcmd_gen_l66) begin
        dma_sta <= 2'b00;
        dma_addr <= 32'h0;
        dma_ycnt <= 16'h0;
        remain_bnum_send <= 17'h0;
      end else begin
        case(dma_sta)
          2'b00 : begin
            if(dma_1d_go) begin
              dma_sta <= 2'b01;
              dma_addr <= io_cfg_dar;
              dma_ycnt <= io_cfg_trans_ysize;
            end
          end
          2'b01 : begin
            if(io_dma_inf_dma_w_ack) begin
              dma_sta <= 2'b10;
              dma_addr <= (_zz_dma_addr + 32'h00000001);
              remain_bnum_send <= {1'b0,io_cfg_trans_xsize};
            end
          end
          2'b10 : begin
            if(when_wcmd_gen_l90) begin
              dma_ycnt <= (dma_ycnt - 16'h0001);
              if(when_wcmd_gen_l92) begin
                dma_sta <= 2'b00;
              end else begin
                dma_sta <= 2'b11;
              end
            end
            if(send_a_data) begin
              if(fir_wdata) begin
                case(align_model)
                  2'b00 : begin
                    remain_bnum_send <= ($signed(remain_bnum_send) - $signed(_zz_remain_bnum_send));
                  end
                  2'b01 : begin
                    remain_bnum_send <= ($signed(remain_bnum_send) - $signed(_zz_remain_bnum_send_1));
                  end
                  2'b10 : begin
                    remain_bnum_send <= ($signed(remain_bnum_send) - $signed(_zz_remain_bnum_send_2));
                  end
                  default : begin
                    remain_bnum_send <= ($signed(remain_bnum_send) - $signed(_zz_remain_bnum_send_3));
                  end
                endcase
              end else begin
                remain_bnum_send <= ($signed(remain_bnum_send) - $signed(_zz_remain_bnum_send_4));
              end
            end
          end
          default : begin
            if(dma_1d_go) begin
              dma_addr <= (dma_addr + _zz_dma_addr_2);
              dma_sta <= 2'b01;
            end
          end
        endcase
      end
      if(send_a_cmd) begin
        align_model <= dma_addr[1 : 0];
        case(switch_wcmd_gen_l146)
          2'b00 : begin
            fir_wbe <= 4'b1111;
          end
          2'b01 : begin
            fir_wbe <= 4'b1110;
          end
          2'b10 : begin
            fir_wbe <= 4'b1100;
          end
          default : begin
            fir_wbe <= 4'b1000;
          end
        endcase
        case(end_bcnt)
          2'b00 : begin
            last_wbe <= 4'b1111;
          end
          2'b01 : begin
            last_wbe <= 4'b0001;
          end
          2'b10 : begin
            last_wbe <= 4'b0011;
          end
          default : begin
            last_wbe <= 4'b0111;
          end
        endcase
      end
      if(when_wcmd_gen_l177) begin
        remain_bnum_rd <= 17'h10000;
      end else begin
        if(send_a_cmd) begin
          remain_bnum_rd <= {{1{_zz_remain_bnum_rd[15]}}, _zz_remain_bnum_rd};
        end else begin
          remain_bnum_rd <= ($signed(remain_bnum_rd) - $signed(_zz_remain_bnum_rd_1));
        end
      end
      if(fir_wdata) begin
        case(align_model)
          2'b00 : begin
            sub_bcnt <= 3'b100;
          end
          2'b01 : begin
            sub_bcnt <= 3'b011;
          end
          2'b10 : begin
            sub_bcnt <= 3'b010;
          end
          default : begin
            sub_bcnt <= 3'b001;
          end
        endcase
      end else begin
        sub_bcnt <= 3'b100;
      end
      case(switch_wcmd_gen_l232)
        2'b00 : begin
          nxt_buf_bcnt <= buf_bcnt;
        end
        2'b01 : begin
          nxt_buf_bcnt <= ($signed(buf_bcnt) - $signed(_zz_nxt_buf_bcnt));
        end
        2'b10 : begin
          nxt_buf_bcnt <= ($signed(buf_bcnt) + $signed(_zz_nxt_buf_bcnt_1));
        end
        default : begin
          nxt_buf_bcnt <= ($signed(_zz_nxt_buf_bcnt_2) + $signed(_zz_nxt_buf_bcnt_4));
        end
      endcase
      if(when_wcmd_gen_l247) begin
        buf_bcnt <= 4'b0000;
      end else begin
        if(send_a_cmd) begin
          buf_bcnt <= 4'b0000;
        end else begin
          if(when_wcmd_gen_l253) begin
            buf_bcnt <= nxt_buf_bcnt;
          end
        end
      end
      if(when_wcmd_gen_l259) begin
        case(align_model)
          2'b00 : begin
            wd0 <= io_buffer_buf_rdata[7 : 0];
            wd1 <= io_buffer_buf_rdata[15 : 8];
            wd2 <= io_buffer_buf_rdata[23 : 16];
            wd3 <= io_buffer_buf_rdata[31 : 24];
            ed0 <= ed0;
            ed1 <= ed1;
            ed2 <= ed2;
          end
          2'b01 : begin
            wd0 <= ed0;
            wd1 <= io_buffer_buf_rdata[7 : 0];
            wd2 <= io_buffer_buf_rdata[15 : 8];
            wd3 <= io_buffer_buf_rdata[23 : 16];
            ed0 <= io_buffer_buf_rdata[31 : 24];
            ed1 <= ed1;
            ed2 <= ed2;
          end
          2'b10 : begin
            wd0 <= ed0;
            wd1 <= ed1;
            wd2 <= io_buffer_buf_rdata[7 : 0];
            wd3 <= io_buffer_buf_rdata[15 : 8];
            ed0 <= io_buffer_buf_rdata[23 : 16];
            ed1 <= io_buffer_buf_rdata[31 : 24];
            ed2 <= ed2;
          end
          default : begin
            wd0 <= ed0;
            wd1 <= ed1;
            wd2 <= ed2;
            wd3 <= io_buffer_buf_rdata[7 : 0];
            ed0 <= io_buffer_buf_rdata[15 : 8];
            ed1 <= io_buffer_buf_rdata[23 : 16];
            ed2 <= io_buffer_buf_rdata[31 : 24];
          end
        endcase
      end
    end
  end


endmodule
