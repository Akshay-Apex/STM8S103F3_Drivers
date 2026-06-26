#ifndef WS2812_H
#define WS2812_H

#include <stdint.h>

/*=============================================================*
* 
* WS2812 Public API Declarations BEGIN 
*
*=============================================================*/

/* Global Variable and Constant Declarations */
extern uint8_t TIM2_ARR;
extern uint8_t TIM2_COMPARE_BIT_0;
extern uint8_t TIM2_COMPARE_BIT_1;


/* Timing Parameters Calibration Function */
void ws2812_timing_calibrate(void);


/* WS2812 Initialization Function */
void ws2812_init(uint8_t pin);


/* WS2812 Write Functions */
void ws2812_write_frame_ch1(uint8_t *frame, uint8_t frame_len);

void ws2812_write_frame_ch2(uint8_t *frame, uint8_t frame_len);

void ws2812_write_frame_ch3(uint8_t *frame, uint8_t frame_len);


/*=============================================================*
 * WS2812 Public API Declarations END
 *=============================================================*/

#endif