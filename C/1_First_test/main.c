
#include <lint.h>
#include <8052.h>

//__data -> заделя клетка от вътрешната рам памет
//__at(0x20) -> указва адрес от паметта 

__data __at(0x20) char my_char; 
__data __at(0x30) int counter;
void main(){
	
	counter = 0x11aa;
	P0 = 0x00;
	my_char = 0x55;

		if (counter==0xffff)	{
			P0 = 0xf1;	
		}
	 while(1){}
}