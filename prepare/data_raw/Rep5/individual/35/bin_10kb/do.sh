#!/bin/bash


for i in `seq 1 23`
do
cp ../chr${i}.dat test.dat
#awk '{print $1,$2,1}' ../chr${i}.dat > test.dat
echo -e test.dat '\n' density${i}.dat | ./getweightdensityfrombed.o
done
