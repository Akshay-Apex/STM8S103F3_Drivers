#include "../STM8S103F3_L0_Drivers/gpio.h"
#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/timer.h"
#include "./ws2812.h"

#define WS2812_TIM2_PSC 0

/*=============================================================*
 * 
 * WS2812 Public API Definitions
 *
 *=============================================================*/

/* Definition of global WS2812 service variables (shared via extern in ws2812.h) */
uint16_t TIM2_ARR = 0;
uint16_t TIM2_COMPARE_BIT_0 = 0;
uint16_t TIM2_COMPARE_BIT_1 = 0;

/* Timing Parameters Calibration Function */
void ws2812_timing_calibrate(void) {
  uint8_t fmaster_freq_mhz = (clk_fmaster_freq_khz_get() >> 10) + 1;
  if(fmaster_freq_mhz == 16) {    
    TIM2_ARR = 20;
    TIM2_COMPARE_BIT_0 = 6;
    TIM2_COMPARE_BIT_1 = 12;
  } else if(fmaster_freq_mhz == 8) {    
    TIM2_ARR = 10;
    TIM2_COMPARE_BIT_0 = 3;
    TIM2_COMPARE_BIT_1 = 6;
  } else if(fmaster_freq_mhz == 4) {    
    TIM2_ARR = 5;
    TIM2_COMPARE_BIT_0 = 1;
    TIM2_COMPARE_BIT_1 = 3;
  } 
}


// NOt completed =========   ===  ===========  ===== =    = = =
void ws2812_init(uint8_t pin) {    
  clk_peripheral_1_clock_enable(CLK_TIM2);
  tim2_prescaler_set(0);  

  if(pin == 4) {    
    tim2_cc1_channel_mode_set(TIM2_CC1_OUTPUT);
    tim2_cc1_enable();

  } else if(pin == 3) {    
    tim2_cc2_channel_mode_set(TIM2_CC2_OUTPUT);
    tim2_cc2_enable();

  } else if(pin == 2) {    
    tim2_cc3_channel_mode_set(TIM2_CC3_OUTPUT);
    tim2_cc3_enable();
  }

  gpio_out_push_pull_fast_mode(GPIO_D, pin);
}


void ws2812_deinit(void);
