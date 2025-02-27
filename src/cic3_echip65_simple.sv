///////////////////////////////////////////////////////////////////
// File Name: cic3_echip65_simple.sv
// Engineer:  Carl Grace (crgrace@lbl.gov)
// Description: cascaded integrator comb filter (CIC)
//          Processes filter sigma-delta modulator output
//          Need the following number of internal bits:
//          W = Nlog2(D)+1
//          N = filter order (3 here)
//          D = decimation factor (256 here)
//          so W = 3*(8)+1 = 25. 
//          divide ratio is 256 (need 25 bits minimum internally)
//          based on sample code provided by ADI in AD7401 datasheet
//
//   DOES NOT INCLUDE MONTIOR MUX
//   IS NOT PARAMETERIZED
///////////////////////////////////////////////////////////////////


module cic3_echip65
    (output logic [24:0] out, // filtered output
    input logic in, // single bit from sigma-delta modulator
    input logic clk, // high-speed modulator clk
    input logic reset_n); // asynchronous digital reset (active low)

logic [24:0] in_coded; // input coded to 25-bit two's complement
logic [24:0] acc1;
logic [24:0] acc2;
logic [24:0] acc3;
logic [24:0] acc3_d;
logic [24:0] diff1;
logic [24:0] diff2;
logic [24:0] diff3;
logic [24:0] diff1_d;
logic [24:0] diff2_d;
logic [7:0] clock_counter; // 256 decimation ratio
logic divided_clk;

// 2's complement encoder
always_comb begin : coder
    if (in) 
        in_coded = 1;
    else
        in_coded = 0;
end // always_comb

// clock assignment
always_comb begin : clock_assign
//    divided_clk = clock_counter[2]; // D = 8
//    divided_clk = clock_counter[5]; // D = 64 
    divided_clk = clock_counter[7]; // D = 256
end // always_comb

// integrators
always_ff @ (posedge clk or negedge reset_n) begin 
    if (!reset_n) begin 
        acc1 <= 'b0; 
        acc2 <= 'b0; 
        acc3 <= 'b0; 
    end 
    else begin
        acc1 <= acc1 + in_coded; 
        acc2 <= acc2 + acc1; 
        acc3 <= acc3 + acc2;  
    end
end // always_ff

// clock divider
always_ff @ (posedge clk or negedge reset_n) begin
    if (!reset_n)
        clock_counter <= 'b0; 
    else 
        clock_counter <= clock_counter + 1'b1;
end // always_ff

// differentiators
always_ff @ (negedge divided_clk or negedge reset_n) begin 
    if(!reset_n) begin
        acc3_d <= 'b0; 
        diff1_d <= 'b0; 
        diff2_d <= 'b0; 
        diff1 <= 'b0; 
        diff2 <= 'b0; 
        diff3 <= 'b0;
    end 
    else begin 
        diff1 <= acc3 - acc3_d; 
        diff2 <= diff1 - diff1_d; 
        diff3 <= diff2 - diff2_d; 
        acc3_d <= acc3; 
        diff1_d <= diff1; 
        diff2_d <= diff2; 
    end
end // always_ff

/* Clock the CIC3 output into the output register */
always_ff @ (posedge divided_clk)      
    out <= diff3;

endmodule

