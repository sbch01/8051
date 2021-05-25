;======================================================================
;Library with soubroutnes for delay function no need of hardware timers
;All delay are calculated for 12 MHz Clock frequency 
;
;Date: 21.04.2021		Author: S. Banchev
;Source: https://github.com/sbch01/8051/
;======================================================================


;----------------------------------------------------------------------
; Subroutine wait uS
;----------------------------------------------------------------------
Wait_uS: ;loop aprox A value in uS
	RRC A ; divide by two loded in A value 
Wait_uSx2: ;loop aprox A value  x2 in uS
	DJNZ A,$ ;
	RET
;----------------------------------------------------------------------

;----------------------------------------------------------------------
; Subroutine wait mS
;----------------------------------------------------------------------
;Load A and B register with your delay needs 
;A register is low byte digit and B register is high byte register
;Always check value in two register before call subroutine
;Max delay is 65535 mS if A=0xff and B=0xff
Wait_mS:
	INC B
Loop_mS:
	MOV R0,#249
	DJNZ R0,$
	MOV R0,#249
	DJNZ R0,$
	DJNZ A,Loop_mS
	DJNZ B,Loop_mS
	RET