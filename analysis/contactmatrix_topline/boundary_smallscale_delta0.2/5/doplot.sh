#!/bin/bash

bid=109
eid=114

awk -v BID=$[bid*100] -v EID=$[eid*100] '{if(($1>BID)&&($1<EID)) print $1,1}' targetpeakid.dat  > targetpeakid_plot.dat
echo $[bid*100] 3 >> targetpeakid_plot.dat
echo $[eid*100] 3 >> targetpeakid_plot.dat

gnuplot boundaryplot.plt
mv temp.png boundary_${bid}_${eid}.png

