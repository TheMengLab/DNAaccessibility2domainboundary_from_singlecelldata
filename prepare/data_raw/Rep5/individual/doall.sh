#!/bin/bash

for i in `seq 1 100`
do
cd $i
bash do.sh $i
cd ..
done
