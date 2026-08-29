/**
 * @file timer2.h
 * @brief STM8S103F3 Timer 2 driver.
 *
 * @details Provides an API for configuring and controlling the STM8S103F3
 *          Timer 2 peripheral.
 */

#ifndef TIMER2_H
#define TIMER2_H

#include <stdint.h>

/* TIM2 Register Definitions */
typedef struct {
  volatile uint8_t CR1;   // TIM2 control register 1
  volatile uint8_t Reserved_0; 
  volatile uint8_t Reserved_1; 

  volatile uint8_t IER;   // TIM2 Interrupt enable register
  volatile uint8_t SR1;   // TIM2 status register 1
  volatile uint8_t SR2;   // TIM2 status register 2
  volatile uint8_t EGR;   // TIM2 event generation register

  volatile uint8_t CCMR1; // TIM2 capture/compare mode register 1
  volatile uint8_t CCMR2; // TIM2 capture/compare mode register 2
  volatile uint8_t CCMR3; // TIM2 capture/compare mode register 3

  volatile uint8_t CCER1; // TIM2 capture/compare enable register 1
  volatile uint8_t CCER2; // TIM2 capture/compare enable register 2
  volatile uint8_t CNTRH; // TIM2 counter high
  volatile uint8_t CNTRL; // TIM2 counter low
  volatile uint8_t PSCR;  // TIM2 prescaler register
  volatile uint8_t ARRH;  // TIM2 auto-reload register high
  volatile uint8_t ARRL;  // TIM2 auto-reload register low

  volatile uint8_t CCR1H; // TIM2 capture/compare register 1 high
  volatile uint8_t CCR1L; // TIM2 capture/compare register 1 low
  volatile uint8_t CCR2H; // TIM2 capture/compare register 2 high
  volatile uint8_t CCR2L; // TIM2 capture/compare register 2 low
  volatile uint8_t CCR3H; // TIM2 capture/compare register 3 high
  volatile uint8_t CCR3L; // TIM2 capture/compare register 3 low
} TIM2_REG;

#define TIM2 ((TIM2_REG *)0x5300) // Base address binding of TIM2 registers


/*=============================================================*
 *
 * TIM2 - 16-bit General Purpose Timer
 *
 *=============================================================*/

/* TIM2 control register 1 (CR1) */
inline void tim2_counter_enable(void) {
  TIM2->CR1 |= (1U << 0);
}

inline void tim2_counter_disable(void) {
  TIM2->CR1 &= ~(1U << 0);
}


inline void tim2_auto_update_event_enable(void) {
  TIM2->CR1 &= ~(1U << 1);
}

inline void tim2_auto_update_event_disable(void) {
  TIM2->CR1 |= (1U << 1);
}


inline void tim2_update_req_src_any_event_set(void) {
  TIM2->CR1 &= ~(1U << 2);
}

inline void tim2_update_req_src_overflow_underflow_only_set(void) {
  TIM2->CR1 |= (1U << 2);
}


inline void tim2_one_pulse_mode_enable(void) {
  TIM2->CR1 |= (1U << 3);
}

inline void tim2_one_pulse_mode_disable(void) {
  TIM2->CR1 &= ~(1U << 3);
}


inline void tim2_auto_reload_preload_enable(void) {
  TIM2->CR1 |= (1U << 7);
}

inline void tim2_auto_reload_preload_disable(void) {
  TIM2->CR1 &= ~(1U << 7);
}



/* TIM2 interrupt enable register (IER) */
inline void tim2_update_irq_enable(void) {
  TIM2->IER |= (1U << 0);
}

inline void tim2_update_irq_disable(void) {
  TIM2->IER &= ~(1U << 0);
}


inline void tim2_cc1_irq_enable(void) {
  TIM2->IER |= (1U << 1);
}

inline void tim2_cc1_irq_disable(void) {
  TIM2->IER &= ~(1U << 1);
}


inline void tim2_cc2_irq_enable(void) {
  TIM2->IER |= (1U << 2);
}

inline void tim2_cc2_irq_disable(void) {
  TIM2->IER &= ~(1U << 2);
}


inline void tim2_cc3_irq_enable(void) {
  TIM2->IER |= (1U << 3);
}

inline void tim2_cc3_irq_disable(void) {
  TIM2->IER &= ~(1U << 3);
}



