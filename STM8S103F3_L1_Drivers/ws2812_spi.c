#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/gpio.h"
#include "../STM8S103F3_L0_Drivers/spi.h"
#include "../STM8S103F3_L1_Drivers/time.h"
#include "./ws2812_spi.h"


/*=============================================================*
* 
* WS2812_SPI Public API Definitions
*
*=============================================================*/

/* Interrupt Enable and Disable */
#define global_interrupt_enable()  __asm__("rim") 
#define global_interrupt_disable() __asm__("sim")

/* Bit Values */
#define BIT_0 0x3800
#define BIT_1 0x3F00

/* Global Variable and Constant Declarations */
uint8_t WS2812_BRIGHTNESS = 255;



/* WS2812 Initilization Function */
void ws2812_spi_init(void) {
  clk_peripheral_1_clock_enable(CLK_SPI);   
  gpio_output_mode_push_pull_fast_mode_init(GPIO_C, 6);
  gpio_output_clear(GPIO_C, 6);
}



/* Writes the Data-Frame to WS2812 */
void ws2812_send_frame(uint8_t *frame, uint8_t frame_len) {
  global_interrupt_disable();  
  CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
  
  spi_master_mode_set(SPI_MASTER_CONFIGURATION);
  spi_baud_rate_prescaler_set(SPI_BAUD_RATE_PSC_2); 
  spi_enable();
  
  uint16_t accumulator = 0x0000;  
  for(uint8_t i = 0; i < frame_len; i++) {
    uint8_t frame_byte = frame[i];      

    for(uint8_t mask = 0x80; mask > 0; mask >>= 1) {
      if(frame_byte & mask) {        
        accumulator = (uint16_t)(accumulator << 8) | BIT_1;        
      } else {
        accumulator = (uint16_t)(accumulator << 8) | BIT_0;
      }      

      while(!spi_tx_buffer_status_read());
      spi_tx_data_write((uint8_t)(accumulator >> 8));
    }     
  }                
  
  while(spi_busy_status_read());  
  spi_disable();
  time_delay_us_16mhz(300U);
  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();
}



/* WS2812 Data-Frame Build Functions */
/* Writes to Individual Pixel of a Data-Frame */
void ws2812_frame_pixel_write(uint8_t *frame, uint8_t pixel_index, uint8_t r, uint8_t g, uint8_t b) {
  pixel_index *= 3;

  frame[pixel_index + 0] = g;
  frame[pixel_index + 1] = r;
  frame[pixel_index + 2] = b;
}


/* Writes the Digit in BCD in Upper or Lower Nibble which can be selected using lower_nibble_flag */
void ws2812_frame_bcd_digit_write(uint8_t *frame, uint8_t start_index, uint8_t lower_nibble_flag, uint8_t digit,  uint8_t r, uint8_t g, uint8_t b) {
  uint8_t count = 4;
  while(count--) {
    if(digit & 1) {
      ws2812_frame_pixel_write(frame, start_index, r, g, b);
    } else {
      if(lower_nibble_flag) {
        ws2812_frame_pixel_write(frame, start_index, 1, 1, 1);        
      } else {
        ws2812_frame_pixel_write(frame, start_index, 1, 0, 1);        
      }
    }

    start_index++;
    digit >>= 1;
  }
}


/* Writes the Number in BCD format to the Data-Frame */
void ws2812_frame_bcd_number_write(uint8_t *frame, uint8_t size, uint16_t number) {
  uint8_t index = 0;
  uint8_t pixel_length = size / 3;
  while(index < pixel_length) {
    uint8_t digit_1 = number % 10;
    number = number / 10;
    uint8_t digit_2 = number % 10;
    number = number / 10;

    ws2812_frame_bcd_digit_write(frame, index, 1, digit_1, 0, WS2812_BRIGHTNESS, 0);
    index += 4;
    ws2812_frame_bcd_digit_write(frame, index, 0, digit_2, 0, 0, WS2812_BRIGHTNESS);
    index += 4;
  }
}
