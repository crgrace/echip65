///////////////////////////////////////////////////////////////////
// File Name: cic3_echip65_v3.sv
// Engineer:  Carl Grace (crgrace@lbl.gov)
// Description: cascaded integrator comb filter (CIC)
//          Processes filter sigma-delta modulator output
//          Need the following number of internal bits:
//          W = Nlog2(D)+1
//          N = filter order (3 here)
//          D = decimation factor (256 here)
//          so W = 3*(8)+1 = 25. 
//          default divide ratio is 256 (need 25 bits minimum internally)
//          based on sample code provided by ADI in AD7401 datasheet
//
//          This version includes an external divided_clk
///////////////////////////////////////////////////////////////////


module cic3_echip65
    #(parameter DECIMATION_FACTOR = 256, // default D = 256
    parameter CLOCK_WIDTH = $clog2(DECIMATION_FACTOR),
    parameter NUMBITS = 3*CLOCK_WIDTH+1)
    (output logic [NUMBITS-1:0] out, // filtered output
    input logic in, // single bit from sigma-delta modulator
    input logic [3:0] digital_monitor_sel, // which test point to watch
    input logic clk, // high-speed modulator clk
    input logic reset_n); // asynchronous digital reset (active low)

logic divided_clk;

// CIC3 filter without internal clock generator

cic3_echip65_noclk
    cic3_echip65_noclk (
        .out                    (out),
        .in                     (in),
        .digital_monitor_sel    (digital_monitor_sel),
        .divided_clk            (divided_clk),
        .clk                    (clk),
        .reset_n                (reset_n)
    );
// clk divider to generate differentiator clocks
cic3_clkdiv
    cic3_clkdiv (
        .divided_clk            (divided_clk),
        .clk                    (clk),
        .reset_n                (reset_n)
    );


endmodule

