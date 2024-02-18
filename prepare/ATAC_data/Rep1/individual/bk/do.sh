#!/bin/bash


repid=$1
id=$2
#cp ../wgEncodeAwgDnaseUwdukeK562UniPk.narrowPeak data.dat
awk '{print $1,$2,$3,1}' ../../../../data_raw/Rep${repid}/cell${id}.dat > data.dat
#cp ../data/bed/hg19/dataall.dat data.dat
#cp ../data/dataall.dat data.dat


for i in `seq 1 22`
do
grep -P chr${i}"\ " data.dat | awk '{print $2,$3,$4}' > chr${i}.dat
done

grep -P chrX"\ " data.dat | awk '{print $2,$3,$4}' > chr23.dat



cd bin_10kb
bash do.sh
cd further/
bash do.sh
cd ../
cd ../

rm chr*.dat
rm data.dat
