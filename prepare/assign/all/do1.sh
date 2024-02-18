#!/bin/bash


basevalue=`cat ../../ATAC_data/all/test_average/ave_statis.dat`

for i in `seq 1 500`
do
echo -e ../../ATAC_data/all/densityall_${i}.dat '\n' ${basevalue} '\n'  len$[i].dat | ./getnorm_pointlen.o

done


