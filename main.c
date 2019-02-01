/*
 * Project1.c
 *
 * Created: 1/31/2019 6:53:30 PM
 * Author : Eli
 */ 

#include <avr/io.h>
#include <util/delay.h>
#include "IncFile1.h"
#include "EmSys.h"

#define PORT_ON 0x40
#define PORT_OFF 0x00

void sw_serial_putc(char c);

int main(void)
{
    DDRB |= (1 << PB6);
	init_sw_serial_putc_test(9600,SERIAL_8N1);
	
    while (1) 
    {
		sw_serial_putc('U');
		test_sw_serial_putc();
		_delay_ms(1000);
    }
}

void sw_serial_putc(char c) {
	PORTB = PORT_OFF;
	delay_usec(104);
	for (int i = 0; i < 8; i++) {
		char bit = (c >> i) & 0x01;
		PORTB = bit << PB6;
		delay_usec(103);
	}
	PORTB = PORT_ON;
	delay_usec(104);
}
