#!/bin/bash

#generating initial structures for 100,000-bead polymer chain by self-avoid random walk
cd initconf
bash do.sh
cd ..

#prepare files for simulating the random folding process of 100,000-bead polymer chains in confined space
cd simulation/
bash copy.sh	
cd ..
