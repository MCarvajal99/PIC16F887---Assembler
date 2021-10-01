;Made by: Marco Antonio Carvajal Muñiz

;Leer el Puerto B y mostrarlo por el Puerto C

	LIST	P=16F887	; list directive to define processor
	INCLUDE	<P16F887.INC>	; processor specific variable definitions
 
 
	__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT
	__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

 ; variable decleration.
 	CBLOCK	0x20
	ENDC
 	ORG     0X0000  

;Inicia programa.

	;Configuración de puertos.
	BANKSEL	ANSEL	;Banco 3°.
	CLRF	ANSEL	;Puertos digitales.
	CLRF	ANSELH	;Puertos digitales.
	BANKSEL	TRISC	;Banco 1°.
	CLRF	TRISC	;Puerto C = Salida.
	BANKSEL	PORTB	;Banco 0°.
;Recordar que todos los puertos por Default están como entradas.

	;Inicia main
REPITE	MOVF	PORTB,W	;PORTB ==> W.
	MOVWF	PORTC	;W ==> PORTC.

	;Ciclo infinito
	GOTO	REPITE
   	END	