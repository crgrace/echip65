`timescale 1ns/1ps
// `define SHAREDCLK // define for version with clock seperate from filter

module sdm_cic3_wEchipClkGenerators_FULLROW_tb();

parameter NUM_INSTANCES = 24;

real sine_input;

// local signals

logic modulator_out;
logic [(NUM_INSTANCES-1):0] mod_outDelayed; //delayed modulator outputs across the row
// logic [(24-1):0] mod_outDelayed; //delayed modulator outputs across the row
logic [3:0] digital_monitor_selL;
logic [3:0] digital_monitor_selR;
logic clk;
logic phi1;
logic phi1_delayed;
logic phi2;
logic phi2_delayed;
logic phi1F;
logic [(NUM_INSTANCES-1):0] phi1F_delayed;
// logic [(24-1):0] phi1F_delayed;
logic sclk;
logic reset_n;
logic enable;

// logic [(25-1):0] cic3_out [(12-1):0];

logic [(25-1):0] out0;
logic [(25-1):0] out1;
logic [(25-1):0] out2;
logic [(25-1):0] out3;
logic [(25-1):0] out4; 
logic [(25-1):0] out5;
logic [(25-1):0] out6; 
logic [(25-1):0] out7;
logic [(25-1):0] out8; 
logic [(25-1):0] out9;
logic [(25-1):0] out10; 
logic [(25-1):0] out11;
logic [(25-1):0] out12;
logic [(25-1):0] out13;
logic [(25-1):0] out14;
logic [(25-1):0] out15;
logic [(25-1):0] out16; 
logic [(25-1):0] out17;
logic [(25-1):0] out18; 
logic [(25-1):0] out19;
logic [(25-1):0] out20; 
logic [(25-1):0] out21;
logic [(25-1):0] out22; 
logic [(25-1):0] out23;

logic [(25-1):0] serial_out1;
logic [(25-1):0] serial_out2;
logic [(25-1):0] serial_out3;
logic [(25-1):0] serial_out4;
logic [(25-1):0] serial_out5;
logic [(25-1):0] serial_out6;
logic [(25-1):0] serial_out7;
logic [(25-1):0] serial_out8;
logic [(25-1):0] serial_out9;
logic [(25-1):0] serial_out10;
logic [(25-1):0] serial_out11;
logic [(25-1):0] serial_out12;
logic [(25-1):0] serial_out13;
logic [(25-1):0] serial_out14;
logic [(25-1):0] serial_out15;
logic [(25-1):0] serial_out16;
logic [(25-1):0] serial_out17;
logic [(25-1):0] serial_out18;
logic [(25-1):0] serial_out19;
logic [(25-1):0] serial_out20;
logic [(25-1):0] serial_out21;
logic [(25-1):0] serial_out22;
logic [(25-1):0] serial_out23;
logic [(25-1):0] serial_out24;

/*
Should iterate across skew for PHI1, PHI2 delays as well as expected skew for filter rows for modulator and clk inputs
top most filter row has max. PHI1F delay, min. FINPUT delay offset
bottom most filter row has min. PHI1F delay, max. FINPUT delay offset
for 1x12 module, there will be an extra offset whether right or left bank of filters
*/

parameter CLK_PERIOD = 12.207/2.0; //[ns] (12.20703125ns is actual period); 81.92Mhz high speed input serializer clock

parameter PHI1_DELAY = 5; //[ns]; propagation delay from source to modulator clk input (will have skew across modulators)
parameter PHI2_DELAY = 5; //[ns]; propagation delay from source to modulator clk input (will have skew across modulators)

parameter PHI1F_DELAY_MIN = 3; //[ns]; min propagation delay from source to filter clk input (will have skew across filter rows)
parameter PHI1F_DELAY_INTER = 1.0; //[ns]; relative propagation delay from one filter input to next (will have skew across filter rows)

parameter FINPUT_DELAY_MIN = 3; //[ns]; min propagation delay from modulator output to filter input (will have skew across filter rows)
parameter FINPUT_DELAY_INTER = 1.0; //[ns]; relative propagation delay from one filter input to next  (will have skew across filter rows)

// clock
always #(CLK_PERIOD/2) clk = ~clk; // 81.92Mhz high speed input serializer clock

// generated clk delays
always @(phi1) phi1_delayed <= #(PHI1_DELAY) phi1;
always @(phi2) phi2_delayed <= #(PHI2_DELAY) phi2;

//clks come up left right so for a row, min delay is on left edge, max delay on right edge (this is for V5 mainly, other versions have 1 clk pin input and clk tree takes care of below)
genvar m;
generate
    // int k;
    for (m=0; m<NUM_INSTANCES; m=m+1) begin : PHI1FDELAY
        always @(phi1F) phi1F_delayed[(m)] <= #(PHI1F_DELAY_MIN + (NUM_INSTANCES-1-m)*PHI1F_DELAY_INTER) phi1F;
    end
endgenerate

//mod input come from right side so for a row, min delay is on right edge, max delay on left edge
genvar n;
generate
    // int k;
    for (n=0; n<NUM_INSTANCES; n=n+1) begin : MODDELAY
        always @(modulator_out) mod_outDelayed[(n)] <= #(FINPUT_DELAY_MIN + n*FINPUT_DELAY_INTER) modulator_out;
    end
endgenerate

