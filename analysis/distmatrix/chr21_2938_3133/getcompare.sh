#!/bin/bash

cp /home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/data/MERFISH/coor/IMR90_chr21_28_30M/distmatrix_ave/distmatrix.png distmatrix_exp.png
cp /home/group/code/c/Nucleosome_model/segment_sample/HiC/simulation/single_cell/MD_attraction/compartment_individualcell/data/MERFISH/coor/IMR90_chr21_28_30M/distmatrix_ave/distmatrix_ave.dat distmatrix_ave_exp.dat

echo -e distmatrix_ave_exp.dat '\n' distmatrix_ave_exp_col.dat | ./row2col_double.o 
echo -e matrix21_30kb.dat '\n' distmatrix_col.dat | ./row2col_double.o 
#Input the filename for the cpt file:
#Input the filename for the output filename:

paste distmatrix_col.dat distmatrix_ave_exp_col.dat | grep -v 000000 > compare.dat

