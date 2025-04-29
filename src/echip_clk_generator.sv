///////////////////////////////////////////////////////////////////
// File Name: echip_clk_generator.sv
// Engineer:  Jyothisraj Johnson (jyothisrajjohnson@lbl.gov)
// Description: Model the modulator and filter clock generation scheme on-chip.
//              Starts w/ 81.92MHz high speed serializer clk, 16-bit shift register 
//              available to define patterns for modulator clocks, filter clock and 
//              SCLK, which captures the filter output data. 
///////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

module echip_clk_generator 
    (output logic phi1, //input clk to modulator (5.12 MHz); non-overlapping with phi2 (level-sensitive)
    output logic phi2, //input clk to modulator (5.12 MHz); non-overlapping with phi1 (level-sensitive)
    output logic phi1F, //input clk to digital filters (5.12 MHz); (edge-sensitive)
    output logic sclk, //serial data clk, captures data for serializer (5.12 MHz); (edge-sensitive)
    input logic clk, //input 81.92M MHz high speed serializer clk
    input logic enable,
    input logic rstn
    );

//16-bit words capturing pattern for generated clks 

//generation is MSB to LSB for defined pattern
// logic [15:0] patternPHI1  = 16'b0111111100000000; 
// logic [15:0] patternPHI2  = 16'b0000000001111111;
// logic [15:0] patternPHI1F = 16'b0011111110000000;
// logic [15:0] patternSCLK  = 16'b1111111100000000;

//generation is LSB to MSB for defined pattern
logic [15:0] patternPHI1  = 16'b0000000011111110; 
logic [15:0] patternPHI2  = 16'b1111111000000000;
// logic [15:0] patternPHI1F = 16'b0000000111111110;
logic [15:0] patternPHI1F = 16'b1111111100000000;
// logic [15:0] patternSCLK  = 16'b0000000011111111;
logic [15:0] patternSCLK  = 16'b1111111100000000;

shift_reg phi1_generator (
    .gen_clk(phi1),
    .din_clk(patternPHI1), 
    .clk(clk), 
    .rstn(rstn)
);

shift_reg phi2_generator (
    .gen_clk(phi2),
    .din_clk(patternPHI2), 
    .clk(clk), 
    .rstn(rstn)
);

shift_reg phi1F_generator (
    .gen_clk(phi1F),
    .din_clk(patternPHI1F), 
    .clk(clk), 
    .rstn(rstn)
);

shift_reg sclk_generator (
    .gen_clk(sclk),
    .din_clk(patternSCLK), 
    .clk(clk), 
    .rstn(rstn)
);

endmodule