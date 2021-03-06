;-----------------------------------------------------------------------------------------
;Това е пример на асемблер в , който е демонстрирано подпрограми за изчакване чрез и без използване на 
;вградените таймери
;Направена е и демонстрация на прекъсване от таймер 0
;Демонстрирано е и използването на на програмната памет за съхранение на константи
;
;
;18.04.2021 		Автор: С. Банчев
;-----------------------------------------------------------------------------------------
;INCLUDE ext.asm

ORG	0000H 	;място на което се установява PC след рестарт
	SJMP INITIAL

	
ORG 	000BH	;място от програмната памет където се разполага 
	SJMP TMR0_INTR	;вектора на прекъсване от таймер 0

;ORG	001BH	;място от програмната памет където се разполага 
;	SJMP TMR1_INTR	;вектора на прекъсване от таймер 1

;ORG	0003H	;място от програмната памет където се разполага 
;	SJMP INT0_INTR ;вектора на прекъсване от външен източник 0

;ORG	0013H ;място от програмната памет където се разполага 
;	SJMP INT1_INTR	;вектора на прекъсване от външен източник 1

;ORG	0023H	;място от програмната памет където се разполага 
;	SJMP UART_INT	;вектора на прекъсване от асинхрония приемо предавател на данни


DECRES 	EQU 30H	;Директива за дефиниране на константа
MYBIT	EQU 02H
ORG	0030H	;Започване на стартовата програма от адрес 30H на програмната памет

INITIAL:
	;Включване на таймер 0
	;MOV TMOD,#00000010B ;Тестване на различните видове работи на таймера чрез битове М10 и М00
	;MOV TCON,#00010010B ;Конфигуриране на таймер 0
	;MOV IE,#10000010B ;Разрешеаване на прекъсване от таймер 0
	;MOV TH0,#005
START:
	;MOV A,#5
	;CALL WAIT_US
	
	MOV A,#2CH;Зареждаме колко mS искаме да изчака WAIT_MS
	MOV B,#01H ;
	CALL WAIT_MS ;Извиква подпрограма за 
	MOV DPTR,#MY_STRING ;зарежда адреса на стринга в 
	CALL READ_STR ;Извиква подпрограма за извличане на стрига
	MOV A,#3
	CALL ASCII_DIG
	JMP $
	
;-----------------------------------------------------------------------------------
;Подпрограми за изчакване
;-----------------------------------------------------------------------------------
;Подпрограма изчакваща uS
WAIT_US:
	RRC A ;Делим на две акумулатора чрез ротация
WAIT_USX2: ;От тук извикваме подпрограмата ако искаме закъснение по 2 стойноста на акумулатора в uS
	DJNZ A,$ ;Циклим ....
	RET
	
;----------------------------------------------	
;Подпрограма изчакваща mS
;Можем да постигнем закъснения от 65 535 mS
;Участват регистри A и B регистър A е нисшия байт а B висшия байт
WAIT_MS:
	INC B
LOOP_MS:
	MOV R0,#249
	DJNZ R0,$
	MOV R0,#249
	DJNZ R0,$
	DJNZ A,LOOP_MS
	DJNZ B,LOOP_MS
	RET
;----------------------------------------------
;Подпрограма за извличане на стрингове от програмната памет
READ_STR:
	CLR A
	MOVC A,@A+DPTR
	INC DPTR
	JNZ READ_STR
	RET
;-------------------------------------------------------------------------------
;Подпрограми обслужващи прекъсванията
;-------------------------------------------------------------------------------	
;Прекъсване от таймер0
TMR0_INTR:
	NOP
	CLR TF0
	RETI
	
;-------------------------------------------------------------------------------
;Място за съхранение на стрингови константи и люкъп таблици
;-------------------------------------------------------------------------------
MY_STRING:
	DB 'Hello World',0
ASCII_DIG:
	INC A
	MOVC A,@A+PC
	RET
	DB 30H,31H,32H,33H,34H,35H,36H,37H,38H,39H
	END