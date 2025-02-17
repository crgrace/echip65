`timescale 1ns/10ps

module cic3_tb();

// local signals

logic in;
logic clk;
logic reset_n;
logic [13:0] out;

// clock
always #100 clk = ~clk; // 5Mhz


initial begin
    clk = 0;
    in = 0;
    reset_n = 0;
    #1000 reset_n = 1;
// CIC3 test (step response test)
    #405500 in = 1;
end // initial

cic3_echip65
    cic3_echip65 (
        .out        (out),
        .in         (in),
        .clk        (clk),
        .reset_n    (reset_n)
    );

endmodule

