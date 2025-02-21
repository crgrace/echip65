///////////////////////////////////////////////////////////////////
// File Name: sdm_rnm.sv
// Engineer:  Carl Grace (crgrace@lbl.gov)
// Description: Real-Number Model of 2nd-order sigma-delta modulator
////////////////////////////////////////////////////////////////////

module sdm_rnm (
    output logic dout,
    input real analog_in,
    input logic clk,
    input logic reset_n);

real delay[2:1];
real sdm_sign_val;
real sdm_sum1; 
real sdm_sum2;
real test;

always @(negedge clk)
begin
    delay[1] = sdm_sum1;
    delay[2] = test;
    sdm_sum1 = analog_in/8.0 + delay[1] - sdm_sign_val/8.0; 
    test = sdm_sum1/2.0 +delay[2]-sdm_sign_val/8.0; 
    if (delay[2] > 0.0) begin // SIGNAL
        sdm_sign_val = 1.0;
    end
    else if (delay[2] < 0.0) begin
        sdm_sign_val = -1.0;
    end
    else begin
        sdm_sign_val = 0.0;
    end
    if (sdm_sign_val< 0.0) begin // dout
        dout = 0;
    end
    else begin
        dout = 1;
    end
end
endmodule // sdm_-rnm
