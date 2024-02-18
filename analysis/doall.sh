#!/bin/bash
#prepare the file
chrnum=23

bash do_tempfile.sh

rm mergepoint/*.dat


#generating ensembles of chromosome conformations from random folded conformations of 100,000-bead polymer
for i in `seq 1 $chrnum`
do 
	nohup bash do_rep.sh $i & 
done

endbool=0

while [ $endbool -eq 0 ]
do
endbool=1
for i in `seq 1 $chrnum`
do
        if [ -f ./mergepoint/500_chr${i}.dat ]
        then
        count=1
        else
        count=0
        endbool=0
        fi

done

sleep 1

done


#calculate the distance matrix for chromosome 21:29.38Mb-31.33Mb at the resolution of 30kb
cd distmatrix/chr21_2938_3133/
bash do.sh
cd ../..



#calculate the contact matrix from the conformation ensemble of each chromosome
cd contactmatrix_topline
bash do.sh
cd ..


#calculate the separation score and identify the domain boundaries for each chromosome
cd contactmatrix_topline/boundary_smallscale_delta0.2/
bash doall.sh
cd ../..
