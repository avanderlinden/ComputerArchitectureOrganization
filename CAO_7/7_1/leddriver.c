#include <stdint.h>

#include "LPC13xx.h"
#include "leddriver.h"

void init_leds (void)
{
	// Leds 0-3 are on PIO3_0-PIO3_3
	LPC_GPIO3->DIR |= (1<<3) | (1<<2) | (1<<1) | (1<<0);
	// Leds 4-7 are on PIO2_4-PIO2_7
	LPC_GPIO2->DIR |= (1<<7) | (1<<6) | (1<<5) | (1<<4);
}


uint8_t get_leds (void)
{
	uint32_t leds_low_data  = ~LPC_GPIO3->DATA & 0x0F;
	uint32_t leds_high_data = ~LPC_GPIO2->DATA & 0xF0;

	return leds_high_data | leds_low_data;
}


void toggle_leds (uint8_t toggle_mask)
{
	uint32_t toggle_mask_low  = toggle_mask & 0x0F;
	uint32_t toggle_mask_high = toggle_mask & 0xF0;

	LPC_GPIO3->DATA = LPC_GPIO3->DATA ^ toggle_mask_low;
	LPC_GPIO2->DATA = LPC_GPIO2->DATA ^ toggle_mask_high;
}


void set_leds (uint8_t leds)
{
	uint32_t leds_low_data  = ~leds & 0x0F;
	uint32_t leds_high_data = ~leds & 0xF0;

	LPC_GPIO3->DATA = (LPC_GPIO3->DATA & ~0x0F) | leds_low_data;
	LPC_GPIO2->DATA = (LPC_GPIO2->DATA & ~0xF0) | leds_high_data;
}
