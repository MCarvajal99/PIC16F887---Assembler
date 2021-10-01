;Made by: Marco Antonio Carvajal Muñiz

;Lo que haya en PORTB sumarle 0X54 y mostrarlo en PORTC (PORTB+0x54 = PORTC)

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
REPITE	MOVF	PORTB,W	;PORTB ==> W.
	ADDLW	0x54	;W + 0x54 ==> W.
	MOVWF	PORTC	;PORTC = W + 0x54.

;Ciclo infinito
	GOTO	REPITE
	END