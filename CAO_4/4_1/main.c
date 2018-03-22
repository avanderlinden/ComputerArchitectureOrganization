#include "LPC13xx.h"
#include "delay.h"

#define LED1 (1<<0)

void init_led(){
    LPC_GPIO3->DIR = LED1;
}

void led_on(){
    LPC_GPIO3->DATA = LED1;
}

void led_off(){
    LPC_GPIO3->DATA = LPC_GPIO3->DATA & (~LED1);
}

int main(void)
{
    init_led();

	while(1)
	{
        led_on();
		delay_ms(500);
        led_off();
		delay_ms(500);

	}

    // not executed
	return 0;
}
