#!/bin/bash

chrid=$1

dir=../mergepoint/

filenum=`ls ${dir}/[1-9]*_chr${chrid}.dat | nl | tail -n 1 | awk '{print $1}'`
#filenum=`ls ../[1-9]*.dat | nl | tail -n 1 | awk '{print $1}'`

for id in `seq ${chrid} ${chrid}`
do

nl ../../prepare/chrlen/tempassign_10kb/chrassignall.dat | awk '{print $1,$2}' | grep " "$[id]$ > temp_chr${id}.dat
sid=`head -n 1 temp_chr${id}.dat | awk '{print $1}'`
eid=`tail -n 1 temp_chr${id}.dat | awk '{print $1}'`
echo $id $sid $eid


ls ${dir}/[1-9]*_chr${id}.dat > filelist_chr${id}.dat

nl ${dir}/1_chr${id}.dat | awk '{print $1,1}' > targetid_chr${id}.dat

atomnum=`nl ${dir}/1_chr${id}.dat | tail -n 1 | awk '{print $1}'`

time echo -e filelist_chr${id}.dat '\n' ${atomnum} '\n' targetid_chr${id}.dat '\n' 4 '\n' 100 '\n' matrix4_chr${id}_norm_top100.dat | ./getcontactmatrix_dark_noneigh_norm_topline.o 
#Input the filename for filelist of original coordinate:
#Input the number of atoms in this system:
#Input filename for target atomlist(start from 1):
#Input the cutoff for contact dist(with radius of 10):
#Input the value for top linenum:
#Input filename for output:

rm tempcoor/[1-9]*_chr${id}.dat
done


