;--------------------------------------------------------------------------
;Този файл съдържа код, който преобразува бинарни числа в BCD числа
;Подпрограма BIN_DEC_CONVERT: конвертира един байт в BCD числа, като всяко число се съхранява в отделен байт
;Подпрограма DEC_ASCI_CONVERT: конвертира един байт с BCD число в ASCII код
;Подпрограма WRD_BIN_BCD: конвертира число съдържащо се в два байта в пакетирано BCD число
;
;05.04.2021г.		Автор: С. Банчев.
;--------------------------------------------------------------------------

;CONVERTING BIN (HEX) TO ASCII
;------------------------------------------
;Променливи ползвани за BIN_DEC_CONVERT: и DEC_ASCI_CONVERT:
RAM_ADDR	EQU	40H
ASCI_RESULT	EQU	50H
COUNT		EQU	3
;------------------------------------------
;Променливи ползвани за WRD_BIN_BCD:
BCD_U		EQU	60H
BCD_H		EQU	61H
BCD_L		EQU	62H

BIN_L		EQU	63H
BIN_H		EQU	64H

CNTWRD		EQU	16
;


;---------MAIN PROGRAM------------------------------------------
ORG	0
;ACALL	BIN_DEC_CONVERT
;ACALL	DEC_ASCI_CONVERT

MOV BIN_L,#0XFF
MOV BIN_H,#0XFF
ACALL WRD_BIN_BCD

SJMP	$

;---------CONVERTING BIN (HEX) TO DEC (00-FF TO 000-255)--------

BIN_DEC_CONVERT:
	MOV R0, #RAM_ADDR
	MOV A,P1
	MOV B,#10
	DIV AB
	MOV @R0,B
	INC R0
	MOV B,#10
	DIV AB
	MOV @R0,B
	INC R0
	MOV @R0,A
	RET

;----------CONVERT DEC DIGITS TO ASCII DIGITS ------------------

DEC_ASCI_CONVERT:
	MOV R0,#RAM_ADDR
	MOV R1,#ASCI_RESULT
	MOV R2,#COUNT
BACK:	MOV A,@R0
	ORL A,#30H
	MOV @R1,A
	INC R0
	INC R1
	DJNZ R2,BACK
	RET

;--------------WORD NUMBER TO PACKED BCD------------------------

WRD_BIN_BCD:
	CLR BCD_L
	CLR BCD_H
	CLR BCD_U
	MOV R0,#CNTWRD
CONVERT_BIN:
	MOV A,BIN_L
	RLC A
	MOV BIN_L,A

	MOV A,BIN_H
	RLC A
	MOV BIN_H,A

	MOV A,BCD_L
	ADDC A,BCD_L
	DA A
	MOV BCD_L,A

	MOV A,BCD_H
	ADDC A,BCD_H
	DA A
	MOV BCD_H,A

	MOV A,BCD_U
	RLC A
	MOV BCD_U,A

	DJNZ R0, CONVERT_BIN
	RET

	END
