#
#  Configura graficaciÃ³n en GNUplot
#  
# Ejecutar desde un Shell de linux $ gnuplot -p 'graf_senal.gp
# Ejecutar desde GNUplot; $load 'graf_senal.gp'
# Ejecutar desde una lÃ­nea en cÃ³digo  c:
# system("gnuplot -p 'graf_senal.gp' ");
###
set autoscale
set output  "seno.eps"
set grid
set style data lines

#------------- Graf 1 ----------------
set title "Autocorrelacion Cruzada de un Seno"
#unset label
set xlabel   "n"
set ylabel   "r_{xx}(n)"
# Grafica el archivo de datos
plot  "data_files/rxx_noisy_sinef10_float.dat"    
unset xlabel
unset ylabel
unset title