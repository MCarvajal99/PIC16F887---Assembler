;Made by: Marco Antonio Carvajal Muñiz

;Saca por el puerto B el valor de 0x55
;Saca por el puerto C el valor de 0xAA
;Saca por el puerto D el valor 0xCC

	LIST	P=16F887	; list directive to define processor
	INCLUDE	<P16F887.INC>	; processor specific variable definitions
 
 
	__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT
	__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

 ; variable decleration
 	CBLOCK	0x20
	ENDC
    	ORG     	0X0000  
;Inicia programa

;Para cambiar de bancos se modifican los bits RP1 y RP0
;del REG. STATUS
;0	0	Banco 0 
;0	1	Banco 1
;1	0	Banco 2
;1	1	Banco 3
	
	BANKSEL	PORTC		;Banco 0
	MOVLW	0X55
	MOVWF	PORTB
	MOVLW	0XAA
	MOVWF	PORTC
	MOVLW	0XCC
	MOVWF	PORTD		;Por default en banco 0, no hay necesidad de seleccionarlo
	BANKSEL	ANSEL		;Banco 3
	CLRF	ANSEL
	CLRF	ANSELH		;Puertos digitales
	BANKSEL	TRISB		;Banco 1
	CLRF	TRISB
	CLRF	TRISC
	CLRF	TRISD		;B, C y D son salidas
SINFIN: GOTO	SINFIN
	END