`timescale 1ns/10ps

module cic3_tb();

// local signals
logic [24:0] digital_monitor;
logic [3:0] digital_monitor_sel;
logic in;
logic clk;
logic reset_n;
logic [23:0] out;

        
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
    checkMonitor();
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

