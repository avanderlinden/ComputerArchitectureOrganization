#include "LPC13xx.h"
#include "delay.h"

#define LED1 (1<<0)
#define BUTTON1 (1<<9)

#define TRUE 1
#define FALSE 0

#define DUTYCYCLE 10
#define PERIOD 10000

void init_led(){
    LPC_GPIO3->DIR |= LED1;
}

void led_on(){
    LPC_GPIO3->DATA = LPC_GPIO3->DATA & (~LED1);
}

void led_off(){
    LPC_GPIO3->DATA |= LED1;
}


void led_inverse() {
    if(LPC_GPIO3->DATA & LED1){
        led_on();
    }
    else {
        led_off();
    }

}

void init_timer(){
    LPC_SYSCON->SYSAHBCLKCTRL |= (1<<9);

    // Interrupt flag on match register 0
    LPC_TMR32B0->MCR |= (1<<0);
    LPC_TMR32B0->MCR |= (1<<9);

    /* Prescale registers */
    LPC_TMR32B0->PR = (72);

}


void reset_timer(int us){
    LPC_TMR32B0->TCR = 0x02;
    LPC_TMR32B0->PR = (72);
    LPC_TMR32B0->IR |= (1<<0);
    LPC_TMR32B0->MR0 = us;
    LPC_TMR32B0->TCR = 0x01;
}



void poll_timer(int us){
    // start timer
    reset_timer(us);

    // wait for interrupt flag
    while(!(LPC_TMR32B0->IR & (1<<0) ));

    // stop timer
    LPC_TMR32B0->TCR = 0x00;
}

int main(void)
{
    init_led();
    init_timer();

    int on_time = (PERIOD * DUTYCYCLE) / 100;
    int off_time = PERIOD - on_time;

    led_on();
	while(1)
	{
        poll_timer(on_time);
        led_off();
        poll_timer(off_time);
        led_on();
	}

    // not executed
	return 0;
}
