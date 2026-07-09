#include <stdint.h>
#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/gpio.h"

#include "../STM8S103F3_L1_Drivers/time.h"
#include "../STM8S103F3_L1_Drivers/ws2812_spi.h"
#include "../STM8S103F3_L1_Drivers/ds18b20.h"

uint8_t frame[16 * 3];

int main(void) {      
  WS2812_BRIGHTNESS = 40; 
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);  
  gpio_out_push_pull(GPIO_B, 5);
  time_init();
  ws2812_spi_init();
  ds18b20_init(GPIO_D, 4);

  while(1) {
    gpio_output_toggle(GPIO_B, 5);    
    time_delay_sec(1);
    if(ds18b20_reset_and_detect_slave()) {
      CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
      CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
      HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

      clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
      clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
      

      ds18b20_byte_write(0x33);            
      for(uint8_t i = 0; i < 8; i++) {        
        ws2812_frame_build_bcd(frame, sizeof(frame), ds18b20_byte_read());
        time_delay_sec(1);
        ws2812_send_frame(frame, sizeof(frame)); 
      }                  



      clk_fmaster_switch_src_auto_mode(current_clock_src);
      clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
    } else {
      for(uint8_t i = 0; i < (sizeof(frame) / 3); i++) {
        ws2812_frame_pixel_write(frame, i, 255, 0, 0);
      }      
      ws2812_send_frame(frame, sizeof(frame));   
    }
             
  }
}


