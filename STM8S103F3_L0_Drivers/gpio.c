#include <stdint.h>
#include "gpio.h"

// GPIO Pin Configuration
void gpio_multi_mode_config(GPIO_PORT_REG *port, GPIO_MULTI_MODE mode, uint8_t pin) {
  uint8_t pin_mask = (1U << pin);

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


/* GPIO Read Input */
uint8_t gpio_input_read(GPIO_PORT_REG *port, uint8_t pin) {
  return ((port->IDR >> pin) & 1);   
}

/* GPIO Read Output */
uint8_t gpio_output_read(GPIO_PORT_REG *port, uint8_t pin) {
  return ((port->ODR >> pin) & 1);
}

/* GPIO Write Output */
void gpio_output_set(GPIO_PORT_REG *port, uint8_t pin) {
  port->ODR |= (1U << pin);
}

void gpio_output_clear(GPIO_PORT_REG *port, uint8_t pin) {
  port->ODR &= ~(1U << pin);
}

/* GPIO Toggle Function */
void gpio_output_toggle(GPIO_PORT_REG *port, uint8_t pin) {
  port->ODR ^= (1U << pin);
}
