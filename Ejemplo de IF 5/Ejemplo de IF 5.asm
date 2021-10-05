;Made by: Marco Antonio Carvajal Muñiz
;4 de Octubre de 2021
;Ejercicio de If
;Leer RB7 y RC3
;Si el RB7 = 0 y RC3 = 0 mostrar en el PD 0xF3 y en el PA 0x89
;Si el RB7 = 0 y RC3 = 1 mostrar en el PD 0x45 y en el PA 0x7C
;Si el RB7 = 1 y RC3 = 0 mostrar en el PD 0x94 y en el PA 0x42
;Si el RB7 = 1 y RC3 = 1 mostrar en el PD 0xFF y en el PA 0xDE

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
		CLRF	TRISD	;Salida.
		CLRF	TRISA	;Salida.

;Inicia main.
		BANKSEL PORTB	;Banco 0°.	;Primer caso B0 C0
REPITE:		BTFSC	PORTB,7	;¿RB7 = 0?
		GOTO	B1_C0	;RB = 1
		BTFSC	PORTC,3	;¿RC3 = 0?
		GOTO	B0_C1	;RC3 = 1
		MOVLW	0xF3	;W=0xF3
		MOVWF	PORTD	;PORTD = 0xF3
		MOVLW	0x89	;W = 0x89
		MOVWF	PORTA	;PORTA=0x89
		GOTO	REPITE

B1_C0:		BTFSC	PORTC,3	;¿RC3 = 0?
		GOTO	B1_C1	;RC3 = 1
		MOVLW	0x94	;W=0xF3
		MOVWF	PORTD	;PORTD = 0xF3
		MOVLW	0x42	;W = 0x89
		MOVWF	PORTA	;PORTA=0x89
		GOTO	REPITE

B1_C1:		MOVLW	0xFF	;W=0xF3
		MOVWF	PORTD	;PORTD = 0xF3
		MOVLW	0xDE	;W = 0x89
		MOVWF	PORTA	;PORTA=0x89
		GOTO	REPITE

B0_C1:		MOVLW	0x45	;W=0xF3
		MOVWF	PORTD	;PORTD = 0xF3
		MOVLW	0x7C	;W = 0x89
		MOVWF	PORTA	;PORTA=0x89
		GOTO	REPITE
		
		END