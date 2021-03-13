;Source: https://www.circuitstoday.com/blinking-led-using-8051


START: CPL P1.0
       ACALL WAIT  
       SJMP START

WAIT:  MOV R4,#05H
WAIT1: MOV R3,#00H
WAIT2: MOV R2,#00H
WAIT3: DJNZ R2,WAIT3
       DJNZ R3,WAIT2
       DJNZ R4,WAIT1
       RET