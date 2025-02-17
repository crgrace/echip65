onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cic3_tb/clk
add wave -noupdate /cic3_tb/in
add wave -noupdate -radix decimal -childformat {{{/cic3_tb/out[13]} -radix decimal} {{/cic3_tb/out[12]} -radix decimal} {{/cic3_tb/out[11]} -radix decimal} {{/cic3_tb/out[10]} -radix decimal} {{/cic3_tb/out[9]} -radix decimal} {{/cic3_tb/out[8]} -radix decimal} {{/cic3_tb/out[7]} -radix decimal} {{/cic3_tb/out[6]} -radix decimal} {{/cic3_tb/out[5]} -radix decimal} {{/cic3_tb/out[4]} -radix decimal} {{/cic3_tb/out[3]} -radix decimal} {{/cic3_tb/out[2]} -radix decimal} {{/cic3_tb/out[1]} -radix decimal} {{/cic3_tb/out[0]} -radix decimal}} -subitemconfig {{/cic3_tb/out[13]} {-height 17 -radix decimal} {/cic3_tb/out[12]} {-height 17 -radix decimal} {/cic3_tb/out[11]} {-height 17 -radix decimal} {/cic3_tb/out[10]} {-height 17 -radix decimal} {/cic3_tb/out[9]} {-height 17 -radix decimal} {/cic3_tb/out[8]} {-height 17 -radix decimal} {/cic3_tb/out[7]} {-height 17 -radix decimal} {/cic3_tb/out[6]} {-height 17 -radix decimal} {/cic3_tb/out[5]} {-height 17 -radix decimal} {/cic3_tb/out[4]} {-height 17 -radix decimal} {/cic3_tb/out[3]} {-height 17 -radix decimal} {/cic3_tb/out[2]} {-height 17 -radix decimal} {/cic3_tb/out[1]} {-height 17 -radix decimal} {/cic3_tb/out[0]} {-height 17 -radix decimal}} /cic3_tb/out
add wave -noupdate /cic3_tb/reset_n
add wave -noupdate -radix decimal -childformat {{{/cic3_tb/cic3_echip65/diff3[25]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[24]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[23]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[22]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[21]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[20]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[19]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[18]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[17]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[16]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[15]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[14]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[13]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[12]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[11]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[10]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[9]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[8]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[7]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[6]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[5]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[4]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[3]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[2]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[1]} -radix decimal} {{/cic3_tb/cic3_echip65/diff3[0]} -radix decimal}} -subitemconfig {{/cic3_tb/cic3_echip65/diff3[25]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[24]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[23]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[22]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[21]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[20]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[19]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[18]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[17]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[16]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[15]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[14]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[13]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[12]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[11]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[10]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[9]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[8]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[7]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[6]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[5]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[4]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[3]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[2]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[1]} {-radix decimal} {/cic3_tb/cic3_echip65/diff3[0]} {-radix decimal}} /cic3_tb/cic3_echip65/diff3
add wave -noupdate /cic3_tb/cic3_echip65/out
add wave -noupdate /cic3_tb/cic3_echip65/in
add wave -noupdate /cic3_tb/cic3_echip65/clk
add wave -noupdate /cic3_tb/cic3_echip65/reset_n
add wave -noupdate /cic3_tb/cic3_echip65/in_coded
add wave -noupdate /cic3_tb/cic3_echip65/acc1
add wave -noupdate /cic3_tb/cic3_echip65/acc2
add wave -noupdate /cic3_tb/cic3_echip65/acc3
add wave -noupdate /cic3_tb/cic3_echip65/acc3_d
add wave -noupdate /cic3_tb/cic3_echip65/diff1
add wave -noupdate /cic3_tb/cic3_echip65/diff2
add wave -noupdate /cic3_tb/cic3_echip65/diff3
add wave -noupdate /cic3_tb/cic3_echip65/diff1_d
add wave -noupdate /cic3_tb/cic3_echip65/diff2_d
add wave -noupdate /cic3_tb/cic3_echip65/clock_counter
add wave -noupdate /cic3_tb/cic3_echip65/divided_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50900000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 275
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {77111680 ps}
