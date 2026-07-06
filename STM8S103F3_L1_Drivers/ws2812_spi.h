#ifndef WS2812_SPI_H
#define WS2812_SPI_H

#include <stdint.h>

/*=============================================================*
* 
* WS2812_SPI Public API Declarations BEGIN 
*
*=============================================================*/

extern uint8_t WS2812_BRIGHTNESS;


void ws2812_spi_init(void);

void ws2812_send_frame(uint8_t *frame, uint8_t frame_len);

void ws2812_frame_pixel_write(uint8_t *frame, uint8_t pixel_index, uint8_t r, uint8_t g, uint8_t b);

void ws2812_frame_nibble_write(uint8_t *frame, uint8_t start_index, uint8_t lower_nibble, uint8_t digit,  uint8_t r, uint8_t g, uint8_t b);

void ws2812_frame_build_bcd(uint8_t *frame, uint8_t size, uint16_t number);

/*=============================================================*
 * WS2812_SPI Public API Declarations END
 *=============================================================*/

#endif