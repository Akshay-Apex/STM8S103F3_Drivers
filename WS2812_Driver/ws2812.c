#include <stdint.h>

#include "../STM8S103F3_Drivers/clk.h"
//#include "../STM8S103F3_Drivers/gpio.h"
//#include "../STM8S103F3_Drivers/timer.h"

int main(void) {
  clk_lsi_osc_enable();

  return 0;
}