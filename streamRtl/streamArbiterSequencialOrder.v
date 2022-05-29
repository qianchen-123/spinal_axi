// Generator : SpinalHDL v1.7.0a    git head : 150a9b9067020722818dfb17df4a23ac712a7af8
// Component : streamArbiterSequencialOrder
// Git hash  : 3a903e741cbbe310a98c75dc1ebbd289cb1c87a4

`timescale 1ns/1ps

module streamArbiterSequencialOrder (
  input               io_s_in_0_valid,
  output              io_s_in_0_ready,
  input      [31:0]   io_s_in_0_payload,
  input               io_s_in_1_valid,
  output              io_s_in_1_ready,
  input      [31:0]   io_s_in_1_payload,
  input               io_s_in_2_valid,
  output              io_s_in_2_ready,
  input      [31:0]   io_s_in_2_payload,
  input               io_s_in_3_valid,
  output              io_s_in_3_ready,
  input      [31:0]   io_s_in_3_payload,
  output              io_m_out_valid,
  input               io_m_out_ready,
  output     [31:0]   io_m_out_payload,
  input               clk,
  input               reset
);

  wire                streamArbiter_1_io_output_ready;
  wire                streamArbiter_1_io_inputs_0_ready;
  wire                streamArbiter_1_io_inputs_1_ready;
  wire                streamArbiter_1_io_inputs_2_ready;
  wire                streamArbiter_1_io_inputs_3_ready;
  wire                streamArbiter_1_io_output_valid;
  wire       [31:0]   streamArbiter_1_io_output_payload;
  wire       [1:0]    streamArbiter_1_io_chosen;
  wire       [3:0]    streamArbiter_1_io_chosenOH;
  wire                streamArbiter_1_io_output_s2mPipe_valid;
  reg                 streamArbiter_1_io_output_s2mPipe_ready;
  wire       [31:0]   streamArbiter_1_io_output_s2mPipe_payload;
  reg                 streamArbiter_1_io_output_rValid;
  reg        [31:0]   streamArbiter_1_io_output_rData;
  wire                streamArbiter_1_io_output_s2mPipe_m2sPipe_valid;
  wire                streamArbiter_1_io_output_s2mPipe_m2sPipe_ready;
  wire       [31:0]   streamArbiter_1_io_output_s2mPipe_m2sPipe_payload;
  reg                 streamArbiter_1_io_output_s2mPipe_rValid;
  reg        [31:0]   streamArbiter_1_io_output_s2mPipe_rData;
  wire                when_Stream_l368;

  StreamArbiter streamArbiter_1 (
    .io_inputs_0_valid   (io_s_in_0_valid                        ), //i
    .io_inputs_0_ready   (streamArbiter_1_io_inputs_0_ready      ), //o
    .io_inputs_0_payload (io_s_in_0_payload[31:0]                ), //i
    .io_inputs_1_valid   (io_s_in_1_valid                        ), //i
    .io_inputs_1_ready   (streamArbiter_1_io_inputs_1_ready      ), //o
    .io_inputs_1_payload (io_s_in_1_payload[31:0]                ), //i
    .io_inputs_2_valid   (io_s_in_2_valid                        ), //i
    .io_inputs_2_ready   (streamArbiter_1_io_inputs_2_ready      ), //o
    .io_inputs_2_payload (io_s_in_2_payload[31:0]                ), //i
    .io_inputs_3_valid   (io_s_in_3_valid                        ), //i
    .io_inputs_3_ready   (streamArbiter_1_io_inputs_3_ready      ), //o
    .io_inputs_3_payload (io_s_in_3_payload[31:0]                ), //i
    .io_output_valid     (streamArbiter_1_io_output_valid        ), //o
    .io_output_ready     (streamArbiter_1_io_output_ready        ), //i
    .io_output_payload   (streamArbiter_1_io_output_payload[31:0]), //o
    .io_chosen           (streamArbiter_1_io_chosen[1:0]         ), //o
    .io_chosenOH         (streamArbiter_1_io_chosenOH[3:0]       ), //o
    .clk                 (clk                                    ), //i
    .reset               (reset                                  )  //i
  );
  assign io_s_in_0_ready = streamArbiter_1_io_inputs_0_ready;
  assign io_s_in_1_ready = streamArbiter_1_io_inputs_1_ready;
  assign io_s_in_2_ready = streamArbiter_1_io_inputs_2_ready;
  assign io_s_in_3_ready = streamArbiter_1_io_inputs_3_ready;
  assign streamArbiter_1_io_output_ready = (! streamArbiter_1_io_output_rValid);
  assign streamArbiter_1_io_output_s2mPipe_valid = (streamArbiter_1_io_output_valid || streamArbiter_1_io_output_rValid);
  assign streamArbiter_1_io_output_s2mPipe_payload = (streamArbiter_1_io_output_rValid ? streamArbiter_1_io_output_rData : streamArbiter_1_io_output_payload);
  always @(*) begin
    streamArbiter_1_io_output_s2mPipe_ready = streamArbiter_1_io_output_s2mPipe_m2sPipe_ready;
    if(when_Stream_l368) begin
      streamArbiter_1_io_output_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l368 = (! streamArbiter_1_io_output_s2mPipe_m2sPipe_valid);
  assign streamArbiter_1_io_output_s2mPipe_m2sPipe_valid = streamArbiter_1_io_output_s2mPipe_rValid;
  assign streamArbiter_1_io_output_s2mPipe_m2sPipe_payload = streamArbiter_1_io_output_s2mPipe_rData;
  assign io_m_out_valid = streamArbiter_1_io_output_s2mPipe_m2sPipe_valid;
  assign streamArbiter_1_io_output_s2mPipe_m2sPipe_ready = io_m_out_ready;
  assign io_m_out_payload = streamArbiter_1_io_output_s2mPipe_m2sPipe_payload;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      streamArbiter_1_io_output_rValid <= 1'b0;
      streamArbiter_1_io_output_s2mPipe_rValid <= 1'b0;
    end else begin
      if(streamArbiter_1_io_output_valid) begin
        streamArbiter_1_io_output_rValid <= 1'b1;
      end
      if(streamArbiter_1_io_output_s2mPipe_ready) begin
        streamArbiter_1_io_output_rValid <= 1'b0;
      end
      if(streamArbiter_1_io_output_s2mPipe_ready) begin
        streamArbiter_1_io_output_s2mPipe_rValid <= streamArbiter_1_io_output_s2mPipe_valid;
      end
    end
  end

  always @(posedge clk) begin
    if(streamArbiter_1_io_output_ready) begin
      streamArbiter_1_io_output_rData <= streamArbiter_1_io_output_payload;
    end
    if(streamArbiter_1_io_output_s2mPipe_ready) begin
      streamArbiter_1_io_output_s2mPipe_rData <= streamArbiter_1_io_output_s2mPipe_payload;
    end
  end


endmodule

module StreamArbiter (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      [31:0]   io_inputs_0_payload,
  input               io_inputs_1_valid,
  output              io_inputs_1_ready,
  input      [31:0]   io_inputs_1_payload,
  input               io_inputs_2_valid,
  output              io_inputs_2_ready,
  input      [31:0]   io_inputs_2_payload,
  input               io_inputs_3_valid,
  output              io_inputs_3_ready,
  input      [31:0]   io_inputs_3_payload,
  output              io_output_valid,
  input               io_output_ready,
  output     [31:0]   io_output_payload,
  output     [1:0]    io_chosen,
  output     [3:0]    io_chosenOH,
  input               clk,
  input               reset
);

  wire       [1:0]    _zz_arbitration_counter_valueNext;
  wire       [0:0]    _zz_arbitration_counter_valueNext_1;
  reg        [31:0]   _zz_io_output_payload_2;
  wire       [1:0]    _zz_io_output_payload_3;
  reg                 locked;
  reg                 maskProposal_0;
  reg                 maskProposal_1;
  reg                 maskProposal_2;
  reg                 maskProposal_3;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  reg                 maskLocked_2;
  reg                 maskLocked_3;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire                maskRouted_2;
  wire                maskRouted_3;
  wire                io_output_fire;
  reg                 arbitration_counter_willIncrement;
  wire                arbitration_counter_willClear;
  reg        [1:0]    arbitration_counter_valueNext;
  reg        [1:0]    arbitration_counter_value;
  wire                arbitration_counter_willOverflowIfInc;
  wire                arbitration_counter_willOverflow;
  wire       [3:0]    _zz_1;
  wire                io_output_fire_1;
  wire                _zz_io_output_payload;
  wire                _zz_io_output_payload_1;
  wire                _zz_io_chosen;
  wire                _zz_io_chosen_1;
  wire                _zz_io_chosen_2;

  assign _zz_arbitration_counter_valueNext_1 = arbitration_counter_willIncrement;
  assign _zz_arbitration_counter_valueNext = {1'd0, _zz_arbitration_counter_valueNext_1};
  assign _zz_io_output_payload_3 = {_zz_io_output_payload_1,_zz_io_output_payload};
  always @(*) begin
    case(_zz_io_output_payload_3)
      2'b00 : _zz_io_output_payload_2 = io_inputs_0_payload;
      2'b01 : _zz_io_output_payload_2 = io_inputs_1_payload;
      2'b10 : _zz_io_output_payload_2 = io_inputs_2_payload;
      default : _zz_io_output_payload_2 = io_inputs_3_payload;
    endcase
  end

  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign maskRouted_2 = (locked ? maskLocked_2 : maskProposal_2);
  assign maskRouted_3 = (locked ? maskLocked_3 : maskProposal_3);
  assign io_output_fire = (io_output_valid && io_output_ready);
  always @(*) begin
    arbitration_counter_willIncrement = 1'b0;
    if(io_output_fire) begin
      arbitration_counter_willIncrement = 1'b1;
    end
  end

  assign arbitration_counter_willClear = 1'b0;
  assign arbitration_counter_willOverflowIfInc = (arbitration_counter_value == 2'b11);
  assign arbitration_counter_willOverflow = (arbitration_counter_willOverflowIfInc && arbitration_counter_willIncrement);
  always @(*) begin
    arbitration_counter_valueNext = (arbitration_counter_value + _zz_arbitration_counter_valueNext);
    if(arbitration_counter_willClear) begin
      arbitration_counter_valueNext = 2'b00;
    end
  end

  always @(*) begin
    maskProposal_0 = 1'b0;
    if(_zz_1[0]) begin
      maskProposal_0 = 1'b1;
    end
  end

  always @(*) begin
    maskProposal_1 = 1'b0;
    if(_zz_1[1]) begin
      maskProposal_1 = 1'b1;
    end
  end

  always @(*) begin
    maskProposal_2 = 1'b0;
    if(_zz_1[2]) begin
      maskProposal_2 = 1'b1;
    end
  end

  always @(*) begin
    maskProposal_3 = 1'b0;
    if(_zz_1[3]) begin
      maskProposal_3 = 1'b1;
    end
  end

  assign _zz_1 = ({3'd0,1'b1} <<< arbitration_counter_value);
  assign io_output_fire_1 = (io_output_valid && io_output_ready);
  assign io_output_valid = ((((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1)) || (io_inputs_2_valid && maskRouted_2)) || (io_inputs_3_valid && maskRouted_3));
  assign _zz_io_output_payload = (maskRouted_1 || maskRouted_3);
  assign _zz_io_output_payload_1 = (maskRouted_2 || maskRouted_3);
  assign io_output_payload = _zz_io_output_payload_2;
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_inputs_2_ready = (maskRouted_2 && io_output_ready);
  assign io_inputs_3_ready = (maskRouted_3 && io_output_ready);
  assign io_chosenOH = {maskRouted_3,{maskRouted_2,{maskRouted_1,maskRouted_0}}};
  assign _zz_io_chosen = io_chosenOH[3];
  assign _zz_io_chosen_1 = (io_chosenOH[1] || _zz_io_chosen);
  assign _zz_io_chosen_2 = (io_chosenOH[2] || _zz_io_chosen);
  assign io_chosen = {_zz_io_chosen_2,_zz_io_chosen_1};
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      locked <= 1'b0;
      arbitration_counter_value <= 2'b00;
    end else begin
      arbitration_counter_value <= arbitration_counter_valueNext;
      if(io_output_valid) begin
        locked <= 1'b1;
      end
      if(io_output_fire_1) begin
        locked <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if(io_output_valid) begin
      maskLocked_0 <= maskRouted_0;
      maskLocked_1 <= maskRouted_1;
      maskLocked_2 <= maskRouted_2;
      maskLocked_3 <= maskRouted_3;
    end
  end


endmodule
