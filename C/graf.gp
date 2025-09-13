# GRAFICA CUATRO GRAFICAS EN UNA VENTANA
# l@rry
#set term corel
set output  "Dos_graficas.eps"

set autoscale
set multiplot layout 3,1 rowsfirst
set grid
set style data lines

#------------- Graf 1 ----------------
set title "Funcion seno"
#unset label
set xlabel   "n"
set ylabel   "y(n)"
plot  "puntos_sin.dat"
unset xlabel
unset ylabel
unset title

#------------- Graf 2 ----------------
set title "Funcion ruido aleatorio"
# unset label
set xlabel   "n"
set ylabel   "y(n)"
plot  "rand_noise.dat"
unset xlabel
unset ylabel
unset title

#------------- Graf 3 ----------------
set title "Funcion seno + ruido"
# unset label
set xlabel   "n"
set ylabel   "y(n)"
plot  "noise_sin.dat"
unset xlabel
unset ylabel
unset title


#pause(3)
#unset multiplot

#