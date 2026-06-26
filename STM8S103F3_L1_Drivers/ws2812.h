#ifndef WS2812_H
#define WS2812_H

#include <stdint.h>

/*=============================================================*
* 
* WS2812 Public API Declarations BEGIN 
*
*=============================================================*/

/* WS2812 Channel and Pin Selection */
typedef enum {
  WS2812_CH1_PD4 = 4,
  WS2812_CH2_PD3 = 3,
  WS2812_CH3_PD2 = 2
} WS2812_CHANNEL_PIN;


/* Global Variable and Constant Declarations */
extern uint8_t TIM2_ARR;
extern uint8_t TIM2_COMPARE_BIT_0;
extern uint8_t TIM2_COMPARE_BIT_1;


/* Timing Parameters Calibration Function */
void ws2812_timing_calibrate(void);


/* WS2812 Initialization Function */
void ws2812_init(WS2812_CHANNEL_PIN pin);


/* WS2812 Write Functions */
void ws2812_write_frame_ch1(uint8_t *frame, uint8_t frame_len);

void ws2812_write_frame_ch2(uint8_t *frame, uint8_t frame_len);

void ws2812_write_frame_ch3(uint8_t *frame, uint8_t frame_len);


/*=============================================================*
 * WS2812 Public API Declarations END
 *=============================================================*/

#endif