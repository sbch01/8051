;Some of web 
;https://www.8051projects.net/lcd-interfacing/introduction.php

;===============Initialisation constant================================
FUNC_8BIT_1L	EQU 30H
FUNC_8BIT_2L	EQU 38H
FUNC_4BIT_1L	EQU 20H
FUNC_4BIT_2L	EQU 28H
;================Comand definition=====================================
DISP_ON 	EQU 0CH
DISP_ON_CUR	EQU 0EH
DISP_ON_BLK	EQU 0FH
DISP_OFF	EQU 08H
CLR_DISP	EQU 01H

ENTRY_INC	EQU 06H
ENTRY_INC_S	EQU 07H
ENTRY_DEC	EQU 04H
ENTRY_DEC_S	EQU 05H

;=================Disp addresses=======================================
DD_RAM_ADDR1	EQU 80H ;First line start address
DD_RAM_ADDR2	EQU 0C0H ;Second line start address
DD_RAM_ADDR3	EQU 94H ;Third line start address on 20x4 lcds
DD_RAM_ADDR4	EQU 0D4H ;Fourth line start address on 20x4 lcds

CG_RAM_ADDR	EQU 40H

;======================================================================
; Here define the pins you use for LCD control in 8 bit mode
LCD_data equ P2    ;LCD Data port
LCD_D7   equ P2.7  ;LCD D7/Busy Flag
LCD_rs   equ P1.0  ;LCD Register Select
LCD_rw   equ P1.1  ;LCD Read/Write
LCD_en   equ P1.2  ;LCD Enable



LCD_Init:
;----------------------------------------------------------------------
	clr LCD_rs
	clr LCD_rw
	clr LCD_en
	
	mov A,#20
	mov B,#0
	;acall Wait_mS ;Wait 20 mS
	mov  LCD_data,#00110000B
	setb LCD_en
	clr  LCD_en
	
	mov A,#6
	mov B,#0
        ;acall Wait_mS ;Wait 6 mS
	mov  LCD_data,#FUNC_8BIT_2L
	setb LCD_en
	clr  LCD_en

	mov A,#DISP_OFF
	acall LCD_command

	mov A,#DISP_ON
	acall LCD_command

	mov A,#ENTRY_INC
	acall LCD_command

	ret
;----------------------------------------------------------------------

 
;======================================================================

;Ports used are same as the previous example
;Routine to send command to LCD
 
LCD_command:
         mov   LCD_data,A     ;Move the command to LCD port
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->

         clr   LCD_en
         acall LCD_busy       ;Wait for LCD to process the command
         ret                  ;Return from busy routine
 

;======================================================================
;Ports used are same as the previous example
;Routine to send data (single character) to LCD
 
LCD_sendchar:
         mov   LCD_data,A     ;Move the command to LCD port
         setb  LCD_rs         ;Selected data register
         clr   LCD_rw         ;We are writing
         setb  LCD_en         ;Enable H->

         clr   LCD_en
         acall LCD_busy       ;Wait for LCD to process the data
         ret                  ;Return from busy routine

         

LCD_buildchar:

	MOV A,#40H
	ACALL LCD_command

	MOV R0,#7
NEXT_data:
	CLR A
	MOVC A,@A+DPTR
	ACALL LCD_sendchar
	INC DPTR
	DJNZ R0,NEXT_data
	RET

	
;======================================================================
LCD_sendstr:

	CLR A
	MOVC A,@A+DPTR
	JZ EXIT_sendstr
	ACALL LCD_sendchar
	INC DPTR
	JMP LCD_sendstr
EXIT_sendstr:
	RET
;=======================================================================
LCD_busy:
	 setb   LCD_D7        ;Make D7th bit of LCD data port as i/p
         setb   LCD_en        ;Make port pin as o/p
         clr    LCD_rs        ;Select command register
         setb   LCD_rw        ;we are reading
check:
         clr    LCD_en        ;Enable H->
	 mov	A,LCD_data
         setb   LCD_en
         jb     A.7,check     ;read busy flag again and again till it becomes 0
         ret                  ;Return from busy routine
	
;------------------------Subroutines for delay-------------------------
INCLUDE delay.inc