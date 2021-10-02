;Made by: Marco Antonio Carvajal Muñiz
;2 de Octubre de 2021
;Ejercicio de If
;Leer el puerto B y C
;Si PB<=PC mostrar en PD 0xFD y en PA sacar 0x9F
;Si PB>PC mostrar en PD 0x34 y en PA sacar 0x6A

;Configuración del PIC.
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
	CLRF	TRISA	;Puerto A como salida.

;Inicia main.
	BANKSEL	PORTB	;Banco 0°.
REPITE:	MOVF	PORTB,W	;Mueve lo de PB a W.
	SUBWF	PORTC,W	;PORTC - W (Se guarda en W).
	BTFSS	STATUS,C;¿C = 1? es decir PB<=PC.
	GOTO	PB_MAYOR
	MOVLW	0xFD	;W=0XFD.
	MOVWF	PORTD	;PORTD = 0xFD.
	MOVLW	0x9F	;W=0x9F.
	MOVWF	PORTA	;PORTA = 0x9F.
	GOTO	REPITE
PB_MAYOR
	MOVLW	0x34	;W=0x34.
	MOVWF	PORTD	;PD = 0x34.
	MOVLW	0x6A	;W=0x6A.
	MOVWF	PORTA	;PA = 0x6A.
	GOTO	REPITE
	END