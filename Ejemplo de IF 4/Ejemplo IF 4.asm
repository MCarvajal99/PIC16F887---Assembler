;Made by: Marco Antonio Carvajal Muñiz
;4 de Octubre de 2021
;Ejercicio de If
;Leer RB0
;Si RB0 == 0 mostrar en el PD 0xF5
;Si RB0 == 1 mostrar en el PD 0x24

;Configuración del PIC.
	LIST	P=16F887	; list directive to define processor
	INCLUDE	<P16F887.INC>	; processor specific variable definitions
 
 
	__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT
	__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Configuración de puertos.
		BANKSEL	ANSEL	;Banco 3°.
		CLRF 	ANSEL	;Puertos digitales.
		CLRF 	ANSELH	;Puertos digitales.
		BANKSEL TRISD	;Banco 1°
		CLRF	TRISD	;PD como salida.

;Inicia main.
		BANKSEL PORTB	;Banco 0°.
REPITE:		MOVLW	0x24	;W = 0x24.
		BTFSS	PORTB,0	;¿RB0 = 1?
		MOVLW	0xF5	;W = 0xF5.
		MOVWF	PORTD	;W se mueve a PORTD.
		GOTO 	REPITE
		END	