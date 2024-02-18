#!/bin/bash

delta=0.20
winsize=10

#dir=/home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/Hi-C_highresolution/K562/10kb_resolution_intrachromosomal/boundary/smallscale_delta0.2

for i in `seq 1 23`
do
cd ${i}
bash do.sh $i $delta $winsize ${dir}
#cd random
#bash do.sh $i $delta $winsize ${dir}
#cd ../
cd ../
done


#cat *[0-9]/dist_sort.dat | sort -g | grep -v 10000 > test.dat
#statenum=`nl test.dat | tail -n 1 | awk '{print $1}'`
#targetcount=`cat test.dat | awk '{if($1<10.5) count++} END {print count}'`
#
#totalcount=`cat ${dir}/*[0-9]/targetpeakid.dat | nl | tail -n 1 | awk '{print $1}'`
#echo $targetcount $statenum $totalcount | awk '{print $1,$2,$3}' > statis.dat
#
#bash dorandom.sh $delta $winsize ${dir}
#
#cat statis.dat | awk '{print $1/$2}' > statis_ratio.dat
#cd pvalue
#bash do.sh
#cd ..
