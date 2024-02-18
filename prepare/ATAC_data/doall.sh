#!/bin/bash



for i in `seq 1 5`
do
	cd Rep${i}/individual/
	bash doall.sh
	cd ../..
done

id=1
for i in `seq 1 5`
do
for j in `seq 1 100`
do
	cp Rep${i}/individual/${j}/bin_10kb/further/densityall.dat all/densityall_${id}.dat
	id=$[id+1]
done
done


cd all/test_average/
bash dolistaverage.sh
cd ../..
