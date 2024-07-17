set term pdf size 3in,3in font "Times New Roman,10"
set out "metrics.pdf"

set xlabel "nThreads"
set ylabel "SpeedUp"
set title "Speedup"

#set xrange [0:16];
#set yrange [0:16];

plot x lc "black" notitle, \
	 "metrics.txt" using 1:3 pt 5 ps 0.5 dt 2 lc "green" t 'S'

set xlabel "nThreads"
set ylabel "Eficiencia"
set title "Efficiency"

#set xrange [0:16];
#set yrange [0:1.01];

plot 1 lc "red" notitle, \
	 0.6 lc "blue" notitle, \
	 "metrics.txt" using 1:4 pt 5 ps 0.5 dt 2 lc "green" t 'E'

unset output