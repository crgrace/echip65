///////////////////////////////////////////////////////////////////
// File Name: cic3_echip65_2x12Row_v1.sv
// Engineer:  Jyothisraj Johnson (jyothisrajjohnson@lbl.gov)
// Description: 2x12 row of digital filters 
//              (simple, no integrated digital monitor always_comb block or cfg. bits)
//              clk is common input and divided_clk generated internally
///////////////////////////////////////////////////////////////////

/*
JJ (03/06/25): keeping same module name for the moment for iterating through implementation power checks
this assumes cic3_echip65_simple.sv as root src code
*/

module cic3_echip65_2x12Row
#(
parameter NUM_FILTERS_SUBSECTION = 12,
parameter NUM_SUBSECTIONS = 2
)
(output logic [(NUM_FILTERS_SUBSECTION*NUM_SUBSECTIONS*25-1):0] out,
input logic in, //common modulator input
input logic clk, //common "high spped" modulator clk
input logic reset_n // common async. reset active low
);

/*
The filter row is formed by 2 sets of 12 filters and generate blocks are set-up accordingly.
All 24 filters will share a common modulator input.
They will also share a common clk input (high speed modulator clk) and reset active low (async) input.
divided_clk is generated internally to each filter.
Will have both rvt and hvt flavours synthesized.
*/

logic [(NUM_FILTERS_SUBSECTION*25-1):0] outR; //output bits from FILTERS_RIGHT
logic [(NUM_FILTERS_SUBSECTION*25-1):0] outL; //output bits from FILTERS_LEFT

assign out = {outL,outR}; //concatinating 

genvar j;
generate
    for (j=0; j<NUM_FILTERS_SUBSECTION; j=j+1) begin : FILTERS_LEFT
        cic3_echip65
            cic3_echip65 (
                .out                    (outL[(j+1)*25-1:j*25]), //25-bit digital output for filter
                .in                     (in),
                .clk                    (clk),
                .reset_n                (reset_n)
            );
    end
endgenerate

genvar i;
generate
    for (i=0; i<NUM_FILTERS_SUBSECTION; i=i+1) begin : FILTERS_RIGHT
        cic3_echip65
            cic3_echip65(
                .out                    (outR[(i+1)*25-1:i*25]), //25-bit digital output for filter
                .in                     (in),
                .clk                    (clk),
                .reset_n                (reset_n)
            );
    end
endgenerate

endmodule