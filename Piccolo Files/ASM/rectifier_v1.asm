*
* 	@author: 	Oscar Harun
*	@brief:		Rectifica una senoidal de 1000 muestras
*

		.global _c_int00 					; Símbolo global para inicio de codigo
		.data 								; Seccion de datos, se definio en el .cmd

pal		.set	16							; las palabras son de 16 bits
N 		.set 	1000						; define N = 1000 = constante

sine   	.space  pal*N      					; reserva espacio de memoria para el seno (2000 bytes = 1000 words)
rect	.space  pal*N						; seno rectificado


		.text 								; seccion de codigo

_c_int00:
		SETC 	SXM 						; modo extension de signo
		SPM 	#0 							; sin corrimiento en el multiplicador

		MOVL 	XAR1,		#sine			; XAR1 apunta a vector x
		MOVL 	XAR2,		#rect 			; XAR1 apunta a vector x
		MOV 	AR0,		#N-1 			; AR0 = N, para contador de ciclo
		ZAPA 								; ACC = 0, P =0

CICLO_P1
		MOV		AL,			*XAR1++
		CMP		AL,			#0				; compara XAR1-0
;		MOV 	*XAR2++,	AL,		GEQ		; XAR2 = AL if AL > 0	Semiciclo positivo
		MOV 	*XAR2++,	AL,		LT		; XAR2 = AL if AL < 0	Semiciclo negativo
		BANZ 	CICLO_P1,	AR0-- 			; Regresa a CICLO_P1 si AR0 != 0

FIN_R 	NOP 								; i lo infinito
		LB 		FIN_R
		.end