/* TIM2 status register 1 (SR1) */
inline void tim2_update_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 0);
}

inline uint8_t tim2_update_irq_flag_read(void) {
  return ((TIM2->SR1 >> 0) & 1);
}


inline void tim2_cc1_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 1);
}

inline uint8_t tim2_cc1_irq_flag_read(void) {
  return ((TIM2->SR1 >> 1) & 1);
}


inline void tim2_cc2_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 2);
}

inline uint8_t tim2_cc2_irq_flag_read(void) {
  return ((TIM2->SR1 >> 2) & 1);
}


inline void tim2_cc3_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 3);
}

inline uint8_t tim2_cc3_irq_flag_read(void) {
  return ((TIM2->SR1 >> 3) & 1);
}



/* TIM2 status register 2 (SR2) */
inline void tim2_cc1_overcapture_flag_clear(void) {
  TIM2->SR2 &= ~(1U << 1);
}

inline uint8_t tim2_cc1_overcapture_flag_read(void) {
  return ((TIM2->SR2 >> 1) & 1);
}


inline void tim2_cc2_overcapture_flag_clear(void) {
  TIM2->SR2 &= ~(1U << 2);
}

inline uint8_t tim2_cc2_overcapture_flag_read(void) {
  return ((TIM2->SR2 >> 2) & 1);
}


inline void tim2_cc3_overcapture_flag_clear(void) {
  TIM2->SR2 &= ~(1U << 3);
}

inline uint8_t tim2_cc3_overcapture_flag_read(void) {
  return ((TIM2->SR2 >> 3) & 1);
}



/* TIM2 event generation register (EGR) */
inline void tim2_update_event_generate(void) {
  TIM2->EGR |= (1U << 0);
}

inline void tim2_cc1_event_generate(void) {
  TIM2->EGR |= (1U << 1);
}

inline void tim2_cc2_event_generate(void) {
  TIM2->EGR |= (1U << 2);
}

inline void tim2_cc3_event_generate(void) {
  TIM2->EGR |= (1U << 3);
}



/* TIM2 Capture/Compare mode register 1 (CCMR1) */
/* Generic Functions */
typedef enum {
  TIM2_CC1_OUTPUT    = 0x00,
  TIM2_CC1_INPUT_TI1 = 0x01,
  TIM2_CC1_INPUT_TI2 = 0x02  
} TIM2_CC1_CHANNEL_MODE;

#define TIM2_CC1_CHANNEL_MODE_CLR_MASK 0xFC

