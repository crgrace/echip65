///////////////////////////////////////////////////////////////////
// File Name: cic3_clk_divider.sv
// Engineer:  Carl Grace (crgrace@lbl.gov)
// Description: cascaded integrator comb filter (CIC)
//          Share clk divider across multiple CIC filter datapaths
//          Intended to see how much power savings are possible 
///////////////////////////////////////////////////////////////////


module cic3_clkdiv
    #(parameter DECIMATION_FACTOR = 256, // default D = 256
    parameter CLOCK_WIDTH = $clog2(DECIMATION_FACTOR),
    parameter NUMBITS = 3*CLOCK_WIDTH+1)
    (output logic divided_clk, // clk divided by DECIMATION_FACTOR 
    input logic clk, // high-speed modulator clk
    input logic reset_n); // asynchronous digital reset (active low)

logic [CLOCK_WIDTH-1:0] clock_counter;

always_comb begin : clock_assign
    divided_clk = clock_counter[CLOCK_WIDTH-1]; 
end // always_comb

// clock divider
always_ff @ (posedge clk or negedge reset_n) begin
    if (!reset_n)
        clock_counter <= 'b0; 
    else 
        clock_counter <= clock_counter + 1'b1;
end // always_ff


endmodule

