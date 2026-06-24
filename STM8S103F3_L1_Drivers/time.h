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

/* Timing Parameters Calibration Function */
void time_timing_calibrate(void);

/* Time INIT and DEINIT Functions */
void time_init(void);

void time_deinit(void);

/* Low Precision Clock based delay functions */
void time_delay_lsi_ms(uint16_t ms);

void time_delay_lsi_sec(uint16_t sec);

/* High Precision Clock based delay functions */
void time_delay_us(uint16_t us);

void time_delay_ms(uint16_t ms);

void time_delay_sec(uint16_t sec);

/*=============================================================*
 * Time Public API Declarations END
 *=============================================================*/

#endif