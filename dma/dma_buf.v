// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : dma_buf
// Git hash  : 9c40920248c54b4106d59045a2d785d7f59e312f

`timescale 1ns/1ps

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
  input               io_rstn,
  input               clk,
  input               reset
);

  wire       [31:0]   _zz_mem_port0;
  wire       [4:0]    _zz_mem_port;
  wire       [0:0]    _zz_wptr;
  wire       [0:0]    _zz_rptr;
  reg                 _zz_1;
  reg        [5:0]    buf_empty_word;
  reg        [5:0]    buf_buf_word;
  reg        [5:0]    rptr;
  reg        [5:0]    wptr;
  wire       [4:0]    _zz_io_rd_buf_rdata;
  wire                when_dma_buf_l29;
  wire                when_dma_buf_l32;
  wire       [1:0]    switch_dma_buf_l33;
  wire                when_dma_buf_l50;
  wire                when_dma_buf_l53;
  wire       [1:0]    switch_dma_buf_l54;
  wire                when_dma_buf_l75;
  wire                when_dma_buf_l85;
  wire                when_dma_buf_l89;
  (* ram_style = "distributed" *) reg [31:0] mem [0:23];

  assign _zz_wptr = wptr[5];
  assign _zz_rptr = rptr[5];
  assign _zz_mem_port = wptr[4 : 0];
  assign _zz_mem_port0 = mem[_zz_io_rd_buf_rdata];
  always @(posedge clk) begin
    if(_zz_1) begin
      mem[_zz_mem_port] <= io_wr_buf_wdata;
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(io_wr_buf_wr) begin
      _zz_1 = 1'b1;
    end
  end

  assign io_rd_clr_buf_err = 1'b0;
  assign io_wr_buf_empty_word = buf_empty_word;
  assign io_rd_buf_buf_word = buf_buf_word;
  assign io_rd_buf_empty = (rptr == wptr);
  assign _zz_io_rd_buf_rdata = rptr[4 : 0];
  assign io_rd_buf_rdata = _zz_mem_port0;
  assign when_dma_buf_l29 = (! io_rstn);
  assign when_dma_buf_l32 = (io_wr_buf_wr || io_rd_buf_rd);
  assign switch_dma_buf_l33 = {io_rd_buf_rd,io_wr_buf_wr};
  assign when_dma_buf_l50 = (! io_rstn);
  assign when_dma_buf_l53 = (io_wr_buf_wr || io_rd_buf_rd);
  assign switch_dma_buf_l54 = {io_rd_buf_rd,io_wr_buf_wr};
  assign when_dma_buf_l75 = (! io_rstn);
  assign when_dma_buf_l85 = (! io_rstn);
  assign when_dma_buf_l89 = (rptr[4 : 0] == 5'h17);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      buf_empty_word <= 6'h0;
      buf_buf_word <= 6'h0;
      rptr <= 6'h0;
      wptr <= 6'h0;
    end else begin
      if(when_dma_buf_l29) begin
        buf_empty_word <= 6'h18;
      end else begin
        if(when_dma_buf_l32) begin
          case(switch_dma_buf_l33)
            2'b00 : begin
              buf_empty_word <= buf_empty_word;
            end
            2'b01 : begin
              buf_empty_word <= (buf_empty_word + 6'h01);
            end
            2'b10 : begin
              buf_empty_word <= (buf_empty_word - 6'h01);
            end
            default : begin
              buf_empty_word <= buf_empty_word;
            end
          endcase
        end
      end
      if(when_dma_buf_l50) begin
        buf_buf_word <= 6'h0;
      end else begin
        if(when_dma_buf_l53) begin
          case(switch_dma_buf_l54)
            2'b00 : begin
              buf_buf_word <= buf_buf_word;
            end
            2'b01 : begin
              buf_buf_word <= (buf_buf_word - 6'h01);
            end
            2'b10 : begin
              buf_buf_word <= (buf_buf_word + 6'h01);
            end
            default : begin
              buf_buf_word <= buf_buf_word;
            end
          endcase
        end
      end
      if(when_dma_buf_l75) begin
        wptr <= 6'h0;
      end else begin
        if(io_wr_buf_wr) begin
          wptr <= {5'h0,(! _zz_wptr[0])};
        end else begin
          wptr <= (wptr + 6'h01);
        end
      end
      if(when_dma_buf_l85) begin
        rptr <= 6'h0;
      end else begin
        if(io_rd_buf_rd) begin
          if(when_dma_buf_l89) begin
            rptr <= {5'h0,(! _zz_rptr[0])};
          end else begin
            rptr <= (rptr + 6'h01);
          end
        end
      end
    end
  end


endmodule
