#ifndef WS2812_H
#define WS2812_H

#include <stdint.h>

#define WS2812_T0H 6
#define WS2812_T1H 12

/*=============================================================*
* 
* WS2812 Public API Declarations BEGIN 
*
*=============================================================*/

/* Global Variable and Constant Declarations */


/* Timing Parameters Calibration Function */
void ws2812_timing_calibrate(void);

void ws2812_init(uint8_t pin);

typedef struct {
  uint8_t green;
  uint8_t red;
  uint8_t blue;
} ws2812_pixel_t;

void ws2812_set_pixel(uint8_t index, ws2812_pixel_t pixel);

void ws2812_clear(void);

void ws2812_show(void);

void ws2812_reset(void);

/*=============================================================*
 * WS2812 Public API Declarations END
 *=============================================================*/

#endif