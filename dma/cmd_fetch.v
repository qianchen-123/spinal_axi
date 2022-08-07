// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : cmd_fetch
// Git hash  : 9c40920248c54b4106d59045a2d785d7f59e312f

`timescale 1ns/1ps

module cmd_fetch (
  input               io_ll_ll_req,
  input      [31:0]   io_ll_ll_addr,
  output              io_ll_ll_ack,
  output              io_ll_ll_dvld,
  output     [31:0]   io_ll_ll_rdata,
  output     [2:0]    io_ll_ll_dcnt,
  output              io_dma_inf_dma_r_req,
  input               io_dma_inf_dma_r_ack,
  output     [31:0]   io_dma_inf_dma_r_addr,
  output     [15:0]   io_dma_inf_dma_r_len,
  input               io_dma_inf_dma_dvld,
  input               io_dma_inf_dma_rd_last,
  input      [31:0]   io_dma_inf_dma_rdata,
  input      [3:0]    io_dma_inf_dma_rbe,
  output              io_dma_inf_dma_dack,
  input               io_rstn,
  input               clk,
  input               reset
);

  reg        [2:0]    ll_dcnt;
  wire                when_cmd_fetch_l29;
  wire                when_cmd_fetch_l32;

  assign io_dma_inf_dma_r_req = io_ll_ll_req;
  assign io_dma_inf_dma_r_addr = io_ll_ll_addr;
  assign io_dma_inf_dma_r_len = 16'h0017;
  assign io_dma_inf_dma_dack = 1'b1;
  assign io_ll_ll_ack = io_dma_inf_dma_r_ack;
  assign io_ll_ll_dvld = io_dma_inf_dma_dvld;
  assign io_ll_ll_rdata = io_dma_inf_dma_rdata;
  assign io_ll_ll_dcnt = ll_dcnt;
  assign when_cmd_fetch_l29 = (! io_rstn);
  assign when_cmd_fetch_l32 = (io_ll_ll_req && io_ll_ll_ack);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      ll_dcnt <= 3'b000;
    end else begin
      if(when_cmd_fetch_l29) begin
        ll_dcnt <= 3'b000;
      end else begin
        if(when_cmd_fetch_l32) begin
          ll_dcnt <= 3'b000;
        end else begin
          if(io_ll_ll_dvld) begin
            ll_dcnt <= (ll_dcnt + 3'b001);
          end
        end
      end
    end
  end


endmodule
