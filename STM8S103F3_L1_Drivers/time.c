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







  /* Initialize the TIM4 Prescaler to run the Counter at 1MHz */
  uint8_t fmaster_freq_mhz = (clk_fmaster_freq_khz_get() >> 10) + 1;
  TIM4_PSC_VAL_FOR_1MHZ = 0;
  while(fmaster_freq_mhz > 1) {
    fmaster_freq_mhz >>= 1;
    TIM4_PSC_VAL_FOR_1MHZ++;
  }    
}


/* GIve support for the lsi osc ms delay */

// is the update event necessary (look into it )




/*@Important: Functions properly only when HSE or HSI Oscillator is the fmaster source */
void time_delay_us(uint16_t us) {
  tim4_prescaler_set(TIM4_PSC_VAL_FOR_1MHZ);
  while(us > 0) {
    uint16_t chunk = (us >= 256U) ? 256U : us;
    tim4_auto_reload_set((chunk - 1));
    tim4_update_event_generate();
    tim4_update_irq_flag_clear();
    tim4_counter_enable();
    while(!tim4_update_irq_flag_read());
    tim4_counter_disable();
    us -= chunk;
  }
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