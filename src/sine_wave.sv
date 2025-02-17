`timescale 1ns/10ps
package math_pkg;

  //import dpi task      C Name = SV function name

  import "DPI" pure function real cos (input real rTheta);

  import "DPI" pure function real sin (input real rTheta);

  import "DPI" pure function real log (input real rVal);

  import "DPI" pure function real log10 (input real rVal);

endpackage : math_pkg

module sine_wave(output real sine_out);


  import math_pkg::*;

 

  parameter  sampling_time = 5;

  const real pi = 3.1416;

  real       time_us, time_s ;

  bit        sampling_clock;

  real       freq = 1.0231e3;

  real       offset = 0.0;

  real       ampl = 0.9;

 

  always sampling_clock = #(sampling_time) ~sampling_clock;

 

  always @(sampling_clock) begin

    time_us = $time/1000;

    time_s = time_us/1000000;

  end

  assign sine_out = offset + (ampl * sin(2*pi*freq*time_s));

endmodule
