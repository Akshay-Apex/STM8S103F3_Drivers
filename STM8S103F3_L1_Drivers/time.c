#include "./time.h"
#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/timer.h"

/*@Important: Works only when the HSI Oscillator is fmaster Source */
void time_delay_us(uint16_t us) {
  uint32_t fmaster_freq = clk_fmaster_freq_get();
  
  if(fmaster_freq == 0 || us == 0) {
    return;
  }

  uint8_t divisor = fmaster_freq / 1000000UL;
  uint8_t prescaler = 0;
  
  while(divisor > 1) {
    divisor >>= 1;
    prescaler++;
  }

  tim4_prescaler_set(prescaler);

  while(us > 0) {
    uint16_t chunk = (us >= 256) ? 256 : us;
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
    time_delay_us(1000);
  }
}


void time_delay_sec(uint16_t sec) {
  while(sec--) {
    time_delay_ms(1000);
  }
}