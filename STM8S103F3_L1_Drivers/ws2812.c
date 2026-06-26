#include "../STM8S103F3_L0_Drivers/gpio.h"
#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/timer.h"
#include "../STM8S103F3_L1_Drivers/time.h"
#include "./ws2812.h"

#define WS2812_TIM2_PSC 0

/*=============================================================*
* 
* WS2812 Public API Definitions
*
*=============================================================*/

/* Definition of global WS2812 service variables (shared via extern in ws2812.h) */
uint8_t TIM2_ARR = 0;
uint8_t TIM2_COMPARE_BIT_0 = 0;
uint8_t TIM2_COMPARE_BIT_1 = 0;


/* Timing Parameters Calibration Function */
void ws2812_timing_calibrate(void) {
  uint8_t fmaster_freq_mhz = (clk_fmaster_freq_khz_get() >> 10) + 1;
  if(fmaster_freq_mhz == 16) {    
    TIM2_ARR = 19U;
    TIM2_COMPARE_BIT_0 = 6U;
    TIM2_COMPARE_BIT_1 = 12U;
  } else if(fmaster_freq_mhz == 8) {    
    TIM2_ARR = 9U;
    TIM2_COMPARE_BIT_0 = 3U;
    TIM2_COMPARE_BIT_1 = 6U;
  } else if(fmaster_freq_mhz == 4) {    
    TIM2_ARR = 4U;
    TIM2_COMPARE_BIT_0 = 1U;
    TIM2_COMPARE_BIT_1 = 3U;
  }    
}


void ws2812_init(WS2812_CHANNEL_PIN pin) {    
  gpio_out_push_pull_fast_mode(GPIO_D, pin);
  clk_peripheral_1_clock_enable(CLK_TIM2);  
  tim2_auto_reload_preload_enable();

  if(pin == WS2812_CH1_PD4) {    
    tim2_cc1_channel_mode_set(TIM2_CC1_OUTPUT);
    tim2_output_compare1_mode_set(TIM2_OC_PWM_MODE_1);
    tim2_cc1_preload_enable();
    tim2_cc1_enable();

  } else if(pin == WS2812_CH2_PD3) {    
    tim2_cc2_channel_mode_set(TIM2_CC2_OUTPUT);
    tim2_output_compare2_mode_set(TIM2_OC_PWM_MODE_1);
    tim2_cc2_preload_enable();
    tim2_cc2_enable();

  } else if(pin == WS2812_CH3_PD2) {    
    tim2_cc3_channel_mode_set(TIM2_CC3_OUTPUT);
    tim2_output_compare3_mode_set(TIM2_OC_PWM_MODE_1);
    tim2_cc3_preload_enable();
    tim2_cc3_enable();
  }

  ws2812_timing_calibrate();
}


void ws2812_write_frame_ch1(uint8_t *frame, uint8_t frame_len) {
  tim2_prescaler_set(WS2812_TIM2_PSC);
  tim2_auto_reload_write(TIM2_ARR);          
  tim2_cc1_write(((frame[0] >> 7) & 1) ? TIM2_COMPARE_BIT_1 : TIM2_COMPARE_BIT_0);                  
  tim2_update_event_generate();
  tim2_update_irq_flag_clear();
  tim2_cc1_irq_flag_clear();
  uint8_t first_entry = 1;
  
  for(uint8_t i = 0; i < frame_len; i++) {
    for(int j = 7; j >= 0; j--) {                  
      if(first_entry) {
        tim2_counter_enable();                    
        first_entry = 0;
        continue;        
      }

      
      while(!tim2_cc1_irq_flag_read());
      tim2_cc1_irq_flag_clear();
      tim2_cc1_write(((frame[i] >> j) & 1) ? TIM2_COMPARE_BIT_1 : TIM2_COMPARE_BIT_0);                              

      while(!tim2_update_irq_flag_read());  
      tim2_update_irq_flag_clear();
    }              
  }         

  while(!tim2_cc1_irq_flag_read());
  tim2_cc1_irq_flag_clear();
  tim2_counter_disable();
  time_delay_us(300);    
}


void ws2812_write_frame_ch2(uint8_t *frame, uint8_t frame_len) {
  tim2_prescaler_set(WS2812_TIM2_PSC);
  tim2_auto_reload_write(TIM2_ARR);          
  tim2_cc2_write(((frame[0] >> 7) & 1) ? TIM2_COMPARE_BIT_1 : TIM2_COMPARE_BIT_0);                  
  tim2_update_event_generate();
  tim2_update_irq_flag_clear();
  tim2_cc2_irq_flag_clear();
  uint8_t first_entry = 1;
  
  for(uint8_t i = 0; i < frame_len; i++) {
    for(int j = 7; j >= 0; j--) {                  
      if(first_entry) {
        tim2_counter_enable();                    
        first_entry = 0;
        continue;        
      }

      
      while(!tim2_cc2_irq_flag_read());
      tim2_cc2_irq_flag_clear();
      tim2_cc2_write(((frame[i] >> j) & 1) ? TIM2_COMPARE_BIT_1 : TIM2_COMPARE_BIT_0);                              

      while(!tim2_update_irq_flag_read());  
      tim2_update_irq_flag_clear();
    }              
  }         

  while(!tim2_cc2_irq_flag_read());
  tim2_cc2_irq_flag_clear();
  tim2_counter_disable();
  time_delay_us(300);    
}


void ws2812_write_frame_ch3(uint8_t *frame, uint8_t frame_len) {
  tim2_prescaler_set(WS2812_TIM2_PSC);
  tim2_auto_reload_write(TIM2_ARR);          
  tim2_cc3_write(((frame[0] >> 7) & 1) ? TIM2_COMPARE_BIT_1 : TIM2_COMPARE_BIT_0);                  
  tim2_update_event_generate();
  tim2_update_irq_flag_clear();
  tim2_cc3_irq_flag_clear();
  uint8_t first_entry = 1;
  
  for(uint8_t i = 0; i < frame_len; i++) {
    for(int j = 7; j >= 0; j--) {                  
      if(first_entry) {
        tim2_counter_enable();                    
        first_entry = 0;
        continue;        
      }

      
      while(!tim2_cc3_irq_flag_read());
      tim2_cc3_irq_flag_clear();
      tim2_cc3_write(((frame[i] >> j) & 1) ? TIM2_COMPARE_BIT_1 : TIM2_COMPARE_BIT_0);                              

      while(!tim2_update_irq_flag_read());  
      tim2_update_irq_flag_clear();
    }              
  }         

  while(!tim2_cc3_irq_flag_read());
  tim2_cc3_irq_flag_clear();
  tim2_counter_disable();
  time_delay_us(300);    
}