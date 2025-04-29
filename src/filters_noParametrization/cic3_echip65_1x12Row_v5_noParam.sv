///////////////////////////////////////////////////////////////////
// File Name: cic3_echip65_1x12Row_v5.sv
// Engineer:  Jyothisraj Johnson (jyothisrajjohnson@lbl.gov)
// Description: 1x12 row of digital filters 
//              (simple, no integrated digital monitor always_comb block or cfg. bits)
//              clk is common input and divided_clk generated for each set of two filters
//              at top internally and distributed to all filters in the row.
//              
///////////////////////////////////////////////////////////////////

/*
JJ (03/06/25): keeping same module name for the moment for iterating through implementation power checks
               this assumes cic3_echip65_simple_noclk.sv and cic3_clkdiv.sv as root src code
JJ (03/13/25): creating 24 sets of 25-bit filter outputs to make association of outputs w/ filter instances explicit     
JJ (03/30/25): making a 12-filter V3 module sub-version (b) representing left bank of filters          
*/

module cic3_echip65_1x12RowV5 
// #(
// parameter NUM_FILTERS_SUBSECTION = 12
// )
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
input logic [(6-1):0] clk, //common "high speed" filter clk (same frequency, adjustable phase as modulator clk)
input logic reset_n // common async. reset active low
);

/*
The filter row is formed by 1 sets of 12 filters and generate blocks are set-up accordingly.
All 12 filters will share a common modulator input but have seperate input pins.
They will also share a common clk input (high speed filter clk) and reset active low (async) input.
divided_clk is generated at top (ROW-level) to each filter.
Will have both rvt and hvt flavours synthesized.
*/

logic [(6-1):0] divided_clk; // JJ (03/20/25): adding in 1 divided clk instance for each pair of 2 filters (to reflect final chip's expected floorplan)
logic [(12-1):0] divided_clk_int; // JJ (03/20/25): length 12 because of way assignment is set up
logic [(12-1):0] clk_int; // JJ (03/2/025): length 12 because of way assignment is set up
logic [(12*25-1):0] out_int; //output bits from FILTERS

/*
in[11] is at left most side of top edge and in[0] is right-most side of top edge
*/

/*
To make it easier for grouping of output bits to each filter instance, we have to get explicit.
Digital filter numbering starts w/ instance 0 at right edge and 23 at left edge.
For each, [MSB:LSB] pin ordering --> out0[0] is right-most bit and out23[24] is left-most bit on bottom edge
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

// clk divider to generate differentiator clocks
genvar m;
generate
    for (m=0; m<6; m=m+1) begin : DIVIDED_CLKS
        cic3_clkdiv
            cic3_clkdiv (
                .divided_clk            (divided_clk[m]),
                .clk                    (clk[m]), // "high speed" modulator clk input
                .reset_n                (reset_n)
        );
    end
endgenerate

/*
out_int[24:0] corresponds to in[0] and out_int[299:275] corresponds to in[11]
divided_clk[0] corresponds to in[1] and in[0]
divided_clk[5] corresponds to in[11] and in[10]
*/

//JJ: I'm sure there's a more clever way to do this but there's benefits to being explicit with RTL...
assign clk_int = {clk[5],clk[5],clk[4],clk[4],
                    clk[3],clk[3],clk[2],clk[2],
                    clk[1],clk[1],clk[0],clk[0]
                    };

assign divided_clk_int = {divided_clk[5],divided_clk[5],divided_clk[4],divided_clk[4],
                    divided_clk[3],divided_clk[3],divided_clk[2],divided_clk[2],
                    divided_clk[1],divided_clk[1],divided_clk[0],divided_clk[0]
                    };

genvar i;
generate
    for (i=0; i<12; i=i+1) begin : FILTERS
        cic3_echip65_simple_noclk //cic3_echip65_noclk
            cic3_echip65_noclk (
                .out                    (out_int[(i+1)*25-1:i*25]), //25-bit digital output for filter
                .in                     (in[i]),
                .clk                    (clk_int[i]),
                .divided_clk            (divided_clk_int[i]),
                .reset_n                (reset_n)
            );
    end
endgenerate

endmodule