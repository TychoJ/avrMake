/*
 * MIT License
 *
 * Copyright (c) 20223 TychoJ
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

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
