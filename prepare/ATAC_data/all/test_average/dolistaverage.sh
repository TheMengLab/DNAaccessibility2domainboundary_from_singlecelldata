#!/bin/bash
ls ../densityall_*.dat > filelist.dat
echo -e filelist.dat '\n' output_nozero.dat | ./listaverage_nozero.o
#echo -e filelist.dat '\n' output.dat | ./listaverage.o 
#Input the name for input list file:
#Input the filename for output:

awk '{print $1}' output_nozero.dat > ave.dat


cat ave.dat | grep -v 0.000000 | nl | awk '{SUM+=$2} END {print SUM/$1}' > ave_statis.dat
