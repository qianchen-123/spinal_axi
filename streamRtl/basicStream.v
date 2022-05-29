// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : basicStream
// Git hash  : 3a903e741cbbe310a98c75dc1ebbd289cb1c87a4

`timescale 1ns/1ps

module basicStream (
  input               io_s_in_valid,
  output              io_s_in_ready,
  input      [31:0]   io_s_in_payload,
  output              io_m_out_valid,
  input               io_m_out_ready,
  output     [31:0]   io_m_out_payload
);


  assign io_m_out_valid = io_s_in_valid;
  assign io_s_in_ready = io_m_out_ready;
  assign io_m_out_payload = io_s_in_payload;

endmodule
