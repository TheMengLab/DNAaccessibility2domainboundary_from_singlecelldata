#!/bin/bash


for i in `seq 1 23`
do
statenum=`nl ../../../../../../chrlen/tempassign_10kb/assign${i}.dat | tail -n 1 | awk '{print $1}'`
paste ../../../../../../chrlen/tempassign_10kb/assign${i}.dat ../density${i}.dat | awk '{print $1,$2+0}' | awk '{print $2}' | head -n $statenum > density${i}.dat
done


for i in `seq 1 23`; do cat density${i}.dat ; done > densityall.dat

