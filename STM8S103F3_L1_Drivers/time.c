#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/timer.h"
#include "./time.h"

/*=============================================================*
 * 
 * Time Public API Definitions
 *
 *=============================================================*/

/* Definition of global time service variables (shared via extern in time.h) */
uint8_t TIM4_PSC_VAL_FOR_1MHZ = 0;

/*@Important: Call this function at every Clock (clk) Frequency Change */
void time_init(void) {
  /* Initialize the Peripheral clock gating enable */
  clk_peripheral_1_clock_enable(CLK_TIM4);
  clk_peripheral_1_clock_enable(CLK_TIM2);
  clk_peripheral_1_clock_enable(CLK_TIM1);

  /* Initialize the TIM4 Prescaler to run the Counter at 1MHz (TIM4_PSC_VAL_FOR_1MHZ) */
  uint8_t fmaster_freq_mhz = (clk_fmaster_freq_khz_get() >> 10) + 1;
  TIM4_PSC_VAL_FOR_1MHZ = 0;
  while(fmaster_freq_mhz > 1) {
    fmaster_freq_mhz >>= 1;
    TIM4_PSC_VAL_FOR_1MHZ++;
  }    
}


void time_deinit(void) {
  /* Initialize the Peripheral clock gating enable */
  clk_peripheral_1_clock_disable(CLK_TIM4);
  clk_peripheral_1_clock_disable(CLK_TIM2);
  clk_peripheral_1_clock_disable(CLK_TIM1);

  TIM4_PSC_VAL_FOR_1MHZ = 0;
}


/* Low Precision Clock based delay functions */
/*@Important: Functions properly only when LSI Oscillator is the fmaster source */
void time_delay_lsi_ms(uint16_t ms) {
  tim4_prescaler_set(TIM4_PRESCALER_1);
  tim4_counter_enable();
  while(ms--) {    
    tim4_auto_reload_set(127U);
    // Resets the counter on every update generated
    tim4_update_event_generate();
    tim4_update_irq_flag_clear();
    while(!tim4_update_irq_flag_read());    
  }
  tim4_counter_disable();
  tim4_update_irq_flag_clear();
}


void time_delay_lsi_sec(uint16_t sec) {
  while(sec--) {
    time_delay_lsi_ms(1000U);
  }
}



/* High Precision Clock based delay functions */
/*@Important: Functions properly only when HSE or HSI Oscillator is the fmaster source */
void time_delay_us(uint16_t us) {
  tim4_prescaler_set(TIM4_PSC_VAL_FOR_1MHZ);
  tim4_counter_enable();
  while(us > 0) {
    uint16_t chunk = (us >= 256U) ? 256U : us;
    tim4_auto_reload_set((chunk - 1));
    // Resets the counter on every update generated
    tim4_update_event_generate();
    tim4_update_irq_flag_clear();
    while(!tim4_update_irq_flag_read());
    us -= chunk;
  }
  tim4_counter_disable();
  tim4_update_irq_flag_clear();
}


void time_delay_ms(uint16_t ms) {
  while(ms--) {
    time_delay_us(1000U);
  }
}


void time_delay_sec(uint16_t sec) {
  while(sec--) {
    time_delay_ms(1000U);
  }
}