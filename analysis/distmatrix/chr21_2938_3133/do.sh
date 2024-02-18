#!/bin/bash


chrid=21
id1=2938
id2=3133

filenum=`ls ../../mergepoint/[1-9]*_chr${chrid}.dat | nl | tail -n 1 | awk '{print $1}'`

for id in `seq ${chrid} ${chrid}`
do



sid=$id1
eid=$[id2-1]
echo $id $sid $eid

rm tempcoor/*_chr${id}.dat
for i in `seq 1 $filenum`
do
head -n $[eid] ../../mergepoint/${i}_chr${chrid}.dat | tail -n $[eid-sid+1] > tempcoor/${i}_chr${id}.dat
done



##nl ../1.dat | awk '{print $1,$2}'  > temp_chr${id}.dat
#nl ../../../../assign/detail/chrassign_10kb.dat | awk '{print $1,$2}' | grep " "$[id-1]$ > temp_chr${id}.dat
#sid=`head -n ${id1} temp_chr${id}.dat | tail -n 1 | awk '{print $1}'`
#eid=`head -n $[id2-1] temp_chr${id}.dat | tail -n 1 | awk '{print $1}'`
#echo $id $sid $eid
#
#rm tempcoor/*_chr${id}.dat
#for i in `seq 1 $filenum`
#do
#head -n $[eid] ../../${i}.dat | tail -n $[eid-sid+1] > tempcoor/${i}_chr${id}.dat
#done

ls tempcoor/[1-9]*_chr${id}.dat > filelist.dat

nl tempcoor/1_chr${id}.dat | awk '{print $1,1}' > targetid.dat

#time echo -e filelist.dat '\n' $[eid-sid+1] '\n' targetid.dat '\n' 4 '\n' matrix4_norm.dat | ./getcontactmatrix_dark_noneigh_norm.o
#time echo -e filelist.dat '\n' $[eid-sid+1] '\n' targetid.dat '\n' 4 '\n' matrix4_norm_chr${id}.dat '\n' 1 | ./getcontactmatrix_dark_noneigh_norm_targetchrid_coarse_scale.o

#time echo -e filelist.dat '\n' $[eid-sid+1] '\n' 3 '\n' matrix${id}_30kb.dat | ./getdistmatrix_coor_median_ratio.o
time echo -e filelist.dat '\n' $[eid-sid+1] '\n' 3 '\n' matrix${id}_30kb.dat | ./getdistmatrix_coor_ave_ratio.o
#time echo -e filelist.dat '\n' $[eid-sid+1] '\n' 1 '\n' matrix${id}_10kb_log.dat | ./getdistmatrix_coor_normlog_median_ratio.o


done

gnuplot plot.plt

