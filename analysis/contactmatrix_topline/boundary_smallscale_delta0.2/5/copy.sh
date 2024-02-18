#!/bin/bash


while read line
do
cp boundaryplot.plt ${line}/
cp doplot.sh ${line}/
cd ${line}/
bash doplot.sh
cd -
done < list.dat

