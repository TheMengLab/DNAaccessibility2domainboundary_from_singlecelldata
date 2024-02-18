#!/bin/bash

bash do1.sh

for i in `seq 1 500`
do
	for j in `seq 1 23`
	do
		paste ../../chrlen/tempassign_10kb/chrassignall.dat len${i}.dat | awk -v CID=${j} '{if($1==CID) print $2}' > ../${j}/len${i}.dat
	done
done
	



