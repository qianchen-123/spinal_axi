// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : strict_round_arbt
// Git hash  : 1ada80d2d659ea5af45b334c0c8b37d14dd88650

`timescale 1ns/1ps

module strict_round_arbt (
  input               io_req0,
  input               io_req1,
  input               io_req2,
  input               io_req3,
  output              io_gnt0,
  output              io_gnt1,
  output              io_gnt2,
  output              io_gnt3,
  output     [1:0]    io_gnt_id,
  input               io_clk,
  input               io_rstn
);

  reg                 myArea_arbt_time_d;
  reg        [7:0]    myArea_cur_pri;
  reg        [1:0]    myArea_gnt_id_w;
  reg        [1:0]    myArea_gnt_id_fix;
  reg                 myArea_fix_req0;
  reg                 myArea_fix_req1;
  reg                 myArea_fix_req2;
  reg                 myArea_fix_req3;
  wire                myArea_arbt_time;
  wire       [1:0]    switch_strict_round_arbt_l49;
  wire       [1:0]    switch_strict_round_arbt_l64;
  wire       [1:0]    switch_strict_round_arbt_l79;
  wire       [1:0]    switch_strict_round_arbt_l94;
  reg                 myArea_gnt0;
  reg                 myArea_gnt1;
  reg                 myArea_gnt2;
  reg                 myArea_gnt3;
  reg        [1:0]    myArea_gnt_id;

  always @(*) begin
    myArea_gnt_id_fix = 2'b00;
    if(myArea_fix_req0) begin
      myArea_gnt_id_fix = 2'b00;
    end else begin
      if(myArea_fix_req1) begin
        myArea_gnt_id_fix = 2'b01;
      end else begin
        if(myArea_fix_req2) begin
          myArea_gnt_id_fix = 2'b10;
        end else begin
          if(myArea_fix_req3) begin
            myArea_gnt_id_fix = 2'b11;
          end
        end
      end
    end
  end

  assign myArea_arbt_time = ((! myArea_arbt_time_d) && (((io_req0 || io_req1) || io_req2) || io_req3));
  assign switch_strict_round_arbt_l49 = myArea_cur_pri[1 : 0];
  always @(*) begin
    case(switch_strict_round_arbt_l49)
      2'b00 : begin
        myArea_fix_req0 = io_req0;
      end
      2'b01 : begin
        myArea_fix_req0 = io_req1;
      end
      2'b10 : begin
        myArea_fix_req0 = io_req2;
      end
      default : begin
        myArea_fix_req0 = io_req3;
      end
    endcase
  end

  assign switch_strict_round_arbt_l64 = myArea_cur_pri[3 : 2];
  always @(*) begin
    case(switch_strict_round_arbt_l64)
      2'b00 : begin
        myArea_fix_req1 = io_req0;
      end
      2'b01 : begin
        myArea_fix_req1 = io_req1;
      end
      2'b10 : begin
        myArea_fix_req1 = io_req2;
      end
      default : begin
        myArea_fix_req1 = io_req3;
      end
    endcase
  end

  assign switch_strict_round_arbt_l79 = myArea_cur_pri[5 : 4];
  always @(*) begin
    case(switch_strict_round_arbt_l79)
      2'b00 : begin
        myArea_fix_req2 = io_req0;
      end
      2'b01 : begin
        myArea_fix_req2 = io_req1;
      end
      2'b10 : begin
        myArea_fix_req2 = io_req2;
      end
      default : begin
        myArea_fix_req2 = io_req3;
      end
    endcase
  end

  assign switch_strict_round_arbt_l94 = myArea_cur_pri[7 : 6];
  always @(*) begin
    case(switch_strict_round_arbt_l94)
      2'b00 : begin
        myArea_fix_req3 = io_req0;
      end
      2'b01 : begin
        myArea_fix_req3 = io_req1;
      end
      2'b10 : begin
        myArea_fix_req3 = io_req2;
      end
      default : begin
        myArea_fix_req3 = io_req3;
      end
    endcase
  end

  always @(*) begin
    case(myArea_gnt_id_fix)
      2'b00 : begin
        myArea_gnt_id_w = myArea_cur_pri[1 : 0];
      end
      2'b01 : begin
        myArea_gnt_id_w = myArea_cur_pri[3 : 2];
      end
      2'b10 : begin
        myArea_gnt_id_w = myArea_cur_pri[5 : 4];
      end
      default : begin
        myArea_gnt_id_w = myArea_cur_pri[7 : 6];
      end
    endcase
  end

  assign io_gnt0 = myArea_gnt0;
  assign io_gnt1 = myArea_gnt1;
  assign io_gnt2 = myArea_gnt2;
  assign io_gnt3 = myArea_gnt3;
  assign io_gnt_id = myArea_gnt_id;
  always @(posedge io_clk or negedge io_rstn) begin
    if(!io_rstn) begin
      myArea_arbt_time_d <= 1'b0;
      myArea_cur_pri <= {2'b11,{2'b10,{2'b01,2'b00}}};
      myArea_gnt0 <= 1'b0;
      myArea_gnt1 <= 1'b0;
      myArea_gnt2 <= 1'b0;
      myArea_gnt3 <= 1'b0;
      myArea_gnt_id <= 2'b00;
    end else begin
      if(myArea_arbt_time) begin
        case(myArea_gnt_id_w)
          2'b00 : begin
            myArea_gnt0 <= 1'b1;
          end
          2'b01 : begin
            myArea_gnt1 <= 1'b1;
          end
          2'b10 : begin
            myArea_gnt2 <= 1'b1;
          end
          default : begin
            myArea_gnt3 <= 1'b1;
          end
        endcase
      end else begin
        if(myArea_arbt_time_d) begin
          myArea_gnt0 <= 1'b0;
          myArea_gnt1 <= 1'b0;
          myArea_gnt2 <= 1'b0;
          myArea_gnt3 <= 1'b0;
        end
      end
      if(myArea_arbt_time) begin
        myArea_gnt_id <= myArea_gnt_id_w;
      end
      if(myArea_arbt_time) begin
        case(myArea_gnt_id_fix)
          2'b00 : begin
            myArea_cur_pri <= {myArea_cur_pri[1 : 0],myArea_cur_pri[7 : 2]};
          end
          2'b01 : begin
            myArea_cur_pri <= {myArea_cur_pri[3 : 2],{myArea_cur_pri[7 : 4],myArea_cur_pri[1 : 0]}};
          end
          2'b10 : begin
            myArea_cur_pri <= {myArea_cur_pri[5 : 4],{myArea_cur_pri[7 : 6],myArea_cur_pri[3 : 0]}};
          end
          default : begin
            myArea_cur_pri <= {myArea_cur_pri[7 : 6],myArea_cur_pri[5 : 0]};
          end
        endcase
      end
      myArea_arbt_time_d <= myArea_arbt_time;
    end
  end


endmodule