inline void tim2_cc1_channel_mode_set(TIM2_CC1_CHANNEL_MODE mode) {
  TIM2->CCMR1 = (TIM2->CCMR1 & TIM2_CC1_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM2_CC1_CHANNEL_MODE tim2_cc1_channel_mode_read(void) {
  return (TIM2_CC1_CHANNEL_MODE)(TIM2->CCMR1 & ~TIM2_CC1_CHANNEL_MODE_CLR_MASK);
}

/* Output mode functions */
inline void tim2_cc1_preload_enable(void) {
  TIM2->CCMR1 |= (1U << 3);
}

inline void tim2_cc1_preload_disable(void) {
  TIM2->CCMR1 &= ~(1U << 3);
}


typedef enum {
    TIM2_OC_FROZEN            = 0x00,
    TIM2_OC_ACTIVE_ON_MATCH   = 0x01,
    TIM2_OC_INACTIVE_ON_MATCH = 0x02,
    TIM2_OC_TOGGLE            = 0x03,
    TIM2_OC_FORCE_INACTIVE    = 0x04,
    TIM2_OC_FORCE_ACTIVE      = 0x05,
    TIM2_OC_PWM_MODE_1        = 0x06,
    TIM2_OC_PWM_MODE_2        = 0x07
} TIM2_OUTPUT_COMPARE_MODE;

#define TIM2_OUTPUT_COMPARE1_MODE_CLR_MASK 0x8F

inline void tim2_output_compare1_mode_set(TIM2_OUTPUT_COMPARE_MODE mode) {
  TIM2->CCMR1 = (TIM2->CCMR1 & TIM2_OUTPUT_COMPARE1_MODE_CLR_MASK) | ((uint8_t)mode << 4);
}

inline TIM2_OUTPUT_COMPARE_MODE tim2_output_compare1_mode_read(void) {
  return (TIM2_OUTPUT_COMPARE_MODE)((TIM2->CCMR1 >> 4) & 0x07);
}

/* Input mode functions */
typedef enum {
    TIM2_IC_PRESCALER_1 = 0x00,  // Capture every event
    TIM2_IC_PRESCALER_2 = 0x01,  // Capture every 2 events
    TIM2_IC_PRESCALER_4 = 0x02,  // Capture every 4 events
    TIM2_IC_PRESCALER_8 = 0x03   // Capture every 8 events
} TIM2_INPUT_CAPTURE_PRESCALER;

#define TIM2_INPUT_CAPTURE1_PRESCALER_CLR_MASK 0xF3
  
inline void tim2_input_capture1_prescaler_set(TIM2_INPUT_CAPTURE_PRESCALER psc) {
  TIM2->CCMR1 = (TIM2->CCMR1 & TIM2_INPUT_CAPTURE1_PRESCALER_CLR_MASK) | ((uint8_t)psc << 2);
}

inline TIM2_INPUT_CAPTURE_PRESCALER tim2_input_capture1_prescaler_read(void) {
  return (TIM2_INPUT_CAPTURE_PRESCALER)((TIM2->CCMR1 >> 2) & 0x03);
}



typedef enum {
    TIM2_IC_FILTER_NONE    = 0x00,
    TIM2_IC_FILTER_FM_N2   = 0x01,
    TIM2_IC_FILTER_FM_N4   = 0x02,
    TIM2_IC_FILTER_FM_N8   = 0x03,

    TIM2_IC_FILTER_FM2_N6  = 0x04,
    TIM2_IC_FILTER_FM2_N8  = 0x05,

    TIM2_IC_FILTER_FM4_N6  = 0x06,
    TIM2_IC_FILTER_FM4_N8  = 0x07,

    TIM2_IC_FILTER_FM8_N6  = 0x08,
    TIM2_IC_FILTER_FM8_N8  = 0x09,

    TIM2_IC_FILTER_FM16_N5 = 0x0A,
    TIM2_IC_FILTER_FM16_N6 = 0x0B,
    TIM2_IC_FILTER_FM16_N8 = 0x0C,

    TIM2_IC_FILTER_FM32_N5 = 0x0D,
    TIM2_IC_FILTER_FM32_N6 = 0x0E,
    TIM2_IC_FILTER_FM32_N8 = 0x0F
} TIM2_INPUT_CAPTURE_FILTER;

#define TIM2_INPUT_CAPTURE1_FILTER_CLR_MASK 0x0F

inline void tim2_input_capture1_filter_set(TIM2_INPUT_CAPTURE_FILTER filter) {
  TIM2->CCMR1 = (TIM2->CCMR1 & TIM2_INPUT_CAPTURE1_FILTER_CLR_MASK) | ((uint8_t)filter << 4);
}

inline TIM2_INPUT_CAPTURE_FILTER tim2_input_capture1_filter_read(void) {
  return (TIM2_INPUT_CAPTURE_FILTER)((TIM2->CCMR1 >> 4) & 0x0F);
}



/* TIM2 Capture/Compare mode register 2 (CCMR2) */
/* Generic Functions */
typedef enum {
  TIM2_CC2_OUTPUT    = 0x00,
  TIM2_CC2_INPUT_TI2 = 0x01,
  TIM2_CC2_INPUT_TI1 = 0x02  
} TIM2_CC2_CHANNEL_MODE;

#define TIM2_CC2_CHANNEL_MODE_CLR_MASK 0xFC

inline void tim2_cc2_channel_mode_set(TIM2_CC2_CHANNEL_MODE mode) {
  TIM2->CCMR2 = (TIM2->CCMR2 & TIM2_CC2_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM2_CC2_CHANNEL_MODE tim2_cc2_channel_mode_read(void) {
  return (TIM2_CC2_CHANNEL_MODE)(TIM2->CCMR2 & 0x03);
}

/* Output mode functions */
inline void tim2_cc2_preload_enable(void) {
  TIM2->CCMR2 |= (1U << 3);
}

inline void tim2_cc2_preload_disable(void) {
  TIM2->CCMR2 &= ~(1U << 3);
}


#define TIM2_OUTPUT_COMPARE2_MODE_CLR_MASK 0x8F

inline void tim2_output_compare2_mode_set(TIM2_OUTPUT_COMPARE_MODE mode) {
  TIM2->CCMR2 = (TIM2->CCMR2 & TIM2_OUTPUT_COMPARE2_MODE_CLR_MASK) | ((uint8_t)mode << 4);
}

inline TIM2_OUTPUT_COMPARE_MODE tim2_output_compare2_mode_read(void) {
  return (TIM2_OUTPUT_COMPARE_MODE)((TIM2->CCMR2 >> 4) & 0x07);
}

/* Input mode functions */
#define TIM2_INPUT_CAPTURE2_PRESCALER_CLR_MASK 0xF3

inline void tim2_input_capture2_prescaler_set(TIM2_INPUT_CAPTURE_PRESCALER psc) {
  TIM2->CCMR2 = (TIM2->CCMR2 & TIM2_INPUT_CAPTURE2_PRESCALER_CLR_MASK) | ((uint8_t)psc << 2);
}

inline TIM2_INPUT_CAPTURE_PRESCALER tim2_input_capture2_prescaler_read(void) {
  return (TIM2_INPUT_CAPTURE_PRESCALER)((TIM2->CCMR2 >> 2) & 0x03);
}


#define TIM2_INPUT_CAPTURE2_FILTER_CLR_MASK 0x0F

inline void tim2_input_capture2_filter_set(TIM2_INPUT_CAPTURE_FILTER filter) {
  TIM2->CCMR2 = (TIM2->CCMR2 & TIM2_INPUT_CAPTURE2_FILTER_CLR_MASK) | ((uint8_t)filter << 4);
}

inline TIM2_INPUT_CAPTURE_FILTER tim2_input_capture2_filter_read(void) {
  return (TIM2_INPUT_CAPTURE_FILTER)((TIM2->CCMR2 >> 4) & 0x0F);
}



/* TIM2 Capture/Compare mode register 3 (CCMR3) */
/* Generic Functions */
typedef enum {
  TIM2_CC3_OUTPUT    = 0x00,
  TIM2_CC3_INPUT_TI3 = 0x01   
} TIM2_CC3_CHANNEL_MODE;

#define TIM2_CC3_CHANNEL_MODE_CLR_MASK 0xFC

inline void tim2_cc3_channel_mode_set(TIM2_CC3_CHANNEL_MODE mode) {
  TIM2->CCMR3 = (TIM2->CCMR3 & TIM2_CC3_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM2_CC3_CHANNEL_MODE tim2_cc3_channel_mode_read(void) {
  return (TIM2_CC3_CHANNEL_MODE)(TIM2->CCMR3 & 0x03);
}

/* Output mode functions */
inline void tim2_cc3_preload_enable(void) {
  TIM2->CCMR3 |= (1U << 3);
}

inline void tim2_cc3_preload_disable(void) {
  TIM2->CCMR3 &= ~(1U << 3);
}


#define TIM2_OUTPUT_COMPARE3_MODE_CLR_MASK 0x8F

inline void tim2_output_compare3_mode_set(TIM2_OUTPUT_COMPARE_MODE mode) {
  TIM2->CCMR3 = (TIM2->CCMR3 & TIM2_OUTPUT_COMPARE3_MODE_CLR_MASK) | ((uint8_t)mode << 4);
}

inline TIM2_OUTPUT_COMPARE_MODE tim2_output_compare3_mode_read(void) {
  return (TIM2_OUTPUT_COMPARE_MODE)((TIM2->CCMR3 >> 4) & 0x07);
}

/* Input mode functions */
#define TIM2_INPUT_CAPTURE3_PRESCALER_CLR_MASK 0xF3

inline void tim2_input_capture3_prescaler_set(TIM2_INPUT_CAPTURE_PRESCALER psc) {
  TIM2->CCMR3 = (TIM2->CCMR3 & TIM2_INPUT_CAPTURE3_PRESCALER_CLR_MASK) | ((uint8_t)psc << 2);
}

inline TIM2_INPUT_CAPTURE_PRESCALER tim2_input_capture3_prescaler_read(void) {
  return (TIM2_INPUT_CAPTURE_PRESCALER)((TIM2->CCMR3 >> 2) & 0x03);
}


#define TIM2_INPUT_CAPTURE3_FILTER_CLR_MASK 0x0F

inline void tim2_input_capture3_filter_set(TIM2_INPUT_CAPTURE_FILTER filter) {
  TIM2->CCMR3 = (TIM2->CCMR3 & TIM2_INPUT_CAPTURE3_FILTER_CLR_MASK) | ((uint8_t)filter << 4);
}

inline TIM2_INPUT_CAPTURE_FILTER tim2_input_capture3_filter_read(void) {
  return (TIM2_INPUT_CAPTURE_FILTER)((TIM2->CCMR3 >> 4) & 0x0F);
}



/* TIM2 Capture/Compare enable register 1 (CCER1) */
inline void tim2_cc1_enable(void) {
  TIM2->CCER1 |= (1U << 0);
}

inline void tim2_cc1_disable(void) {
  TIM2->CCER1 &= ~(1U << 0);
}


inline void tim2_cc1_polarity_high(void) {
  TIM2->CCER1 &= ~(1U << 1);
}

inline void tim2_cc1_polarity_low(void) {
  TIM2->CCER1 |= (1U << 1);
}


inline void tim2_cc2_enable(void) {
  TIM2->CCER1 |= (1U << 4);
}

inline void tim2_cc2_disable(void) {
  TIM2->CCER1 &= ~(1U << 4);
}


inline void tim2_cc2_polarity_high(void) {
  TIM2->CCER1 &= ~(1U << 5);
}

inline void tim2_cc2_polarity_low(void) {
  TIM2->CCER1 |= (1U << 5);
}



/* TIM2 Capture/Compare enable register 2 (CCER2) */
inline void tim2_cc3_enable(void) {
  TIM2->CCER2 |= (1U << 0);
}

inline void tim2_cc3_disable(void) {
  TIM2->CCER2 &= ~(1U << 0);
}

inline void tim2_cc3_polarity_high(void) {
  TIM2->CCER2 &= ~(1U << 1);
}

inline void tim2_cc3_polarity_low(void) {
  TIM2->CCER2 |= (1U << 1);
}



/* TIM2 Counter register (CNTRH/CNTRL) */
inline void tim2_counter_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM2->CNTRH = (uint8_t)((value >> 8) & 0xFF);
  TIM2->CNTRL = (uint8_t)(value & 0xFF);
}

inline uint16_t tim2_counter_read(void) {
  // Read high byte first to automatically latch the low byte 
  uint8_t high_byte = TIM2->CNTRH; 
  uint8_t low_byte = TIM2->CNTRL;  
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM2 Prescaler register (PSCR) */
inline void tim2_prescaler_set(uint8_t prescaler) {
  TIM2->PSCR = (prescaler & 0x07);
}

inline uint8_t tim2_prescaler_read(void) {
  return (TIM2->PSCR & 0x07);
}



/* TIM2 Auto Reload register (ARRH/ARRL) */
inline void tim2_auto_reload_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM2->ARRH = (uint8_t)((value >> 8) & 0xFF);
  TIM2->ARRL = (uint8_t)(value & 0xFF);
}

inline uint16_t tim2_auto_reload_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM2->ARRH;
  uint8_t low_byte = TIM2->ARRL;
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM2 Capture/Compare1 register (CCR1H/CCR1L) */ 
inline void tim2_cc1_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM2->CCR1H = (uint8_t)((value >> 8) & 0xFF);
  TIM2->CCR1L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim2_cc1_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM2->CCR1H;
  uint8_t low_byte = TIM2->CCR1L;
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM2 Capture/Compare2 register (CCR2H/CCR2L) */
inline void tim2_cc2_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM2->CCR2H = (uint8_t)((value >> 8) & 0xFF);
  TIM2->CCR2L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim2_cc2_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM2->CCR2H;
  uint8_t low_byte = TIM2->CCR2L;
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM2 Capture/Compare3 register (CCR3H/CCR3L) */
inline void tim2_cc3_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM2->CCR3H = (uint8_t)((value >> 8) & 0xFF);
  TIM2->CCR3L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim2_cc3_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM2->CCR3H;
  uint8_t low_byte = TIM2->CCR3L;
  return ((uint16_t)high_byte << 8) | low_byte;
}

#endif