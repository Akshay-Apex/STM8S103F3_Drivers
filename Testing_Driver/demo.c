#include <stdint.h>
#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/gpio.h"

#include "../STM8S103F3_L1_Drivers/time.h"
#include "../STM8S103F3_L1_Drivers/ws2812_spi.h"

uint8_t frame[16 * 3];

WS2812_BRIGHTNESS = 40;

int main(void) {       
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);  
  gpio_out_push_pull(GPIO_B, 5);
  time_init();
  ws2812_spi_init();

  uint32_t count = 0;
  while(1) {
    gpio_output_toggle(GPIO_B, 5);    
    time_delay_sec(1);
    ws2812_frame_build_bcd(frame, sizeof(frame), count++);
    ws2812_send_frame(frame, sizeof(frame));            
  }
}


