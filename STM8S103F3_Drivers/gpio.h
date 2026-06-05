#ifndef GPIO_H
#define GPIO_H

#include <stdint.h>

/* Register Definitions */
typedef struct {
  volatile uint8_t ODR; // Data output latch register
  volatile uint8_t IDR; // Input pin value register
  volatile uint8_t DDR; // Data direction register
  volatile uint8_t CR1; // Control register 1
  volatile uint8_t CR2; // Control register 2
} GPIO_PORT_REG;

#define GPIO_A  ((GPIO_PORT_REG *)0x5000) // Base Address Binding Port A
#define GPIO_B  ((GPIO_PORT_REG *)0x5005) // Base Address Binding Port B
#define GPIO_C  ((GPIO_PORT_REG *)0x500A) // Base Address Binding Port C
#define GPIO_D  ((GPIO_PORT_REG *)0x500F) // Base Address Binding Port D


/* GPIO Pin Modes */
typedef enum {
  // Input selection modes
  GPIO_IN_FLOAT_NO_IRQ          = 0,
  GPIO_IN_FLOAT_WITH_IRQ        = 1,
  GPIO_IN_PULL_UP_NO_IRQ        = 2,
  GPIO_IN_PULL_UP_WITH_IRQ      = 3,
  // Output selection modes
  GPIO_OUT_OPEN_DRAIN           = 4,
  GPIO_OUT_OPEN_DRAIN_FAST_MODE = 5,
  GPIO_OUT_PUSH_PULL            = 6,
  GPIO_OUT_PUSH_PULL_FAST_MODE  = 7
} GPIO_MULTI_MODE;

#define DDR_SET_HIGH(MODE) (((MODE) >> 2) & 1)
#define CR1_SET_HIGH(MODE) (((MODE) >> 1) & 1)
#define CR2_SET_HIGH(MODE) (((MODE) >> 0) & 1)


/* GPIO Pin Generic Multi Mode Configuration Function */
void gpio_multi_mode_config(GPIO_PORT_REG *port, GPIO_MULTI_MODE mode, uint8_t pin);

static inline void gpio_fast_multi_mode_config(GPIO_PORT_REG *port, GPIO_MULTI_MODE mode, uint8_t pin) {
  uint8_t pin_mask = (1U << pin);
  port->DDR = (DDR_SET_HIGH(mode)) ? (port->DDR | pin_mask) : (port->DDR & ~(pin_mask));
  port->CR1 = (CR1_SET_HIGH(mode)) ? (port->CR1 | pin_mask) : (port->CR1 & ~(pin_mask));
  port->CR2 = (CR2_SET_HIGH(mode)) ? (port->CR2 | pin_mask) : (port->CR2 & ~(pin_mask));
}


/* Fast GPIO Pin Multi Mode Configuration Functions */
/* GPIO Input Modes */
static inline void gpio_in_float_no_irq(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR &= ~(1U << pin);
  port->CR1 &= ~(1U << pin);
  port->CR2 &= ~(1U << pin);
}

static inline void gpio_in_pull_up_no_irq(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR &= ~(1U << pin);
  port->CR1 |= (1U << pin);
  port->CR2 &= ~(1U << pin);
}

static inline void gpio_in_float_with_irq(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR &= ~(1U << pin);
  port->CR1 &= ~(1U << pin);
  port->CR2 |= (1U << pin);
}
 
static inline void gpio_in_pull_up_with_irq(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR &= ~(1U << pin);
  port->CR1 |= (1U << pin); 
  port->CR2 |= (1U << pin);
}


/* GPIO Output Modes */
static inline void gpio_out_open_drain(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR |= (1U << pin);
  port->CR1 &= ~(1U << pin);
  port->CR2 &= ~(1U << pin);
}

static inline void gpio_out_push_pull(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR |= (1U << pin);
  port->CR1 |= (1U << pin);
  port->CR2 &= ~(1U << pin);
}

static inline void gpio_out_open_drain_fast_mode(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR |= (1U << pin);
  port->CR1 &= ~(1U << pin);
  port->CR2 |= (1U << pin);
}

static inline void gpio_out_push_pull_fast_mode(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR |= (1U << pin);
  port->CR1 |= (1U << pin);
  port->CR2 |= (1U << pin);
}


/* Fast GPIO Pin Advanced Single Mode Configuration Functions */
/* GPIO I/O Mode Selection */
static inline void gpio_mode_output_init(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR |= (1U << pin);
}

static inline void gpio_mode_input_init(GPIO_PORT_REG *port, uint8_t pin) {
  port->DDR &= ~(1U << pin);
}


/* GPIO Input Modes */
static inline void gpio_in_pull_up_enable(GPIO_PORT_REG *port, uint8_t pin) {
  port->CR1 |= (1U << pin);
}

static inline void gpio_in_pull_up_disable(GPIO_PORT_REG *port, uint8_t pin) {
  port->CR1 &= ~(1U << pin);
}

static inline void gpio_in_irq_enable(GPIO_PORT_REG *port, uint8_t pin) {
  port->CR2 |= (1U << pin);
}

static inline void gpio_in_irq_disable(GPIO_PORT_REG *port, uint8_t pin) {
  port->CR2 &= ~(1U << pin);
}


/* GPIO Output Modes */
static inline void gpio_out_push_pull_enable(GPIO_PORT_REG *port, uint8_t pin) {
  port->CR1 |= (1U << pin);
}

static inline void gpio_out_open_drain_enable(GPIO_PORT_REG *port, uint8_t pin) {
  port->CR1 &= ~(1U << pin);
}

static inline void gpio_out_fast_mode_enable(GPIO_PORT_REG *port, uint8_t pin) {
  port->CR2 |= (1U << pin);
}

static inline void gpio_out_fast_mode_disable(GPIO_PORT_REG *port, uint8_t pin) {
  port->CR2 &= ~(1U << pin);
}


/* GPIO Input Read Functions */
uint8_t gpio_input_read(GPIO_PORT_REG *port, uint8_t pin);

static inline uint8_t gpio_fast_input_read(GPIO_PORT_REG *port, uint8_t pin) {
   return ((port->IDR >> pin) & 1);   
}



/* GPIO Output Functions */
/* GPIO Write Output */
void gpio_output_set(GPIO_PORT_REG *port, uint8_t pin);

static inline void gpio_fast_output_set(GPIO_PORT_REG *port, uint8_t pin) {
  port->ODR |= (1U << pin);
}

void gpio_output_clear(GPIO_PORT_REG *port, uint8_t pin);

static inline void gpio_fast_output_clear(GPIO_PORT_REG *port, uint8_t pin) {
  port->ODR &= ~(1U << pin);
}


/* GPIO Read Output */
uint8_t gpio_output_read(GPIO_PORT_REG *port, uint8_t pin);

static inline uint8_t gpio_fast_output_read(GPIO_PORT_REG *port, uint8_t pin) {
  return ((port->ODR >> pin) & 1);
}


/* GPIO Toggle Function */
void gpio_output_toggle(GPIO_PORT_REG *port, uint8_t pin);

static inline void gpio_fast_output_toggle(GPIO_PORT_REG *port, uint8_t pin) {
  port->ODR ^= (1U << pin);
}

#endif