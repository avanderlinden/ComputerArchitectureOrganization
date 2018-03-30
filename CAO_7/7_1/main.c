#include "LPC13xx.h"
#include "delay.h"
#include "leddriver.h"

void init_i2c(){

    // Enable clock for I2C
    LPC_SYSCON->SYSAHBCLKCTRL |= (1<<5);

    // set pin modes:
    LPC_IOCON->PIO0_4 |= (1<<0); // SCL pin 15
    LPC_IOCON->PIO0_5 |= (1<<0); // SDA pin 16

    // Reset I2C
    LPC_SYSCON->PRESETCTRL = (1<<1);

    // set clock freq to 100 kHz and dutycyle to 50%
    // 72 Mhz / (360+360) = 100kHz
    LPC_I2C->SCLH = 360;
    LPC_I2C->SCLL = 360;

    // enable I2C interface
    LPC_I2C->CONSET = (1<<6);

    // enable interrupt
    LPC_I2C->CONSET = (1<<3);
}


void handle_I2C_events(){
    uint8_t data = 0;

    uint8_t state = LPC_I2C->STAT;

    switch(state) {

        /*
         * Common Master Stages
         */
        case 0x00: // bus error
            // not implemente
            break;

        case 0x08: // START transmitted, ack received
            // send write slave address with R/W bit
            LPC_I2C->DAT = 0x90;
            // clear START flag
            LPC_I2C->CONCLR = (1<<5);
            break;

        case 0x10: // Repeated START transmitted, ack recieved
            LPC_I2C->DAT = 0x91;
            LPC_I2C->CONCLR = (1<<5);
            break;


        /*
         * Master Transmit Stages
         */
        case 0x18: // Slave+W addr trasmitted, ack
            // wite pointer register
            LPC_I2C->DAT = 0x00;
            break;


        case 0x20: // Save+W addr transmitted, no ack
            // not implemented
            break;

        case 0x28: // DATA transmitted, ack
            // All data was transmitted

            // Start
            LPC_I2C->CONSET = (1<<5);
            break;

        case 0x30: // DATA transmitted no ack
            // not implemented
            break;

        case 0x38: // Arbitrarion lost
            // not implemented
            break;

        /*
         * Master Receive Stages
         */
        case 0x40: // Slave+R addr transmitted, ack
            // Clear Ack bit
            LPC_I2C->CONCLR = (1<<2);
            break;

        case 0x48: // Slave+R addr transmitted, no ack
            // not inplemented
            break;

        case 0x50: // DATA received, ack
            // not inplemented
            break;

        case 0x58: // DATA received, no ack
            // send STOP signal
            LPC_I2C->CONSET =(1<<4);
            // get data
            data = LPC_I2C->DAT;
            // write data to leds
            set_leds(data);
            // send START signal
            LPC_I2C->CONSET = (1<<5);
            break;

        default:
            // not inplemented
            break;
    }

    // clear interrupt flag
    LPC_I2C->CONCLR = (1<<3);
}

void start_i2c(){
    LPC_I2C->CONSET = (1<<5);
}

void poll_i2c(){
    while(!(LPC_I2C->CONSET & (1<<3)));
}

int main(void)
{
    init_leds();
    init_i2c();

    start_i2c();
    while(1){
        poll_i2c();
        handle_I2C_events();
    }

	return 0; // not executed
}
