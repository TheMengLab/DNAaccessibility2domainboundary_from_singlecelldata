#!/bin/bash

repid=$1
#chrid=22

#targetfile=/home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/toymodel/4/assign/detail/assign_10kb_rep1.dat
targetfile=/home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/HSC/openfitting/mm10/chr11_15M_25M/CLP/assign/detail/assign_10kb_rep1.dat

statenum=`nl ../../../../assign/detail/assign${chrid}_10kb_rep${repid}.dat | tail -n 1 | awk '{print $1}'`

ls ../*/output_10.dat > filelist.dat

i=1



#while read line
#do
#confnum=`grep S ${line} | nl | tail -n 1 | awk '{print $1}'`
#linenum=`cat ${line} | nl | tail -n 1 | awk '{print $1}'`
#
#if [ $[confnum+confnum*statenum] == $[linenum]  ]
#then
#tail -n ${statenum} ${line} > tempfile/${i}.dat
#i=$[i+1]
#fi
#
#done < filelist.dat


#targetsegnum=`nl /home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/part/toymodel/4/assign/detail/assign${chrid}_10kb_rep1.dat | tail -n 1 | awk '{print $1}'`
targetsegnum=`nl $targetfile | tail -n 1 | awk '{print $1}'`

cp $targetfile assign.dat

filenum=`nl filelist.dat | tail -n 1 | awk '{print $1}'`

id=1
for i in `seq 1 $filenum`
do
	for j in `seq 1 10`
	do
		head -n $[RANDOM%(statenum-targetsegnum)+targetsegnum] tempfile/${i}.dat | tail -n ${targetsegnum} > ${id}.dat
		id=$[id+1]
	done
done



##cat ../[1-9]*/output_1.dat > data.dat
#
#confnum=`grep S data.dat | nl | tail -n 1 | awk '{print $1}'`
#
#for i in `seq 1 $confnum`
#do
#echo ${i}.dat
#done > filelist.dat
#
#echo -e data.dat '\n' filelist.dat '\n' $[statenum+1] | ./splitfile.o
#
#for i in `seq 1 $confnum`
#do
#tail -n ${statenum} ${i}.dat > temp.dat
#mv temp.dat ${i}.dat
#done
#rm data.dat
#
##confnum=`ls ../[1-9]*/output_1.dat | nl | tail -n 1 | awk '{print $1}'`
###confnum=`nl ../output.dat | tail -n 1 | awk -v NUM=${statenum} '{print $1/(NUM+1)}'`
##
###echo $confnum
###rm [1-9]*.dat
##ls ../[1-9]*/output_1.dat > templist.dat
##
##rm finallist.dat
##while read line
##do
##linenum=`nl $line | tail -n 1 | awk '{print $1}'`
##if [ $linenum = $[statenum*3+3] ]
##then
##echo $line
##fi
##done < templist.dat > finallist.dat
##
##rm [1-9]*.dat
##
##i=1
##while read line
##do
##tail -n $statenum $line > ${i}.dat
##i=$[i+1]
##done < finallist.dat
###for i in `seq 1 $confnum`
###do
###tail -n $statenum ../output${i}.dat > ${i}.dat
####echo ${i}.dat
###done 
###
