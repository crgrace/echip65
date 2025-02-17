#!/bin/bash

echo  'delete old files for a clean start'

rm -rf work

echo 'run modelsim'
if [ $# -gt 0 ]; then
    # found something on the command line
    echo "running $1.do"
    vsim -do "$1".do

else
    # default testbench is verilog_tb
    echo 'running cic_tb.do'
    vsim -do cic3_tb.do
fi

