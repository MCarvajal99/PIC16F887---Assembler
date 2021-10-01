;Made by: Marco Antonio Carvajal Muñiz

;PORTB + PORTC = PORTD

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
	BANKSEL	TRISD	;Banco 1°.
	CLRF	TRISD	;Puerto C como salida.
	;Solo declaramos salidas, por default las demás son entradas.

;Inicia main
	BANKSEL	PORTB	;Banco 0°.
REPITE:	MOVF	PORTB,W	;PORTB ==> W.
	ADDWF	PORTC,W	;PORTC+W = PORTC+PORTB (se guarda en W).
	MOVWF	PORTD	;Mueve W a PORTD.
	GOTO	REPITE
	END