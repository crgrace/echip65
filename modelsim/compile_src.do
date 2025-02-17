#
# Create work library
#
vlib work

#
# Map libraries
#
vmap work  

#
# Design sources
#
vlog -incr -sv "../src/sinc3_filter.v" 
vlog -incr -sv "../src/cic3_alt.sv" 
vlog -incr -sv "../src/cic3_echip65.sv" 
vlog -incr -sv "../src/sine_wave.sv" 
vlog -incr -sv "../src/sdm_2nd_order.sv" 
vlog -incr -sv "../src/sdm_rnm.sv" 


vlog -incr  "../src/CIC.v" 


# Testbenches
#
vlog -incr -sv "../testbench/sdm_cic3_tb.sv" 
vlog -incr -sv "../testbench/cic3_tb.sv" 
vlog -incr -sv "../testbench/cic_tb.sv" 


