`timescale 1ns/10ps

module cic3_tb();

// local signals
logic [24:0] digital_monitor;
logic [3:0] digital_monitor_sel;
logic in;
logic clk;
logic reset_n;
logic [13:0] out;

        
// clock
always #100 clk = ~clk; // 5Mhz

// testing tasks
`include "echip65_tasks.sv"


initial begin
    digital_monitor_sel = 0;
    clk = 0;
    in = 0;
    reset_n = 0;
    #1000 reset_n = 1;
// CIC3 test (step response test)
    #405500 in = 1;
// now test digital_monitor
    for (int index = 0; index < 16; index++) begin
        digital_monitor_sel = index;
        #472834 checkMonitor(digital_monitor,digital_monitor_sel);
        #500 digital_monitor_sel = digital_monitor_sel + 1;
    end // for
    $display("Digital Monitor Test Complete");

end // initial

cic3_echip65
    cic3_echip65 (
        .out                    (out),
        .digital_monitor        (digital_monitor),
        .in                     (in),
        .digital_monitor_sel    (digital_monitor_sel),
        .clk                    (clk),
        .reset_n                (reset_n)
    );

endmodule

