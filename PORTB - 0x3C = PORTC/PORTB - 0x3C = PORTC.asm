;Made by: Marco Antonio Carvajal Muñiz

;PORTB - 0x3C = PORTC (magnitud)

	LIST	P=16F887	; list directive to define processor
	INCLUDE	<P16F887.INC>	; processor specific variable definitions
 
 
	__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT
	__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

 ; variable decleration.
 	CBLOCK	0x20
	ENDC
 	ORG     0X0000  

;Configuración de puertos.
	BANKSEL	ANSEL	;Banco 3°
	CLRF	ANSEL	;Puertos digitales.
	CLRF	ANSELH	;Puertos digitales.
	BANKSEL	TRISC	;Banco 1°.
	CLRF	TRISC	;Puerto C como salida.

;Inicia main
	BANKSEL	PORTB	;Banco 0°.
REPITE:	MOVLW	0x3C
	SUBWF	PORTB,W

;SUBWF PORTB,W
;	PORTB - W = Resultado.
;	PORTB + C2 de W = Resultado.
;	C = 1 si es positivo.
;	C = 0 si es negativo.
	
	BTFSS	STATUS,C ;¿Carry es igual a 1? salta a MOVWF (Línea 37)
	SUBLW	.0	;Carry = 0, se obtiene su magnitud (C2)
	MOVWF	PORTC
	GOTO	REPITE

;SUBLW K
;	W = K - W
;	W = K + (C2)W
; Si K = 0
;	W = 0 + (C2)W
	
	END