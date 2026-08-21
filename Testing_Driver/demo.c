#include <stdint.h>
#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/gpio.h"

#include "../STM8S103F3_L1_Drivers/ds18b20.h"
#include "../STM8S103F3_L1_Drivers/time.h"
#include "../STM8S103F3_L1_Drivers/ws2812_spi.h"

#define LED_GPIO_PIN      GPIO_B, 5
#define DS18B20_GPIO_PIN  GPIO_D, 4

uint8_t frame[16 * 3];
uint8_t scratchpad[9];

int main(void) {
  /* Initialization */ 
  // Clock
  clk_cpu_div_prescalar_set(CLK_CPU_DIV_1);
  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_LSI);
  // GPIO
  gpio_output_mode_push_pull_init(LED_GPIO_PIN);
  // WS2812 SPI
  ws2812_spi_init();
  WS2812_BRIGHTNESS = 40;
  // DS18B20
  DS18B20_SENSOR temp_sensor = ds18b20_init(DS18B20_GPIO_PIN);
  // Time
  time_init();

  // Other state variables
  uint16_t temp;
  while(1) {
    gpio_output_toggle(LED_GPIO_PIN);

    temp = ds18b20_temperature_blocking_read(&temp_sensor);
    if(temp == DS18B20_ERROR_CODE) {
      for(uint8_t i = 0; i < sizeof(frame) / 3; i++) {
        ws2812_frame_pixel_write(frame, i, 255, 0, 0);
      }
    } else {
      temp = ds18b20_temp_to_sign_encoded_abs_centi_celsius(temp) - 19;
      ws2812_frame_bcd_number_write(frame, sizeof(frame), temp);
    }

    ws2812_send_frame(frame, sizeof(frame));
  }
}














// #include <stdint.h>
// #include "../STM8S103F3_L0_Drivers/clk.h"
// #include "../STM8S103F3_L0_Drivers/gpio.h"

// #include "../STM8S103F3_L1_Drivers/ds18b20.h"
// #include "../STM8S103F3_L1_Drivers/time.h"
// #include "../STM8S103F3_L1_Drivers/ws2812_spi.h"

// #define LED_GPIO_PIN      GPIO_B, 5
// #define DS18B20_GPIO_PIN  GPIO_D, 4

// uint8_t frame[16 * 3];
// uint8_t scratchpad[9];

// int main(void) {
//   /* Initialization */ 
//   // Clock
//   clk_cpu_div_prescalar_set(CLK_CPU_DIV_1);
//   clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_LSI);
//   // GPIO
//   gpio_output_mode_push_pull_init(LED_GPIO_PIN);
//   // WS2812 SPI
//   ws2812_spi_init();
//   WS2812_BRIGHTNESS = 40;
//   // DS18B20
//   DS18B20_SENSOR temp_sensor = ds18b20_init(DS18B20_GPIO_PIN);
//   // Time
//   time_init();

//   // Other state variables
//   uint16_t temp;
//   while(1) {
//     gpio_output_toggle(LED_GPIO_PIN);

//     temp = ds18b20_temperature_blocking_read(&temp_sensor);
//     if(temp == DS18B20_ERROR_CODE) {
//       for(uint8_t i = 0; i < sizeof(frame) / 3; i++) {
//         ws2812_frame_pixel_write(frame, i, 255, 0, 0);
//       }
//     } else {
//       temp = ds18b20_temp_to_sign_encoded_abs_centi_celsius(temp) - 19;
//       ws2812_frame_bcd_number_write(frame, sizeof(frame), temp);
//     }

//     ws2812_send_frame(frame, sizeof(frame));
//   }
// }