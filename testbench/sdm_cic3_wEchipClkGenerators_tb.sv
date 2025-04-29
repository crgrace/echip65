`timescale 1ns/1ps
// `define SHAREDCLK // define for version with clock seperate from filter

module sdm_cic3_wEchipClkGenerators_tb();

real sine_input;

// local signals

logic modulator_out;
logic mod_outDelayed;
logic [3:0] digital_monitor_sel;
logic clk;
logic phi1;
logic phi2;
logic phi1F;
logic phi1_delayed;
logic phi2_delayed;
logic phi1F_delayed;
logic sclk;
logic reset_n;
logic enable;
logic [24:0] cic3_out;
logic [24:0] serial_out;

parameter CLK_PERIOD = 12.207; //[ns] (12.20703125ns is actual period); 81.92Mhz high speed input serializer clock

parameter PHI1_DELAY = 0; //[ns]; propagation delay from source to modulator clk input (will have skew across modulators)
parameter PHI2_DELAY = 0; //[ns]; propagation delay from source to modulator clk input (will have skew across modulators)

parameter PHI1F_DELAY_MIN = 0.0; //[ns]; min propagation delay from source to filter clk input (will have skew across filter rows)
parameter PHI1F_DELAY_INTER = 0.0; //[ns]; relative propagation delay from one filter input to next (will have skew across filter rows)

parameter FINPUT_DELAY_MIN = 0.0; //[ns]; min propagation delay from modulator output to filter input (will have skew across filter rows)
parameter FINPUT_DELAY_INTER = 50.0; //[ns]; relative propagation delay from one filter input to next  (will have skew across filter rows)

// clock
always #(CLK_PERIOD/2) clk = ~clk; // 81.92Mhz high speed input serializer clock

// generated clk delays
always @(phi1) phi1_delayed <= #(PHI1_DELAY) phi1;
always @(phi2) phi2_delayed <= #(PHI2_DELAY) phi2;

//clks come up left right so for a row, min delay is on left edge, max delay on right edge (this is for V5 mainly, other versions have 1 clk pin input and clk tree takes care of below)
always @(phi1F) phi1F_delayed <= #(PHI1F_DELAY_MIN + 1*PHI1F_DELAY_INTER) phi1F;

//mod input come from right side so for a row, min delay is on right edge, max delay on left edge
always @(modulator_out) mod_outDelayed <= #(FINPUT_DELAY_MIN + 1*FINPUT_DELAY_INTER) modulator_out;

// testing tasks
// `include "echip65_tasks.sv"

initial begin
    clk = 1'b0;
    reset_n = 1'b0;
    digital_monitor_sel = 'b0;
    enable = 1'b1;
    #1000 reset_n = 1'b1;
    // checkMonitor();
end // initial

always @(posedge sclk) serial_out <= cic3_out;

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
        .clk        (phi2_delayed),
        .reset_n    (reset_n),
        .dout       (modulator_out)
        );

cic3_echip65
    cic3_echip65 (
        .out                    (cic3_out),
        .in                     (mod_outDelayed),
        .digital_monitor_sel    (digital_monitor_sel),
        .clk                    (phi1F_delayed),
        .reset_n                (reset_n)
    );

// cic3_echip65
//     cic3_echip65 (
//         .out                    (out),
//         .in                     (modulator_out),
//         // .digital_monitor_sel    (digital_monitor_sel),
//         .clk                    (clk),
//         .reset_n                (reset_n)
//     );

endmodule