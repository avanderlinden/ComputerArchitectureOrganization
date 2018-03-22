#include "LPC13xx.h"
#include "delay.h"

#define LED1 (1<<0)
#define BUTTON1 (1<<9)

#define TRUE 1
#define FALSE 0

void init_led(){
    LPC_GPIO3->DIR = LED1;
}

void led_on(){
    LPC_GPIO3->DATA = LPC_GPIO3->DATA & (~LED1);
}

void led_off(){
    LPC_GPIO3->DATA = LED1;
}

void led_inverse() {
    if(LPC_GPIO3->DATA & LED1){
        led_on();
    }
    else {
        led_off();
    }

}

void init_button(){
    //LPC_GPIO2->DIR = LPC_GPIO2->DIR & (~BUTTON1);
    LPC_GPIO2->DIR = 0x0;
    //LPC_IOCON->PIO2_9 = 0x16; // set to GPIO pullup mode.
}

int button1_pressed(){
    if(!(LPC_GPIO2->DATA & BUTTON1)){
        return TRUE;
    }
    else {
        return FALSE;
    }
}


int main(void)
{
    init_led();
    led_off();

    init_button();

	while(1)
	{
        if(button1_pressed()){
            led_inverse();
            while(button1_pressed());
            delay_ms(25);
        }
	}

    // not executed
	return 0;
}
