// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : memTest
// Git hash  : 3a903e741cbbe310a98c75dc1ebbd289cb1c87a4

`timescale 1ns/1ps

module memTest (
  input               io_enable,
  input      [2:0]    io_addr,
  input      [31:0]   io_din,
  output reg [31:0]   io_dout,
  input               clk,
  input               reset
);

  reg        [31:0]   _zz_rom_port0;
  wire                _zz_io_dout_1;
  wire                _zz_rom_port;
  wire       [2:0]    _zz_rom_port_1;
  reg                 _zz_1;
  wire       [2:0]    _zz_io_dout;
  reg [31:0] rom [0:5];

  assign _zz_rom_port = 1'b1;
  assign _zz_rom_port_1 = io_addr;
  always @(posedge clk) begin
    if(_zz_rom_port) begin
      _zz_rom_port0 <= rom[_zz_io_dout];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      rom[_zz_rom_port_1] <= io_din;
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(!io_enable) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    io_dout = 32'h0;
    if(io_enable) begin
      io_dout = _zz_rom_port0;
    end
  end

  assign _zz_io_dout = io_addr;

endmodule
