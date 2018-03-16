#include "LPC13xx.h"

void delay(void);

int main(void)
{
	LPC_GPIO0->DIR = (1<<7); //Config PIO0_7 as Output

	while(1)
	{
		LPC_GPIO0->DATA = (1<<7); //Drive output HIGH to turn LED ON
		// Better way would be LPC_GPIO0->DATA |= (1<<7);

		delay();
		LPC_GPIO0->DATA = 0x0; //Drive output LOW to turn LED OFF
		// Better way would be LPC_GPIO0->DATA &= ~(1<<7);

		delay();
	}
	return 0; //normally this wont execute
}

void delay(void) //Hard-coded delay function
{
	int count,i=0;
	for(count=0; count < 4500000; count++) //You can edit this as per your needs
	{
		i++; //something needs to be here else compiler will remove the for loop!
	}
}
