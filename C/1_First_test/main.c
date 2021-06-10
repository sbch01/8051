#include <lint.h>
#include <8052.h>
//-------------Function declaration------------------------
void delay (int time);
//-------------Variable declaration------------------------

//__data -> заделя клетка от вътрешната рам памет
//__at(0x20) -> указва адрес от паметта 

__data __at(0x20) char my_char; 
__data __at(0x30) int counter;
__data char str[10] = "Stoian";

//Заделяне на един бит __bit
__bit FlagBit = 0;

//Съхранява се в програмната памет __code
__code char Version[] = "Ver 2.0";

//----------Interupt handler function----------------------
//__using(0/1) показва коя банка се ползва по време на прекъсването

//void ext0_isr (void) __interrupt (0) __using (0){	
//}

//void timer0_isr (void) __interrupt (1) __using (0){	
//}

//void ext1_isr (void) __interrupt (2) __using (0){	
//}

//void timer1_isr (void) __interrupt (3) __using (0){	
//}

//void serial_isr (void) __interrupt (4) __using (0){	
//}

//void timer2_isr (void) __interrupt (5) __using (0){	//only 8052
//}

//=======================================================
//  CUSTOM FUNCTION
//=======================================================

void delay (int time){

	while(time!=0){
		time--;
	}
}

//=========================================================
//			MAIN PROGRAM
//=========================================================
void main(){

	__asm //начало на асемблерови инструкции
	; This is a comment
		label:
		nop
	__endasm; //край на асемблерови инструкции
	
	FlagBit = 1;

	counter = 0x11aa;
	P0 = 0x00;
	my_char = 0x55;

		if (counter==0xffff)	{
			P0_0 = 1;	
		}

	//cycling code here
	 while(1){
		
		P0_0 =! P0_0;
		delay (100);
		//P0_0 = 0;
		//delay(100);
	 }
}