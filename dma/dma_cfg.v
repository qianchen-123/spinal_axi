// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : dma_cfg
// Git hash  : 1ada80d2d659ea5af45b334c0c8b37d14dd88650

`timescale 1ns/1ps

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
  wire       [3:0]    switch_dma_cfg_l179;
  wire                when_dma_cfg_l204;
  reg        [0:0]    myArea_ll_sta;
  reg                 myArea_dma_end_flag;
  wire                myArea_dma_end_w;
  wire                when_dma_cfg_l226;
  wire                myArea_dma_cmd_goon;
  wire                when_dma_cfg_l273;
  wire       [3:0]    switch_dma_cfg_l282;

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
  assign switch_dma_cfg_l179 = myArea_cmd_update_addr[3 : 0];
  assign when_dma_cfg_l204 = (myArea_apb_write && (myArea_apb_addr == 4'b0111));
  assign io_ll_addr = myArea_cfg_llr;
  assign io_ll_req = (myArea_ll_sta == 1'b1);
  assign myArea_dma_end_w = (io_dma_cmd_end && (myArea_cfg_llr[31 : 2] == 30'h0));
  assign when_dma_cfg_l226 = (io_dma_cmd_end && (myArea_cfg_llr[31 : 2] != 30'h0));
  assign myArea_dma_cmd_goon = (io_ll_dvld && (io_ll_dcnt == 3'b101));
  assign io_dma_intr = (myArea_dma_end_flag && myArea_cfg_intr_en);
  assign when_dma_cfg_l273 = (myArea_dma_sof_w || myArea_dma_cmd_goon);
  assign switch_dma_cfg_l282 = myArea_apb_addr[3 : 0];
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
        case(switch_dma_cfg_l179)
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
      if(when_dma_cfg_l204) begin
        myArea_cfg_intr_en <= io_apb_PWDATA[0];
        myArea_cfg_dma_halt <= io_apb_PWDATA[4];
        myArea_cfg_bf <= io_apb_PWDATA[8];
        myArea_cfg_cf <= io_apb_PWDATA[9];
      end
      case(myArea_ll_sta)
        1'b0 : begin
          if(when_dma_cfg_l226) begin
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
      if(when_dma_cfg_l273) begin
        myArea_dma_cmd_sof <= 1'b1;
      end else begin
        myArea_dma_cmd_sof <= 1'b1;
      end
      if(myArea_apb_read) begin
        case(switch_dma_cfg_l282)
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
