#!/bin/bash

repid=$1
#chrid=22

statenum=`nl ../../../../assign/detail/assign${chrid}_10kb_rep${repid}.dat | tail -n 1 | awk '{print $1}'`

ls ../*/output_10.dat > filelist.dat

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


#targetsegnum=`nl /home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/toymodel/4/assign/detail/assign${chrid}_10kb_rep1.dat | tail -n 1 | awk '{print $1}'`
#
#filenum=`nl filelist.dat | tail -n 1 | awk '{print $1}'`
#
#id=1
#for i in `seq 1 $filenum`
#do
#	for j in `seq 1 10`
#	do
#		head -n $[RANDOM%(statenum-targetsegnum)+targetsegnum] tempfile/${i}.dat | tail -n ${targetsegnum} > ${id}.dat
#		id=$[id+1]
#	done
#done
#
#
#
