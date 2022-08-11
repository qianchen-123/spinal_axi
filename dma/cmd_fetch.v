// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : cmd_fetch
// Git hash  : 1ada80d2d659ea5af45b334c0c8b37d14dd88650

`timescale 1ns/1ps

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
  wire                when_cmd_fetch_l109;

  assign io_dma_inf_r_req = io_ll_req;
  assign io_dma_inf_r_addr = io_ll_addr;
  assign io_dma_inf_r_len = 16'h0017;
  assign io_dma_inf_dack = 1'b1;
  assign io_ll_ack = io_dma_inf_r_ack;
  assign io_ll_dvld = io_dma_inf_dvld;
  assign io_ll_rdata = io_dma_inf_rdata;
  assign io_ll_dcnt = myArea_ll_dcnt;
  assign when_cmd_fetch_l109 = (io_ll_req && io_ll_ack);
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_ll_dcnt <= 3'b000;
    end else begin
      if(when_cmd_fetch_l109) begin
        myArea_ll_dcnt <= 3'b000;
      end else begin
        if(io_ll_dvld) begin
          myArea_ll_dcnt <= (myArea_ll_dcnt + 3'b001);
        end
      end
    end
  end


endmodule
