#!/bin/bash

chrid=$1
delta=$2
winsize=$3
dir=$4
#cp /media/group/2b2676b5-76e1-42af-864b-2152cf8da195/20201210/code/c/Nucleosome_model/segment_sample/HiC/simulation/Hi-C_highresolution/K562/10kb_resolution_intrachromosomal/compartment/compartment_assign/clustering_H3K4me3_assign/chr_10kb/assign${chrid}_10kb.dat .

statenum=`nl ../score_topline.dat | tail -n 1 | awk '{print $1}'`

count=100
#count=$[statenum/1000]
rm dist_sort_*.dat

for i in `seq 1 ${count}`
do
awk -v C=${i} -v S=${statenum} '{print ($1+1000*C)%S,$2}' ../targetpeakid.dat > temp.dat
#echo -e temp.dat '\n' ../../../../hic_boundary/${chrid}/targetpeakid.dat '\n' dist.dat | ./getdomain_dist.o
#echo -e temp.dat '\n' /media/group/2b2676b5-76e1-42af-864b-2152cf8da195/20201210/code/c/Nucleosome_model/segment_sample/HiC/simulation/Hi-C_highresolution/K562/10kb_resolution_intrachromosomal/boundary/delta/${delta}/win${winsize}/${chrid}/targetpeakid.dat '\n' dist.dat | ./getdomain_dist.o
echo -e temp.dat '\n' ${dir}/${chrid}/targetpeakid.dat '\n' dist.dat | ./getdomain_dist.o


awk '{print $2}' dist.dat | sort -g > dist_sort_${i}.dat
done

