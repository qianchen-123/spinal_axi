// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : streamReg_m2s
// Git hash  : 3a903e741cbbe310a98c75dc1ebbd289cb1c87a4

`timescale 1ns/1ps

module streamReg_m2s (
  input               io_s_in_valid,
  output reg          io_s_in_ready,
  input      [31:0]   io_s_in_payload,
  output              io_m_out_valid,
  input               io_m_out_ready,
  output     [31:0]   io_m_out_payload,
  input               clk,
  input               reset
);

  wire                io_s_in_m2sPipe_valid;
  wire                io_s_in_m2sPipe_ready;
  wire       [31:0]   io_s_in_m2sPipe_payload;
  reg                 io_s_in_rValid;
  reg        [31:0]   io_s_in_rData;
  wire                when_Stream_l368;

  always @(*) begin
    io_s_in_ready = io_s_in_m2sPipe_ready;
    if(when_Stream_l368) begin
      io_s_in_ready = 1'b1;
    end
  end

  assign when_Stream_l368 = (! io_s_in_m2sPipe_valid);
  assign io_s_in_m2sPipe_valid = io_s_in_rValid;
  assign io_s_in_m2sPipe_payload = io_s_in_rData;
  assign io_m_out_valid = io_s_in_m2sPipe_valid;
  assign io_s_in_m2sPipe_ready = io_m_out_ready;
  assign io_m_out_payload = io_s_in_m2sPipe_payload;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_s_in_rValid <= 1'b0;
    end else begin
      if(io_s_in_ready) begin
        io_s_in_rValid <= io_s_in_valid;
      end
    end
  end

  always @(posedge clk) begin
    if(io_s_in_ready) begin
      io_s_in_rData <= io_s_in_payload;
    end
  end


endmodule
