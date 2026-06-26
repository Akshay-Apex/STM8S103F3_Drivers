#include <stdint.h>

#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/gpio.h"
#include "../STM8S103F3_L1_Drivers/time.h"
#include "../STM8S103F3_L1_Drivers/ws2812.h"


int main(void) {
  /* 16 LEDs - All Red */
  uint8_t frame_red[48] = {
      0x00,0xFF,0x00, 0x00,0xFF,0x00, 0x00,0xFF,0x00, 0x00,0xFF,0x00,
      0x00,0xFF,0x00, 0x00,0xFF,0x00, 0x00,0xFF,0x00, 0x00,0xFF,0x00,
      0x00,0xFF,0x00, 0x00,0xFF,0x00, 0x00,0xFF,0x00, 0x00,0xFF,0x00,
      0x00,0xFF,0x00, 0x00,0xFF,0x00, 0x00,0xFF,0x00, 0x00,0xFF,0x00
  };

  /* 16 LEDs - All Green */
  uint8_t frame_green[48] = {
      0xFF,0x00,0x00, 0xFF,0x00,0x00, 0xFF,0x00,0x00, 0xFF,0x00,0x00,
      0xFF,0x00,0x00, 0xFF,0x00,0x00, 0xFF,0x00,0x00, 0xFF,0x00,0x00,
      0xFF,0x00,0x00, 0xFF,0x00,0x00, 0xFF,0x00,0x00, 0xFF,0x00,0x00,
      0xFF,0x00,0x00, 0xFF,0x00,0x00, 0xFF,0x00,0x00, 0xFF,0x00,0x00
  };

  /* 16 LEDs - All Blue */
  uint8_t frame_blue[48] = {
      0x00,0x00,0xFF, 0x00,0x00,0xFF, 0x00,0x00,0xFF, 0x00,0x00,0xFF,
      0x00,0x00,0xFF, 0x00,0x00,0xFF, 0x00,0x00,0xFF, 0x00,0x00,0xFF,
      0x00,0x00,0xFF, 0x00,0x00,0xFF, 0x00,0x00,0xFF, 0x00,0x00,0xFF,
      0x00,0x00,0xFF, 0x00,0x00,0xFF, 0x00,0x00,0xFF, 0x00,0x00,0xFF
  };

  clk_hsi_osc_enable();
  clk_lsi_osc_enable();

  clk_cpu_div_prescalar_set(CLK_CPU_DIV_1);
  time_init();
  ws2812_init(WS2812_CH1_PD4);
  gpio_out_push_pull(GPIO_B, 5);
  uint8_t i = 0;
  
  while(1) {
    /* HSI Clock at 16 MHz */
    while(!clk_hsi_osc_is_ready());
    clk_master_switch_src(CLK_MASTER_SRC_HSI);
    while(clk_switch_is_ongoing());
    clk_hsi_div_prescalar_set(CLK_HSI_DIV_1);    

    time_timing_calibrate();
    ws2812_timing_calibrate();

    ws2812_write_frame_ch1(frame_red, sizeof(frame_red));

    while(i < 6) {
      gpio_output_toggle(GPIO_B, 5);
      i++;
      time_delay_sec(1);
    }
    i = 0;
    
    time_delay_sec(2);

    /* HSI Clock at 8 MHz */
    clk_hsi_div_prescalar_set(CLK_HSI_DIV_2);
    
    time_timing_calibrate();
    ws2812_timing_calibrate();

    ws2812_write_frame_ch1(frame_blue, sizeof(frame_blue));

    while(i < 8) {
      gpio_output_toggle(GPIO_B, 5);
      i++;
      time_delay_sec(1);
    }
    i = 0;
    
    time_delay_sec(2);


    /* HSI Clock at 4 MHz */
    clk_hsi_div_prescalar_set(CLK_HSI_DIV_4);
    
    time_timing_calibrate();
    ws2812_timing_calibrate();

    ws2812_write_frame_ch1(frame_green, sizeof(frame_green));

    while(i < 10) {
      gpio_output_toggle(GPIO_B, 5);
      i++;
      time_delay_sec(1);
    }
    i = 0;
    
    time_delay_sec(2);


    /* LSI Clock at 128 KHz */
    while(!clk_lsi_osc_is_ready());
    clk_master_switch_src(CLK_MASTER_SRC_LSI);
    while(clk_switch_is_ongoing());    

    time_timing_calibrate();        

    while(i < 6) {
      gpio_output_toggle(GPIO_B, 5);
      i++;
      time_delay_lsi_sec(1);
    }
    i = 0;
    
    time_delay_lsi_sec(2);
  }
}