#include "../STM8S103F3_L0_Drivers/gpio.h"
#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/timer.h"
#include "../STM8S103F3_L1_Drivers/time.h"
#include "./ws2812.h"


/*=============================================================*
* 
* WS2812 Public API Definitions
*
*=============================================================*/
/* Interrupt Enable and Disable */
#define global_interrupt_enable()  __asm__("rim") 
#define global_interrupt_disable() __asm__("sim")


/* WS2812 Prescaler Value */
#define WS2812_TIM2_PSC 0
#define WS2812_TIM2_ARR 19U
#define WS2812_TIM2_COMPARE_BIT_0 7U
#define WS2812_TIM2_COMPARE_BIT_1 15U


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

  time_init();
}


void ws2812_write_frame_ch1(uint8_t *frame, uint8_t frame_len) {  
  global_interrupt_disable();

  CLK_MASTER_SRC current_clock_src = clk_master_get_source();
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);

  tim2_prescaler_set(WS2812_TIM2_PSC);
  tim2_auto_reload_write(WS2812_TIM2_ARR);            
  uint8_t cc1_value = (frame[0] & 0x80) ? WS2812_TIM2_COMPARE_BIT_1 : WS2812_TIM2_COMPARE_BIT_0;
  tim2_cc1_write(cc1_value);
  tim2_update_event_generate();        
  tim2_cc1_irq_flag_clear();
  tim2_counter_enable();                    

  for(uint8_t i = 0; i < frame_len; i++) {                      
    uint8_t frame_byte = frame[i];
    for(uint8_t mask = (i == 0) ? 0x40 : 0x80; mask > 0; mask >>= 1) {
      cc1_value = (frame_byte & mask) ? WS2812_TIM2_COMPARE_BIT_1 : WS2812_TIM2_COMPARE_BIT_0;
      while(!tim2_cc1_irq_flag_read());
      tim2_cc1_irq_flag_clear();
      tim2_cc1_write(cc1_value);                              
    }              
  }         

  while(!tim2_cc1_irq_flag_read());
  tim2_counter_disable();
  tim2_cc1_irq_flag_clear();
  tim2_update_irq_flag_clear();
  
  time_delay_us_16mhz(300U);    
  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();
}


void ws2812_write_frame_ch2(uint8_t *frame, uint8_t frame_len) {
  global_interrupt_disable();

  CLK_MASTER_SRC current_clock_src = clk_master_get_source();
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);

  tim2_prescaler_set(WS2812_TIM2_PSC);
  tim2_auto_reload_write(WS2812_TIM2_ARR);            
  uint8_t cc2_value = (frame[0] & 0x80) ? WS2812_TIM2_COMPARE_BIT_1 : WS2812_TIM2_COMPARE_BIT_0;
  tim2_cc2_write(cc2_value);
  tim2_update_event_generate();        
  tim2_cc2_irq_flag_clear();
  tim2_counter_enable();                    

  for(uint8_t i = 0; i < frame_len; i++) {                      
    uint8_t frame_byte = frame[i];
    for(uint8_t mask = (i == 0) ? 0x40 : 0x80; mask > 0; mask >>= 1) {
      cc2_value = (frame_byte & mask) ? WS2812_TIM2_COMPARE_BIT_1 : WS2812_TIM2_COMPARE_BIT_0;
      while(!tim2_cc2_irq_flag_read());
      tim2_cc2_irq_flag_clear();
      tim2_cc2_write(cc2_value);                              
    }              
  }         

  while(!tim2_cc2_irq_flag_read());
  tim2_counter_disable();
  tim2_cc2_irq_flag_clear();
  tim2_update_irq_flag_clear();
  
  time_delay_us_16mhz(300U);    
  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();
}


void ws2812_write_frame_ch3(uint8_t *frame, uint8_t frame_len) {
  global_interrupt_disable();

  CLK_MASTER_SRC current_clock_src = clk_master_get_source();
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);

  tim2_prescaler_set(WS2812_TIM2_PSC);
  tim2_auto_reload_write(WS2812_TIM2_ARR);            
  uint8_t cc3_value = (frame[0] & 0x80) ? WS2812_TIM2_COMPARE_BIT_1 : WS2812_TIM2_COMPARE_BIT_0;
  tim2_cc3_write(cc3_value);
  tim2_update_event_generate();        
  tim2_cc3_irq_flag_clear();
  tim2_counter_enable();                    

  for(uint8_t i = 0; i < frame_len; i++) {                      
    uint8_t frame_byte = frame[i];
    for(uint8_t mask = (i == 0) ? 0x40 : 0x80; mask > 0; mask >>= 1) {
      cc3_value = (frame_byte & mask) ? WS2812_TIM2_COMPARE_BIT_1 : WS2812_TIM2_COMPARE_BIT_0;
      while(!tim2_cc3_irq_flag_read());
      tim2_cc3_irq_flag_clear();
      tim2_cc3_write(cc3_value);                              
    }              
  }         

  while(!tim2_cc3_irq_flag_read());
  tim2_counter_disable();
  tim2_cc3_irq_flag_clear();
  tim2_update_irq_flag_clear();

  time_delay_us_16mhz(300U);    
  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();
}