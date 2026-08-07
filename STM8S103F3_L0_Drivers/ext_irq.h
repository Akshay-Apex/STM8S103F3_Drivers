/**
 * @file ext_irq.h
 * @brief STM8S103F3 External Interrupt driver.
 *
 * @details Provides an API for configuring and controlling the STM8S103F3
 *          External Interrupt peripheral.
 */

#ifndef EXT_IRQ_H
#define EXT_IRQ_H

#include <stdint.h>

/* External Interrupt Register */
#define EXT_IRQ  (*(volatile uint8_t *)0x50A0)

typedef enum {
  EXT_IRQ_PORT_A = 0,
  EXT_IRQ_PORT_B = 2,
  EXT_IRQ_PORT_C = 4,
  EXT_IRQ_PORT_D = 6
} EXT_IRQ_PORT;

typedef enum {
  EXT_IRQ_FALLING_EDGE_AND_LOW_LEVEL  = 0,
  EXT_IRQ_RISING_EDGE_ONLY            = 1,
  EXT_IRQ_FALLING_EDGE_ONLY           = 2,
  EXT_IRQ_RISING_AND_FALLING_EDGE     = 3
} EXT_IRQ_PORT_SENSITIVITY;

#define EXT_IRQ_PORT_SENSITIVITY_MASK 0x03

inline void ext_irq_port_sensitivity_set(EXT_IRQ_PORT port, EXT_IRQ_PORT_SENSITIVITY sensitivity) {  
  // Forces CCR to Level 3 (Disable interrupts globally)
   __asm__("sim");

  EXT_IRQ = (EXT_IRQ & ~((uint8_t)EXT_IRQ_PORT_SENSITIVITY_MASK << port)) | ((uint8_t)sensitivity << port);
  
  // Restores CCR back to Level 0 (Re-enable interrupts globally)
  __asm__("rim"); 
}

#endif