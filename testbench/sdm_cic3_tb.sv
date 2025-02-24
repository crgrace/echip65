`timescale 1ns/10ps

module sdm_cic3_tb();


real sine_input;

// local signals

logic modulator_out;
logic [24:0] digital_monitor;
logic [3:0] digital_monitor_sel;
logic clk;
logic reset_n;
logic [24:0] cic_out;

// clock
always #10 clk = ~clk; // 50Mhz

// testing tasks
`include "echip65_tasks.sv"

initial begin
    clk = 0;
    reset_n = 0;
    digital_monitor_sel = 0;
    #1000 reset_n = 1;
    checkMonitor();
end // initial


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
        .out                    (cic_out),
        .digital_monitor        (digital_monitor),
        .in                     (modulator_out),
        .digital_monitor_sel    (digital_monitor_sel),
        .clk                    (clk),
        .reset_n                (reset_n)
    );
/*
cic3_echip65_v2
    cic3_echip65 (
        .out                    (cic_out),
        .digital_monitor        (digital_monitor),
        .in                     (modulator_out),
        .digital_monitor_sel    (digital_monitor_sel),
        .clk                    (clk),
        .reset_n                (reset_n)
    );
*/


endmodule

