///////////////////////////////////////////////////////////////////
// File Name: cic3_echip65_2x12Row_v4.sv
// Engineer:  Jyothisraj Johnson (jyothisrajjohnson@lbl.gov)
// Description: 2x12 row of digital filters 
//              (w/ digital monitor always_comb block & cfg. bits)
//              clk is common input and divided_clk generated at top internally
//              and distributed to all filters in the row.
///////////////////////////////////////////////////////////////////

/*
JJ (03/06/25): keeping same module name for the moment for iterating through implementation power checks
               this assumes cic3_echip65_noclk.sv and cic3_clkdiv.sv as root src code
JJ (03/13/25): creating 24 sets of 25-bit filter outputs to make association of outputs w/ filter instances explicit
*/

module cic3_echip65_2x12Row
#(
parameter NUM_FILTERS_SUBSECTION = 12,
parameter NUM_SUBSECTIONS = 2
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
output logic [(25-1):0] out12, 
output logic [(25-1):0] out13,
output logic [(25-1):0] out14, 
output logic [(25-1):0] out15,
output logic [(25-1):0] out16, 
output logic [(25-1):0] out17,
output logic [(25-1):0] out18, 
output logic [(25-1):0] out19,
output logic [(25-1):0] out20, 
output logic [(25-1):0] out21,
output logic [(25-1):0] out22, 
output logic [(25-1):0] out23,
input logic [(24-1):0] in, //will be common modulator input (clocked on modulator clk) but have 24 unique inputs pins to minimize routing congestion
input logic [3:0] digital_monitor_selR, // which test out to select (right subblock of 12 filters)
input logic [3:0] digital_monitor_selL, // which test out to select (left subblock of 12 filters)
input logic clk, //common "high speed" filter clk (same frequency, adjustable phase as modulator clk)
input logic reset_n // common async. reset active low
);

/*
The filter row is formed by 2 sets of 12 filters and generate blocks are set-up accordingly.
All 24 filters will share a common modulator input but have seperate input pins.
They will also share a common clk input (high speed filter clk) and reset active low (async) input.
2 sets of digital_monitor_sel config. bits to select active output for each set of 12 filters.
divided_clk is generated at top (ROW-level) to each filter.
Will have both rvt and hvt flavours synthesized.
*/

logic divided_clk;
logic [(NUM_FILTERS_SUBSECTION-1):0] inR; //input bit for FILTERS_RIGHT
logic [(NUM_FILTERS_SUBSECTION-1):0] inL; //input bit for FILTERS_LEFT
logic [(NUM_FILTERS_SUBSECTION*25-1):0] outR; //output bits from FILTERS_RIGHT
logic [(NUM_FILTERS_SUBSECTION*25-1):0] outL; //output bits from FILTERS_LEFT

/*
in[0] is inR[0] and in[23] is inL[11]
in[23] is at left most side of top edge and in[0] is right-most side of top edge
*/
genvar k;
generate
    for (k=0; k<NUM_FILTERS_SUBSECTION; k=k+1) begin : FILTER_INPUTS
        assign inR[k] = in[k];
        assign inL[k] = in[k+NUM_FILTERS_SUBSECTION];
    end
endgenerate

/*
To make it easier for grouping of output bits to each filter instance, we have to get explicit.
Digital filter numbering starts w/ instance 0 at right edge and 23 at left edge.
For each, [MSB:LSB] pin ordering --> out0[0] is right-most bit and out23[24] is left-most bit on bottom edge
*/
assign out0 = outR[(25*1 -1):25*0];
assign out1 = outR[(25*2 -1):25*1];
assign out2 = outR[(25*3 -1):25*2];
assign out3 = outR[(25*4 -1):25*3];
assign out4 = outR[(25*5 -1):25*4];
assign out5 = outR[(25*6 -1):25*5];
assign out6 = outR[(25*7 -1):25*6];
assign out7 = outR[(25*8 -1):25*7];
assign out8 = outR[(25*9 -1):25*8];
assign out9 = outR[(25*10 -1):25*9];
assign out10 = outR[(25*11 -1):25*10];
assign out11 = outR[(25*12 -1):25*11];
assign out12 = outL[(25*1 -1):25*0];
assign out13 = outL[(25*2 -1):25*1];
assign out14 = outL[(25*3 -1):25*2];
assign out15 = outL[(25*4 -1):25*3];
assign out16 = outL[(25*5 -1):25*4];
assign out17 = outL[(25*6 -1):25*5];
assign out18 = outL[(25*7 -1):25*6];
assign out19 = outL[(25*8 -1):25*7];
assign out20 = outL[(25*9 -1):25*8];
assign out21 = outL[(25*10 -1):25*9];
assign out22 = outL[(25*11 -1):25*10];
assign out23 = outL[(25*12 -1):25*11];

// clk divider to generate differentiator clocks
cic3_clkdiv
    cic3_clkdiv (
        .divided_clk            (divided_clk),
        .clk                    (clk), // "high speed" modulator clk input
        .reset_n                (reset_n)
    );

/*
outL[24:0] corresponds to inL[0] and outL[299:275] corresponds to inL[11]
out12[24:0] corresponds to outL[24:0], out13[24:0] corresponds to outL[49:25], etc
*/
genvar j;
generate
    for (j=0; j<NUM_FILTERS_SUBSECTION; j=j+1) begin : FILTERS_LEFT
        cic3_echip65_noclk
            cic3_echip65_noclk (
                .out                    (outL[(j+1)*25-1:j*25]), //25-bit digital output for filter
                .in                     (inL[j]), 
                .clk                    (clk),
                .divided_clk            (divided_clk),
                .digital_monitor_sel    (digital_monitor_selL),
                .reset_n                (reset_n)
            );
    end
endgenerate

/*
outR[24:0] corresponds to inR[0] and outR[299:275] corresponds to inR[11]
out0[24:0] corresponds to outR[24:0], out1[24:0] corresponds to outR[49:25], etc
*/
genvar i;
generate
    for (i=0; i<NUM_FILTERS_SUBSECTION; i=i+1) begin : FILTERS_RIGHT
        cic3_echip65_noclk
            cic3_echip65_noclk (
                .out                    (outR[(i+1)*25-1:i*25]), //25-bit digital output for filter
                .in                     (inR[i]),
                .clk                    (clk),
                .divided_clk            (divided_clk),
                .digital_monitor_sel    (digital_monitor_selR),
                .reset_n                (reset_n)
            );
    end
endgenerate

endmodule