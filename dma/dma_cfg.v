// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : dma_cfg
// Git hash  : 9c40920248c54b4106d59045a2d785d7f59e312f

`timescale 1ns/1ps

module dma_cfg (
  input      [7:0]    io_cfg_dma_apb_PADDR,
  input      [0:0]    io_cfg_dma_apb_PSEL,
  input               io_cfg_dma_apb_PENABLE,
  output              io_cfg_dma_apb_PREADY,
  input               io_cfg_dma_apb_PWRITE,
  input      [31:0]   io_cfg_dma_apb_PWDATA,
  output reg [31:0]   io_cfg_dma_apb_PRDATA,
  output     [31:0]   io_cfg_sar,
  output     [31:0]   io_cfg_dar,
  output     [15:0]   io_cfg_trans_xsize,
  output     [15:0]   io_cfg_trans_ysize,
  output     [15:0]   io_cfg_sa_ystep,
  output     [15:0]   io_cfg_da_ystep,
  output     [31:0]   io_cfg_llr,
  output              io_cfg_dma_halt,
  output              io_cfg_bf,
  output              io_cfg_cf,
  input               io_cfg_buf_err,
  output              io_cfg_clr_bur_err,
  output reg          io_cfg_ll_req,
  output     [31:0]   io_cfg_ll_addr,
  input               io_cfg_ll_ack,
  input               io_cfg_ll_dvld,
  input      [31:0]   io_cfg_ll_rdata,
  input      [2:0]    io_cfg_ll_dcnt,
  output              io_cfg_dma_cmd_sof,
  input               io_cfg_dma_cmd_end,
  output     [7:0]    io_cfg_cmd_num,
  output              io_cfg_dma_busy,
  output              io_cfg_intr,
  input               io_cfg_clk,
  input               io_cfg_rstn,
  input               clk,
  input               reset
);
  localparam fsm_enumDef_BOOT = 2'd0;
  localparam fsm_enumDef_s_idle = 2'd1;
  localparam fsm_enumDef_s_req = 2'd2;

  reg        [31:0]   prdata;
  reg        [31:0]   cfg_sar;
  reg        [31:0]   cfg_dar;
  reg        [15:0]   cfg_trans_xsize;
  reg        [15:0]   cfg_trans_ysize;
  reg        [15:0]   cfg_sa_ystep;
  reg        [15:0]   cfg_da_ystep;
  reg        [31:0]   cfg_llr;
  reg                 cfg_dma_halt;
  reg                 cfg_bf;
  reg                 cfg_cf;
  reg                 dma_cmd_sof;
  reg        [7:0]    cmd_num;
  reg                 dma_busy;
  reg                 cfg_intr_en;
  wire                apb_write;
  wire                apb_read;
  wire       [3:0]    apb_addr;
  wire                clr_intr;
  wire                dma_sof_w;
  wire                cmd_update;
  wire       [3:0]    cmd_update_addr;
  wire       [31:0]   cmd_update_wd;
  wire                when_dma_cfg_l71;
  wire       [3:0]    switch_dma_cfg_l81;
  wire                when_dma_cfg_l105;
  wire                when_dma_cfg_l111;
  reg                 dma_end_flag;
  wire                dma_end_w;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  wire                dma_cmd_goon;
  wire                when_dma_cfg_l158;
  wire                when_dma_cfg_l170;
  wire                when_dma_cfg_l182;
  wire                when_dma_cfg_l196;
  wire                when_dma_cfg_l199;
  wire                when_dma_cfg_l207;
  wire       [3:0]    switch_dma_cfg_l211;
  reg        [1:0]    fsm_stateReg;
  reg        [1:0]    fsm_stateNext;
  wire                when_dma_cfg_l131;
  wire                when_dma_cfg_l134;
  wire                when_dma_cfg_l144;
  `ifndef SYNTHESIS
  reg [47:0] fsm_stateReg_string;
  reg [47:0] fsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT  ";
      fsm_enumDef_s_idle : fsm_stateReg_string = "s_idle";
      fsm_enumDef_s_req : fsm_stateReg_string = "s_req ";
      default : fsm_stateReg_string = "??????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT  ";
      fsm_enumDef_s_idle : fsm_stateNext_string = "s_idle";
      fsm_enumDef_s_req : fsm_stateNext_string = "s_req ";
      default : fsm_stateNext_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    io_cfg_dma_apb_PRDATA = prdata;
    if(when_dma_cfg_l207) begin
      io_cfg_dma_apb_PRDATA = 32'h0;
    end
  end

  assign io_cfg_sar = cfg_sar;
  assign io_cfg_dar = cfg_dar;
  assign io_cfg_trans_xsize = cfg_trans_xsize;
  assign io_cfg_trans_ysize = cfg_trans_ysize;
  assign io_cfg_sa_ystep = cfg_sa_ystep;
  assign io_cfg_da_ystep = cfg_da_ystep;
  assign io_cfg_llr = cfg_llr;
  assign io_cfg_dma_halt = cfg_dma_halt;
  assign io_cfg_bf = cfg_bf;
  assign io_cfg_cf = cfg_cf;
  assign io_cfg_dma_cmd_sof = dma_cmd_sof;
  assign io_cfg_cmd_num = cmd_num;
  assign io_cfg_dma_busy = dma_busy;
  assign apb_write = ((io_cfg_dma_apb_PSEL[0] && io_cfg_dma_apb_PWRITE) && io_cfg_dma_apb_PENABLE);
  assign apb_read = (io_cfg_dma_apb_PSEL[0] && (! io_cfg_dma_apb_PWRITE));
  assign apb_addr = io_cfg_dma_apb_PADDR[5 : 2];
  assign io_cfg_dma_apb_PREADY = 1'b1;
  assign clr_intr = (((apb_write && io_cfg_dma_apb_PENABLE) && (apb_addr == 4'b0110)) && (! io_cfg_dma_apb_PWDATA[0]));
  assign dma_sof_w = (((apb_write && io_cfg_dma_apb_PENABLE) && (apb_addr == 4'b1000)) && io_cfg_dma_apb_PWDATA[0]);
  assign io_cfg_clr_bur_err = (((apb_write && io_cfg_dma_apb_PENABLE) && (apb_addr == 4'b0110)) && (! io_cfg_dma_apb_PWDATA[4]));
  assign cmd_update = (apb_write || io_cfg_ll_dvld);
  assign cmd_update_addr = (apb_write ? apb_addr : {io_cfg_ll_dcnt,1'b0});
  assign cmd_update_wd = (apb_write ? io_cfg_dma_apb_PWDATA : io_cfg_ll_rdata);
  assign when_dma_cfg_l71 = (! io_cfg_rstn);
  assign switch_dma_cfg_l81 = cmd_update_addr[3 : 0];
  assign when_dma_cfg_l105 = (! io_cfg_rstn);
  assign when_dma_cfg_l111 = (apb_write && (apb_addr == 4'b0111));
  assign io_cfg_ll_addr = cfg_llr;
  assign dma_end_w = (io_cfg_dma_cmd_end && (cfg_llr[30 : 2] == 29'h0));
  always @(*) begin
    io_cfg_ll_req = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_s_idle : begin
        io_cfg_ll_req = 1'b0;
        if(!when_dma_cfg_l131) begin
          if(when_dma_cfg_l134) begin
            io_cfg_ll_req = 1'b1;
          end
        end
      end
      fsm_enumDef_s_req : begin
      end
      default : begin
      end
    endcase
  end

  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_s_idle : begin
      end
      fsm_enumDef_s_req : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  assign dma_cmd_goon = (io_cfg_ll_dvld && (io_cfg_ll_dcnt == 3'b101));
  assign when_dma_cfg_l158 = (! io_cfg_rstn);
  assign when_dma_cfg_l170 = (! io_cfg_rstn);
  assign when_dma_cfg_l182 = (! io_cfg_rstn);
  assign io_cfg_intr = (dma_end_flag && cfg_intr_en);
  assign when_dma_cfg_l196 = (! io_cfg_rstn);
  assign when_dma_cfg_l199 = (dma_sof_w || dma_cmd_goon);
  assign when_dma_cfg_l207 = (! io_cfg_rstn);
  assign switch_dma_cfg_l211 = apb_addr[3 : 0];
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_s_idle : begin
        if(when_dma_cfg_l131) begin
          fsm_stateNext = fsm_enumDef_s_idle;
        end else begin
          if(when_dma_cfg_l134) begin
            fsm_stateNext = fsm_enumDef_s_req;
          end
        end
      end
      fsm_enumDef_s_req : begin
        if(when_dma_cfg_l144) begin
          fsm_stateNext = fsm_enumDef_s_idle;
        end else begin
          if(io_cfg_ll_ack) begin
            fsm_stateNext = fsm_enumDef_s_idle;
          end
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_s_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  assign when_dma_cfg_l131 = (! io_cfg_rstn);
  assign when_dma_cfg_l134 = (io_cfg_dma_cmd_end && (cfg_llr[30 : 2] != 29'h0));
  assign when_dma_cfg_l144 = (! io_cfg_rstn);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      prdata <= 32'h0;
      cfg_sar <= 32'h0;
      cfg_dar <= 32'h0;
      cfg_trans_xsize <= 16'h0;
      cfg_trans_ysize <= 16'h0;
      cfg_sa_ystep <= 16'h0;
      cfg_da_ystep <= 16'h0;
      cfg_llr <= 32'h0;
      cfg_dma_halt <= 1'b0;
      cfg_bf <= 1'b0;
      cfg_cf <= 1'b0;
      dma_cmd_sof <= 1'b0;
      cmd_num <= 8'h0;
      dma_busy <= 1'b0;
      cfg_intr_en <= 1'b0;
      dma_end_flag <= 1'b0;
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      if(when_dma_cfg_l71) begin
        cfg_sar <= 32'h0;
        cfg_dar <= 32'h0;
        cfg_trans_xsize <= 16'h0;
        cfg_trans_ysize <= 16'h0;
        cfg_sa_ystep <= 16'h0;
        cfg_da_ystep <= 16'h0;
        cfg_llr <= 32'h0;
      end else begin
        if(cmd_update) begin
          case(switch_dma_cfg_l81)
            4'b0000 : begin
              cfg_sar <= cmd_update_wd;
            end
            4'b0001 : begin
              cfg_dar <= cmd_update_wd;
            end
            4'b0010 : begin
              cfg_trans_xsize <= cmd_update_wd[15 : 0];
            end
            4'b0011 : begin
              cfg_trans_ysize <= cmd_update_wd[31 : 16];
            end
            4'b0100 : begin
              cfg_sa_ystep <= cmd_update_wd[15 : 0];
              cfg_da_ystep <= cmd_update_wd[31 : 16];
            end
            4'b0101 : begin
              cfg_llr <= cmd_update_wd;
            end
            default : begin
            end
          endcase
        end
      end
      if(when_dma_cfg_l105) begin
        cfg_dma_halt <= 1'b0;
        cfg_intr_en <= 1'b0;
        cfg_bf <= 1'b0;
        cfg_cf <= 1'b0;
      end else begin
        if(when_dma_cfg_l111) begin
          cfg_intr_en <= io_cfg_dma_apb_PWDATA[0];
          cfg_dma_halt <= io_cfg_dma_apb_PWDATA[4];
          cfg_bf <= io_cfg_dma_apb_PWDATA[8];
          cfg_cf <= io_cfg_dma_apb_PWDATA[9];
        end
      end
      if(when_dma_cfg_l158) begin
        cmd_num <= 8'h0;
      end else begin
        if(dma_sof_w) begin
          cmd_num <= 8'h0;
        end else begin
          if(io_cfg_dma_cmd_end) begin
            cmd_num <= (cmd_num + 8'h01);
          end
        end
      end
      if(when_dma_cfg_l170) begin
        dma_busy <= 1'b0;
      end else begin
        if(dma_sof_w) begin
          dma_busy <= 1'b1;
        end else begin
          if(dma_end_w) begin
            dma_busy <= 1'b1;
          end
        end
      end
      if(when_dma_cfg_l182) begin
        dma_end_flag <= 1'b0;
      end else begin
        if(dma_sof_w) begin
          dma_end_flag <= 1'b1;
        end else begin
          if(dma_end_w) begin
            dma_end_flag <= 1'b1;
          end
        end
      end
      if(when_dma_cfg_l196) begin
        dma_cmd_sof <= 1'b0;
      end else begin
        if(when_dma_cfg_l199) begin
          dma_cmd_sof <= 1'b1;
        end else begin
          dma_cmd_sof <= 1'b1;
        end
      end
      if(!when_dma_cfg_l207) begin
        if(apb_read) begin
          case(switch_dma_cfg_l211)
            4'b0000 : begin
              prdata <= cfg_sar;
            end
            4'b0001 : begin
              prdata <= cfg_dar;
            end
            4'b0010 : begin
              prdata <= {cfg_trans_xsize,16'h0};
            end
            4'b0011 : begin
              prdata <= {cfg_trans_ysize,16'h0};
            end
            4'b0100 : begin
              prdata <= {cfg_sa_ystep,cfg_da_ystep};
            end
            4'b0101 : begin
              prdata <= cfg_llr;
            end
            4'b0110 : begin
              prdata <= {dma_end_flag,{dma_busy,{2'b00,{io_cfg_buf_err,{3'b000,{cmd_num,16'h0}}}}}};
            end
            4'b0111 : begin
              prdata <= {cfg_intr_en,{3'b000,{cfg_dma_halt,{3'b000,{cfg_bf,{cfg_cf,22'h0}}}}}};
            end
            4'b1000 : begin
              prdata <= 32'h0;
            end
            4'b1001 : begin
              prdata <= 32'h0;
            end
            4'b1010 : begin
              prdata <= 32'h0;
            end
            4'b1011 : begin
              prdata <= {16'h5310,16'h0};
            end
            default : begin
              prdata <= 32'h0;
            end
          endcase
        end
      end
      fsm_stateReg <= fsm_stateNext;
    end
  end


endmodule
