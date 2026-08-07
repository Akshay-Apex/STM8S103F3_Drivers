 /**
 * @file iwdg.h
 * @brief STM8S103F3 Independent Watchdog driver.
 *
 * @details Provides an API for configuring and controlling the STM8S103F3
 *          Independent Watchdog peripheral.
 */

#ifndef IWDG_H
#define IWDG_H

#include <stdint.h>

typedef struct {
  volatile uint8_t KR;   // IWDG key register
  volatile uint8_t PR;   // IWDG prescaler register
  volatile uint8_t RLR;  // IWDG reload register
} IWDG_REG;

#define IWDG ((IWDG_REG *)0x50E0)  // Base address binding of independent watchdog registers


/* IWDG key register (KR) */
typedef enum {
  IWDG_KEY_ENABLE = 0xCC,  // Enable the Independent watchdog
  IWDG_KEY_REFRESH = 0xAA, // Refresh the watchdog counter
  IWDG_KEY_ACCESS = 0x55,  // Unlocks the write access to IWDG_PR and IWDG_RLR registers
} IWDG_KEY_CODES;

inline void iwdg_key_write(IWDG_KEY_CODES key) {
  IWDG->KR = key;
}

inline void iwdg_feed(void) {
  iwdg_key_write(IWDG_KEY_REFRESH);
}



/* IWDG prescaler register (PR) */
typedef enum {
  IWDG_PSC_DIV_4   = 0x00,   
  IWDG_PSC_DIV_8   = 0x01,   
  IWDG_PSC_DIV_16  = 0x02,  
  IWDG_PSC_DIV_32  = 0x03,  
  IWDG_PSC_DIV_64  = 0x04,  
  IWDG_PSC_DIV_128 = 0x05, 
  IWDG_PSC_DIV_256 = 0x06, 
} IWDG_PSC_DIVIDER;

/*@Note: Refer the Reference Manual for Timeout Period Calculation */
inline void iwdg_prescaler_div_set(IWDG_PSC_DIVIDER divider) {
  iwdg_key_write(IWDG_KEY_ACCESS); 
  IWDG->PR = divider;
  iwdg_key_write(IWDG_KEY_REFRESH); 
}



/* IWDG reload register (RLR) */
inline void iwdg_reload_write(uint8_t reload_value) {
  iwdg_key_write(IWDG_KEY_ACCESS);
  IWDG->RLR = reload_value;
  iwdg_key_write(IWDG_KEY_REFRESH);
}



/* IWDG Initialization */
inline void iwdg_init(IWDG_PSC_DIVIDER prescaler, uint8_t reload_value) {
  iwdg_key_write(IWDG_KEY_ENABLE); 
  iwdg_key_write(IWDG_KEY_ACCESS); 
  
  IWDG->PR = prescaler;
  IWDG->RLR = reload_value;
  
  iwdg_key_write(IWDG_KEY_REFRESH);
}

#endif