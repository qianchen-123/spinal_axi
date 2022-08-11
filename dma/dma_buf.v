// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : dma_buf
// Git hash  : 1ada80d2d659ea5af45b334c0c8b37d14dd88650

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
  input               io_clk,
  input               io_rstn
);

  wire       [31:0]   _zz_myArea_mem_port0;
  wire       [4:0]    _zz_myArea_mem_port;
  wire       [0:0]    _zz_myArea_wptr;
  wire       [0:0]    _zz_myArea_rptr;
  reg                 _zz_1;
  reg        [5:0]    myArea_buf_empty_word;
  reg        [5:0]    myArea_buf_buf_word;
  reg        [5:0]    myArea_rptr;
  reg        [5:0]    myArea_wptr;
  wire       [4:0]    _zz_io_rd_buf_rdata;
  wire                when_dma_buf_l40;
  wire                when_dma_buf_l43;
  wire       [1:0]    switch_dma_buf_l44;
  wire                when_dma_buf_l61;
  wire                when_dma_buf_l64;
  wire       [1:0]    switch_dma_buf_l65;
  wire                when_dma_buf_l86;
  wire                when_dma_buf_l96;
  wire                when_dma_buf_l100;
  (* ram_style = "distributed" *) reg [31:0] myArea_mem [0:23];

  assign _zz_myArea_wptr = myArea_wptr[5];
  assign _zz_myArea_rptr = myArea_rptr[5];
  assign _zz_myArea_mem_port = myArea_wptr[4 : 0];
  assign _zz_myArea_mem_port0 = myArea_mem[_zz_io_rd_buf_rdata];
  always @(posedge io_clk) begin
    if(_zz_1) begin
      myArea_mem[_zz_myArea_mem_port] <= io_wr_buf_wdata;
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(io_wr_buf_wr) begin
      _zz_1 = 1'b1;
    end
  end

  assign io_rd_clr_buf_err = 1'b0;
  assign io_wr_buf_empty_word = myArea_buf_empty_word;
  assign io_rd_buf_buf_word = myArea_buf_buf_word;
  assign io_rd_buf_empty = (myArea_rptr == myArea_wptr);
  assign _zz_io_rd_buf_rdata = myArea_rptr[4 : 0];
  assign io_rd_buf_rdata = _zz_myArea_mem_port0;
  assign when_dma_buf_l40 = (! io_rstn);
  assign when_dma_buf_l43 = (io_wr_buf_wr || io_rd_buf_rd);
  assign switch_dma_buf_l44 = {io_rd_buf_rd,io_wr_buf_wr};
  assign when_dma_buf_l61 = (! io_rstn);
  assign when_dma_buf_l64 = (io_wr_buf_wr || io_rd_buf_rd);
  assign switch_dma_buf_l65 = {io_rd_buf_rd,io_wr_buf_wr};
  assign when_dma_buf_l86 = (! io_rstn);
  assign when_dma_buf_l96 = (! io_rstn);
  assign when_dma_buf_l100 = (myArea_rptr[4 : 0] == 5'h17);
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_buf_empty_word <= 6'h0;
      myArea_buf_buf_word <= 6'h0;
      myArea_rptr <= 6'h0;
      myArea_wptr <= 6'h0;
    end else begin
      if(when_dma_buf_l40) begin
        myArea_buf_empty_word <= 6'h18;
      end else begin
        if(when_dma_buf_l43) begin
          case(switch_dma_buf_l44)
            2'b00 : begin
              myArea_buf_empty_word <= myArea_buf_empty_word;
            end
            2'b01 : begin
              myArea_buf_empty_word <= (myArea_buf_empty_word + 6'h01);
            end
            2'b10 : begin
              myArea_buf_empty_word <= (myArea_buf_empty_word - 6'h01);
            end
            default : begin
              myArea_buf_empty_word <= myArea_buf_empty_word;
            end
          endcase
        end
      end
      if(when_dma_buf_l61) begin
        myArea_buf_buf_word <= 6'h0;
      end else begin
        if(when_dma_buf_l64) begin
          case(switch_dma_buf_l65)
            2'b00 : begin
              myArea_buf_buf_word <= myArea_buf_buf_word;
            end
            2'b01 : begin
              myArea_buf_buf_word <= (myArea_buf_buf_word - 6'h01);
            end
            2'b10 : begin
              myArea_buf_buf_word <= (myArea_buf_buf_word + 6'h01);
            end
            default : begin
              myArea_buf_buf_word <= myArea_buf_buf_word;
            end
          endcase
        end
      end
      if(when_dma_buf_l86) begin
        myArea_wptr <= 6'h0;
      end else begin
        if(io_wr_buf_wr) begin
          myArea_wptr <= {5'h0,(! _zz_myArea_wptr[0])};
        end else begin
          myArea_wptr <= (myArea_wptr + 6'h01);
        end
      end
      if(when_dma_buf_l96) begin
        myArea_rptr <= 6'h0;
      end else begin
        if(io_rd_buf_rd) begin
          if(when_dma_buf_l100) begin
            myArea_rptr <= {5'h0,(! _zz_myArea_rptr[0])};
          end else begin
            myArea_rptr <= (myArea_rptr + 6'h01);
          end
        end
      end
    end
  end


endmodule
