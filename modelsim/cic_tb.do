# compile source
do {compile_src.do}


# run vsim
vsim -voptargs=+acc cic3_tb

#
# Source wave do file
#
do {cic_tb_wave.do}

#
# Set the window types
#
view wave
view structure
view signals

#
# End
#
