#!/bin/bash

delta=0.20
winsize=10

cat *[0-9]/dist_sort.dat | sort -g | grep -v 10000 > test.dat
statenum=`nl test.dat | tail -n 1 | awk '{print $1}'`
targetcount=`cat test.dat | awk '{if($1<10.5) count++} END {print count}'`
#totalcount=`cat /media/group/2b2676b5-76e1-42af-864b-2152cf8da195/20201210/code/c/Nucleosome_model/segment_sample/HiC/simulation/Hi-C_highresolution/K562/10kb_resolution_intrachromosomal/boundary/delta/${delta}/win${winsize}/*/targetpeakid.dat | nl | tail -n 1 | awk '{print $1}'`
totalcount=`cat /home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/Hi-C_highresolution/K562/10kb_resolution_intrachromosomal/boundary/delta/${delta}/win${winsize}_nodelta_test/*[0-9]/targetpeakid.dat | nl | tail -n 1 | awk '{print $1}'`
echo $targetcount $statenum $totalcount | awk '{print $1,$2,$3}' > statis.dat

bash dorandom.sh $delta $winsize

cat statis.dat | awk '{print $1/$2}' > statis_ratio.dat
