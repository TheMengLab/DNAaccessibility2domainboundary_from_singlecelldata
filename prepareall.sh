#!/bin/bash

chrnum=23	#The number of chromosome in the simulated cell, the value of 23 means 22 autosomes+ X chromosome



#Starting from ATAC/DNase data(genomic length of each chromosome is also needed) to prepare input files for performing simulation for stochastic folding
cd prepare/



cd chrlen/
bash doall.sh $chrnum
cd ..


#assign the DNA accessibility signals detected by experiment(ATAC-seq or DNase-seq) to each 10-kb segments of the genome
cd ATAC_data/
bash doall.sh $chrnum
cd ..

#construct heteropolymers models for chromosomes. For each chromosome, 10 heteropolymer models are built
cd assign/
bash doall.sh $chrnum
cd ..

cd ../



cd simulation/
#generating initial structures for 100,000-bead polymer chain and prepare input files for random folding simulation
bash prepare.sh
cd ..

