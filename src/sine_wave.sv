`timescale 1ns/10ps

///////////////////////////////////////////////////////////////////
// File Name: sine_wave.sv
// Engineer:  Carl Grace (crgrace@lbl.gov)
// Description: Generates real-valued sine wave for use in testbenches
// uses verilog PLI facility
////////////////////////////////////////////////////////////////////

module sine_wave(output real sine_out);
parameter  sampling_time = 5;
real pi = 3.1416;
real       time_us, time_s ;
bit        sampling_clock;
real       freq = 1.0231e3;
real       offset = 0.0;
real       ampl = 0.9;

always sampling_clock = #(sampling_time) ~sampling_clock;

always @(sampling_clock) begin
    time_us = $time/1000;
    time_s = time_us/1000000;
end // always

assign sine_out = offset + (ampl * $sin(2*pi*freq*time_s));

endmodule
