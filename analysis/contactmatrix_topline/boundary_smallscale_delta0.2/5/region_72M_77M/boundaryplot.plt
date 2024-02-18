set terminal png size 800,600
#set terminal png size 800,680	// for full matrix
set terminal png size 800,698	#for inner square matrix 10:1
set terminal png size 800,150	#for inner square matrix 10:1
#set terminal png size 800,800
#set terminal png size 791.9,520.3
#set terminal png size 814.0,523.4
set output "temp.png"
#load '/home/group/code/gnuplot/colormap/gnuplot-colorbrewer-master/sequential/Reds.plt'
#load '/home/group/code/gnuplot/colormap/gnuplot-colorbrewer-master/diverging/Spectral.plt'
#set palette defined ( 0 0 0 0, 0.1667 0 0 1, 0.5 0 1 0, 0.8333 1 0 0, 1 1 1 1 )
set palette defined ( 0 1 1 1,  1 1 0 0 )
#set palette defined ( 0 0 0 0, 0.1667 0 0 1, 0.5 0 1 0, 0.8333 1 0 0, 1 1 1 1 )
#set palette defined (1 1 1 1,  0.8333 1 0 0, 0.5 0 1 0,  0.1667 0 0 1, 0 0 0 0)
#set palette defined (0 1 0 0 ,  0.5 1 1 1,  1 0 0 1)
#set palette negative

#set cbrange [0:7]
set xrange[7200:7700]
set yrange[0:4.0]
#set xrange[-0.5:500.0]
#set yrange[-0.5:500.0]
set xtics -100,1001,1000.5
set xtics font "Times-Roman,0"
set ytics -100,1001,1000.5
set ytics font "Times-Roman,0"
#set xtics -0.5,501,1000.5
#set xtics font "Times-Roman,0"
#set ytics -0.5,501,1000.5
#set ytics font "Times-Roman,0"
#set tics front
unset border
#unset ylabel
unset key
#plot "refplot.dat" with points pointtype 9 pointsize 2
plot "targetpeakid_plot.dat" with points pointtype 9 pointsize 3
#plot "test.dat" matrix with image

