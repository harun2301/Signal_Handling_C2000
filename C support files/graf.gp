# GRAFICA CUATRO GRAFICAS EN UNA VENTANA
# l@rry
#set term corel
set output  "multi_graph.eps"

set autoscale
set multiplot layout 2,1 rowsfirst
set grid
set style data lines

#------------- Graf 1 ----------------
#set title "Pure Sine"
#unset label
#set xlabel   "n"
#set ylabel   "y(n)"
#plot  "pure_sine_f10.dat"
#unset xlabel
#unset ylabel
#unset title

#------------- Graf 2 ----------------
set title "Sine in Q4"
# unset label
set xlabel   "n"
set ylabel   "y(n)"
plot  "pure_sine_Q4.dat"
unset xlabel
unset ylabel
unset title

#------------- Graf 3 ----------------
#set title "Sine in Q10"
# unset label
#set xlabel   "n"
#set ylabel   "y(n)"
#plot  "pure_sine_Q10.dat"
#unset xlabel
#unset ylabel
#unset title

#------------- Graf 4 ----------------
#set title "Noisy Sine in Q8"
# unset label
#set xlabel   "n"
#set ylabel   "y(n)"
#plot  "noisy_sine_Q8.dat"
#unset xlabel
#unset ylabel
#unset title

#------------- Graf 5 ----------------
set title "Noisy Sine in Q12"
# unset label
set xlabel   "n"
set ylabel   "y(n)"
plot  "noisy_sine_Q12.dat"
unset xlabel
unset ylabel
unset title

#pause(3)
#unset multiplot

#