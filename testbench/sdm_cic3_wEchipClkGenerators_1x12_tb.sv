`timescale 1ns/1ps
// `define SHAREDCLK // define for version with clock seperate from filter

module sdm_cic3_wEchipClkGenerators_1x12_tb();

real sine_input;

// local signals

logic modulator_out;
logic [(12-1):0] mod_outDelayed; //delayed modulator outputs across the row
logic [3:0] digital_monitor_sel;
logic clk;
logic phi1;
logic phi1_delayed;
logic phi2;
logic phi2_delayed;
logic phi1F;
logic [(12-1):0] phi1F_delayed;
logic sclk;
logic reset_n;
logic enable;

logic [(25-1):0] cic3_out [(12-1):0];
// logic [(25-1):0] cic3_out2;
// logic [(25-1):0] cic3_out3;
// logic [(25-1):0] cic3_out4;
// logic [(25-1):0] cic3_out5;
// logic [(25-1):0] cic3_out6;
// logic [(25-1):0] cic3_out7;
// logic [(25-1):0] cic3_out8;
// logic [(25-1):0] cic3_out9;
// logic [(25-1):0] cic3_out10;
// logic [(25-1):0] cic3_out11;
// logic [(25-1):0] cic3_out12;

logic [(25-1):0] serial_out1;
logic [(25-1):0] serial_out2;
logic [(25-1):0] serial_out3;
logic [(25-1):0] serial_out4;
logic [(25-1):0] serial_out5;
logic [(25-1):0] serial_out6;
logic [(25-1):0] serial_out7;
logic [(25-1):0] serial_out8;
logic [(25-1):0] serial_out9;
logic [(25-1):0] serial_out10;
logic [(25-1):0] serial_out11;
logic [(25-1):0] serial_out12;

/*
Should iterate across skew for PHI1, PHI2 delays as well as expected skew for filter rows for modulator and clk inputs
top most filter row has max. PHI1F delay, min. FINPUT delay offset
bottom most filter row has min. PHI1F delay, max. FINPUT delay offset
for 1x12 module, there will be an extra offset whether right or left bank of filters
*/

parameter CLK_PERIOD = 12.207; //[ns] (12.20703125ns is actual period); 81.92Mhz high speed input serializer clock

parameter PHI1_DELAY = 5; //[ns]; propagation delay from source to modulator clk input (will have skew across modulators)
parameter PHI2_DELAY = 5; //[ns]; propagation delay from source to modulator clk input (will have skew across modulators)

parameter PHI1F_DELAY_MIN = 3; //[ns]; min propagation delay from source to filter clk input (will have skew across filter rows)
parameter PHI1F_DELAY_INTER = 2.0; //[ns]; relative propagation delay from one filter input to next (will have skew across filter rows)

parameter FINPUT_DELAY_MIN = 3; //[ns]; min propagation delay from modulator output to filter input (will have skew across filter rows)
parameter FINPUT_DELAY_INTER = 2.0; //[ns]; relative propagation delay from one filter input to next  (will have skew across filter rows)

// clock
always #(CLK_PERIOD/2) clk = ~clk; // 81.92Mhz high speed input serializer clock

// generated clk delays
always @(phi1) phi1_delayed <= #(PHI1_DELAY) phi1;
always @(phi2) phi2_delayed <= #(PHI2_DELAY) phi2;

//clks come up left right so for a row, min delay is on left edge, max delay on right edge (this is for V5 mainly, other versions have 1 clk pin input and clk tree takes care of below)
always @(phi1F) phi1F_delayed[11] <= #(PHI1F_DELAY_MIN + 0*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[10] <= #(PHI1F_DELAY_MIN + 1*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[9] <= #(PHI1F_DELAY_MIN + 2*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[8] <= #(PHI1F_DELAY_MIN + 3*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[7] <= #(PHI1F_DELAY_MIN + 4*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[6] <= #(PHI1F_DELAY_MIN + 5*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[5] <= #(PHI1F_DELAY_MIN + 6*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[4] <= #(PHI1F_DELAY_MIN + 7*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[3] <= #(PHI1F_DELAY_MIN + 8*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[2] <= #(PHI1F_DELAY_MIN + 9*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[1] <= #(PHI1F_DELAY_MIN + 10*PHI1F_DELAY_INTER) phi1F;
always @(phi1F) phi1F_delayed[0] <= #(PHI1F_DELAY_MIN + 11*PHI1F_DELAY_INTER) phi1F;

