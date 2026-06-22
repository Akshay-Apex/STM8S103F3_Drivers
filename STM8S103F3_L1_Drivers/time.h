#ifndef TIME_H
#define TIME_H

#include <stdint.h>

/*=============================================================*
* 
* Time Public API Declarations BEGIN 
*
*=============================================================*/

/* Global Variable and Constant Declarations */
extern uint8_t TIM4_PSC_VAL_FOR_1MHZ;

void time_delay_us(uint16_t us);
void time_delay_ms(uint16_t ms);
void time_delay_sec(uint16_t sec);

/*=============================================================*
 * Time Public API Declarations END
 *=============================================================*/

#endif