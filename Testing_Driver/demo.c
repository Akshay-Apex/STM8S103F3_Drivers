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
  ONE_WIRE_BUS temp_sensor = ds18b20_init(GPIO_D, 4);
  
  // uint16_t counter = 0;
  while(1) {
    gpio_output_toggle(GPIO_B, 5);    
        
    uint16_t temp = ds18b20_temperature_blocking_read(&temp_sensor);
    if(temp == DS18B20_ERROR_CODE) {
      for(uint8_t i = 0; i < (sizeof(frame) / 3); i++) {
        ws2812_frame_pixel_write(frame, i, 255, 0, 0);
      }          
    } else if(temp != DS18B20_PROCESSING_TEMP) {
      ws2812_frame_bcd_number_write(frame, sizeof(frame), ds18b20_temp_to_sign_encoded_fixed_point_max_99_celc(temp) - 19);      
    }
    ws2812_send_frame(frame, sizeof(frame));       

    // if(counter >= 10000U) {
    //   counter = 0;
    // } 
    // time_delay_ms(20);

    // ws2812_frame_bcd_number_write(frame, sizeof(frame), counter++);
    // ws2812_send_frame(frame, sizeof(frame));
  }
}


