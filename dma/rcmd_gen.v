// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : rcmd_gen
// Git hash  : 9c40920248c54b4106d59045a2d785d7f59e312f

`timescale 1ns/1ps

module rcmd_gen (
  input      [31:0]   io_cfg_sar,
  input      [15:0]   io_cfg_trans_xsize,
  input      [15:0]   io_cfg_trans_ysize,
  input      [15:0]   io_cfg_sa_ystep,
  input               io_dma_cmd_sof,
  output              io_dma_inf_dma_r_req,
  input               io_dma_inf_dma_r_ack,
  output     [31:0]   io_dma_inf_dma_r_addr,
  output     [15:0]   io_dma_inf_dma_r_len,
  input               io_dma_inf_dma_dvld,
  input               io_dma_inf_dma_rd_last,
  input      [31:0]   io_dma_inf_dma_rdata,
  input      [3:0]    io_dma_inf_dma_rbe,
  output              io_dma_inf_dma_dack,
  output              io_buffer_buf_wr,
  output     [31:0]   io_buffer_buf_wdata,
  input      [5:0]    io_buffer_buf_empty_word,
  input               io_rstn,
  input               clk,
  input               reset
);

  wire       [31:0]   _zz_dma_addr;
  wire       [31:0]   _zz_dma_addr_1;
  wire       [31:0]   _zz_dma_addr_2;
  wire       [0:0]    _zz_io_buffer_buf_wr;
  reg        [1:0]    cmd_sta;
  reg        [15:0]   dma_ycnt;
  reg        [31:0]   dma_addr;
  wire                when_rcmd_gen_l41;
  wire                when_rcmd_gen_l60;
  wire                when_rcmd_gen_l72;
  wire                when_rcmd_gen_l78;
  reg        [7:0]    dbuf0;
  reg        [7:0]    dbuf1;
  reg        [7:0]    dbuf2;
  reg        [2:0]    buf_byte;
  reg                 dma_dlast_r;
  reg        [31:0]   dma_rdata_sf;
  wire                dma_dack;
  wire                dma_d_recv;
  wire       [2:0]    nxt_buf_byte0;
  wire       [2:0]    nxt_buf_byte1;
  wire       [2:0]    nxt_buf_byte2;
  wire       [2:0]    nxt_buf_byte3;
  wire                when_rcmd_gen_l106;
  wire                when_rcmd_gen_l110;
  wire                when_rcmd_gen_l113;
  wire                when_rcmd_gen_l116;
  wire                when_rcmd_gen_l119;
  wire                when_rcmd_gen_l129;
  wire                when_rcmd_gen_l133;
  wire                when_rcmd_gen_l136;
  wire                when_rcmd_gen_l139;
  wire                when_rcmd_gen_l142;
  wire                when_rcmd_gen_l151;
  wire                when_rcmd_gen_l155;
  wire                when_rcmd_gen_l158;
  wire                when_rcmd_gen_l161;
  wire                when_rcmd_gen_l164;
  wire                when_rcmd_gen_l174;
  wire                when_rcmd_gen_l177;
  wire                when_rcmd_gen_l184;
  wire       [1:0]    switch_rcmd_gen_l196;
  wire                last_wr_1d;
  wire       [31:0]   last_wdata;

  assign _zz_dma_addr = (dma_addr + _zz_dma_addr_1);
  assign _zz_dma_addr_1 = {16'd0, io_cfg_trans_xsize};
  assign _zz_dma_addr_2 = {16'd0, io_cfg_sa_ystep};
  assign _zz_io_buffer_buf_wr = nxt_buf_byte3[2];
  assign io_dma_inf_dma_r_req = ((cmd_sta == 2'b00) ? 1'b1 : 1'b0);
  assign io_dma_inf_dma_r_addr = dma_addr;
  assign io_dma_inf_dma_r_len = io_cfg_trans_xsize;
  assign when_rcmd_gen_l41 = (! io_rstn);
  assign when_rcmd_gen_l60 = (dma_ycnt != io_cfg_trans_ysize);
  assign when_rcmd_gen_l72 = (! io_rstn);
  assign when_rcmd_gen_l78 = (cmd_sta == 2'b10);
  assign dma_dack = ((io_buffer_buf_empty_word != 6'h0) && (! dma_dlast_r));
  assign io_dma_inf_dma_dack = dma_dack;
  assign dma_d_recv = (io_dma_inf_dma_dvld && io_dma_inf_dma_dack);
  assign nxt_buf_byte0 = ({1'b1,buf_byte[1 : 0]} + {2'b00,io_dma_inf_dma_rbe[0]});
  assign nxt_buf_byte1 = (nxt_buf_byte0 + {2'b00,io_dma_inf_dma_rbe[1]});
  assign nxt_buf_byte2 = (nxt_buf_byte1 + {2'b00,io_dma_inf_dma_rbe[2]});
  assign nxt_buf_byte3 = (nxt_buf_byte2 + {2'b00,io_dma_inf_dma_rbe[3]});
  assign when_rcmd_gen_l106 = (! io_rstn);
  assign when_rcmd_gen_l110 = (io_dma_inf_dma_rbe[0] && (buf_byte[1 : 0] == 2'b00));
  assign when_rcmd_gen_l113 = (io_dma_inf_dma_rbe[1] && (nxt_buf_byte0[1 : 0] == 2'b00));
  assign when_rcmd_gen_l116 = (io_dma_inf_dma_rbe[2] && (nxt_buf_byte0[1 : 0] == 2'b00));
  assign when_rcmd_gen_l119 = (io_dma_inf_dma_rbe[3] && (nxt_buf_byte0[1 : 0] == 2'b00));
  assign when_rcmd_gen_l129 = (! io_rstn);
  assign when_rcmd_gen_l133 = (io_dma_inf_dma_rbe[0] && (buf_byte[1 : 0] == 2'b01));
  assign when_rcmd_gen_l136 = (io_dma_inf_dma_rbe[1] && (nxt_buf_byte0[1 : 0] == 2'b01));
  assign when_rcmd_gen_l139 = (io_dma_inf_dma_rbe[2] && (nxt_buf_byte0[1 : 0] == 2'b01));
  assign when_rcmd_gen_l142 = (io_dma_inf_dma_rbe[3] && (nxt_buf_byte0[1 : 0] == 2'b01));
  assign when_rcmd_gen_l151 = (! io_rstn);
  assign when_rcmd_gen_l155 = (io_dma_inf_dma_rbe[0] && (buf_byte[1 : 0] == 2'b10));
  assign when_rcmd_gen_l158 = (io_dma_inf_dma_rbe[1] && (nxt_buf_byte0[1 : 0] == 2'b10));
  assign when_rcmd_gen_l161 = (io_dma_inf_dma_rbe[2] && (nxt_buf_byte0[1 : 0] == 2'b10));
  assign when_rcmd_gen_l164 = (io_dma_inf_dma_rbe[3] && (nxt_buf_byte0[1 : 0] == 2'b10));
  assign when_rcmd_gen_l174 = (! io_rstn);
  assign when_rcmd_gen_l177 = (dma_d_recv && io_dma_inf_dma_rd_last);
  assign when_rcmd_gen_l184 = (! io_rstn);
  assign switch_rcmd_gen_l196 = buf_byte[1 : 0];
  assign last_wr_1d = (dma_dlast_r && (buf_byte[1 : 0] != 2'b00));
  assign last_wdata = {8'h0,{dbuf2,{dbuf1,dbuf0}}};
  assign io_buffer_buf_wr = ((dma_d_recv && _zz_io_buffer_buf_wr[0]) || last_wr_1d);
  assign io_buffer_buf_wdata = (last_wr_1d ? last_wdata : dma_rdata_sf);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      cmd_sta <= 2'b00;
      dma_ycnt <= 16'h0;
      dma_addr <= 32'h0;
      dbuf0 <= 8'h0;
      dbuf1 <= 8'h0;
      dbuf2 <= 8'h0;
      buf_byte <= 3'b000;
      dma_dlast_r <= 1'b0;
      dma_rdata_sf <= 32'h0;
    end else begin
      if(when_rcmd_gen_l41) begin
        cmd_sta <= 2'b00;
        dma_addr <= 32'h0;
      end else begin
        case(cmd_sta)
          2'b00 : begin
            if(io_dma_cmd_sof) begin
              cmd_sta <= 2'b01;
              dma_addr <= io_cfg_sar;
            end
          end
          2'b01 : begin
            if(io_dma_inf_dma_r_ack) begin
              cmd_sta <= 2'b10;
              dma_addr <= (_zz_dma_addr + 32'h00000001);
            end
          end
          2'b10 : begin
            dma_addr <= (dma_addr + _zz_dma_addr_2);
            if(when_rcmd_gen_l60) begin
              cmd_sta <= 2'b01;
            end else begin
              cmd_sta <= 2'b00;
            end
          end
          default : begin
            cmd_sta <= 2'b00;
          end
        endcase
      end
      if(when_rcmd_gen_l72) begin
        dma_ycnt <= 16'h0;
      end else begin
        if(io_dma_cmd_sof) begin
          dma_ycnt <= 16'h0;
        end else begin
          if(when_rcmd_gen_l78) begin
            dma_ycnt <= (dma_ycnt + 16'h0001);
          end
        end
      end
      if(when_rcmd_gen_l106) begin
        dbuf0 <= 8'h0;
      end else begin
        if(dma_d_recv) begin
          if(when_rcmd_gen_l110) begin
            dbuf0 <= io_dma_inf_dma_rdata[7 : 0];
          end else begin
            if(when_rcmd_gen_l113) begin
              dbuf0 <= io_dma_inf_dma_rdata[15 : 8];
            end else begin
              if(when_rcmd_gen_l116) begin
                dbuf0 <= io_dma_inf_dma_rdata[23 : 16];
              end else begin
                if(when_rcmd_gen_l119) begin
                  dbuf0 <= io_dma_inf_dma_rdata[31 : 24];
                end
              end
            end
          end
        end
      end
      if(when_rcmd_gen_l129) begin
        dbuf1 <= 8'h0;
      end else begin
        if(dma_d_recv) begin
          if(when_rcmd_gen_l133) begin
            dbuf1 <= io_dma_inf_dma_rdata[7 : 0];
          end else begin
            if(when_rcmd_gen_l136) begin
              dbuf1 <= io_dma_inf_dma_rdata[15 : 8];
            end else begin
              if(when_rcmd_gen_l139) begin
                dbuf1 <= io_dma_inf_dma_rdata[23 : 16];
              end else begin
                if(when_rcmd_gen_l142) begin
                  dbuf1 <= io_dma_inf_dma_rdata[31 : 24];
                end
              end
            end
          end
        end
      end
      if(when_rcmd_gen_l151) begin
        dbuf2 <= 8'h0;
      end else begin
        if(dma_d_recv) begin
          if(when_rcmd_gen_l155) begin
            dbuf2 <= io_dma_inf_dma_rdata[7 : 0];
          end else begin
            if(when_rcmd_gen_l158) begin
              dbuf2 <= io_dma_inf_dma_rdata[15 : 8];
            end else begin
              if(when_rcmd_gen_l161) begin
                dbuf2 <= io_dma_inf_dma_rdata[23 : 16];
              end else begin
                if(when_rcmd_gen_l164) begin
                  dbuf2 <= io_dma_inf_dma_rdata[31 : 24];
                end
              end
            end
          end
        end
      end
      if(when_rcmd_gen_l174) begin
        dma_dlast_r <= 1'b0;
      end else begin
        if(when_rcmd_gen_l177) begin
          dma_dlast_r <= 1'b1;
        end else begin
          dma_dlast_r <= 1'b0;
        end
      end
      if(when_rcmd_gen_l184) begin
        buf_byte <= 3'b000;
      end else begin
        if(dma_d_recv) begin
          buf_byte <= {1'b0,nxt_buf_byte3[1 : 0]};
        end else begin
          if(dma_dlast_r) begin
            buf_byte <= 3'b000;
          end
        end
      end
      case(switch_rcmd_gen_l196)
        2'b00 : begin
          dma_rdata_sf <= io_dma_inf_dma_rdata[31 : 0];
        end
        2'b01 : begin
          dma_rdata_sf <= {io_dma_inf_dma_rdata[23 : 0],dbuf0};
        end
        2'b10 : begin
          dma_rdata_sf <= {io_dma_inf_dma_rdata[15 : 0],{dbuf1,dbuf0}};
        end
        default : begin
          dma_rdata_sf <= {io_dma_inf_dma_rdata[7 : 0],{dbuf2,{dbuf1,dbuf0}}};
        end
      endcase
    end
  end


endmodule
