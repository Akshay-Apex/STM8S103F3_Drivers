#ifndef WS2812_SPI_H
#define WS2812_SPI_H

#include <stdint.h>

/*=============================================================*
* 
* WS2812_SPI Public API Declarations BEGIN 
*
*=============================================================*/

void ws2812_spi_init(void);

void ws2812_send_frame(uint8_t *frame, uint8_t frame_len);

/*=============================================================*
 * WS2812_SPI Public API Declarations END
 *=============================================================*/

#endif