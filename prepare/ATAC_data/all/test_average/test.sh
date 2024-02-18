#!/bin/bash


cat ave[1-9]*.dat | grep -v 0.000000 | sort -g > ave_sort.dat
linenum=`nl ave_sort.dat | tail -n 1 | awk '{print $1}'`
head -n $[linenum/2] ave_sort.dat | tail -n 1 > ave_median.dat
