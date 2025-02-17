module sdm_rnm (
    output logic Dout,
    input real Ain,
    input logic clk_1mhz,
    input logic reset_n);

real dlay[2:1];
real sdm_sign_val;
real sdm_sum1; 
real sdm_sum2;
real test;

always @(negedge clk_1mhz)
begin
//    set_dlay (1, sdm_sum1); // Unit delayed values 
//    set_dlay (2, sdm_sum2);
    dlay[1] = sdm_sum1;
    dlay[2] = test;
    sdm_sum1 = Ain/8.0 + dlay[1] - sdm_sign_val/8.0; 
    test = sdm_sum1/2.0 +dlay[2]-sdm_sign_val/8.0; 
    if (dlay[2] > 0.0) begin // SIGNAL
        sdm_sign_val = 1.0;
    end
    else if (dlay[2] < 0.0) begin
        sdm_sign_val = -1.0;
    end
    else begin
        sdm_sign_val = 0.0;
    end
    if (sdm_sign_val< 0.0) begin // Dout
        Dout = 0;
    end
    else begin
        Dout = 1;
    end
end
endmodule // sdm_-rnm
