;Made by: Marco Antonio Carvajal Muñiz
;3 de Octubre de 2021
;Leer el nibble bajo de PC
;Mostrarlo en el nibble alto de PD.
;Leer el nibble alto de PB
;Mostrarlo en el nibble bajo de PD.

;Configuración del PIC.
	LIST	P=16F887	; list directive to define processor
	INCLUDE	<P16F887.INC>	; processor specific variable definitions
 
 
	__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT
	__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Declaración de variables
	CBLOCK 0x20
	A
	ENDC

;Configuración de puertos.
		ORG     0X0000    
		BANKSEL	ANSEL	;Banco 3°.
		CLRF 	ANSEL	;Puertos digitales.
		CLRF	ANSELH	;Puertos digitales.
		BANKSEL	TRISD	;Banco 1.
		CLRF	TRISD	;PD como salida.

;Inicia main.
		BANKSEL	PORTC	;Banco 0°.
REPITE:		MOVLW	0x0F	;W = Mask = 0b00001111.
		ANDWF	PORTC,W	;W AND PORTC, se guarda en W.	
		MOVWF	A	;W se mueve a A.
		MOVLW	0xF0	;W = Mask = 0b11110000.
		ANDWF	PORTB,W	;W AND PORTB, se guarda en W.
		IORWF	A,F	;W OR A, se guarda en A.
		SWAPF	A,W	;Inverte nibbles de A y guardalos en W.
		MOVWF	PORTD	;Mueve W a PORTD.
		GOTO 	REPITE
		END

;NIBBLES
;Necesitamos Nibble bajo de PC
;		AND Mask: 0b00001111
;		       W: 0bXXXX1111
;			  ----------
;			  0b00001111
;
;		OR Mask: 0b11110000
;		      W: 0b00001111
;			 ----------
;			 0b11111111