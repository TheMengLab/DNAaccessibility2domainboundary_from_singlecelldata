#!/bin/bash

repid=$1
#chrid=22
confnum=50
#statenum=3908
statenum=`nl ../../../assign/detail/assign${chrid}_640kb_rep${repid}.dat | tail -n 1 | awk '{print $1}'`

for i in `seq 1 50`
do
echo -e ${statenum} '\n' 0.1 '\n' $[repid*confnum+i] '\n' conf${i}.dat | ./genrandomconf_v2.o
#Input the number of beads in the system:
#Input the length of chromatin in each bead(in the unit of 10kb):
#Input the number of points for the free molecules:
#Input the initial seed for random number generation:
#Input the filename for output:
done

#while read line
#do 
#ls ../../assign/density_medcutoff/density_${line}.dat 
#done < ../targetlist.dat > filelist.dat
#
#
#
#
#echo -e filelist.dat '\n' 1000 '\n' assign.dat | ./genassign_chr.o
##Input the filename for input list:
##Input the length of each file:
##Input the filename for output:
#
