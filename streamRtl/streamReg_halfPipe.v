// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : streamReg_halfPipe
// Git hash  : 3a903e741cbbe310a98c75dc1ebbd289cb1c87a4

`timescale 1ns/1ps

module streamReg_halfPipe (
  input               io_s_in_valid,
  output              io_s_in_ready,
  input      [31:0]   io_s_in_payload,
  output              io_m_out_valid,
  input               io_m_out_ready,
  output     [31:0]   io_m_out_payload,
  input               clk,
  input               reset
);

  wire                io_s_in_halfPipe_valid;
  wire                io_s_in_halfPipe_ready;
  wire       [31:0]   io_s_in_halfPipe_payload;
  reg                 io_s_in_rValid;
  wire                io_s_in_halfPipe_fire;
  reg        [31:0]   io_s_in_rData;

  assign io_s_in_halfPipe_fire = (io_s_in_halfPipe_valid && io_s_in_halfPipe_ready);
  assign io_s_in_ready = (! io_s_in_rValid);
  assign io_s_in_halfPipe_valid = io_s_in_rValid;
  assign io_s_in_halfPipe_payload = io_s_in_rData;
  assign io_m_out_valid = io_s_in_halfPipe_valid;
  assign io_s_in_halfPipe_ready = io_m_out_ready;
  assign io_m_out_payload = io_s_in_halfPipe_payload;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_s_in_rValid <= 1'b0;
    end else begin
      if(io_s_in_valid) begin
        io_s_in_rValid <= 1'b1;
      end
      if(io_s_in_halfPipe_fire) begin
        io_s_in_rValid <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if(io_s_in_ready) begin
      io_s_in_rData <= io_s_in_payload;
    end
  end


endmodule
