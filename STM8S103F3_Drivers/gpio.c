#include <stdint.h>
#include "gpio.h"

// GPIO Pin Configuration
void gpio_multi_mode_config(GPIO_PORT_REG *port, GPIO_MULTI_MODE mode, uint8_t pin) {
  uint8_t pin_mask = (1 << pin);

  if(DDR_SET_HIGH(mode)) {
    port->DDR |= pin_mask;    
  } else {
    port->DDR &= ~(pin_mask);  
  }

  if(CR1_SET_HIGH(mode)) {
    port->CR1 |= pin_mask;    
  } else {
    port->CR1 &= ~(pin_mask);  
  }

  if(CR2_SET_HIGH(mode)) {    
    port->CR2 |= pin_mask;    
  } else {    
    port->CR2 &= ~(pin_mask);
  }
}