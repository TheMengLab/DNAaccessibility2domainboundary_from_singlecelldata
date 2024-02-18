#!/bin/bash
chrnum=23


for i in `seq 1 ${chrnum}`
do
rm matrix4_chr${i}_norm_top100.dat
	nohup bash temp.sh ${i} &
done



endbool=0

while [ $endbool -eq 0 ]
do
endbool=1
for i in `seq 1 $chrnum`
do
        if [ -f matrix4_chr${i}_norm_top100.dat ]
        then
        count=1
        else
        count=0
        endbool=0
        fi

done

sleep 1

done



