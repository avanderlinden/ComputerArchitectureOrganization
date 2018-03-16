#include "LPC13xx.h"
#include "delay.h"
#include "uart.h"


int main(void)
{
	LPC_GPIO3->DIR = (1<<0); //Config PIO0_7 as Output

    char msg[] = { 'H','e','l','l','o',' ','f','r','o','m',' ','L','P','C','1','3','4','3','\0' };
	int count=0;

	initUART();


	while(1)
	{
		LPC_GPIO3->DATA = (1<<0); //Drive output HIGH to turn LED ON
		// Better way would be LPC_GPIO0->DATA |= (1<<7);

		delay_ms(500);
		LPC_GPIO3->DATA = 0x0; //Drive output LOW to turn LED OFF
		// Better way would be LPC_GPIO0->DATA &= ~(1<<7);

		delay_ms(500);


        while( msg[count]!='\0' )
        {
            uartWrite(msg[count]);
            count++;
        }
        //Send NEW Line Character(s) i.e. "\n"
        uartWrite(CARRIAGE_RETURN); //Comment this for Linux or MacOS
        uartWrite(LINE_FEED); //Windows uses CR+LF for newline.
        count=0; // reset counter

	}
	return 0; //normally this wont execute
}
