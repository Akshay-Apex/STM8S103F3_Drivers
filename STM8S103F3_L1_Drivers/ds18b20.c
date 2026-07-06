#include "../STM8S103F3_L0_Drivers/clk.h"

#include "../STM8S103F3_L1_Drivers/time.h"
#include "./ds18b20.h"

void ds18b20_init(GPIO_PORT_REG *port, uint8_t pin) {
  gpio_out_open_drain(port, pin);

}

