#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/timer4.h"
#include "./time.h"

/*=============================================================*
 * 
 * Time Public API Definitions
 *
 *=============================================================*/

/* Definition of global time service variables (shared via extern in time.h) */
uint8_t TIM4_PSC_VAL_FOR_125KHZ = 0;


/* Timing Parameters Calibration Function */
/*@Important: Call this function at every Clock (clk) Frequency Change */
void time_timing_calibrate(void) {  
  uint8_t fmaster_freq_mhz = (clk_fmaster_freq_khz_get() / 1000U);    

  // Calculates the prescaler value for the timer 4 to run at 125KHz
  switch(fmaster_freq_mhz) {
    case 16:
      TIM4_PSC_VAL_FOR_125KHZ = 7;
      break;
    case 8:
      TIM4_PSC_VAL_FOR_125KHZ = 6;
      break;
    case 4:
      TIM4_PSC_VAL_FOR_125KHZ = 5;
      break;
    case 2:
      TIM4_PSC_VAL_FOR_125KHZ = 4;
      break;
    case 1:
      TIM4_PSC_VAL_FOR_125KHZ = 3;
      break;
    default:
      TIM4_PSC_VAL_FOR_125KHZ = 0;
      break;
  }    
}
  
  
/* Time Initialization Function */
void time_init(void) {  
  clk_peripheral_1_clock_enable(CLK_TIM4);  
  tim4_auto_reload_preload_enable();      
  time_timing_calibrate();
}


/* Low Precision Clock based delay functions */
/*@Important: Functions properly only when LSI Oscillator is the fmaster source */  
void time_delay_lsi_ms(uint16_t ms) {
  if(ms == 0) return;
    
  tim4_prescaler_set(0);
  tim4_auto_reload_set(127);

  tim4_update_event_generate();
  tim4_update_irq_flag_clear();

  tim4_counter_enable();

  while(ms--) {
    while(!tim4_update_irq_flag_read());
    tim4_update_irq_flag_clear();
  }

  tim4_counter_disable();
}


void time_delay_lsi_sec(uint16_t sec) {  
  while(sec--) {
    time_delay_lsi_ms(1000U);
  }  
}



/* High Precision Clock based delay functions */
void time_delay_ms(uint16_t ms) {
  if(ms == 0) return;

  tim4_prescaler_set(TIM4_PSC_VAL_FOR_125KHZ);
  tim4_auto_reload_set(124);

  tim4_update_event_generate();
  tim4_update_irq_flag_clear();

  tim4_counter_enable();

  while(ms--) {
    while(!tim4_update_irq_flag_read());
    tim4_update_irq_flag_clear();
  }

  tim4_counter_disable();
}


void time_delay_sec(uint16_t sec) {  
  while(sec--) {
    time_delay_ms(1000U);
  }  
}

