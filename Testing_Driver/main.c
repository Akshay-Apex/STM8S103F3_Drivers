#include <stdint.h>

#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/gpio.h"

#include "../STM8S103F3_L1_Drivers/time.h"

int main(void) {
  gpio_out_push_pull(GPIO_B, 5);
  
  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_LSI);
  time_init();

  while(1) {
    if(clk_master_get_source() == CLK_MASTER_SRC_LSI) {
      gpio_output_set(GPIO_B, 5);
      time_delay_lsi_sec(2);

      gpio_output_clear(GPIO_B, 5);
      time_delay_lsi_sec(2);
    } else {
      gpio_output_set(GPIO_B, 5);
      time_delay_lsi_sec(5);

      gpio_output_clear(GPIO_B, 5);
      time_delay_lsi_sec(5);
    }
  }
}