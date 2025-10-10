*
* 	@author: 	Oscar Harun
*	@brief:		Troza una senoidal de 1000 muestras, deja pasar el n octavo de los ciclos positivo y negativo
*

		.global _c_int00
	    .data

pal		.set	16			; las palabras son de 16 bits
N 		.set 	1000		; define N = 1000 = constante
n		.set 	0			; 1 octavo

p8	   	.word	0
semis	.word	20			; f0=10, 20 semiciclos
seno   	.space  pal*N
troz 	.space  pal*N



* ------------------------------------------------------ M  A  I  N  ------------------------------------------------------
    	.text
_c_int00:

	; Calcula cuantos puntos hay por semiciclo
		MOVL	XAR1, 	#seno			; XAR1 recorrera la señal
		MOVW	DP,		#p8				; p8 lleva la cuenta de los puntos por cada semiciclo
COMP1	MOV 	AL,		*XAR1++			; AL = *XAR1
	  	CMP 	AL,		#0				; XAR1 - 0
		BF 		POSIT,	GEQ				; XAR >= 0 confirmado, salta a subrutina

	; Suma 1 para recuperar el primero punto que se salto
		MOV		AL,		#1				; carga Al con 1
		ADD		ACC,	@p8				; ACC = ACC + p8
	; Divide entre 8 para saber el no. de puntos por octavo
		MOV		T,		#3				; pq 2^3 = 8
		ASRL	ACC,	T				; corrimiento a la der >> 3  = dividir entre 8
		MOV		@p8,	AL				; p8 = ACC, no. de puntos por octavo


		MOVL	XAR1,	#seno			; XAR1 servira para recorrer toda la senal original
		MOVL	XAR2,	#troz			; XAR2 servira para crear la senal troceada

	; Carga el contador para recorrer toda la senal
		MOVL	XAR0,	#semis
		MOV 	AL,		*XAR0
		MOV		AR3,	AL


	; Si es el primer octavo, pasa directamente a trocear
SEMI	MOV 	AL,		#0				; AL = 0
	  	CMP 	AL,		#n				; n = 0?
		BF 		INI,	EQ				; n=0 confirmado, primer octavo, comienza a trocear

	; Avanza XAR1 y XAR2 al inicio del n octavo que se desea pasar
		MPY		ACC,	@p8,	#n		; ACC = p8 * n -> localidad de inicio del n octavo
		SUBB	ACC,	#1				; le resta 1 para la instruccion RPT
		MOV 	AR0,	AL	 			; AR0 = ACC = p8, para contador de ciclo
		ZAPA 							; ACC = 0, P = 0
AVA_OCT	MOV		AR7,	*XAR1++
		MOV		AR7,	*XAR2++
		BANZ 	AVA_OCT,AR0--

	; Troza el octavo correspondiente al semiciclo
INI		ZAPA							; ACC = 0
		ADD		AL,		@p8				; ACC = p8
		SUBB	ACC,	#1				; le resta 1 para la instruccion RPT
		MOV 	AR0,	AL	 			; AR0 = ACC = p8, para contador de ciclo
		ZAPA 							; ACC = 0, P = 0
TROZA	MOV		AR7,	*XAR1++
		MOV		*XAR2++,AR7
		BANZ 	TROZA,	AR0--

	; Avanza al siguiente semiciclo
		MOV     AL,		*XAR1++       	; AL = primer valor
		MOV		AR7,	*XAR2++			; va avanzando el XAR2 en la senal troceada
        MOV     AH,     AL            	; AH = valor anterior

LOOP    MOV     AL,     *XAR1++       	; AL = valor actual
		MOV		AR7,	*XAR2++			; va avanzando el XAR2 en la senal troceada
        MOV     T,      AL            	; copia AL a T
        XOR     T,      AH            	; T = AL XOR AH
        AND     T,      #0x8000       	; aísla el bit de signo
        BF      OTRO,	NEQ      		; si bit 15 cambió, salta

        ; No cambió de signo:
        MOV     AH,     AL				; actualiza valor anterior
        BF      LOOP,   UNC

OTRO	BANZ 	SEMI	,AR3--


REGRESA NOP
 		LB REGRESA



* ------------------------------------------------------ S U B R U T I N A S ------------------------------------------------------

POSIT	MOV		AL,		#1				; carga Al con 1
		ADD		ACC,	@p8				; ACC = ACC + p8
		MOV		@p8,	AL				; p8 = ACC
		LC		COMP1					; vuelve a comparar


.end