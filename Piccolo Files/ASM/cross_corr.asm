*
* Correlacion entre dos senales discretas
* usando datos con formato de punto fijo de 16 bits
*

		.global _c_int00
		.data

N 		.set 	7	 	; Total de puntos de cada senal y(n) y x(n)
cont 	.word 	0 		; Contador de la cantidad de productos
						; a realizar por cada iteracion de la
						; variable l

xn 		.space 	N*16 	; Vector reservado para la secuencia x(n)
yn 		.space 	N*16 	; Vector reservado para la secuencia y(n)
rxy 	.space 	(2*N*16)-16 	; Vector reservado para guardar el resultado
basx 	.word 	0 		; Localidad de memoria para separar vectores
basy	.word 	0 		; Localidad de memoria para separar vectores
incDir 	.long 	0 		; Variable para incrementar direcciones
						; del apuntador


		.text
_c_int00:

		SETC 	SXM 			; Modo extension de signo
		SETC 	OVM
		SPM 	0 				; Corrimientos nulos en P

		MOVW 	DP,		#cont 	; Direccionamiento a la pagina de memoria
								; que contiene la variable cont
		MOV 	AR4,	#N-1 	; Carga la cantidad de iteraciones
								; para l <=0
		MOVL 	XAR5,	#rxy+N 	; Direccionamiento al elemento 500
								; del vector rxy
		MOVL 	XAR2,	#yn 	; Direccionamiento al vector de
								; datos y, secuencia movil
		MOV 	AL,		#N-1 	; Coloca el numero 499 en el AL
		MOVW 	@cont,	AL 		; Escribe el contenido de AL en la
								; variable cont
		MOVL 	XAR3,	#incDir ; Direccionamiento a incDir

* ∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗
* Primera parte de la correlacion cruzada para l <= 0

CORRELN
		MOVL 	XAR7,	#xn 		; Direccionamiento a la secuencia x(n)
		ZAPA
		RPT 	@cont
		|| MAC 	P, 		*XAR2++,	*XAR7++	; Calculo de la MAC a 16 bits

		ADDL 	ACC, 	P<<PM 		; Acumulacion del ultimo producto
		;LSL 	ACC,	#4			; Ajuste de formato Qi
		MOV 	*--XAR5,AL 			; Pre−decrementa el apuntador rxy y
									; guarda el resultado calculado de rxy(l)

		DEC 	@cont 				; Decrementa la cantidad de productos a realizar
									; en la siguiente iteracion

* Desplazamiento de la secuencia movil en la
* operacion correlacion para l <=0
		MOVL 	ACC, 	*XAR3 		; Se carga la variable incDir en ACC
		ADD 	ACC,	#1 			; Suma 1 al valor de ACC, para
									; desplazar la secuencia
		MOVL 	*XAR3,	ACC 		; Coloca el valor del ACC en incDir

		MOVL 	XAR2,	#yn 		; Se apunta a la direccion de y
		MOVL 	ACC,	XAR2 		; Se coloca la direccion anterior
									; en el ACC
		ADDL 	ACC, 	*XAR3 		; Se suma a la direccion el valor
									; de incDir
		MOVL 	XAR2,	ACC 		; Se regresa el resultado
									; al apuntador de la secuencia
									; movil y(n) regresando el valor
									; a la var  del Dir

		BANZ 	CORRELN,AR4-- 		; Ciclo de calculo de los N elementos de la
									; correlacion para l <=0

*∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗∗
* Segunda parte de la correlacion cruzada, para l > 0

		MOVW 	DP,		#cont 		; Direccionamiento a la pagina de memoria
									; que contiene la variable cont
		MOV 	AR4,	#N-1 		; Cantidad de iteraciones a realizar para l >0
		MOVL 	XAR2,	#xn 		; Direccionamiento al vector x(n)
		MOV 	AL,		#N-1 		; Coloca el numero 499 en el AL
		MOVW 	@cont,	AL 			; Escribe la cantidad de productos
									; a realizar en cont
		MOVL 	XAR5,	#rxy+N-1 	; Se apunta con XAR5 al elemento 499 de rxy(l)

		ZAPA
		MOVL 	*XAR3,	ACC 		; incDir = 0

CORRELP
		MOVL 	XAR7,	#yn 		; Se apunta a la direccion a y
		ZAPA
		RPT 	@cont 				; Ciclo para realizar la MAC
		|| MAC 	P, 		*XAR2++,	*XAR7++

		ADDL 	ACC, 	P<<PM 		; Acumulacion del ultimo productoC
		;LSL 	ACC,	#4 			; Ajuste de formato Qi
		MOVW 	*XAR5++,AL 			; Guarda el resultado total de la MAC en rxy(499)
									; y post incrementa
		DEC 	@cont 				; Decrementa la cantidad de productos a realizar
									; en la siguiente iteracion

* Desplazamiento de la secuencia movil en
* la operacion correlacion para l>0
		MOVL 	ACC, 	*XAR3 		; ACC = incDir
		ADD 	ACC,	#1 			; Suma 1 a l ACC
		MOVL 	*XAR3,	ACC 		; incDir = ACC
		MOVL 	XAR2,	#xn 		; XAR2 apunta a xn
		MOVL 	ACC,	XAR2 		; Coloca la direccion en el ACC
		ADDL 	ACC, 	*XAR3 		; Suma la variabla incDir al ACC
		MOVL 	XAR2,	ACC 		; Regresa la direccion obtenida del
									; ACC en el apuntador XAR2
		BANZ 	CORRELP,AR4--

iend	NOP
		LB 		iend 				; Ciclo infinito
.end
