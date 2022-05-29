// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : axi_slave
// Git hash  : 3a903e741cbbe310a98c75dc1ebbd289cb1c87a4

`timescale 1ns/1ps

module axi_slave (
  input               io_axi_in_aw_valid,
  output reg          io_axi_in_aw_ready,
  input      [31:0]   io_axi_in_aw_payload_addr,
  input      [3:0]    io_axi_in_aw_payload_id,
  input      [3:0]    io_axi_in_aw_payload_region,
  input      [7:0]    io_axi_in_aw_payload_len,
  input      [2:0]    io_axi_in_aw_payload_size,
  input      [1:0]    io_axi_in_aw_payload_burst,
  input      [0:0]    io_axi_in_aw_payload_lock,
  input      [3:0]    io_axi_in_aw_payload_cache,
  input      [3:0]    io_axi_in_aw_payload_qos,
  input      [2:0]    io_axi_in_aw_payload_prot,
  input               io_axi_in_w_valid,
  output reg          io_axi_in_w_ready,
  input      [31:0]   io_axi_in_w_payload_data,
  input      [3:0]    io_axi_in_w_payload_strb,
  input               io_axi_in_w_payload_last,
  output reg          io_axi_in_b_valid,
  input               io_axi_in_b_ready,
  output reg [3:0]    io_axi_in_b_payload_id,
  output reg [1:0]    io_axi_in_b_payload_resp,
  output reg [3:0]    io_axi_in_b_payload_user,
  input               io_axi_in_ar_valid,
  output reg          io_axi_in_ar_ready,
  input      [31:0]   io_axi_in_ar_payload_addr,
  input      [3:0]    io_axi_in_ar_payload_id,
  input      [3:0]    io_axi_in_ar_payload_region,
  input      [7:0]    io_axi_in_ar_payload_len,
  input      [2:0]    io_axi_in_ar_payload_size,
  input      [1:0]    io_axi_in_ar_payload_burst,
  input      [0:0]    io_axi_in_ar_payload_lock,
  input      [3:0]    io_axi_in_ar_payload_cache,
  input      [3:0]    io_axi_in_ar_payload_qos,
  input      [2:0]    io_axi_in_ar_payload_prot,
  output reg          io_axi_in_r_valid,
  input               io_axi_in_r_ready,
  output reg [31:0]   io_axi_in_r_payload_data,
  output reg [3:0]    io_axi_in_r_payload_id,
  output reg [1:0]    io_axi_in_r_payload_resp,
  output reg          io_axi_in_r_payload_last,
  output reg [3:0]    io_axi_in_r_payload_user,
  input               clk,
  input               reset
);
  localparam fsm_enumDef_BOOT = 3'd0;
  localparam fsm_enumDef_IDLE = 3'd1;
  localparam fsm_enumDef_W_ADDR = 3'd2;
  localparam fsm_enumDef_W_DATA = 3'd3;
  localparam fsm_enumDef_W_RSP = 3'd4;
  localparam fsm_enumDef_R_ADDR = 3'd5;
  localparam fsm_enumDef_R_DATA = 3'd6;

  reg        [31:0]   _zz_mem1_port1;
  reg        [31:0]   _zz_mem1_port2;
  wire       [31:0]   _zz_axiCfgReg_AxADDR;
  wire       [7:0]    _zz_axiCfgReg_AxADDR_1;
  wire       [31:0]   _zz_axiCfgReg_AxADDR_2;
  wire       [7:0]    _zz_axiCfgReg_AxADDR_3;
  wire       [7:0]    _zz_axiCfgReg_full;
  wire       [7:0]    _zz_axiCfgReg_almostFull;
  wire       [7:0]    _zz_axiCfgReg_almostFull_1;
  wire       [11:0]   _zz_mem1_port;
  wire       [31:0]   _zz_axiCfgReg_AxADDR_4;
  wire       [7:0]    _zz_axiCfgReg_AxADDR_5;
  wire       [3:0]    user;
  reg        [3:0]    axiCfgReg_AxID;
  reg        [31:0]   axiCfgReg_AxADDR;
  reg        [7:0]    axiCfgReg_AxLEN;
  reg        [2:0]    axiCfgReg_AxSIZE;
  reg        [1:0]    axiCfgReg_AxBURST;
  reg        [3:0]    axiCfgReg_counter;
  reg                 axiCfgReg_begin;
  reg                 axiCfgReg_in_burst_trans;
  reg                 axiCfgReg_full;
  wire                axiCfgReg_almostFull;
  wire                when_axi_slave_l64;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  wire                io_axi_in_aw_fire;
  wire                io_axi_in_w_fire;
  wire                io_axi_in_b_fire;
  wire                io_axi_in_ar_fire;
  wire       [11:0]   _zz_io_axi_in_r_payload_data;
  wire       [11:0]   _zz_io_axi_in_r_payload_data_1;
  wire                io_axi_in_r_fire;
  `ifndef SYNTHESIS
  reg [47:0] fsm_stateReg_string;
  reg [47:0] fsm_stateNext_string;
  `endif

  reg [31:0] mem1 [0:4095];
  reg [31:0] mem2 [0:4095];

  assign _zz_axiCfgReg_AxADDR_1 = ({7'd0,1'b1} <<< axiCfgReg_AxSIZE);
  assign _zz_axiCfgReg_AxADDR = {24'd0, _zz_axiCfgReg_AxADDR_1};
  assign _zz_axiCfgReg_AxADDR_3 = ({7'd0,1'b1} <<< axiCfgReg_AxSIZE);
  assign _zz_axiCfgReg_AxADDR_2 = {24'd0, _zz_axiCfgReg_AxADDR_3};
  assign _zz_axiCfgReg_full = {4'd0, axiCfgReg_counter};
  assign _zz_axiCfgReg_almostFull = {4'd0, axiCfgReg_counter};
  assign _zz_axiCfgReg_almostFull_1 = (axiCfgReg_AxLEN - 8'h01);
  assign _zz_axiCfgReg_AxADDR_5 = ({7'd0,1'b1} <<< axiCfgReg_AxSIZE);
  assign _zz_axiCfgReg_AxADDR_4 = {24'd0, _zz_axiCfgReg_AxADDR_5};
  assign _zz_mem1_port = axiCfgReg_AxADDR[11 : 0];
  always @(posedge clk) begin
    if(io_axi_in_w_valid) begin
      mem1[_zz_mem1_port] <= io_axi_in_w_payload_data;
    end
  end

  always @(posedge clk) begin
    if(io_axi_in_r_valid) begin
      _zz_mem1_port1 <= mem1[_zz_io_axi_in_r_payload_data];
    end
  end

  always @(posedge clk) begin
    if(io_axi_in_r_valid) begin
      _zz_mem1_port2 <= mem1[_zz_io_axi_in_r_payload_data_1];
    end
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT  ";
      fsm_enumDef_IDLE : fsm_stateReg_string = "IDLE  ";
      fsm_enumDef_W_ADDR : fsm_stateReg_string = "W_ADDR";
      fsm_enumDef_W_DATA : fsm_stateReg_string = "W_DATA";
      fsm_enumDef_W_RSP : fsm_stateReg_string = "W_RSP ";
      fsm_enumDef_R_ADDR : fsm_stateReg_string = "R_ADDR";
      fsm_enumDef_R_DATA : fsm_stateReg_string = "R_DATA";
      default : fsm_stateReg_string = "??????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT  ";
      fsm_enumDef_IDLE : fsm_stateNext_string = "IDLE  ";
      fsm_enumDef_W_ADDR : fsm_stateNext_string = "W_ADDR";
      fsm_enumDef_W_DATA : fsm_stateNext_string = "W_DATA";
      fsm_enumDef_W_RSP : fsm_stateNext_string = "W_RSP ";
      fsm_enumDef_R_ADDR : fsm_stateNext_string = "R_ADDR";
      fsm_enumDef_R_DATA : fsm_stateNext_string = "R_DATA";
      default : fsm_stateNext_string = "??????";
    endcase
  end
  `endif

  assign user = 4'b0000;
  always @(*) begin
    axiCfgReg_in_burst_trans = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
        axiCfgReg_in_burst_trans = 1'b0;
      end
      fsm_enumDef_W_ADDR : begin
        axiCfgReg_in_burst_trans = 1'b0;
      end
      fsm_enumDef_W_DATA : begin
        if(io_axi_in_w_valid) begin
          axiCfgReg_in_burst_trans = 1'b1;
        end
        if(io_axi_in_w_fire) begin
          if(axiCfgReg_full) begin
            axiCfgReg_in_burst_trans = 1'b0;
          end
        end else begin
          axiCfgReg_in_burst_trans = 1'b0;
        end
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
        axiCfgReg_in_burst_trans = 1'b1;
      end
      fsm_enumDef_R_DATA : begin
        if(io_axi_in_r_fire) begin
          if(axiCfgReg_full) begin
            axiCfgReg_in_burst_trans = 1'b0;
          end else begin
            axiCfgReg_in_burst_trans = 1'b1;
          end
        end else begin
          axiCfgReg_in_burst_trans = 1'b0;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_axi_slave_l64 = (axiCfgReg_begin && (! axiCfgReg_full));
  always @(*) begin
    axiCfgReg_full = (_zz_axiCfgReg_full == axiCfgReg_AxLEN);
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
        axiCfgReg_full = 1'b0;
      end
      fsm_enumDef_W_ADDR : begin
        axiCfgReg_full = 1'b0;
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
        axiCfgReg_full = 1'b0;
      end
      fsm_enumDef_R_DATA : begin
      end
      default : begin
      end
    endcase
  end

  assign axiCfgReg_almostFull = (_zz_axiCfgReg_almostFull == _zz_axiCfgReg_almostFull_1);
  always @(*) begin
    io_axi_in_aw_ready = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
        io_axi_in_aw_ready = 1'b1;
      end
      fsm_enumDef_W_DATA : begin
        io_axi_in_aw_ready = 1'b0;
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_w_ready = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
        io_axi_in_w_ready = 1'b0;
        if(io_axi_in_w_valid) begin
          io_axi_in_w_ready = 1'b1;
        end
      end
      fsm_enumDef_W_RSP : begin
        io_axi_in_w_ready = 1'b0;
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_b_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
        io_axi_in_b_valid = 1'b0;
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
        io_axi_in_b_valid = 1'b1;
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_b_payload_id = 4'b0000;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
        io_axi_in_b_payload_id = axiCfgReg_AxID;
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_b_payload_resp = 2'b00;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
        io_axi_in_b_payload_resp = 2'b00;
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_b_payload_user = user;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
        io_axi_in_b_payload_user = user;
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_ar_ready = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
        io_axi_in_ar_ready = 1'b1;
      end
      fsm_enumDef_R_DATA : begin
        io_axi_in_ar_ready = 1'b0;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_r_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
        io_axi_in_r_valid = 1'b0;
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
        if(io_axi_in_ar_fire) begin
          io_axi_in_r_valid = 1'b1;
        end
      end
      fsm_enumDef_R_DATA : begin
        io_axi_in_r_valid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_r_payload_data = 32'h0;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
        if(io_axi_in_ar_fire) begin
          io_axi_in_r_payload_data = _zz_mem1_port1;
        end
      end
      fsm_enumDef_R_DATA : begin
        io_axi_in_r_payload_data = _zz_mem1_port2;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_r_payload_id = 4'b0000;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
        io_axi_in_r_payload_id = axiCfgReg_AxID;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_r_payload_resp = 2'b00;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
        io_axi_in_r_payload_resp = 2'b00;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_r_payload_last = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
        io_axi_in_r_payload_last = 1'b0;
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
        if(io_axi_in_r_fire) begin
          if(axiCfgReg_full) begin
            io_axi_in_r_payload_last = 1'b1;
          end else begin
            io_axi_in_r_payload_last = 1'b0;
          end
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_in_r_payload_user = user;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
        io_axi_in_r_payload_user = user;
      end
      default : begin
      end
    endcase
  end

  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_W_ADDR : begin
      end
      fsm_enumDef_W_DATA : begin
      end
      fsm_enumDef_W_RSP : begin
      end
      fsm_enumDef_R_ADDR : begin
      end
      fsm_enumDef_R_DATA : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
        if(io_axi_in_aw_valid) begin
          fsm_stateNext = fsm_enumDef_W_ADDR;
        end else begin
          if(io_axi_in_ar_valid) begin
            fsm_stateNext = fsm_enumDef_R_ADDR;
          end
        end
      end
      fsm_enumDef_W_ADDR : begin
        if(io_axi_in_aw_fire) begin
          fsm_stateNext = fsm_enumDef_W_DATA;
        end
      end
      fsm_enumDef_W_DATA : begin
        if(io_axi_in_w_fire) begin
          if(axiCfgReg_full) begin
            fsm_stateNext = fsm_enumDef_W_RSP;
          end else begin
            fsm_stateNext = fsm_enumDef_W_DATA;
          end
        end else begin
          fsm_stateNext = fsm_enumDef_W_DATA;
        end
      end
      fsm_enumDef_W_RSP : begin
        if(io_axi_in_b_fire) begin
          fsm_stateNext = fsm_enumDef_IDLE;
        end
      end
      fsm_enumDef_R_ADDR : begin
        if(io_axi_in_ar_fire) begin
          fsm_stateNext = fsm_enumDef_R_DATA;
        end
      end
      fsm_enumDef_R_DATA : begin
        if(io_axi_in_r_fire) begin
          if(axiCfgReg_full) begin
            fsm_stateNext = fsm_enumDef_IDLE;
          end else begin
            fsm_stateNext = fsm_enumDef_R_DATA;
          end
        end else begin
          fsm_stateNext = fsm_enumDef_R_DATA;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_IDLE;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  assign io_axi_in_aw_fire = (io_axi_in_aw_valid && io_axi_in_aw_ready);
  assign io_axi_in_w_fire = (io_axi_in_w_valid && io_axi_in_w_ready);
  assign io_axi_in_b_fire = (io_axi_in_b_valid && io_axi_in_b_ready);
  assign io_axi_in_ar_fire = (io_axi_in_ar_valid && io_axi_in_ar_ready);
  assign _zz_io_axi_in_r_payload_data = axiCfgReg_AxADDR[11 : 0];
  assign _zz_io_axi_in_r_payload_data_1 = axiCfgReg_AxADDR[11 : 0];
  assign io_axi_in_r_fire = (io_axi_in_r_valid && io_axi_in_r_ready);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      axiCfgReg_AxID <= 4'b0000;
      axiCfgReg_AxADDR <= 32'h0;
      axiCfgReg_AxLEN <= 8'h0;
      axiCfgReg_AxSIZE <= 3'b000;
      axiCfgReg_AxBURST <= 2'b00;
      axiCfgReg_counter <= 4'b0000;
      axiCfgReg_begin <= 1'b0;
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      if(axiCfgReg_in_burst_trans) begin
        if(when_axi_slave_l64) begin
          case(axiCfgReg_AxBURST)
            2'b00 : begin
              axiCfgReg_AxADDR <= axiCfgReg_AxADDR;
            end
            2'b01 : begin
              axiCfgReg_AxADDR <= (axiCfgReg_AxADDR + _zz_axiCfgReg_AxADDR);
            end
            2'b10 : begin
              axiCfgReg_AxADDR <= (axiCfgReg_AxADDR + _zz_axiCfgReg_AxADDR_2);
            end
            default : begin
            end
          endcase
          axiCfgReg_counter <= (axiCfgReg_counter + 4'b0001);
        end
      end
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_IDLE : begin
          axiCfgReg_AxID <= 4'b0000;
          axiCfgReg_AxADDR <= 32'h0;
          axiCfgReg_AxLEN <= 8'h0;
          axiCfgReg_AxSIZE <= 3'b000;
          axiCfgReg_AxBURST <= 2'b00;
          axiCfgReg_counter <= 4'b0000;
          axiCfgReg_begin <= 1'b0;
        end
        fsm_enumDef_W_ADDR : begin
          axiCfgReg_AxID <= io_axi_in_aw_payload_id;
          axiCfgReg_AxADDR <= io_axi_in_aw_payload_addr;
          axiCfgReg_AxLEN <= io_axi_in_aw_payload_len;
          axiCfgReg_AxSIZE <= io_axi_in_aw_payload_size;
          axiCfgReg_AxBURST <= io_axi_in_aw_payload_burst;
          axiCfgReg_counter <= 4'b0001;
          axiCfgReg_begin <= 1'b1;
        end
        fsm_enumDef_W_DATA : begin
        end
        fsm_enumDef_W_RSP : begin
        end
        fsm_enumDef_R_ADDR : begin
          axiCfgReg_AxID <= io_axi_in_ar_payload_id;
          axiCfgReg_AxADDR <= (io_axi_in_ar_payload_addr + _zz_axiCfgReg_AxADDR_4);
          axiCfgReg_AxLEN <= io_axi_in_ar_payload_len;
          axiCfgReg_AxSIZE <= io_axi_in_ar_payload_size;
          axiCfgReg_AxBURST <= io_axi_in_ar_payload_burst;
          axiCfgReg_counter <= 4'b0001;
          axiCfgReg_begin <= 1'b1;
        end
        fsm_enumDef_R_DATA : begin
        end
        default : begin
        end
      endcase
    end
  end
initial begin
$dumpfile("axi_slave_test.vcd");
$dumpvars(0,axi_slave);
end

endmodule
