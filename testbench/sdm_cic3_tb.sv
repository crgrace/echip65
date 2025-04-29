`timescale 1ns/10ps
// `define SHAREDCLK // define for version with clock seperate from filter

module sdm_cic3_tb();

real sine_input;

// local signals

logic modulator_out;
logic [3:0] digital_monitor_sel;
logic clk;
logic reset_n;
logic [24:0] out;
logic [24:0] out_sampled;

// clock
always #5 clk = ~clk; // 100Mhz; breaks down at 125MHz (8ns period, 4ns half period)

// testing tasks
//`include "echip65_tasks.sv"

initial begin
    clk = 0;
    reset_n = 0;
    digital_monitor_sel = 0;
    #1000 reset_n = 1;
    // checkMonitor();
end // initial

always @(posedge clk) out_sampled = out;

sine_wave
    sine_wave (
        .sine_out   (sine_input)
    );

sdm_rnm
    sdm_rdm (
        .analog_in  (sine_input),
        .clk        (clk),
        .reset_n    (reset_n),
        .dout       (modulator_out)
        );

cic3_echip65
    cic3_echip65 (
        .out                    (out),
        .in                     (modulator_out),
        // .digital_monitor_sel    (digital_monitor_sel),
        .clk                    (clk),
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