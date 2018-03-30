#ifndef _LEDDRIVER_H_
#define _LEDDRIVER_H_

#include <stdint.h>

void init_leds (void);
void toggle_leds (uint8_t toggle_mask);
uint8_t get_leds (void);
void set_leds (uint8_t leds);

#endif /* _LEDDRIVER_H_ */
