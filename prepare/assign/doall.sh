#!bin/bash

chrnum=$1

for i in `seq 1 $chrnum`
do
	rm -r $i
	cp -r bk ${i}
done

cd all
bash do.sh $chrnum
cd ../

for i in `seq 1 $chrnum`
do
	cd ${i}/detail/
	nohup bash do.sh &
	cd ../..
#	cd $i
#	bash doall_rep.sh $i
#	cd ..
done
