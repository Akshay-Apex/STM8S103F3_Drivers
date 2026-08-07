 /**
 * @file wwdg.h
 * @brief STM8S103F3 Window Watchdog driver.
 *
 * @details Provides an API for configuring and controlling the STM8S103F3
 *          Window Watchdog peripheral.
 */

#ifndef WWDG_H
#define WWDG_H

#include <stdint.h>

/* Window Watchdog Register Definitions */
typedef struct {
  volatile uint8_t CR; // WWDG control register
  volatile uint8_t WR; // WWDR window register
} WWDG_REG;

#define WWDG ((WWDG_REG *)0x50D1) // Base address binding of window watchdog registers


/* WWDG control register (CR) */
#define WWDG_ACTIVATE_MASK 0x80
#define WWDG_MAX_VALUE_MASK 0x7F
#define WWDG_MIN_VALUE_MASK 0x40

/*@Note: Instructions for using the WWDG counter register:
 * - The WWDG counter register is a 7-bit down-counter that decrements every ~12288 fCPU cycles
 * - Any value written above the (Upper Threshold) Window register value will cause an instant reset 
 * - Any value written below the min value will cause an instant reset
 * - Any value written between [Upper Threshold (WWDG_WR), 0x40 (WWDG_CR)] will not cause a window reset to occur 
 *   and will successfully write the value to the counter register
 * - Any value above the max value will be truncated to the max value      
 */
inline void wwdg_activate_and_counter_write(uint8_t value) {
  WWDG->CR = (WWDG_ACTIVATE_MASK) | (value & WWDG_MAX_VALUE_MASK);
}

inline void wwdg_feed(uint8_t counter_value) {
  wwdg_activate_and_counter_write(counter_value);
}


/* WWDR window register (WR) */
inline void wwdg_window_upper_threshold_write(uint8_t value) {
  WWDG->WR = value & WWDG_MAX_VALUE_MASK;
}



/* Initialization */
inline void wwdg_init(uint8_t counter_value, uint8_t window_value) {
  wwdg_window_upper_threshold_write(window_value);
  wwdg_activate_and_counter_write(counter_value);
}

#endif 