always_ff @(posedge sclk) begin
    serial_out1 <= out0;
    serial_out2 <= out1;
    serial_out3 <= out2;
    serial_out4 <= out3;
    serial_out5 <= out4;
    serial_out6 <= out5;
    serial_out7 <= out6;
    serial_out8 <= out7;
    serial_out9 <= out8;
    serial_out10 <= out9;
    serial_out11 <= out10;
    serial_out12 <= out11;
    serial_out13 <= out12;
    serial_out14 <= out13;
    serial_out15 <= out14;
    serial_out16 <= out15;
    serial_out17 <= out16;
    serial_out18 <= out17;
    serial_out19 <= out18;
    serial_out20 <= out19;
    serial_out21 <= out20;
    serial_out22 <= out21;
    serial_out23 <= out22;
    serial_out24 <= out23;
end

echip_clk_generator echip_clks
    (.phi1(phi1), //input clk to modulator (5.12 MHz); non-overlapping with phi2 (level-sensitive)
    .phi2(phi2), //input clk to modulator (5.12 MHz); non-overlapping with phi1 (level-sensitive)
    .phi1F(phi1F), //input clk to digital filters (5.12 MHz); (edge-sensitive)
    .sclk(sclk), //serial data clk, captures data for serializer (5.12 MHz); (edge-sensitive)
    .clk(clk), //input 81.92M MHz high speed serializer clk
    .enable(enable),
    .rstn(reset_n)
    );

sine_wave
    sine_wave (
        .sine_out   (sine_input)
    );

sdm_rnm
    sdm_rdm (
        .analog_in  (sine_input),
        .clk        (phi2),
        .reset_n    (reset_n),
        .dout       (modulator_out)
        );

// cic3_echip65_1x12Row cic3_echip65_1x12Row1
//     (//outputs are all directly sent to current starved buffers right below bottom power rings at design boundry edge
//     .out0(out0), 
//     .out1(out1),
//     .out2(out2), 
//     .out3(out3),
//     .out4(out4), 
//     .out5(out5),
//     .out6(out6), 
//     .out7(out7),
//     .out8(out8), 
//     .out9(out9),
//     .out10(out10), 
//     .out11(out11),
//     .in(mod_outDelayed[11:0]), //will be common modulator input (clocked on modulator clk) but have 12 unique inputs pins to minimize routing congestion
//     // .clk(phi1F_delayed[11]), //common "high speed" filter clk (same frequency, adjustable phase as modulator clk)
//     .clk(phi1F_delayed[11:6]), //common "high speed" filter clk (same frequency, adjustable phase as modulator clk)
//     .reset_n(reset_n) // common async. reset active low
//     );

// cic3_echip65_1x12Row cic3_echip65_1x12Row2
//     (//outputs are all directly sent to current starved buffers right below bottom power rings at design boundry edge
//     .out0(out12), 
//     .out1(out13),
//     .out2(out14), 
//     .out3(out15),
//     .out4(out16), 
//     .out5(out17),
//     .out6(out18), 
//     .out7(out19),
//     .out8(out20), 
//     .out9(out21),
//     .out10(out22), 
//     .out11(out23),
//     .in(mod_outDelayed[23:12]), //will be common modulator input (clocked on modulator clk) but have 12 unique inputs pins to minimize routing congestion
//     // .clk(phi1F_delayed[6]), //common "high speed" filter clk (same frequency, adjustable phase as modulator clk)
//     .clk(phi1F_delayed[5:0]), //common "high speed" filter clk (same frequency, adjustable phase as modulator clk)
//     .reset_n(reset_n) // common async. reset active low
//     );

cic3_echip65_2x12Row cic3_echip65_2x12Row
    (//outputs are all directly sent to current starved buffers right below bottom power rings at design boundry edge
    .out0(out0), 
    .out1(out1),
    .out2(out2), 
    .out3(out3),
    .out4(out4), 
    .out5(out5),
    .out6(out6), 
    .out7(out7),
    .out8(out8), 
    .out9(out9),
    .out10(out10), 
    .out11(out11),
    .out12(out12), 
    .out13(out13),
    .out14(out14), 
    .out15(out15),
    .out16(out16),
    .out17(out17),
    .out18(out18), 
    .out19(out19),
    .out20(out20), 
    .out21(out21),
    .out22(out22), 
    .out23(out23),
    .in(mod_outDelayed[23:0]), //will be common modulator input (clocked on modulator clk) but have 12 unique inputs pins to minimize routing congestion
    .clk(phi1F_delayed[11]), //common "high speed" filter clk (same frequency, adjustable phase as modulator clk)
    // .clk(phi1F_delayed[5:0]), //common "high speed" filter clk (same frequency, adjustable phase as modulator clk)
    .digital_monitor_selR(digital_monitor_selR),
    .digital_monitor_selL(digital_monitor_selL),
    .reset_n(reset_n) // common async. reset active low
    );

// genvar k;
// generate
//     // int k;
//     for (k=0; k<12; k=k+1) begin : CIC3
//         cic3_echip65
//             cic3_echip65 (
//                 .out                    (cic3_out[k]),
//                 .in                     (mod_outDelayed[k]),
//                 .digital_monitor_sel    (digital_monitor_sel),
//                 .clk                    (phi1F_delayed[k]),
//                 .reset_n                (reset_n)
//             );
//     end
// endgenerate

// cic3_echip65
//     cic3_echip65 (
//         .out                    (out),
//         .in                     (modulator_out),
//         // .digital_monitor_sel    (digital_monitor_sel),
//         .clk                    (clk),
//         .reset_n                (reset_n)
//     );

// testing tasks
//`include "echip65_tasks.sv"

initial begin
    clk = 1'b0;
    reset_n = 1'b0;
    digital_monitor_selL = 'b0;
    digital_monitor_selR = 'b0;
    enable = 1'b1;
    #1000 reset_n = 1'b1;
    // checkMonitor();
end // initial

endmodule