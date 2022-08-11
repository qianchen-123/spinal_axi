// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : rcmd_gen
// Git hash  : 1ada80d2d659ea5af45b334c0c8b37d14dd88650

`timescale 1ns/1ps

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
  wire                when_rcmd_gen_l72;
  wire                when_rcmd_gen_l86;
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
  wire                when_rcmd_gen_l116;
  wire                when_rcmd_gen_l119;
  wire                when_rcmd_gen_l122;
  wire                when_rcmd_gen_l125;
  wire                when_rcmd_gen_l137;
  wire                when_rcmd_gen_l140;
  wire                when_rcmd_gen_l143;
  wire                when_rcmd_gen_l146;
  wire                when_rcmd_gen_l157;
  wire                when_rcmd_gen_l160;
  wire                when_rcmd_gen_l163;
  wire                when_rcmd_gen_l166;
  wire                when_rcmd_gen_l177;
  wire       [1:0]    switch_rcmd_gen_l194;
  wire                myArea_last_wr_1d;
  wire       [31:0]   myArea_last_wdata;

  assign _zz_myArea_dma_addr = (myArea_dma_addr + _zz_myArea_dma_addr_1);
  assign _zz_myArea_dma_addr_1 = {16'd0, io_cfg_trans_xsize};
  assign _zz_myArea_dma_addr_2 = {16'd0, io_cfg_sa_ystep};
  assign _zz_io_buffer_buf_wr = myArea_nxt_buf_byte3[2];
  assign io_dma_inf_r_req = ((myArea_cmd_sta == 2'b00) ? 1'b1 : 1'b0);
  assign io_dma_inf_r_addr = myArea_dma_addr;
  assign io_dma_inf_r_len = io_cfg_trans_xsize;
  assign when_rcmd_gen_l72 = (myArea_dma_ycnt != io_cfg_trans_ysize);
  assign when_rcmd_gen_l86 = (myArea_cmd_sta == 2'b10);
  assign myArea_dma_dack = ((io_buffer_buf_empty_word != 6'h0) && (! myArea_dma_dlast_r));
  assign io_dma_inf_dack = myArea_dma_dack;
  assign myArea_dma_d_recv = (io_dma_inf_dvld && io_dma_inf_dack);
  assign myArea_nxt_buf_byte0 = ({1'b1,myArea_buf_byte[1 : 0]} + {2'b00,io_dma_inf_rbe[0]});
  assign myArea_nxt_buf_byte1 = (myArea_nxt_buf_byte0 + {2'b00,io_dma_inf_rbe[1]});
  assign myArea_nxt_buf_byte2 = (myArea_nxt_buf_byte1 + {2'b00,io_dma_inf_rbe[2]});
  assign myArea_nxt_buf_byte3 = (myArea_nxt_buf_byte2 + {2'b00,io_dma_inf_rbe[3]});
  assign when_rcmd_gen_l116 = (io_dma_inf_rbe[0] && (myArea_buf_byte[1 : 0] == 2'b00));
  assign when_rcmd_gen_l119 = (io_dma_inf_rbe[1] && (myArea_nxt_buf_byte0[1 : 0] == 2'b00));
  assign when_rcmd_gen_l122 = (io_dma_inf_rbe[2] && (myArea_nxt_buf_byte0[1 : 0] == 2'b00));
  assign when_rcmd_gen_l125 = (io_dma_inf_rbe[3] && (myArea_nxt_buf_byte0[1 : 0] == 2'b00));
  assign when_rcmd_gen_l137 = (io_dma_inf_rbe[0] && (myArea_buf_byte[1 : 0] == 2'b01));
  assign when_rcmd_gen_l140 = (io_dma_inf_rbe[1] && (myArea_nxt_buf_byte0[1 : 0] == 2'b01));
  assign when_rcmd_gen_l143 = (io_dma_inf_rbe[2] && (myArea_nxt_buf_byte0[1 : 0] == 2'b01));
  assign when_rcmd_gen_l146 = (io_dma_inf_rbe[3] && (myArea_nxt_buf_byte0[1 : 0] == 2'b01));
  assign when_rcmd_gen_l157 = (io_dma_inf_rbe[0] && (myArea_buf_byte[1 : 0] == 2'b10));
  assign when_rcmd_gen_l160 = (io_dma_inf_rbe[1] && (myArea_nxt_buf_byte0[1 : 0] == 2'b10));
  assign when_rcmd_gen_l163 = (io_dma_inf_rbe[2] && (myArea_nxt_buf_byte0[1 : 0] == 2'b10));
  assign when_rcmd_gen_l166 = (io_dma_inf_rbe[3] && (myArea_nxt_buf_byte0[1 : 0] == 2'b10));
  assign when_rcmd_gen_l177 = (myArea_dma_d_recv && io_dma_inf_rd_last);
  assign switch_rcmd_gen_l194 = myArea_buf_byte[1 : 0];
  always @(*) begin
    case(switch_rcmd_gen_l194)
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
          if(when_rcmd_gen_l72) begin
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
        if(when_rcmd_gen_l86) begin
          myArea_dma_ycnt <= (myArea_dma_ycnt + 16'h0001);
        end
      end
      if(myArea_dma_d_recv) begin
        if(when_rcmd_gen_l116) begin
          myArea_dbuf0 <= io_dma_inf_rdata[7 : 0];
        end else begin
          if(when_rcmd_gen_l119) begin
            myArea_dbuf0 <= io_dma_inf_rdata[15 : 8];
          end else begin
            if(when_rcmd_gen_l122) begin
              myArea_dbuf0 <= io_dma_inf_rdata[23 : 16];
            end else begin
              if(when_rcmd_gen_l125) begin
                myArea_dbuf0 <= io_dma_inf_rdata[31 : 24];
              end
            end
          end
        end
      end
      if(myArea_dma_d_recv) begin
        if(when_rcmd_gen_l137) begin
          myArea_dbuf1 <= io_dma_inf_rdata[7 : 0];
        end else begin
          if(when_rcmd_gen_l140) begin
            myArea_dbuf1 <= io_dma_inf_rdata[15 : 8];
          end else begin
            if(when_rcmd_gen_l143) begin
              myArea_dbuf1 <= io_dma_inf_rdata[23 : 16];
            end else begin
              if(when_rcmd_gen_l146) begin
                myArea_dbuf1 <= io_dma_inf_rdata[31 : 24];
              end
            end
          end
        end
      end
      if(myArea_dma_d_recv) begin
        if(when_rcmd_gen_l157) begin
          myArea_dbuf2 <= io_dma_inf_rdata[7 : 0];
        end else begin
          if(when_rcmd_gen_l160) begin
            myArea_dbuf2 <= io_dma_inf_rdata[15 : 8];
          end else begin
            if(when_rcmd_gen_l163) begin
              myArea_dbuf2 <= io_dma_inf_rdata[23 : 16];
            end else begin
              if(when_rcmd_gen_l166) begin
                myArea_dbuf2 <= io_dma_inf_rdata[31 : 24];
              end
            end
          end
        end
      end
      if(when_rcmd_gen_l177) begin
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
