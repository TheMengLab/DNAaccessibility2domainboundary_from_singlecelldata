#!/bin/bash

filename=`ls ../../data_raw/*Rep1.*`
ls $filename
awk '{print $4}' ${filename} | sort -u   > barcode.dat

time echo -e barcode.dat '\n' ${filename} '\n' count.dat | ./convert_sc.o

paste count.dat barcode.dat | awk '{print $1,$2}' | sort -g | tail -n 100 > top100.dat
awk '{print $2}' top100.dat > barcode_top100.dat

time echo -e barcode_top100.dat '\n' ${filename} '\n' data_target.dat | ./convert_sc_target.o
./liftOver data_target.dat hg38ToHg19.over.chain.gz data_target_hg19.dat ummap
bash getcelldata.sh

