onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cic3_tb/in
add wave -noupdate /cic3_tb/clk
add wave -noupdate /cic3_tb/d_clk
add wave -noupdate /cic3_tb/reset_n
add wave -noupdate /cic3_tb/out
add wave -noupdate /cic3_tb/cic/clk
add wave -noupdate /cic3_tb/cic/rst
add wave -noupdate -radix decimal /cic3_tb/cic/decimation_ratio
add wave -noupdate /cic3_tb/cic/d_in
add wave -noupdate /cic3_tb/cic/d_out
add wave -noupdate /cic3_tb/cic/d_clk
add wave -noupdate /cic3_tb/cic/d_tmp
add wave -noupdate /cic3_tb/cic/d_d_tmp
add wave -noupdate /cic3_tb/cic/d1
add wave -noupdate /cic3_tb/cic/d2
add wave -noupdate /cic3_tb/cic/d3
add wave -noupdate /cic3_tb/cic/d6
add wave -noupdate /cic3_tb/cic/d_d6
add wave -noupdate /cic3_tb/cic/d7
add wave -noupdate /cic3_tb/cic/d_d7
add wave -noupdate -radix unsigned -childformat {{{/cic3_tb/cic/d8[24]} -radix unsigned} {{/cic3_tb/cic/d8[23]} -radix unsigned} {{/cic3_tb/cic/d8[22]} -radix unsigned} {{/cic3_tb/cic/d8[21]} -radix unsigned} {{/cic3_tb/cic/d8[20]} -radix unsigned} {{/cic3_tb/cic/d8[19]} -radix unsigned} {{/cic3_tb/cic/d8[18]} -radix unsigned} {{/cic3_tb/cic/d8[17]} -radix unsigned} {{/cic3_tb/cic/d8[16]} -radix unsigned} {{/cic3_tb/cic/d8[15]} -radix unsigned} {{/cic3_tb/cic/d8[14]} -radix unsigned} {{/cic3_tb/cic/d8[13]} -radix unsigned} {{/cic3_tb/cic/d8[12]} -radix unsigned} {{/cic3_tb/cic/d8[11]} -radix unsigned} {{/cic3_tb/cic/d8[10]} -radix unsigned} {{/cic3_tb/cic/d8[9]} -radix unsigned} {{/cic3_tb/cic/d8[8]} -radix unsigned} {{/cic3_tb/cic/d8[7]} -radix unsigned} {{/cic3_tb/cic/d8[6]} -radix unsigned} {{/cic3_tb/cic/d8[5]} -radix unsigned} {{/cic3_tb/cic/d8[4]} -radix unsigned} {{/cic3_tb/cic/d8[3]} -radix unsigned} {{/cic3_tb/cic/d8[2]} -radix unsigned} {{/cic3_tb/cic/d8[1]} -radix unsigned} {{/cic3_tb/cic/d8[0]} -radix unsigned}} -expand -subitemconfig {{/cic3_tb/cic/d8[24]} {-radix unsigned} {/cic3_tb/cic/d8[23]} {-radix unsigned} {/cic3_tb/cic/d8[22]} {-radix unsigned} {/cic3_tb/cic/d8[21]} {-radix unsigned} {/cic3_tb/cic/d8[20]} {-radix unsigned} {/cic3_tb/cic/d8[19]} {-radix unsigned} {/cic3_tb/cic/d8[18]} {-radix unsigned} {/cic3_tb/cic/d8[17]} {-radix unsigned} {/cic3_tb/cic/d8[16]} {-radix unsigned} {/cic3_tb/cic/d8[15]} {-radix unsigned} {/cic3_tb/cic/d8[14]} {-radix unsigned} {/cic3_tb/cic/d8[13]} {-radix unsigned} {/cic3_tb/cic/d8[12]} {-radix unsigned} {/cic3_tb/cic/d8[11]} {-radix unsigned} {/cic3_tb/cic/d8[10]} {-radix unsigned} {/cic3_tb/cic/d8[9]} {-radix unsigned} {/cic3_tb/cic/d8[8]} {-radix unsigned} {/cic3_tb/cic/d8[7]} {-radix unsigned} {/cic3_tb/cic/d8[6]} {-radix unsigned} {/cic3_tb/cic/d8[5]} {-radix unsigned} {/cic3_tb/cic/d8[4]} {-radix unsigned} {/cic3_tb/cic/d8[3]} {-radix unsigned} {/cic3_tb/cic/d8[2]} {-radix unsigned} {/cic3_tb/cic/d8[1]} {-radix unsigned} {/cic3_tb/cic/d8[0]} {-radix unsigned}} /cic3_tb/cic/d8
add wave -noupdate /cic3_tb/cic/d_d8
add wave -noupdate /cic3_tb/cic/count
add wave -noupdate /cic3_tb/cic/v_comb
add wave -noupdate /cic3_tb/cic/d_clk_tmp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {201 us} {621 us}
