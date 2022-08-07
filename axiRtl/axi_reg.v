// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : axi_reg
// Git hash  : 9c40920248c54b4106d59045a2d785d7f59e312f

`timescale 1ns/1ps

module axi_reg (
  input               io_axi_in_aw_valid,
  output              io_axi_in_aw_ready,
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
  output              io_axi_in_w_ready,
  input      [31:0]   io_axi_in_w_payload_data,
  input      [3:0]    io_axi_in_w_payload_strb,
  input               io_axi_in_w_payload_last,
  output              io_axi_in_b_valid,
  input               io_axi_in_b_ready,
  output     [3:0]    io_axi_in_b_payload_id,
  output     [1:0]    io_axi_in_b_payload_resp,
  input               io_axi_in_ar_valid,
  output              io_axi_in_ar_ready,
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
  output              io_axi_in_r_valid,
  input               io_axi_in_r_ready,
  output     [31:0]   io_axi_in_r_payload_data,
  output     [3:0]    io_axi_in_r_payload_id,
  output     [1:0]    io_axi_in_r_payload_resp,
  output              io_axi_in_r_payload_last,
  output              io_axi_out_aw_valid,
  input               io_axi_out_aw_ready,
  output     [31:0]   io_axi_out_aw_payload_addr,
  output     [3:0]    io_axi_out_aw_payload_id,
  output     [3:0]    io_axi_out_aw_payload_region,
  output     [7:0]    io_axi_out_aw_payload_len,
  output     [2:0]    io_axi_out_aw_payload_size,
  output     [1:0]    io_axi_out_aw_payload_burst,
  output     [0:0]    io_axi_out_aw_payload_lock,
  output     [3:0]    io_axi_out_aw_payload_cache,
  output     [3:0]    io_axi_out_aw_payload_qos,
  output     [2:0]    io_axi_out_aw_payload_prot,
  output              io_axi_out_w_valid,
  input               io_axi_out_w_ready,
  output     [31:0]   io_axi_out_w_payload_data,
  output     [3:0]    io_axi_out_w_payload_strb,
  output              io_axi_out_w_payload_last,
  input               io_axi_out_b_valid,
  output              io_axi_out_b_ready,
  input      [3:0]    io_axi_out_b_payload_id,
  input      [1:0]    io_axi_out_b_payload_resp,
  output              io_axi_out_ar_valid,
  input               io_axi_out_ar_ready,
  output     [31:0]   io_axi_out_ar_payload_addr,
  output     [3:0]    io_axi_out_ar_payload_id,
  output     [3:0]    io_axi_out_ar_payload_region,
  output     [7:0]    io_axi_out_ar_payload_len,
  output     [2:0]    io_axi_out_ar_payload_size,
  output     [1:0]    io_axi_out_ar_payload_burst,
  output     [0:0]    io_axi_out_ar_payload_lock,
  output     [3:0]    io_axi_out_ar_payload_cache,
  output     [3:0]    io_axi_out_ar_payload_qos,
  output     [2:0]    io_axi_out_ar_payload_prot,
  input               io_axi_out_r_valid,
  output              io_axi_out_r_ready,
  input      [31:0]   io_axi_out_r_payload_data,
  input      [3:0]    io_axi_out_r_payload_id,
  input      [1:0]    io_axi_out_r_payload_resp,
  input               io_axi_out_r_payload_last,
  input               clk,
  input               reset
);

  wire                io_axi_in_ar_s2mPipe_valid;
  reg                 io_axi_in_ar_s2mPipe_ready;
  wire       [31:0]   io_axi_in_ar_s2mPipe_payload_addr;
  wire       [3:0]    io_axi_in_ar_s2mPipe_payload_id;
  wire       [3:0]    io_axi_in_ar_s2mPipe_payload_region;
  wire       [7:0]    io_axi_in_ar_s2mPipe_payload_len;
  wire       [2:0]    io_axi_in_ar_s2mPipe_payload_size;
  wire       [1:0]    io_axi_in_ar_s2mPipe_payload_burst;
  wire       [0:0]    io_axi_in_ar_s2mPipe_payload_lock;
  wire       [3:0]    io_axi_in_ar_s2mPipe_payload_cache;
  wire       [3:0]    io_axi_in_ar_s2mPipe_payload_qos;
  wire       [2:0]    io_axi_in_ar_s2mPipe_payload_prot;
  reg                 io_axi_in_ar_rValid;
  reg        [31:0]   io_axi_in_ar_rData_addr;
  reg        [3:0]    io_axi_in_ar_rData_id;
  reg        [3:0]    io_axi_in_ar_rData_region;
  reg        [7:0]    io_axi_in_ar_rData_len;
  reg        [2:0]    io_axi_in_ar_rData_size;
  reg        [1:0]    io_axi_in_ar_rData_burst;
  reg        [0:0]    io_axi_in_ar_rData_lock;
  reg        [3:0]    io_axi_in_ar_rData_cache;
  reg        [3:0]    io_axi_in_ar_rData_qos;
  reg        [2:0]    io_axi_in_ar_rData_prot;
  wire                io_axi_in_ar_s2mPipe_m2sPipe_valid;
  wire                io_axi_in_ar_s2mPipe_m2sPipe_ready;
  wire       [31:0]   io_axi_in_ar_s2mPipe_m2sPipe_payload_addr;
  wire       [3:0]    io_axi_in_ar_s2mPipe_m2sPipe_payload_id;
  wire       [3:0]    io_axi_in_ar_s2mPipe_m2sPipe_payload_region;
  wire       [7:0]    io_axi_in_ar_s2mPipe_m2sPipe_payload_len;
  wire       [2:0]    io_axi_in_ar_s2mPipe_m2sPipe_payload_size;
  wire       [1:0]    io_axi_in_ar_s2mPipe_m2sPipe_payload_burst;
  wire       [0:0]    io_axi_in_ar_s2mPipe_m2sPipe_payload_lock;
  wire       [3:0]    io_axi_in_ar_s2mPipe_m2sPipe_payload_cache;
  wire       [3:0]    io_axi_in_ar_s2mPipe_m2sPipe_payload_qos;
  wire       [2:0]    io_axi_in_ar_s2mPipe_m2sPipe_payload_prot;
  reg                 io_axi_in_ar_s2mPipe_rValid;
  reg        [31:0]   io_axi_in_ar_s2mPipe_rData_addr;
  reg        [3:0]    io_axi_in_ar_s2mPipe_rData_id;
  reg        [3:0]    io_axi_in_ar_s2mPipe_rData_region;
  reg        [7:0]    io_axi_in_ar_s2mPipe_rData_len;
  reg        [2:0]    io_axi_in_ar_s2mPipe_rData_size;
  reg        [1:0]    io_axi_in_ar_s2mPipe_rData_burst;
  reg        [0:0]    io_axi_in_ar_s2mPipe_rData_lock;
  reg        [3:0]    io_axi_in_ar_s2mPipe_rData_cache;
  reg        [3:0]    io_axi_in_ar_s2mPipe_rData_qos;
  reg        [2:0]    io_axi_in_ar_s2mPipe_rData_prot;
  wire                when_Stream_l368;
  wire                io_axi_in_aw_s2mPipe_valid;
  reg                 io_axi_in_aw_s2mPipe_ready;
  wire       [31:0]   io_axi_in_aw_s2mPipe_payload_addr;
  wire       [3:0]    io_axi_in_aw_s2mPipe_payload_id;
  wire       [3:0]    io_axi_in_aw_s2mPipe_payload_region;
  wire       [7:0]    io_axi_in_aw_s2mPipe_payload_len;
  wire       [2:0]    io_axi_in_aw_s2mPipe_payload_size;
  wire       [1:0]    io_axi_in_aw_s2mPipe_payload_burst;
  wire       [0:0]    io_axi_in_aw_s2mPipe_payload_lock;
  wire       [3:0]    io_axi_in_aw_s2mPipe_payload_cache;
  wire       [3:0]    io_axi_in_aw_s2mPipe_payload_qos;
  wire       [2:0]    io_axi_in_aw_s2mPipe_payload_prot;
  reg                 io_axi_in_aw_rValid;
  reg        [31:0]   io_axi_in_aw_rData_addr;
  reg        [3:0]    io_axi_in_aw_rData_id;
  reg        [3:0]    io_axi_in_aw_rData_region;
  reg        [7:0]    io_axi_in_aw_rData_len;
  reg        [2:0]    io_axi_in_aw_rData_size;
  reg        [1:0]    io_axi_in_aw_rData_burst;
  reg        [0:0]    io_axi_in_aw_rData_lock;
  reg        [3:0]    io_axi_in_aw_rData_cache;
  reg        [3:0]    io_axi_in_aw_rData_qos;
  reg        [2:0]    io_axi_in_aw_rData_prot;
  wire                io_axi_in_aw_s2mPipe_m2sPipe_valid;
  wire                io_axi_in_aw_s2mPipe_m2sPipe_ready;
  wire       [31:0]   io_axi_in_aw_s2mPipe_m2sPipe_payload_addr;
  wire       [3:0]    io_axi_in_aw_s2mPipe_m2sPipe_payload_id;
  wire       [3:0]    io_axi_in_aw_s2mPipe_m2sPipe_payload_region;
  wire       [7:0]    io_axi_in_aw_s2mPipe_m2sPipe_payload_len;
  wire       [2:0]    io_axi_in_aw_s2mPipe_m2sPipe_payload_size;
  wire       [1:0]    io_axi_in_aw_s2mPipe_m2sPipe_payload_burst;
  wire       [0:0]    io_axi_in_aw_s2mPipe_m2sPipe_payload_lock;
  wire       [3:0]    io_axi_in_aw_s2mPipe_m2sPipe_payload_cache;
  wire       [3:0]    io_axi_in_aw_s2mPipe_m2sPipe_payload_qos;
  wire       [2:0]    io_axi_in_aw_s2mPipe_m2sPipe_payload_prot;
  reg                 io_axi_in_aw_s2mPipe_rValid;
  reg        [31:0]   io_axi_in_aw_s2mPipe_rData_addr;
  reg        [3:0]    io_axi_in_aw_s2mPipe_rData_id;
  reg        [3:0]    io_axi_in_aw_s2mPipe_rData_region;
  reg        [7:0]    io_axi_in_aw_s2mPipe_rData_len;
  reg        [2:0]    io_axi_in_aw_s2mPipe_rData_size;
  reg        [1:0]    io_axi_in_aw_s2mPipe_rData_burst;
  reg        [0:0]    io_axi_in_aw_s2mPipe_rData_lock;
  reg        [3:0]    io_axi_in_aw_s2mPipe_rData_cache;
  reg        [3:0]    io_axi_in_aw_s2mPipe_rData_qos;
  reg        [2:0]    io_axi_in_aw_s2mPipe_rData_prot;
  wire                when_Stream_l368_1;
  wire                io_axi_in_w_s2mPipe_valid;
  reg                 io_axi_in_w_s2mPipe_ready;
  wire       [31:0]   io_axi_in_w_s2mPipe_payload_data;
  wire       [3:0]    io_axi_in_w_s2mPipe_payload_strb;
  wire                io_axi_in_w_s2mPipe_payload_last;
  reg                 io_axi_in_w_rValid;
  reg        [31:0]   io_axi_in_w_rData_data;
  reg        [3:0]    io_axi_in_w_rData_strb;
  reg                 io_axi_in_w_rData_last;
  wire                io_axi_in_w_s2mPipe_m2sPipe_valid;
  wire                io_axi_in_w_s2mPipe_m2sPipe_ready;
  wire       [31:0]   io_axi_in_w_s2mPipe_m2sPipe_payload_data;
  wire       [3:0]    io_axi_in_w_s2mPipe_m2sPipe_payload_strb;
  wire                io_axi_in_w_s2mPipe_m2sPipe_payload_last;
  reg                 io_axi_in_w_s2mPipe_rValid;
  reg        [31:0]   io_axi_in_w_s2mPipe_rData_data;
  reg        [3:0]    io_axi_in_w_s2mPipe_rData_strb;
  reg                 io_axi_in_w_s2mPipe_rData_last;
  wire                when_Stream_l368_2;
  wire                io_axi_out_r_s2mPipe_valid;
  reg                 io_axi_out_r_s2mPipe_ready;
  wire       [31:0]   io_axi_out_r_s2mPipe_payload_data;
  wire       [3:0]    io_axi_out_r_s2mPipe_payload_id;
  wire       [1:0]    io_axi_out_r_s2mPipe_payload_resp;
  wire                io_axi_out_r_s2mPipe_payload_last;
  reg                 io_axi_out_r_rValid;
  reg        [31:0]   io_axi_out_r_rData_data;
  reg        [3:0]    io_axi_out_r_rData_id;
  reg        [1:0]    io_axi_out_r_rData_resp;
  reg                 io_axi_out_r_rData_last;
  wire                io_axi_out_r_s2mPipe_m2sPipe_valid;
  wire                io_axi_out_r_s2mPipe_m2sPipe_ready;
  wire       [31:0]   io_axi_out_r_s2mPipe_m2sPipe_payload_data;
  wire       [3:0]    io_axi_out_r_s2mPipe_m2sPipe_payload_id;
  wire       [1:0]    io_axi_out_r_s2mPipe_m2sPipe_payload_resp;
  wire                io_axi_out_r_s2mPipe_m2sPipe_payload_last;
  reg                 io_axi_out_r_s2mPipe_rValid;
  reg        [31:0]   io_axi_out_r_s2mPipe_rData_data;
  reg        [3:0]    io_axi_out_r_s2mPipe_rData_id;
  reg        [1:0]    io_axi_out_r_s2mPipe_rData_resp;
  reg                 io_axi_out_r_s2mPipe_rData_last;
  wire                when_Stream_l368_3;
  wire                io_axi_out_b_s2mPipe_valid;
  reg                 io_axi_out_b_s2mPipe_ready;
  wire       [3:0]    io_axi_out_b_s2mPipe_payload_id;
  wire       [1:0]    io_axi_out_b_s2mPipe_payload_resp;
  reg                 io_axi_out_b_rValid;
  reg        [3:0]    io_axi_out_b_rData_id;
  reg        [1:0]    io_axi_out_b_rData_resp;
  wire                io_axi_out_b_s2mPipe_m2sPipe_valid;
  wire                io_axi_out_b_s2mPipe_m2sPipe_ready;
  wire       [3:0]    io_axi_out_b_s2mPipe_m2sPipe_payload_id;
  wire       [1:0]    io_axi_out_b_s2mPipe_m2sPipe_payload_resp;
  reg                 io_axi_out_b_s2mPipe_rValid;
  reg        [3:0]    io_axi_out_b_s2mPipe_rData_id;
  reg        [1:0]    io_axi_out_b_s2mPipe_rData_resp;
  wire                when_Stream_l368_4;

  assign io_axi_in_ar_ready = (! io_axi_in_ar_rValid);
  assign io_axi_in_ar_s2mPipe_valid = (io_axi_in_ar_valid || io_axi_in_ar_rValid);
  assign io_axi_in_ar_s2mPipe_payload_addr = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_addr : io_axi_in_ar_payload_addr);
  assign io_axi_in_ar_s2mPipe_payload_id = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_id : io_axi_in_ar_payload_id);
  assign io_axi_in_ar_s2mPipe_payload_region = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_region : io_axi_in_ar_payload_region);
  assign io_axi_in_ar_s2mPipe_payload_len = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_len : io_axi_in_ar_payload_len);
  assign io_axi_in_ar_s2mPipe_payload_size = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_size : io_axi_in_ar_payload_size);
  assign io_axi_in_ar_s2mPipe_payload_burst = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_burst : io_axi_in_ar_payload_burst);
  assign io_axi_in_ar_s2mPipe_payload_lock = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_lock : io_axi_in_ar_payload_lock);
  assign io_axi_in_ar_s2mPipe_payload_cache = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_cache : io_axi_in_ar_payload_cache);
  assign io_axi_in_ar_s2mPipe_payload_qos = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_qos : io_axi_in_ar_payload_qos);
  assign io_axi_in_ar_s2mPipe_payload_prot = (io_axi_in_ar_rValid ? io_axi_in_ar_rData_prot : io_axi_in_ar_payload_prot);
  always @(*) begin
    io_axi_in_ar_s2mPipe_ready = io_axi_in_ar_s2mPipe_m2sPipe_ready;
    if(when_Stream_l368) begin
      io_axi_in_ar_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l368 = (! io_axi_in_ar_s2mPipe_m2sPipe_valid);
  assign io_axi_in_ar_s2mPipe_m2sPipe_valid = io_axi_in_ar_s2mPipe_rValid;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_addr = io_axi_in_ar_s2mPipe_rData_addr;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_id = io_axi_in_ar_s2mPipe_rData_id;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_region = io_axi_in_ar_s2mPipe_rData_region;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_len = io_axi_in_ar_s2mPipe_rData_len;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_size = io_axi_in_ar_s2mPipe_rData_size;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_burst = io_axi_in_ar_s2mPipe_rData_burst;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_lock = io_axi_in_ar_s2mPipe_rData_lock;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_cache = io_axi_in_ar_s2mPipe_rData_cache;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_qos = io_axi_in_ar_s2mPipe_rData_qos;
  assign io_axi_in_ar_s2mPipe_m2sPipe_payload_prot = io_axi_in_ar_s2mPipe_rData_prot;
  assign io_axi_out_ar_valid = io_axi_in_ar_s2mPipe_m2sPipe_valid;
  assign io_axi_in_ar_s2mPipe_m2sPipe_ready = io_axi_out_ar_ready;
  assign io_axi_out_ar_payload_addr = io_axi_in_ar_s2mPipe_m2sPipe_payload_addr;
  assign io_axi_out_ar_payload_id = io_axi_in_ar_s2mPipe_m2sPipe_payload_id;
  assign io_axi_out_ar_payload_region = io_axi_in_ar_s2mPipe_m2sPipe_payload_region;
  assign io_axi_out_ar_payload_len = io_axi_in_ar_s2mPipe_m2sPipe_payload_len;
  assign io_axi_out_ar_payload_size = io_axi_in_ar_s2mPipe_m2sPipe_payload_size;
  assign io_axi_out_ar_payload_burst = io_axi_in_ar_s2mPipe_m2sPipe_payload_burst;
  assign io_axi_out_ar_payload_lock = io_axi_in_ar_s2mPipe_m2sPipe_payload_lock;
  assign io_axi_out_ar_payload_cache = io_axi_in_ar_s2mPipe_m2sPipe_payload_cache;
  assign io_axi_out_ar_payload_qos = io_axi_in_ar_s2mPipe_m2sPipe_payload_qos;
  assign io_axi_out_ar_payload_prot = io_axi_in_ar_s2mPipe_m2sPipe_payload_prot;
  assign io_axi_in_aw_ready = (! io_axi_in_aw_rValid);
  assign io_axi_in_aw_s2mPipe_valid = (io_axi_in_aw_valid || io_axi_in_aw_rValid);
  assign io_axi_in_aw_s2mPipe_payload_addr = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_addr : io_axi_in_aw_payload_addr);
  assign io_axi_in_aw_s2mPipe_payload_id = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_id : io_axi_in_aw_payload_id);
  assign io_axi_in_aw_s2mPipe_payload_region = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_region : io_axi_in_aw_payload_region);
  assign io_axi_in_aw_s2mPipe_payload_len = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_len : io_axi_in_aw_payload_len);
  assign io_axi_in_aw_s2mPipe_payload_size = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_size : io_axi_in_aw_payload_size);
  assign io_axi_in_aw_s2mPipe_payload_burst = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_burst : io_axi_in_aw_payload_burst);
  assign io_axi_in_aw_s2mPipe_payload_lock = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_lock : io_axi_in_aw_payload_lock);
  assign io_axi_in_aw_s2mPipe_payload_cache = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_cache : io_axi_in_aw_payload_cache);
  assign io_axi_in_aw_s2mPipe_payload_qos = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_qos : io_axi_in_aw_payload_qos);
  assign io_axi_in_aw_s2mPipe_payload_prot = (io_axi_in_aw_rValid ? io_axi_in_aw_rData_prot : io_axi_in_aw_payload_prot);
  always @(*) begin
    io_axi_in_aw_s2mPipe_ready = io_axi_in_aw_s2mPipe_m2sPipe_ready;
    if(when_Stream_l368_1) begin
      io_axi_in_aw_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l368_1 = (! io_axi_in_aw_s2mPipe_m2sPipe_valid);
  assign io_axi_in_aw_s2mPipe_m2sPipe_valid = io_axi_in_aw_s2mPipe_rValid;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_addr = io_axi_in_aw_s2mPipe_rData_addr;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_id = io_axi_in_aw_s2mPipe_rData_id;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_region = io_axi_in_aw_s2mPipe_rData_region;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_len = io_axi_in_aw_s2mPipe_rData_len;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_size = io_axi_in_aw_s2mPipe_rData_size;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_burst = io_axi_in_aw_s2mPipe_rData_burst;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_lock = io_axi_in_aw_s2mPipe_rData_lock;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_cache = io_axi_in_aw_s2mPipe_rData_cache;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_qos = io_axi_in_aw_s2mPipe_rData_qos;
  assign io_axi_in_aw_s2mPipe_m2sPipe_payload_prot = io_axi_in_aw_s2mPipe_rData_prot;
  assign io_axi_out_aw_valid = io_axi_in_aw_s2mPipe_m2sPipe_valid;
  assign io_axi_in_aw_s2mPipe_m2sPipe_ready = io_axi_out_aw_ready;
  assign io_axi_out_aw_payload_addr = io_axi_in_aw_s2mPipe_m2sPipe_payload_addr;
  assign io_axi_out_aw_payload_id = io_axi_in_aw_s2mPipe_m2sPipe_payload_id;
  assign io_axi_out_aw_payload_region = io_axi_in_aw_s2mPipe_m2sPipe_payload_region;
  assign io_axi_out_aw_payload_len = io_axi_in_aw_s2mPipe_m2sPipe_payload_len;
  assign io_axi_out_aw_payload_size = io_axi_in_aw_s2mPipe_m2sPipe_payload_size;
  assign io_axi_out_aw_payload_burst = io_axi_in_aw_s2mPipe_m2sPipe_payload_burst;
  assign io_axi_out_aw_payload_lock = io_axi_in_aw_s2mPipe_m2sPipe_payload_lock;
  assign io_axi_out_aw_payload_cache = io_axi_in_aw_s2mPipe_m2sPipe_payload_cache;
  assign io_axi_out_aw_payload_qos = io_axi_in_aw_s2mPipe_m2sPipe_payload_qos;
  assign io_axi_out_aw_payload_prot = io_axi_in_aw_s2mPipe_m2sPipe_payload_prot;
  assign io_axi_in_w_ready = (! io_axi_in_w_rValid);
  assign io_axi_in_w_s2mPipe_valid = (io_axi_in_w_valid || io_axi_in_w_rValid);
  assign io_axi_in_w_s2mPipe_payload_data = (io_axi_in_w_rValid ? io_axi_in_w_rData_data : io_axi_in_w_payload_data);
  assign io_axi_in_w_s2mPipe_payload_strb = (io_axi_in_w_rValid ? io_axi_in_w_rData_strb : io_axi_in_w_payload_strb);
  assign io_axi_in_w_s2mPipe_payload_last = (io_axi_in_w_rValid ? io_axi_in_w_rData_last : io_axi_in_w_payload_last);
  always @(*) begin
    io_axi_in_w_s2mPipe_ready = io_axi_in_w_s2mPipe_m2sPipe_ready;
    if(when_Stream_l368_2) begin
      io_axi_in_w_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l368_2 = (! io_axi_in_w_s2mPipe_m2sPipe_valid);
  assign io_axi_in_w_s2mPipe_m2sPipe_valid = io_axi_in_w_s2mPipe_rValid;
  assign io_axi_in_w_s2mPipe_m2sPipe_payload_data = io_axi_in_w_s2mPipe_rData_data;
  assign io_axi_in_w_s2mPipe_m2sPipe_payload_strb = io_axi_in_w_s2mPipe_rData_strb;
  assign io_axi_in_w_s2mPipe_m2sPipe_payload_last = io_axi_in_w_s2mPipe_rData_last;
  assign io_axi_out_w_valid = io_axi_in_w_s2mPipe_m2sPipe_valid;
  assign io_axi_in_w_s2mPipe_m2sPipe_ready = io_axi_out_w_ready;
  assign io_axi_out_w_payload_data = io_axi_in_w_s2mPipe_m2sPipe_payload_data;
  assign io_axi_out_w_payload_strb = io_axi_in_w_s2mPipe_m2sPipe_payload_strb;
  assign io_axi_out_w_payload_last = io_axi_in_w_s2mPipe_m2sPipe_payload_last;
  assign io_axi_out_r_ready = (! io_axi_out_r_rValid);
  assign io_axi_out_r_s2mPipe_valid = (io_axi_out_r_valid || io_axi_out_r_rValid);
  assign io_axi_out_r_s2mPipe_payload_data = (io_axi_out_r_rValid ? io_axi_out_r_rData_data : io_axi_out_r_payload_data);
  assign io_axi_out_r_s2mPipe_payload_id = (io_axi_out_r_rValid ? io_axi_out_r_rData_id : io_axi_out_r_payload_id);
  assign io_axi_out_r_s2mPipe_payload_resp = (io_axi_out_r_rValid ? io_axi_out_r_rData_resp : io_axi_out_r_payload_resp);
  assign io_axi_out_r_s2mPipe_payload_last = (io_axi_out_r_rValid ? io_axi_out_r_rData_last : io_axi_out_r_payload_last);
  always @(*) begin
    io_axi_out_r_s2mPipe_ready = io_axi_out_r_s2mPipe_m2sPipe_ready;
    if(when_Stream_l368_3) begin
      io_axi_out_r_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l368_3 = (! io_axi_out_r_s2mPipe_m2sPipe_valid);
  assign io_axi_out_r_s2mPipe_m2sPipe_valid = io_axi_out_r_s2mPipe_rValid;
  assign io_axi_out_r_s2mPipe_m2sPipe_payload_data = io_axi_out_r_s2mPipe_rData_data;
  assign io_axi_out_r_s2mPipe_m2sPipe_payload_id = io_axi_out_r_s2mPipe_rData_id;
  assign io_axi_out_r_s2mPipe_m2sPipe_payload_resp = io_axi_out_r_s2mPipe_rData_resp;
  assign io_axi_out_r_s2mPipe_m2sPipe_payload_last = io_axi_out_r_s2mPipe_rData_last;
  assign io_axi_in_r_valid = io_axi_out_r_s2mPipe_m2sPipe_valid;
  assign io_axi_out_r_s2mPipe_m2sPipe_ready = io_axi_in_r_ready;
  assign io_axi_in_r_payload_data = io_axi_out_r_s2mPipe_m2sPipe_payload_data;
  assign io_axi_in_r_payload_id = io_axi_out_r_s2mPipe_m2sPipe_payload_id;
  assign io_axi_in_r_payload_resp = io_axi_out_r_s2mPipe_m2sPipe_payload_resp;
  assign io_axi_in_r_payload_last = io_axi_out_r_s2mPipe_m2sPipe_payload_last;
  assign io_axi_out_b_ready = (! io_axi_out_b_rValid);
  assign io_axi_out_b_s2mPipe_valid = (io_axi_out_b_valid || io_axi_out_b_rValid);
  assign io_axi_out_b_s2mPipe_payload_id = (io_axi_out_b_rValid ? io_axi_out_b_rData_id : io_axi_out_b_payload_id);
  assign io_axi_out_b_s2mPipe_payload_resp = (io_axi_out_b_rValid ? io_axi_out_b_rData_resp : io_axi_out_b_payload_resp);
  always @(*) begin
    io_axi_out_b_s2mPipe_ready = io_axi_out_b_s2mPipe_m2sPipe_ready;
    if(when_Stream_l368_4) begin
      io_axi_out_b_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l368_4 = (! io_axi_out_b_s2mPipe_m2sPipe_valid);
  assign io_axi_out_b_s2mPipe_m2sPipe_valid = io_axi_out_b_s2mPipe_rValid;
  assign io_axi_out_b_s2mPipe_m2sPipe_payload_id = io_axi_out_b_s2mPipe_rData_id;
  assign io_axi_out_b_s2mPipe_m2sPipe_payload_resp = io_axi_out_b_s2mPipe_rData_resp;
  assign io_axi_in_b_valid = io_axi_out_b_s2mPipe_m2sPipe_valid;
  assign io_axi_out_b_s2mPipe_m2sPipe_ready = io_axi_in_b_ready;
  assign io_axi_in_b_payload_id = io_axi_out_b_s2mPipe_m2sPipe_payload_id;
  assign io_axi_in_b_payload_resp = io_axi_out_b_s2mPipe_m2sPipe_payload_resp;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_axi_in_ar_rValid <= 1'b0;
      io_axi_in_ar_s2mPipe_rValid <= 1'b0;
      io_axi_in_aw_rValid <= 1'b0;
      io_axi_in_aw_s2mPipe_rValid <= 1'b0;
      io_axi_in_w_rValid <= 1'b0;
      io_axi_in_w_s2mPipe_rValid <= 1'b0;
      io_axi_out_r_rValid <= 1'b0;
      io_axi_out_r_s2mPipe_rValid <= 1'b0;
      io_axi_out_b_rValid <= 1'b0;
      io_axi_out_b_s2mPipe_rValid <= 1'b0;
    end else begin
      if(io_axi_in_ar_valid) begin
        io_axi_in_ar_rValid <= 1'b1;
      end
      if(io_axi_in_ar_s2mPipe_ready) begin
        io_axi_in_ar_rValid <= 1'b0;
      end
      if(io_axi_in_ar_s2mPipe_ready) begin
        io_axi_in_ar_s2mPipe_rValid <= io_axi_in_ar_s2mPipe_valid;
      end
      if(io_axi_in_aw_valid) begin
        io_axi_in_aw_rValid <= 1'b1;
      end
      if(io_axi_in_aw_s2mPipe_ready) begin
        io_axi_in_aw_rValid <= 1'b0;
      end
      if(io_axi_in_aw_s2mPipe_ready) begin
        io_axi_in_aw_s2mPipe_rValid <= io_axi_in_aw_s2mPipe_valid;
      end
      if(io_axi_in_w_valid) begin
        io_axi_in_w_rValid <= 1'b1;
      end
      if(io_axi_in_w_s2mPipe_ready) begin
        io_axi_in_w_rValid <= 1'b0;
      end
      if(io_axi_in_w_s2mPipe_ready) begin
        io_axi_in_w_s2mPipe_rValid <= io_axi_in_w_s2mPipe_valid;
      end
      if(io_axi_out_r_valid) begin
        io_axi_out_r_rValid <= 1'b1;
      end
      if(io_axi_out_r_s2mPipe_ready) begin
        io_axi_out_r_rValid <= 1'b0;
      end
      if(io_axi_out_r_s2mPipe_ready) begin
        io_axi_out_r_s2mPipe_rValid <= io_axi_out_r_s2mPipe_valid;
      end
      if(io_axi_out_b_valid) begin
        io_axi_out_b_rValid <= 1'b1;
      end
      if(io_axi_out_b_s2mPipe_ready) begin
        io_axi_out_b_rValid <= 1'b0;
      end
      if(io_axi_out_b_s2mPipe_ready) begin
        io_axi_out_b_s2mPipe_rValid <= io_axi_out_b_s2mPipe_valid;
      end
    end
  end

  always @(posedge clk) begin
    if(io_axi_in_ar_ready) begin
      io_axi_in_ar_rData_addr <= io_axi_in_ar_payload_addr;
      io_axi_in_ar_rData_id <= io_axi_in_ar_payload_id;
      io_axi_in_ar_rData_region <= io_axi_in_ar_payload_region;
      io_axi_in_ar_rData_len <= io_axi_in_ar_payload_len;
      io_axi_in_ar_rData_size <= io_axi_in_ar_payload_size;
      io_axi_in_ar_rData_burst <= io_axi_in_ar_payload_burst;
      io_axi_in_ar_rData_lock <= io_axi_in_ar_payload_lock;
      io_axi_in_ar_rData_cache <= io_axi_in_ar_payload_cache;
      io_axi_in_ar_rData_qos <= io_axi_in_ar_payload_qos;
      io_axi_in_ar_rData_prot <= io_axi_in_ar_payload_prot;
    end
    if(io_axi_in_ar_s2mPipe_ready) begin
      io_axi_in_ar_s2mPipe_rData_addr <= io_axi_in_ar_s2mPipe_payload_addr;
      io_axi_in_ar_s2mPipe_rData_id <= io_axi_in_ar_s2mPipe_payload_id;
      io_axi_in_ar_s2mPipe_rData_region <= io_axi_in_ar_s2mPipe_payload_region;
      io_axi_in_ar_s2mPipe_rData_len <= io_axi_in_ar_s2mPipe_payload_len;
      io_axi_in_ar_s2mPipe_rData_size <= io_axi_in_ar_s2mPipe_payload_size;
      io_axi_in_ar_s2mPipe_rData_burst <= io_axi_in_ar_s2mPipe_payload_burst;
      io_axi_in_ar_s2mPipe_rData_lock <= io_axi_in_ar_s2mPipe_payload_lock;
      io_axi_in_ar_s2mPipe_rData_cache <= io_axi_in_ar_s2mPipe_payload_cache;
      io_axi_in_ar_s2mPipe_rData_qos <= io_axi_in_ar_s2mPipe_payload_qos;
      io_axi_in_ar_s2mPipe_rData_prot <= io_axi_in_ar_s2mPipe_payload_prot;
    end
    if(io_axi_in_aw_ready) begin
      io_axi_in_aw_rData_addr <= io_axi_in_aw_payload_addr;
      io_axi_in_aw_rData_id <= io_axi_in_aw_payload_id;
      io_axi_in_aw_rData_region <= io_axi_in_aw_payload_region;
      io_axi_in_aw_rData_len <= io_axi_in_aw_payload_len;
      io_axi_in_aw_rData_size <= io_axi_in_aw_payload_size;
      io_axi_in_aw_rData_burst <= io_axi_in_aw_payload_burst;
      io_axi_in_aw_rData_lock <= io_axi_in_aw_payload_lock;
      io_axi_in_aw_rData_cache <= io_axi_in_aw_payload_cache;
      io_axi_in_aw_rData_qos <= io_axi_in_aw_payload_qos;
      io_axi_in_aw_rData_prot <= io_axi_in_aw_payload_prot;
    end
    if(io_axi_in_aw_s2mPipe_ready) begin
      io_axi_in_aw_s2mPipe_rData_addr <= io_axi_in_aw_s2mPipe_payload_addr;
      io_axi_in_aw_s2mPipe_rData_id <= io_axi_in_aw_s2mPipe_payload_id;
      io_axi_in_aw_s2mPipe_rData_region <= io_axi_in_aw_s2mPipe_payload_region;
      io_axi_in_aw_s2mPipe_rData_len <= io_axi_in_aw_s2mPipe_payload_len;
      io_axi_in_aw_s2mPipe_rData_size <= io_axi_in_aw_s2mPipe_payload_size;
      io_axi_in_aw_s2mPipe_rData_burst <= io_axi_in_aw_s2mPipe_payload_burst;
      io_axi_in_aw_s2mPipe_rData_lock <= io_axi_in_aw_s2mPipe_payload_lock;
      io_axi_in_aw_s2mPipe_rData_cache <= io_axi_in_aw_s2mPipe_payload_cache;
      io_axi_in_aw_s2mPipe_rData_qos <= io_axi_in_aw_s2mPipe_payload_qos;
      io_axi_in_aw_s2mPipe_rData_prot <= io_axi_in_aw_s2mPipe_payload_prot;
    end
    if(io_axi_in_w_ready) begin
      io_axi_in_w_rData_data <= io_axi_in_w_payload_data;
      io_axi_in_w_rData_strb <= io_axi_in_w_payload_strb;
      io_axi_in_w_rData_last <= io_axi_in_w_payload_last;
    end
    if(io_axi_in_w_s2mPipe_ready) begin
      io_axi_in_w_s2mPipe_rData_data <= io_axi_in_w_s2mPipe_payload_data;
      io_axi_in_w_s2mPipe_rData_strb <= io_axi_in_w_s2mPipe_payload_strb;
      io_axi_in_w_s2mPipe_rData_last <= io_axi_in_w_s2mPipe_payload_last;
    end
    if(io_axi_out_r_ready) begin
      io_axi_out_r_rData_data <= io_axi_out_r_payload_data;
      io_axi_out_r_rData_id <= io_axi_out_r_payload_id;
      io_axi_out_r_rData_resp <= io_axi_out_r_payload_resp;
      io_axi_out_r_rData_last <= io_axi_out_r_payload_last;
    end
    if(io_axi_out_r_s2mPipe_ready) begin
      io_axi_out_r_s2mPipe_rData_data <= io_axi_out_r_s2mPipe_payload_data;
      io_axi_out_r_s2mPipe_rData_id <= io_axi_out_r_s2mPipe_payload_id;
      io_axi_out_r_s2mPipe_rData_resp <= io_axi_out_r_s2mPipe_payload_resp;
      io_axi_out_r_s2mPipe_rData_last <= io_axi_out_r_s2mPipe_payload_last;
    end
    if(io_axi_out_b_ready) begin
      io_axi_out_b_rData_id <= io_axi_out_b_payload_id;
      io_axi_out_b_rData_resp <= io_axi_out_b_payload_resp;
    end
    if(io_axi_out_b_s2mPipe_ready) begin
      io_axi_out_b_s2mPipe_rData_id <= io_axi_out_b_s2mPipe_payload_id;
      io_axi_out_b_s2mPipe_rData_resp <= io_axi_out_b_s2mPipe_payload_resp;
    end
  end


endmodule
