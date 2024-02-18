#!/bin/bash


##run the simulation to generate randomly folded polymer structures in confined space
#cd simulation/simulation/
#
#for i in `seq 1 10`
#do
#	cd $i
#	bash doall.sh
#	cd ..
#done
#
#cd ../..



# If you have enough cpus and RAM, you can run the simulation parallelly(highly suggested).
cd simulation/simulation/

for i in `seq 1 10`
do
	cd $i
	nohup bash doall.sh &
	cd ..
done

cd ../..




