#!/bin/bash

#typeid=$1
chrid=$1
#chrid=22

#targetfile=/home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/toymodel/4/assign/detail/assign_10kb_rep1.dat
#dir=/home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/HSC/openfitting/mm9/chr11_15M_25M/${typeid}/assign/detail
dir=../prepare/assign/${chrid}/detail/
#targetfile=/home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/HSC/openfitting/mm10/chr11_15M_25M/CLP/assign/detail/assign_10kb_rep1.dat

statenum=`nl tempfile/1.dat | tail -n 1 | awk '{print $1}'`


repnum=500

filenum=`ls tempfile/[1-9]*.dat | nl | tail -n 1 | awk '{print $1}'`

id=1
for repid in `seq 1 $repnum`
do
	targetfile=${dir}/assign_10kb_rep${repid}.dat
	targetsegnum=`nl $targetfile | tail -n 1 | awk '{print $1}'`

	echo $targetfile
	echo $targetsegnum
#	cp $targetfile assign.dat
#	for i in `seq 1 $filenum`
#	do
	i=$[RANDOM%filenum+1]
		for k in `seq 1 1`
		do
		head -n $[RANDOM%(statenum-targetsegnum)+targetsegnum] tempfile/${i}.dat | tail -n ${targetsegnum} > ${id}_chr${chrid}.dat
		echo -e ${id}_chr${chrid}.dat '\n' ${dir}/assign_10kb_rep${repid}.dat '\n' ./mergepoint/${id}_chr${chrid}.dat | ./mergecoor.o
		rm ${id}_chr${chrid}.dat
		id=$[id+1]
		done
#	done
done

