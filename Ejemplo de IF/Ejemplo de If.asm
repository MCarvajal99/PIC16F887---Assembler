;Made by: Marco Antonio Carvajal Muñiz

;Leer puerto B y C, si B = C mostrar en el puerto D 0xFD, si B es diferente de C mostrar 0x24.
	LIST	P=16F887	; list directive to define processor
	INCLUDE	<P16F887.INC>	; processor specific variable definitions
 
 
	__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT
	__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Configuración de los puertos.
	BANKSEL ANSEL	;Banco 3°.
	CLRF	ANSEL	;Puertos digitales.
	CLRF	ANSELH	;Puertos digitales.
	BANKSEL	TRISD	;Banco 1°.
	CLRF	TRISD	;Puerto D como salida.

;Inicia main.
	BANKSEL	PORTB	;Banco 0°.
REPITE:	MOVF	PORTB,W	;PORTB se va a W.
	SUBWF	PORTC,W	;PORTC - W. (se guarda en W).
	MOVLW	0xFD	;W = 0xFD.
	BTFSS	STATUS,Z;¿Z es igual a 1? si es así salta a la línea 25.
	MOVLW	0x24	;W = 0x24
	MOVWF	PORTD
	GOTO	REPITE
	END