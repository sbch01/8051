;-----------------------------------------------------------------------------
;Here is LCD Tutorial for 8051 MCU
;The demo is for 8bit data comunication with LCD
;
;-----------------------------------------------------------------------------

ORG	0000H 	;
	SJMP Initial
	
;ORG 	000BH	;
;	SJMP TMR0_INTR	;

;ORG	001BH	;
;	SJMP TMR1_INTR	;

;ORG	0003H	;
;	SJMP INT0_INTR ;

;ORG	0013H ;
;	SJMP INT1_INTR	;

;ORG	0023H	; 
;	SJMP UART_INT	;

DECRES 	EQU 30H	;
MYBIT	EQU 02H ;
	ORG 0030H ;

Initial:
	MOV P3,#3FH
	
	
	ACALL LCD_init
	
	MOV A,#DD_RAM_ADDR1
	ACALL LCD_command
	
	MOV A,#'S'
	ACALL LCD_sendchar

	MOV A,#DD_RAM_ADDR2
	ACALL LCD_command

	MOV A,#'B'
	ACALL LCD_sendchar

	MOV A,#CLR_DISP
	ACALL LCD_command

	MOV A,#DISP_ON_CUR
	ACALL LCD_command
	
	MOV A,#DD_RAM_ADDR1
	ACALL LCD_command

	MOV DPTR,#STR1
	ACALL LCD_sendstr

	MOV DPTR,#BELL
	ACALL LCD_buildchar

	MOV A,#CLR_DISP
	ACALL LCD_command

	MOV A,#DISP_ON
	ACALL LCD_command

	MOV A,#DD_RAM_ADDR1
	ACALL LCD_command

	MOV A,#0H
	ACALL LCD_sendchar


Start:
	NOP
Loop1:
	;CLR P1.0
	;SETB P1.0
	;NOP
	;JB P1.0,Start
	JMP Start


;------------------------------------------------------------------
; Subroutines Library
;------------------------------------------------------------------	
INCLUDE lcd.inc

ORG 0200H
;----------------String constants----------------------------------
STR1:DB '8051 is Legend!',0
;----------------Custom charter constant---------------------------
BELL:DB 00100b, 01110b, 01110b, 01110b, 11111b, 00000b, 00100b, 00000b
	END
	