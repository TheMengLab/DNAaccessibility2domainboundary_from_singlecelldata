#!/bin/bash

#repid=$1

#sed -i "s/sh 1 1/sh ${repid} 1/g" -- 1/doall.sh


for i in `seq 1 10`
do
	rm -r $i
cp -r bk ${i}
#cp 1/do*.sh ${i}/
done



for i in `seq 1 10`
do
sed -i "s/sh 1/sh ${i}/g" -- ${i}/doall.sh
#sed -i "s/sh 1$/sh ${repid}/g" -- ${i}/doall.sh
done
