;Made by: Marco Antonio Carvajal Muñiz
;3 de Octubre de 2021
;Ejercicio de If
;Leer PB y PC
;Si PB>PC, Mostrar en PD 0x12 y PA 0xCC
;Si PB<PC, Mostrar en PD 0x69 y PA 0x7D
;Si PB=PC, Mostrar en PD 0xE1 y PA 0xDD
;Configuración del PIC.
	LIST	P=16F887	; list directive to define processor
	INCLUDE	<P16F887.INC>	; processor specific variable definitions
 
 
	__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT
	__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Configuración de puertos.
		BANKSEL	ANSEL	;Banco 3°.
		CLRF	ANSEL	;Puertos digitales.
		CLRF	ANSELH	;Puertos digitales.
		BANKSEL	TRISD	;Banco 1°.
		CLRF	TRISD	;Entrada.
		CLRF	TRISA	;Entrada.

;Inicia main.
		BANKSEL	PORTB	;Banco 0°.
REPITE:		MOVF	PORTB,W ;Mueve PORTB a W.
		SUBWF	PORTC,W	;PORTC-W, se guarda en W.
		BTFSS	STATUS,Z;¿Z=1? de ser así son iguales.
		GOTO	PB_MENOR
		MOVLW	0xE1
		MOVWF	PORTD	;PORTD = 0xE1.
		MOVLW	0xDD	
		MOVWF	PORTA	;PORTA = 0xDD.
		GOTO	REPITE
PB_MENOR:
		BTFSS	STATUS,C;¿Carry=1? entonces PB<PC
		GOTO	PB_MAYOR
		MOVLW	0x69
		MOVWF	PORTD
		MOVLW	0x7D
		MOVWF	PORTA
		GOTO	REPITE

PB_MAYOR:			;Para PB>PC
		MOVLW	0x12
		MOVWF	PORTD
		MOVLW	0xCC
		MOVWF	PORTA
		GOTO 	REPITE
		
		END