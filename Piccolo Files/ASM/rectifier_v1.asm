*
* 	@author: 	Oscar Harun
*	@brief:		Rectifica una senoidal de 1000 muestras
*

		.global _c_int00 					; Símbolo global para inicio de codigo
		.data 								; Seccion de datos, se definio en el .cmd

x 		.word 1,-2,3,-4,5,-6,7,-8,9,-10		; datos del vector x
y 		.word 0,0,0,0,0,0,0,0,0,0			; datos del vector x
total 	.word 0 							; resultado
N 		.set 10 							; define N = 10 = constante

		.text 								; seccion de codigo

_c_int00:
		SETC 	SXM 						; modo extension de signo
		SPM 	#0 							; sin corrimiento en el multiplicador

		MOVW 	DP,			#total 			; carga a DP página de total
		MOVL 	XAR1,		#x 				; XAR1 apunta a vector x
		MOVL 	XAR2,		#y 				; XAR1 apunta a vector x
		MOV 	AR0,		#N-1 			; AR0 = N, para contador de ciclo
		ZAPA 								; ACC = 0, P =0

CICLO_P1
		MOV		AL,			*XAR1++
		CMP		AL,			#0				; compara XAR1-0
		MOV 	*XAR2++,	AL,		GEQ		; XAR2 = AL if AL > 0
;		MOVB 	*XAR2++,	#0,		LT		; XAR2 = 0 if AL < 0
		BANZ 	CICLO_P1,	AR0-- 			; Regresa a CICLO_P1 si AR0 != 0

FIN_R 	NOP 								; i lo infinito
		LB 		FIN_R
		.end