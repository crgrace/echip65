///////////////////////////////////////////////////////////////////
// File Name: shift_reg.sv
// Engineer:  Jyothisraj Johnson (jyothisrajjohnson@lbl.gov)
// Description: Model the modulator and filter clock generation scheme on-chip.
//              Uses 16-bit shift register to generate clock patterns.
///////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

module shift_reg  
    (output logic gen_clk, // Declare output to read out the current value of all flops in this register
    input [15:0] din_clk, // Declare 16-bit input data for the shift register
    input clk, // Declare input for clock to all flops in the shift register
    input rstn // Declare input to reset the register to a default value
    );    

logic [3:0] clk_counter_4b;

always_ff @ (posedge clk or negedge rstn) begin
    if (!rstn)
        clk_counter_4b <= 4'b0; 
    else 
        clk_counter_4b <= clk_counter_4b + 1'b1;
end // always_ff

//gen_clk generation
always_ff @ (posedge clk) begin
    if (!rstn)
        gen_clk <= 0;
    else begin
        case (clk_counter_4b)
            4'b0000:  gen_clk <= din_clk[0];
            4'b0001:  gen_clk <= din_clk[1];
            4'b0010:  gen_clk <= din_clk[2];
            4'b0011:  gen_clk <= din_clk[3];
            4'b0100:  gen_clk <= din_clk[4];
            4'b0101:  gen_clk <= din_clk[5];
            4'b0110:  gen_clk <= din_clk[6];
            4'b0111:  gen_clk <= din_clk[7];
            4'b1000:  gen_clk <= din_clk[8];
            4'b1001:  gen_clk <= din_clk[9];
            4'b1010:  gen_clk <= din_clk[10];
            4'b1011:  gen_clk <= din_clk[11];
            4'b1100:  gen_clk <= din_clk[12];
            4'b1101:  gen_clk <= din_clk[13];
            4'b1110:  gen_clk <= din_clk[14];
            4'b1111:  gen_clk <= din_clk[15];
        endcase
    end
end // always_ff

endmodule