#include <at89x52.h>

__data __at(0x20) char my_char; 

void main(){

	
		
		P0 = 0x00;
		my_char = 0x55;
		
	 while(1){}
}