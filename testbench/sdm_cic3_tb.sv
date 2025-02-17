`timescale 1ns/10ps

module sdm_cic3_tb();


real sine_input;

// local signals

logic modulator_out;
logic clk;
logic reset_n;
logic [13:0] cic_out;

// clock
always #10 clk = ~clk; // 50Mhz


initial begin
    clk = 0;
    reset_n = 0;
    #1000 reset_n = 1;
end // initial


sine_wave
    sine_wave (
        .sine_out   (sine_input)
    );

/*
sdm_2nd_order
    sdm_2nd_order (
        .dout       (modulator_out),
        .in         (sine_input),
        .phi1       (clk),
        .phi2       (~clk)
    );
*/
sdm_rnm
    sdm_rdm (
        .Ain        (sine_input),
        .clk_1mhz   (clk),
        .reset_n    (reset_n),
        .Dout       (modulator_out)
        );

    
cic3_echip65
    cic3_echip65 (
        .out        (cic_out),
        .in         (modulator_out),
        .clk        (clk),
        .reset_n    (reset_n)
    );


endmodule

