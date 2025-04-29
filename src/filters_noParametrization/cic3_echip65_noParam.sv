///////////////////////////////////////////////////////////////////
// File Name: cic3_echip65.sv
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
///////////////////////////////////////////////////////////////////

module cic3_echip65
    // #(parameter DECIMATION_FACTOR = 256, // default D = 256
    // parameter CLOCK_WIDTH = $clog2(DECIMATION_FACTOR),
    // parameter NUMBITS = 3*CLOCK_WIDTH+1)
    (output logic [25-1:0] out, // filtered output
//    output logic [NUMBITS-1:0] digital_monitor, // internal signals
    input logic in, // single bit from sigma-delta modulator
    input logic [3:0] digital_monitor_sel, // which test point to watch
    input logic clk, // high-speed modulator clk
    input logic reset_n); // asynchronous digital reset (active low)

logic [25-1:0] in_coded; // input coded to 25-bit two's complement
logic [25-1:0] acc1;
logic [25-1:0] acc2;
logic [25-1:0] acc3;
logic [25-1:0] acc3_d;
logic [25-1:0] diff1;
logic [25-1:0] diff2;
logic [25-1:0] diff3;
logic [25-1:0] diff1_d;
logic [25-1:0] diff2_d;
logic [25-1:0] cic3_out;
logic [8-1:0] clock_counter;
logic divided_clk;
logic [25:0] digital_mux; // combinational mux output

/*
JJ (03/13/25): updated clking setup of filter because previous implementation led to difficulties meeting hold time target slack
Original:
integrators update on posedge of clk
clock_counter updates on posedge of clk
    -so MSB transitions both going HIGH and LOW are on posedge of clk
differentiators update on negedge of divided_clk (which aligns with posedge of clk)
End result: update of integrators, downsampling and update of differentiators all effectively happen on same posedge of clk 

Updated:
integrators update on posedge of clk
clock_counter updates on NEGEDGE of clk
    -so MSB transitions both going HIGH and LOW are on NEGEDGE of clk
differentiators update on posedge of divided_clk (which aligns with negedge of clk)
End result: update of integrators and the downsampling + update of differentiators are seperated by 1/2 fast input filter clk period
*/

// 2's complement encoder
always_comb begin : coder
    if (in) 
        in_coded = 1;
    else
        in_coded = 0;
end // always_comb

// digital monitor
always_comb 
    case (digital_monitor_sel)
        4'b0000: digital_mux = cic3_out;
        4'b0001: digital_mux = {24'b0, in};
        4'b0010: digital_mux = in_coded;
        4'b0011: digital_mux = acc1;
        4'b0100: digital_mux = acc2;
        4'b0101: digital_mux = acc3;
        4'b0110: digital_mux = acc3_d;
        4'b0111: digital_mux = diff1;
        4'b1000: digital_mux = diff1_d;
        4'b1001: digital_mux = diff2;
        4'b1010: digital_mux = diff2_d;
        4'b1011: digital_mux = diff3;
        4'b1100: digital_mux = {17'b0, clock_counter};
        4'b1101: digital_mux = {24'b0, divided_clk};
        4'b1110: digital_mux = 'b0;
        4'b1111: digital_mux = 'b1;
    endcase 
// clock assignment

always_comb begin : clock_assign
    divided_clk = clock_counter[8-1]; 
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

// differentiators
// always_ff @ (negedge divided_clk or negedge reset_n) begin 
always_ff @ (posedge divided_clk or negedge reset_n) begin 
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

// timing and output logic
/*
JJ: diff3 gets updated essentially on negedge of clk so cic3_out should be assigned to on posedge of clk
    and then output should be assigned to on negedge of the clk (this allows for matching w/ V1 and V2 as well)
*/
always_ff @ (posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // clock_counter <= 'b0; 
        cic3_out <= 'b0;
        // out <= 'b0;
    end
    else begin 
        // clock_counter <= clock_counter + 1'b1;
        cic3_out <= diff3;
        // out <= digital_mux;
    end
end // always_ff

// JJ: switching to negedge of clk for clock_counter as per notes above
always_ff @ (negedge clk or negedge reset_n) begin
    if (!reset_n) begin
        clock_counter <= 'b0; 
        out <= 'b0;
    end
    else begin 
        clock_counter <= clock_counter + 1'b1;
        out <= digital_mux;
    end
end // always_ff

endmodule

