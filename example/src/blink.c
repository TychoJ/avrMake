//#define __ATxmega256A3U__
#define __AVR_ATxmega256A3U__

#define  F_CPU 2000000UL        // clock is running at 2MHz

#include <avr/io.h>
#include <util/delay.h>

int main(void) {
  PORTC.DIRSET = PIN0_bm;       // bit 0 port C is set, it is an output
  PORTF.DIRSET = PIN1_bm;       // bit 0 port f is set, it is an output

  while (1) {
    PORTC.OUTSET = PIN0_bm;     // bit 0 port C is high, led is on
    PORTF.OUTCLR = PIN1_bm;     // bit 0 port f is low, led is off
    _delay_ms(250);
    PORTC.OUTCLR = PIN0_bm;     // bit 0 port C is low, led is off
    PORTF.OUTSET = PIN1_bm;     // bit 0 port f is high, led is on
    _delay_ms(250);
  }
}