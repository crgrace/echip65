onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 84 -max 0.90000000000000002 -min -0.90000000000000002 /sdm_cic3_tb/sine_input
add wave -noupdate /sdm_cic3_tb/modulator_out
add wave -noupdate /sdm_cic3_tb/digital_monitor_sel
add wave -noupdate /sdm_cic3_tb/clk
add wave -noupdate /sdm_cic3_tb/reset_n
add wave -noupdate -format Analog-Step -height 84 -max 15943300.0 /sdm_cic3_tb/cic_out
add wave -noupdate /sdm_cic3_tb/checkMonitor/monitor_expected
add wave -noupdate /sdm_cic3_tb/sine_wave/sine_out
add wave -noupdate /sdm_cic3_tb/sine_wave/pi
add wave -noupdate /sdm_cic3_tb/sine_wave/time_us
add wave -noupdate /sdm_cic3_tb/sine_wave/time_s
add wave -noupdate /sdm_cic3_tb/sine_wave/sampling_clock
add wave -noupdate /sdm_cic3_tb/sine_wave/freq
add wave -noupdate /sdm_cic3_tb/sine_wave/offset
add wave -noupdate /sdm_cic3_tb/sine_wave/ampl
add wave -noupdate /sdm_cic3_tb/sdm_rdm/dout
add wave -noupdate /sdm_cic3_tb/sdm_rdm/analog_in
add wave -noupdate /sdm_cic3_tb/sdm_rdm/clk
add wave -noupdate /sdm_cic3_tb/sdm_rdm/reset_n
add wave -noupdate /sdm_cic3_tb/sdm_rdm/sdm_sign_val
add wave -noupdate /sdm_cic3_tb/sdm_rdm/sdm_sum1
add wave -noupdate /sdm_cic3_tb/sdm_rdm/sdm_sum2
add wave -noupdate /sdm_cic3_tb/sdm_rdm/test
add wave -noupdate /sdm_cic3_tb/cic3_echip65/out
add wave -noupdate /sdm_cic3_tb/cic3_echip65/in
add wave -noupdate /sdm_cic3_tb/cic3_echip65/digital_monitor_sel
add wave -noupdate /sdm_cic3_tb/cic3_echip65/clk
add wave -noupdate /sdm_cic3_tb/cic3_echip65/reset_n
add wave -noupdate /sdm_cic3_tb/cic3_echip65/in_coded
add wave -noupdate /sdm_cic3_tb/cic3_echip65/acc1
add wave -noupdate /sdm_cic3_tb/cic3_echip65/acc2
add wave -noupdate /sdm_cic3_tb/cic3_echip65/acc3
add wave -noupdate /sdm_cic3_tb/cic3_echip65/acc3_d
add wave -noupdate /sdm_cic3_tb/cic3_echip65/diff1
add wave -noupdate /sdm_cic3_tb/cic3_echip65/diff2
add wave -noupdate /sdm_cic3_tb/cic3_echip65/diff3
add wave -noupdate /sdm_cic3_tb/cic3_echip65/diff1_d
add wave -noupdate /sdm_cic3_tb/cic3_echip65/diff2_d
add wave -noupdate /sdm_cic3_tb/cic3_echip65/clock_counter
add wave -noupdate /sdm_cic3_tb/cic3_echip65/divided_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1894398110 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 353
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {199885830 ps} {200006010 ps}
