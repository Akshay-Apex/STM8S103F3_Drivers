#ifndef WS2812_H
#define WS2812_H

#include <stdint.h>

/*=============================================================*
* 
* WS2812 Public API Declarations BEGIN 
*
*=============================================================*/

/* Global Variable and Constant Declarations */
extern uint16_t TIM2_PSC;
extern uint16_t TIM2_ARR;
extern uint16_t TIM2_COMPARE_BIT_0;
extern uint16_t TIM2_COMPARE_BIT_1;


/* Timing Parameters Calibration Function */
void ws2812_timing_calibrate(void);

void ws2812_init(uint8_t pin);

void ws2812_deinit(void);
/*=============================================================*
 * WS2812 Public API Declarations END
 *=============================================================*/

#endif