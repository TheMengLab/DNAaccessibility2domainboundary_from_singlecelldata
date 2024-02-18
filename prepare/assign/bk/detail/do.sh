#!/bin/bash

#chrid=22
repnum=500
#for i in `seq ${chrid} ${chrid}`
#do
#cat ../density${i}.dat
#done > densityall.dat

#cp assign${chrid}_10kb_compbk.dat compartassign${chrid}_10kb.dat

#linenum=`nl densityall.dat | tail -n 1 | awk '{print $1}'`
#basevalue=`sort -g densityall.dat | head -n $[linenum/2] | tail -n 1 | awk '{print $1*3/4}'`
#
#echo $basevalue
#echo -e densityall.dat '\n' ${basevalue} '\n' 8 '\n' assign${chrid}_10kb.dat '\n' pointlen${chrid}_10kb.dat '\n' mass${chrid}_10kb.dat | ./gendensity_detailbead_mass.o
#echo $basevalue
#echo -e density_chr1_20M_50M.dat '\n' 0.014 '\n' 6 '\n' assign.dat '\n' pointlen.dat| ./gendensity_detailbead.o 
#echo -e densityall.dat '\n'  8 '\n' assign.dat '\n' pointlen.dat '\n' mass.dat | ./gendensity_detailbead_mass_uplimit.o 
#echo -e density_chr1_20M_50M.dat '\n' 0.014 '\n' 6 '\n' assign.dat '\n' pointlen.dat '\n' mass3.dat | ./gendensity_detailbead_mass3.o 
#Input filename for density data:
#Input filename for interval:
#Input the maxlen for each bin:
#Input filename for output:

awk '{print $1}' ../len1.dat > assign${chrid}_10kb_compbk.dat

for id in `seq 1 $repnum`
do
cp assign${chrid}_10kb_compbk.dat compartassign${chrid}_10kb.dat
cp ../len${id}.dat len${chrid}_10kb_rep${id}.dat

list="
10
"

#for res in $list
#do
#echo -e len${chrid}_${res}kb_rep${id}.dat '\n' compartassign${chrid}_${res}kb.dat '\n' 2 '\n' len${chrid}_$[res*2]kb_rep${id}.dat '\n' assign${chrid}_$[res*2]kb_rep${id}.dat '\n' compartassign${chrid}_$[res*2]kb.dat | ./gendensity_detailbead_mass_coarse.o
##echo -e pointlen_${res}kb.dat '\n' 2 '\n' pointlen_$[res*2]kb.dat '\n' assign_$[res*2]kb.dat | ./gendensity_detailbead_mass_coarse.o 
##Input the filename for original pointlen:
##Input the ratio for coarse-graining:
##Input the filename for output pointlen:
##Input the filename for output assignment:
#
#done

res=10
echo -e len${chrid}_${res}kb_rep${id}.dat '\n' compartassign${chrid}_${res}kb.dat '\n' 1 '\n' len${chrid}_$[res]kb_rep${id}_check.dat '\n' assign${chrid}_$[res]kb_rep${id}.dat '\n' compartassign${chrid}_$[res]kb_check.dat | ./gendensity_detailbead_mass_coarse.o

for res in $list
do
awk -v CID=${chrid} '{print CID-1,$1}' compartassign${chrid}_${res}kb.dat > temp.dat
mv temp.dat compartassign${chrid}_${res}kb.dat


#awk '{print $2}' compartassign1_${res}kb.dat > compartassign1_${res}kb_1col.dat


echo -e assign${chrid}_${res}kb_rep${id}.dat '\n' compartassign${chrid}_${res}kb.dat '\n' beadcompartassign${chrid}_${res}kb_rep${id}.dat | ./micro2macromap_chain.o



done


#
#res=640
#
#awk -v CID=${chrid} '{print CID-1,$1}' compartassign${chrid}_${res}kb.dat > temp.dat
#mv temp.dat compartassign${chrid}_${res}kb.dat
#
#
##awk '{print $2}' compartassign1_${res}kb.dat > compartassign1_${res}kb_1col.dat
#
#
#echo -e assign${chrid}_${res}kb_rep${id}.dat '\n' compartassign${chrid}_${res}kb.dat '\n' beadcompartassign${chrid}_${res}kb_rep${id}.dat | ./micro2macromap_chain.o
#
done

rm beadcompartassign*.dat
rm len_10kb_*.dat