//mod input come from right side so for a row, min delay is on right edge, max delay on left edge
always @(modulator_out) mod_outDelayed[0] <= #(FINPUT_DELAY_MIN + 0*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[1] <= #(FINPUT_DELAY_MIN + 1*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[2] <= #(FINPUT_DELAY_MIN + 2*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[3] <= #(FINPUT_DELAY_MIN + 3*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[4] <= #(FINPUT_DELAY_MIN + 4*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[5] <= #(FINPUT_DELAY_MIN + 5*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[6] <= #(FINPUT_DELAY_MIN + 6*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[7] <= #(FINPUT_DELAY_MIN + 7*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[8] <= #(FINPUT_DELAY_MIN + 8*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[9] <= #(FINPUT_DELAY_MIN + 9*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[10] <= #(FINPUT_DELAY_MIN + 10*FINPUT_DELAY_INTER) modulator_out;
always @(modulator_out) mod_outDelayed[11] <= #(FINPUT_DELAY_MIN + 11*FINPUT_DELAY_INTER) modulator_out;


// testing tasks
//`include "echip65_tasks.sv"

initial begin
    clk = 1'b0;
    reset_n = 1'b0;
    digital_monitor_sel = 'b0;
    enable = 1'b1;
    #1000 reset_n = 1'b1;
    // checkMonitor();
end // initial

always_ff @(posedge sclk) begin
    serial_out1 <= cic3_out[0];
    serial_out2 <= cic3_out[1];
    serial_out3 <= cic3_out[2];
    serial_out4 <= cic3_out[3];
    serial_out5 <= cic3_out[4];
    serial_out6 <= cic3_out[5];
    serial_out7 <= cic3_out[6];
    serial_out8 <= cic3_out[7];
    serial_out9 <= cic3_out[8];
    serial_out10 <= cic3_out[9];
    serial_out11 <= cic3_out[10];
    serial_out12 <= cic3_out[11];
end

echip_clk_generator echip_clks
    (.phi1(phi1), //input clk to modulator (5.12 MHz); non-overlapping with phi2 (level-sensitive)
    .phi2(phi2), //input clk to modulator (5.12 MHz); non-overlapping with phi1 (level-sensitive)
    .phi1F(phi1F), //input clk to digital filters (5.12 MHz); (edge-sensitive)
    .sclk(sclk), //serial data clk, captures data for serializer (5.12 MHz); (edge-sensitive)
    .clk(clk), //input 81.92M MHz high speed serializer clk
    .enable(enable),
    .rstn(reset_n)
    );

sine_wave
    sine_wave (
        .sine_out   (sine_input)
    );

sdm_rnm
    sdm_rdm (
        .analog_in  (sine_input),
        .clk        (phi2),
        .reset_n    (reset_n),
        .dout       (modulator_out)
        );

genvar k;
generate
    // int k;
    for (k=0; k<12; k=k+1) begin : CIC3
        cic3_echip65
            cic3_echip65 (
                .out                    (cic3_out[k]),
                .in                     (mod_outDelayed[k]),
                .digital_monitor_sel    (digital_monitor_sel),
                .clk                    (phi1F_delayed[k]),
                .reset_n                (reset_n)
            );
    end
endgenerate

// cic3_echip65
//     cic3_echip65 (
//         .out                    (out),
//         .in                     (modulator_out),
//         // .digital_monitor_sel    (digital_monitor_sel),
//         .clk                    (clk),
//         .reset_n                (reset_n)
//     );

endmodule