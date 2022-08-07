// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : strict_round_arbt
// Git hash  : 9c40920248c54b4106d59045a2d785d7f59e312f

`timescale 1ns/1ps

module strict_round_arbt (
  input               io_req0,
  input               io_req1,
  input               io_req2,
  input               io_req3,
  output reg          io_gnt0,
  output reg          io_gnt1,
  output reg          io_gnt2,
  output reg          io_gnt3,
  output reg [1:0]    io_gnt_id,
  input               io_rstn,
  input               clk,
  input               reset
);

  reg                 arbt_time_d;
  reg        [7:0]    cur_pri;
  reg        [1:0]    gnt_id_w;
  reg        [1:0]    gnt_id_fix;
  reg                 fix_req0;
  reg                 fix_req1;
  reg                 fix_req2;
  reg                 fix_req3;
  wire                arbt_time;
  wire       [1:0]    switch_strict_round_arbt_l36;
  wire       [1:0]    switch_strict_round_arbt_l51;
  wire       [1:0]    switch_strict_round_arbt_l66;
  wire       [1:0]    switch_strict_round_arbt_l81;
  wire                when_strict_round_arbt_l127;
  wire                when_strict_round_arbt_l159;
  wire                when_strict_round_arbt_l167;
  wire                when_strict_round_arbt_l188;

  assign arbt_time = ((! arbt_time_d) && (((io_req0 || io_req1) || io_req2) || io_req3));
  assign switch_strict_round_arbt_l36 = cur_pri[1 : 0];
  assign switch_strict_round_arbt_l51 = cur_pri[3 : 2];
  assign switch_strict_round_arbt_l66 = cur_pri[5 : 4];
  assign switch_strict_round_arbt_l81 = cur_pri[7 : 6];
  assign when_strict_round_arbt_l127 = (! io_rstn);
  always @(*) begin
    io_gnt_id = 2'b00;
    if(when_strict_round_arbt_l159) begin
      io_gnt_id = 2'b00;
    end else begin
      if(arbt_time) begin
        io_gnt_id = gnt_id_w;
      end
    end
  end

  assign when_strict_round_arbt_l159 = (! io_rstn);
  assign when_strict_round_arbt_l167 = (! io_rstn);
  assign when_strict_round_arbt_l188 = (! io_rstn);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_gnt0 <= 1'b0;
      io_gnt1 <= 1'b0;
      io_gnt2 <= 1'b0;
      io_gnt3 <= 1'b0;
      arbt_time_d <= 1'b0;
      cur_pri <= 8'h0;
      gnt_id_w <= 2'b00;
      gnt_id_fix <= 2'b00;
      fix_req0 <= 1'b0;
      fix_req1 <= 1'b0;
      fix_req2 <= 1'b0;
      fix_req3 <= 1'b0;
    end else begin
      case(switch_strict_round_arbt_l36)
        2'b00 : begin
          fix_req0 <= io_req0;
        end
        2'b01 : begin
          fix_req0 <= io_req1;
        end
        2'b10 : begin
          fix_req0 <= io_req2;
        end
        default : begin
          fix_req0 <= io_req3;
        end
      endcase
      case(switch_strict_round_arbt_l51)
        2'b00 : begin
          fix_req1 <= io_req0;
        end
        2'b01 : begin
          fix_req1 <= io_req1;
        end
        2'b10 : begin
          fix_req1 <= io_req2;
        end
        default : begin
          fix_req1 <= io_req3;
        end
      endcase
      case(switch_strict_round_arbt_l66)
        2'b00 : begin
          fix_req2 <= io_req0;
        end
        2'b01 : begin
          fix_req2 <= io_req1;
        end
        2'b10 : begin
          fix_req2 <= io_req2;
        end
        default : begin
          fix_req2 <= io_req3;
        end
      endcase
      case(switch_strict_round_arbt_l81)
        2'b00 : begin
          fix_req3 <= io_req0;
        end
        2'b01 : begin
          fix_req3 <= io_req1;
        end
        2'b10 : begin
          fix_req3 <= io_req2;
        end
        default : begin
          fix_req3 <= io_req3;
        end
      endcase
      if(fix_req0) begin
        gnt_id_fix <= 2'b00;
      end else begin
        if(fix_req1) begin
          gnt_id_fix <= 2'b01;
        end else begin
          if(fix_req2) begin
            gnt_id_fix <= 2'b10;
          end else begin
            if(fix_req3) begin
              gnt_id_fix <= 2'b11;
            end
          end
        end
      end
      case(gnt_id_fix)
        2'b00 : begin
          gnt_id_w <= cur_pri[1 : 0];
        end
        2'b01 : begin
          gnt_id_w <= cur_pri[3 : 2];
        end
        2'b10 : begin
          gnt_id_w <= cur_pri[5 : 4];
        end
        default : begin
          gnt_id_w <= cur_pri[7 : 6];
        end
      endcase
      if(when_strict_round_arbt_l127) begin
        io_gnt0 <= 1'b0;
        io_gnt1 <= 1'b0;
        io_gnt2 <= 1'b0;
        io_gnt3 <= 1'b0;
      end else begin
        if(arbt_time) begin
          case(gnt_id_w)
            2'b00 : begin
              io_gnt0 <= 1'b1;
            end
            2'b01 : begin
              io_gnt1 <= 1'b1;
            end
            2'b10 : begin
              io_gnt2 <= 1'b1;
            end
            default : begin
              io_gnt3 <= 1'b1;
            end
          endcase
        end else begin
          if(arbt_time_d) begin
            io_gnt0 <= 1'b0;
            io_gnt1 <= 1'b0;
            io_gnt2 <= 1'b0;
            io_gnt3 <= 1'b0;
          end
        end
      end
      if(when_strict_round_arbt_l167) begin
        cur_pri <= {2'b00,{2'b01,{2'b10,2'b11}}};
      end else begin
        if(arbt_time) begin
          case(gnt_id_fix)
            2'b00 : begin
              cur_pri <= {cur_pri[1 : 0],cur_pri[7 : 2]};
            end
            2'b01 : begin
              cur_pri <= {cur_pri[3 : 2],{cur_pri[7 : 4],cur_pri[1 : 0]}};
            end
            2'b10 : begin
              cur_pri <= {cur_pri[5 : 4],{cur_pri[7 : 6],cur_pri[3 : 0]}};
            end
            default : begin
              cur_pri <= {cur_pri[5 : 0],cur_pri[7 : 6]};
            end
          endcase
        end
      end
      if(when_strict_round_arbt_l188) begin
        arbt_time_d <= 1'b0;
      end else begin
        arbt_time_d <= arbt_time;
      end
    end
  end


endmodule
