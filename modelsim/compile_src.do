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
vlog -incr -sv "../src/cic3_echip65.sv" 
vlog -incr -sv "../src/cic3_echip65_v2.sv" 
vlog -incr -sv "../src/sine_wave.sv" 
vlog -incr -sv "../src/sdm_rnm.sv" 

# Testbenches
#
vlog +incdir+../testbench/tasks/ -incr -sv "../testbench/sdm_cic3_tb.sv" 
vlog +incdir+../testbench/tasks/ -incr -sv "../testbench/cic3_tb.sv" 


