#!/bin/bash
repid=5
for i in `seq 1 100`
do
	rm -r $i
	cp -r bk $i
done

for i in `seq 1 100`
do
cd $i
nohup bash do.sh $repid $i &
cd ..
done


endbool=0

while [ $endbool -eq 0 ]
do
endbool=1
for i in `seq 1 100`
do
        if [ -f ./${i}/bin_10kb/further/densityall.dat ]
        then
        count=1
        else
        count=0
        endbool=0
        fi

done

sleep 1

done

rm */nohup.out

