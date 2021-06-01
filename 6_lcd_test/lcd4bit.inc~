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

temp equ 80h
;================Initial LCD in 4 bit mode=============================
;In this whole 4-bit tutorial LCD is connected to
;my controller in following way...
;D4 - P3.0
;D5 - P3.1
;D6 - P3.2
;D7 - P3.3
;EN - P3.7
;RS - P3.5
 
	lcd_port equ P3     ;LCD connected to Port3
	en 	 equ P3.7   ;Enable connected to P3.7
	rs 	 equ P3.5   ;Register select to P3.5
	
lcd_reset:                  ;LCD reset sequence
	mov lcd_port, #0FFH
	mov A,#20           ;20mS delay
	mov B,#0
	acall Wait_mS
	mov lcd_port, #83H  ;Data = 30H, EN = 1, First Init
	mov lcd_port, #03H  ;Data = 30H, EN = 0
	
	mov A,#15           ;15mS delay
	mov B,#0
	acall Wait_mS
	
	mov lcd_port, #83H ;Second Init, Data = 30H, EN = 1
 
	mov lcd_port, #03H ;Data = 30H, EN = 0
	
	mov A,#5           ;5mS delay
	mov B,#0
	acall Wait_mS
	
	mov lcd_port, #83H ;Third Init
 
	mov lcd_port, #03H

	mov A,#5           ;5mS delay
	mov B,#0
	acall Wait_mS
	
	mov lcd_port, #82H ;Select Data width (20H for 4bit)
	mov lcd_port, #02H ;Data = 20H, EN = 0

	mov A,#5           ;5mS delay
	mov B,#0
	acall Wait_mS
	ret
 
 
lcd_init:
	acall lcd_reset         ;Call LCD Reset sequence
	mov a,#28H              ;4-bit, 2 line, 5x7 dots
 
	acall lcd_cmd           ;Call LCD command
	mov a,#0CH              ;Display ON cursor OFF
	acall lcd_cmd           ;Call LCD command
	mov a,#06H              ;Set entry mode (Auto increment)
 
	acall lcd_cmd           ;Call LCD command
	mov a,#80H              ;Bring cursor to line 1
	acall lcd_cmd           ;Call LCD command
	ret
;=====================Cmand send to LCD================================
lcd_cmd:                      ;LCD command Routine
	mov temp,a            ;Save a copy of command to temp
	swap a                ;Swap to use higher nibble
	anl a,#0FH            ;Mask the first four bits
	add a,#80H            ;Enable = 1, RS = 0
	mov lcd_port,a        ;Move it to lcd port
	anl a,#0FH            ;Enable = 0, RS = 0
	mov lcd_port,a        ;Move to lcd port
 
	mov a,temp            ;Reload the command from temp
	anl a,#0FH            ;Mask first four bits
	add a,#80H            ;Enable = 1
	mov lcd_port,a        ;Move to port
	anl a,#0FH            ;Enable = 0
	mov lcd_port,a        ;Move to lcd port

 	mov A,#1           ;1mS delay
	mov B,#0
	acall Wait_mS
	ret
;==================Chartar send to LCD=================================
lcd_dat:                  ;LCD data Routine
	mov temp,a            ;Keep copy of data in temp
	swap a                ;We need higher nibble
	anl a,#0FH            ;Mask first four bits
	add a,#0A0H           ;Enable = 1, RS = 1
	mov lcd_port,a        ;Move to lcd port
	nop
	clr en                ;Enable = 0
 
	mov a,temp            ;Reload the data from temp
	anl a,#0FH            ;we need lower nibble now
	add a,#0A0H           ;Enable = 1, RS = 1
	mov lcd_port,a        ;Move to lcd port
	nop
	clr en                ;Enable = 0

 	mov A,#1           ;1mS delay
	mov B,#0
	acall Wait_mS

	ret

;------------------------Subroutines for delay-------------------------
INCLUDE delay.inc