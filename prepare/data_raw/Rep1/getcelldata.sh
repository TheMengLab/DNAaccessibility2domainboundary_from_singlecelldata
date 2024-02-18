#!/bin/bash


i=1

rm cell*.dat
while read line
do

grep ${line} data_target_hg19.dat > cell${i}.dat
i=$[i+1]
done < barcode_top100.dat

