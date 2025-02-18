`timescale 1ns/10ps

module sdm_cic3_tb();


real sine_input;

// local signals

logic modulator_out;
logic [24:0] digital_monitor;
logic [3:0] digital_monitor_sel;
logic clk;
logic reset_n;
logic [13:0] cic_out;

// clock
always #10 clk = ~clk; // 50Mhz

// testing tasks
`include "echip65_tasks.sv"

initial begin
    clk = 0;
    reset_n = 0;
    digital_monitor_sel = 0;
    #1000 reset_n = 1;

// test digital monitor
    for (int index = 0; index < 16; index++) begin
        digital_monitor_sel = index;
        #472834 checkMonitor(digital_monitor,digital_monitor_sel);
        #500 digital_monitor_sel = digital_monitor_sel + 1;
    end // for
    $display("%m: Digital Monitor Test Complete");

end // initial


sine_wave
    sine_wave (
        .sine_out   (sine_input)
    );

sdm_rnm
    sdm_rdm (
        .Ain        (sine_input),
        .clk_1mhz   (clk),
        .reset_n    (reset_n),
        .Dout       (modulator_out)
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


endmodule

