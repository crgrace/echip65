///////////////////////////////////////////////////////////////////
// File Name: cic3_echip65_1x12Row_v1.sv
// Engineer:  Jyothisraj Johnson (jyothisrajjohnson@lbl.gov)
// Description: 1x12 row of digital filters 
//              (simple, no integrated digital monitor always_comb block or cfg. bits)
//              clk is common input and divided_clk generated internally
///////////////////////////////////////////////////////////////////

/*
JJ (03/06/25): keeping same module name for the moment for iterating through implementation power checks
               this assumes cic3_echip65_simple.sv as root src code
JJ (03/13/25): creating 24 sets of 25-bit filter outputs to make association of outputs w/ filter instances explicit
JJ (03/30/25): making a 12-filter V1 module sub-version
*/

module cic3_echip65_1x12Row
#(
parameter NUM_FILTERS_SUBSECTION = 12
)
(//outputs are all directly sent to current starved buffers right below bottom power rings at design boundry edge
output logic [(25-1):0] out0, 
output logic [(25-1):0] out1,
output logic [(25-1):0] out2, 
output logic [(25-1):0] out3,
output logic [(25-1):0] out4, 
output logic [(25-1):0] out5,
output logic [(25-1):0] out6, 
output logic [(25-1):0] out7,
output logic [(25-1):0] out8, 
output logic [(25-1):0] out9,
output logic [(25-1):0] out10, 
output logic [(25-1):0] out11,
input logic [(12-1):0] in, //will be common modulator input (clocked on modulator clk) but have 12 unique inputs pins to minimize routing congestion
input logic clk, //common "high speed" filter clk (same frequency, adjustable phase as modulator clk)
input logic reset_n // common async. reset active low
);

/*
The filter row is formed by 1 sets of 12 filters and generate blocks are set-up accordingly.
All 12 filters will share a common modulator input but have seperate input pins.
They will also share a common clk input (high speed filter clk) and reset active low (async) input.
divided_clk is generated internally to each filter.
Will have both rvt and hvt flavours synthesized.
*/

logic [(NUM_FILTERS_SUBSECTION*25-1):0] out_int; //internal output bits from FILTERS

/*
in[11] is at left most side of top edge and in[0] is right-most side of top edge
*/

/*
To make it easier for grouping of output bits to each filter instance, we have to get explicit.
Digital filter numbering starts w/ instance 0 at right edge and 11 at left edge.
For each, [MSB:LSB] pin ordering --> out0[0] is right-most bit and out11[24] is left-most bit on bottom edge
*/
assign out0 = out_int[(25*1 -1):25*0];
assign out1 = out_int[(25*2 -1):25*1];
assign out2 = out_int[(25*3 -1):25*2];
assign out3 = out_int[(25*4 -1):25*3];
assign out4 = out_int[(25*5 -1):25*4];
assign out5 = out_int[(25*6 -1):25*5];
assign out6 = out_int[(25*7 -1):25*6];
assign out7 = out_int[(25*8 -1):25*7];
assign out8 = out_int[(25*9 -1):25*8];
assign out9 = out_int[(25*10 -1):25*9];
assign out10 = out_int[(25*11 -1):25*10];
assign out11 = out_int[(25*12 -1):25*11];

/*
out_int[24:0] corresponds to in[0] and out_int[299:275] corresponds to in[11]
*/
genvar j;
generate
    for (j=0; j<NUM_FILTERS_SUBSECTION; j=j+1) begin : FILTERS
        cic3_echip65
            cic3_echip65 (
                .out                    (out_int[(j+1)*25-1:j*25]), //25-bit digital output for filter
                .in                     (in[j]),
                .clk                    (clk),
                .reset_n                (reset_n)
            );
    end
endgenerate

endmodule