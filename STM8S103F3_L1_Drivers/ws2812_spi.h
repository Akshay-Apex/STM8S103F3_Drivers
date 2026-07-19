#ifndef WS2812_SPI_H
#define WS2812_SPI_H

#include <stdint.h>

/*=============================================================*
* 
* WS2812_SPI Public API Declarations BEGIN 
*
*=============================================================*/

/* Global Variable and Constant Declarations */
extern uint8_t WS2812_BRIGHTNESS;

/* WS2812 Initilization Function */
void ws2812_spi_init(void);


/* Writes the Data-Frame to WS2812 */
void ws2812_send_frame(uint8_t *frame, uint8_t frame_len);


/* WS2812 Data-Frame Build Functions */
/* Writes to Individual Pixel of a Data-Frame */
void ws2812_frame_pixel_write(uint8_t *frame, uint8_t pixel_index, uint8_t r, uint8_t g, uint8_t b);

/* Writes the Digit in BCD in Upper or Lower Nibble which can be selected using lower_nibble_flag */
void ws2812_frame_bcd_digit_write(uint8_t *frame, uint8_t start_index, uint8_t lower_nibble_flag, uint8_t digit,  uint8_t r, uint8_t g, uint8_t b);

/* Writes the Number in BCD format to the Data-Frame */
void ws2812_frame_bcd_number_write(uint8_t *frame, uint8_t size, uint16_t number);

/*=============================================================*
 * WS2812_SPI Public API Declarations END
 *=============================================================*/

#endif