/**
 * @file timer4.h
 * @brief STM8S103F3 Timer 4 driver.
 *
 * @details Provides an API for configuring and controlling the STM8S103F3
 *          Timer 4 peripheral.
 */

#ifndef TIMER4_H
#define TIMER4_H

#include <stdint.h>

/* TIM4 Register Definitions */
typedef struct {
  volatile uint8_t CR1;         // TIM4 control register 1
  volatile uint8_t Reserved_0;  
  volatile uint8_t Reserved_1;
  volatile uint8_t IER;         // TIM4 interrupt enable register
  volatile uint8_t SR;          // TIM4 status register
  volatile uint8_t EGR;         // TIM4 event generation register
  volatile uint8_t CNTR;        // TIM4 counter
  volatile uint8_t PSCR;        // TIM4 prescaler register
  volatile uint8_t ARR;         // TIM4 auto-reload register
} TIM4_REG;

#define TIM4 ((TIM4_REG *)0x5340) // Base address binding of TIM4 registers


/*=============================================================*
 * 
 * TIM4 - 8-bit Basic Timer
 *
 *=============================================================*/

/* TIM4 control register 1 (CR1) */
inline void tim4_counter_enable(void) {
  TIM4->CR1 |= (1U << 0);
}

inline void tim4_counter_disable(void) {
  TIM4->CR1 &= ~(1U << 0);
} 


inline void tim4_auto_update_event_enable(void) {
  TIM4->CR1 &= ~(1U << 1);
}

inline void tim4_auto_update_event_disable(void) {
  TIM4->CR1 |= (1U << 1);
}


inline void tim4_update_req_src_any_event_set(void) {
  TIM4->CR1 &= ~(1U << 2);
}

inline void tim4_update_req_src_overflow_underflow_only_set(void) {
  TIM4->CR1 |= (1U << 2);
}


inline void tim4_one_pulse_mode_enable(void) {
  TIM4->CR1 |= (1U << 3);
}

inline void tim4_one_pulse_mode_disable(void) {
  TIM4->CR1 &= ~(1U << 3);
}


inline void tim4_auto_reload_preload_enable(void) {
  TIM4->CR1 |= (1U << 7);
}

inline void tim4_auto_reload_preload_disable(void) {
  TIM4->CR1 &= ~(1U << 7);
}



/* TIM4 interrupt enable register (IER) */
inline void tim4_update_irq_enable(void) {
  TIM4->IER |= (1U << 0);
}

inline void tim4_update_irq_disable(void) {
  TIM4->IER &= ~(1U << 0);
}



/* TIM4 status register (SR) */
inline void tim4_update_irq_flag_clear(void) {
  TIM4->SR &= ~(1U << 0);
}

inline uint8_t tim4_update_irq_flag_read(void) {
  return ((TIM4->SR >> 0) & 1);
}



/* TIM4 event generation register (EGR) */
inline void tim4_update_event_generate(void) {
  TIM4->EGR |= (1U << 0);
}



/* TIM4 counter (CNTR) */
inline void tim4_counter_write(uint8_t value) {
  TIM4->CNTR = value;    
}

inline uint8_t tim4_counter_read(void) {
  return TIM4->CNTR;
}



/* TIM4 prescaler register (PSCR) */
typedef enum {
  TIM4_PRESCALER_1   = 0x00, // No prescaling
  TIM4_PRESCALER_2   = 0x01, // Clock divided by 2
  TIM4_PRESCALER_4   = 0x02, // Clock divided by 4
  TIM4_PRESCALER_8   = 0x03, // Clock divided by 8
  TIM4_PRESCALER_16  = 0x04, // Clock divided by 16
  TIM4_PRESCALER_32  = 0x05, // Clock divided by 32
  TIM4_PRESCALER_64  = 0x06, // Clock divided by 64
  TIM4_PRESCALER_128 = 0x07  // Clock divided by 128
} TIM4_PRESCALER_MODES;

inline void tim4_prescaler_set(TIM4_PRESCALER_MODES value) {
  TIM4->PSCR = value;
}

inline uint8_t tim4_prescaler_read(void) {
  return TIM4->PSCR;
}



/* TIM4 auto-reload register (ARR) */
inline void tim4_auto_reload_set(uint8_t value) {
  TIM4->ARR = value;
}

inline uint8_t tim4_auto_reload_read(void) {
  return TIM4->ARR;
}

#endif