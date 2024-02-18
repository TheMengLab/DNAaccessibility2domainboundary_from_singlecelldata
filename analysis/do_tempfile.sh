#!/bin/bash

#typeid=$1
#chrid=$1
#chrid=22
res=10

#targetfile=/home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/toymodel/4/assign/detail/assign_10kb_rep1.dat
#dir=/home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/HSC/openfitting/mm9/chr11_15M_25M/${typeid}/assign/detail
#dir=./prepare/assign/${chrid}/detail/
#targetfile=/home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/HSC/openfitting/mm10/chr11_15M_25M/CLP/assign/detail/assign_10kb_rep1.dat

statenum=`nl ../simulation/initconf/conf1.dat | tail -n 1 | awk '{print $1}'`

for i in `seq 1 10`
do
	ls ../simulation/simulation/${i}/output_${res}.dat
done > filelist.dat
#ls ../*/output_10.dat > filelist.dat

filenum=`nl filelist.dat | tail -n 1 | awk '{print $1}'`

i=1



while read line
do
confnum=`grep S ${line} | nl | tail -n 1 | awk '{print $1}'`
linenum=`cat ${line} | nl | tail -n 1 | awk '{print $1}'`

if [ $[confnum+confnum*statenum] == $[linenum]  ]
then
tail -n ${statenum} ${line} > tempfile/${i}.dat
i=$[i+1]
fi

done < filelist.dat

