 /**
 * @file rst.h
 * @brief STM8S103F3 Reset driver.
 *
 * @details Provides an API for configuring and controlling the STM8S103F3
 *          Reset peripheral.
 */

#ifndef RST_H
#define RST_H

#include <stdint.h>

/* Reset Status Register */
#define RST_SR (*(volatile uint8_t *)0x50B3) 

/* Reset Flags */
typedef enum {
  RST_WWDG_FLAG  = (1U << 0),
  RST_IWDG_FLAG  = (1U << 1),
  RST_ILLOP_FLAG = (1U << 2),
  RST_SWIM_FLAG  = (1U << 3),
  RST_EMC_FLAG   = (1U << 4)
} RST_FLAGS;


/* Clears the specified reset flags */
/* @Note: Combine multiple flags with the bitwise OR (|) operator */
inline void rst_flags_clear(RST_FLAGS flag_mask) {
  RST_SR = flag_mask;
}

/* Reads the reset status register */
inline uint8_t rst_flags_read(void) {
  return RST_SR;
}

#endif