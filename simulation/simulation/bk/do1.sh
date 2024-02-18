#!/bin/bash

#repid=$1
confid=$1
res=10
#chrid=22

#cp ../../../data/medcutoff/chr_all/assignall_1280kb.dat .

awk '{print 1}' ../../initconf/conf${confid}.dat > sudoassign.dat
#awk '{print 1}' ../../../assignment/multi_chr/chr22/assign22_${res}kb.dat > sudoassign.dat
cp sudoassign.dat sudodensity.dat
cp sudoassign.dat sudomass.dat
awk '{print 1 1}' sudoassign.dat > beadcompartassign.dat
for i in `seq ${confid} ${confid}`
do
cp ../../initconf/conf${i}.dat  initconf${res}.dat
time echo -e initconf${res}.dat '\n' sudoassign.dat '\n' sudodensity.dat '\n' 1 '\n' sudomass.dat '\n' beadcompartassign.dat '\n' 1 '\n' 150000 '\n' 150000 '\n' 15000 '\n' ${i} '\n' output_${res}.dat | ./runMD_feature_v25_continue_v2_density_mass_compartment.o
#Input filename for original data:
#Input the assignment for chromatin point:
#Input the value for bond lenth:
#Input the step number for iteration:
#Input the interval for saving:
#Input the value for random number generator:
#Input filename for output:

done
