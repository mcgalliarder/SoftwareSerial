
/*
 *  delay_usec.s
 *
 *  Created: 1/24/2019 9:29:30 AM
 *  Author: Eli McGalliard mcgalliarder
 *  Author: Andrew Thorp thorpah
 */ 
 #define MAX_USEC_DELAY 0
 #define MAX_LONG_USEC_DELAY 0

			.section .text
			.global delay_usec

/*
 * void delay_usec(unsigned int num)
 * param: num stored in r24 and r25 
 * checks to see if r24 and r25 are both zero, if so perform max_delay_usec routine
 * otherwise carry on with normal delay_usec
 */
delay_start: nop
delay_usec:
			sbiw r24, 0x1
			breq int_done
			nop
			call delay_start
			nop
int_done:
			nop
			ret

			.global delay_long_usec
delay_long_start:
			nop
			
delay_long_usec:
			sbiw r24, 0x1
			breq long_done
			nop
			call delay_long_start
			nop

long_done:
			nop
			ret


/*
			cp r24, 0x00 ; 1 cycle, could also use tst
			breq testzero ; 1/2 cycle
			call int_loop_1 ; 4 cycle
			ret
	testzero:	
			cp r25, 0x00 ; 1 cycle
			breq callmax ; 1 cycle not taken, 2 cycle taken
			call int_loop_1 ; 4 cycle
			ret
	callmax:
			call max_delay_usec ; 4 cycle
			ret


/**
* The main loop for the delay_usec method.
* Checks to see if there are numbers left to be decremented, and if so
* performs a 1 us loop for each number.
*/
/*
int_loop_1:	; need to subtract 1 from r24 until it gets to 0, at that point check r25. If it isn't 0, subtract 1, ser r24, and continue
			cp r24, 0x00 ; 1 cycle
			breq test25 ; 1 cycle not taken, 2 cycle taken
			subi r24, 0x01 ; 1 cycle
			and r18, r18 ; 1 cycle
			call wait_millisecond ; 4 cycle for call, 4 cycle after call
			call int_loop_1 ; 4 cycle
	test25: ; 3 cycle to this point, use up 13
			cp r25, 0x00 ; 1 cycle
			breq done ; 1 cycle not taken, 2 cycle taken
			subi r25, 0x01 ; 1 cycle
			ser r24 ; 2 cycle
			ser r26 ; 2 cycle
			ser r27 ; 2 cycle
			call int_loop_1 ; 4 cycle
	done:
			ret 

*/
/**
*  Used in the event that a MAX_USEC_DELAY is passed to delay_long_usec
*  Clears all of the registers and then sets them to 0xff for max delay
*/
/*
max_delay_usec: ; 
			; need to take up 10 cycles
			clr r25 ; 1 cycle : clears the register
			clr r24 ; 1 cycle
			ser r25 ; 2 cycle : sets the register to 0xff
			ser r24 ; 2 cycle
			call int_loop_1 ; 4 cycle
			ret

; wait_one_millisecond uses exactly 16 cycles including the return.
wait_millisecond:
			and r18, r18 ; 1 cycle
			and r19, r19 ; 1 cycle
			and r20, r20 ; 1 cycle
			and r21, r21 ; 1 cycle
			ret ; 4 cycles due to 15 bit PC
			

four_cycle:
			ret
			

wait_one:	
			ret ; 4 cycles due to 15 bit PC
		*/