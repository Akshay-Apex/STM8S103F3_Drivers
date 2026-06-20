#ifndef TIMER_H
#define TIMER_H

#include <stdint.h>

/* TIM1 Register Definitions */
typedef struct {
  volatile uint8_t CR1;   // TIM1 control register 1
  volatile uint8_t CR2;   // TIM1 control register 2

  volatile uint8_t SMCR;  // TIM1 slave mode control register
  volatile uint8_t ETR;   // TIM1 external trigger register
  volatile uint8_t IER;   // TIM1 interrupt enable register
  volatile uint8_t SR1;   // TIM1 status register 1
  volatile uint8_t SR2;   // TIM1 status register 2
  volatile uint8_t EGR;   // TIM1 event generation register

  volatile uint8_t CCMR1; // TIM1 capture/compare mode register 1
  volatile uint8_t CCMR2; // TIM1 capture/compare mode register 2
  volatile uint8_t CCMR3; // TIM1 capture/compare mode register 3
  volatile uint8_t CCMR4; // TIM1 capture/compare mode register 4

  volatile uint8_t CCER1; // TIM1 capture/compare enable register 1
  volatile uint8_t CCER2; // TIM1 capture/compare enable register 2
  volatile uint8_t CNTRH; // TIM1 counter high
  volatile uint8_t CNTRL; // TIM1 counter low
  volatile uint8_t PSCRH; // TIM1 prescaler register high
  volatile uint8_t PSCRL; // TIM1 prescaler register low
  volatile uint8_t ARRH;  // TIM1 auto-reload register high
  volatile uint8_t ARRL;  // TIM1 auto-reload register low
  volatile uint8_t RCR;   // TIM1 repetition counter register

  volatile uint8_t CCR1H; // TIM1 capture/compare register 1 high
  volatile uint8_t CCR1L; // TIM1 capture/compare register 1 low
  volatile uint8_t CCR2H; // TIM1 capture/compare register 2 high
  volatile uint8_t CCR2L; // TIM1 capture/compare register 2 low
  volatile uint8_t CCR3H; // TIM1 capture/compare register 3 high
  volatile uint8_t CCR3L; // TIM1 capture/compare register 3 low
  volatile uint8_t CCR4H; // TIM1 capture/compare register 4 high
  volatile uint8_t CCR4L; // TIM1 capture/compare register 4 low

  volatile uint8_t BKR;   // TIM1 break register
  volatile uint8_t DTR;   // TIM1 dead-time register
  volatile uint8_t OISR;  // TIM1 output idle state register
} TIM1_REG;


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


#define TIM1 ((TIM1_REG *)0x5250) // Base address binding of TIM1 registers
#define TIM2 ((TIM2_REG *)0x5300) // Base address binding of TIM2 registers
#define TIM4 ((TIM4_REG *)0x5340) // Base address binding of TIM4 registers



/* TIM4 Timer Functions */
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
inline void tim4_prescaler_set(uint8_t value) {
  TIM4->PSCR = value & 0x0F;
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



/* TIM2 Timer Functions */
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


inline void tim2_capture_compare1_irq_enable(void) {
  TIM2->IER |= (1U << 1);
}

inline void tim2_capture_compare1_irq_disable(void) {
  TIM2->IER &= ~(1U << 1);
}


inline void tim2_capture_compare2_irq_enable(void) {
  TIM2->IER |= (1U << 2);
}

inline void tim2_capture_compare2_irq_disable(void) {
  TIM2->IER &= ~(1U << 2);
}


inline void tim2_capture_compare3_irq_enable(void) {
  TIM2->IER |= (1U << 3);
}

inline void tim2_capture_compare3_irq_disable(void) {
  TIM2->IER &= ~(1U << 3);
}



/* TIM2 status register 1 (SR1) */
inline void tim2_update_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 0);
}

inline uint8_t tim2_update_irq_flag_read(void) {
  return ((TIM2->SR1 >> 0) & 1);
}


inline void tim2_capture_compare1_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 1);
}

inline uint8_t tim2_capture_compare1_irq_flag_read(void) {
  return ((TIM2->SR1 >> 1) & 1);
}


inline void tim2_capture_compare2_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 2);
}

inline uint8_t tim2_capture_compare2_irq_flag_read(void) {
  return ((TIM2->SR1 >> 2) & 1);
}


inline void tim2_capture_compare3_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 3);
}

inline uint8_t tim2_capture_compare3_irq_flag_read(void) {
  return ((TIM2->SR1 >> 3) & 1);
}



/* TIM2 status register 2 (SR2) */
inline void tim2_capture_compare1_overcapture_flag_clear(void) {
  TIM2->SR2 &= ~(1U << 1);
}

inline uint8_t tim2_capture_compare1_overcapture_flag_read(void) {
  return ((TIM2->SR2 >> 1) & 1);
}


inline void tim2_capture_compare2_overcapture_flag_clear(void) {
  TIM2->SR2 &= ~(1U << 2);
}

inline uint8_t tim2_capture_compare2_overcapture_flag_read(void) {
  return ((TIM2->SR2 >> 2) & 1);
}


inline void tim2_capture_compare3_overcapture_flag_clear(void) {
  TIM2->SR2 &= ~(1U << 3);
}

inline uint8_t tim2_capture_compare3_overcapture_flag_read(void) {
  return ((TIM2->SR2 >> 3) & 1);
}



/* TIM2 event generation register (EGR) */
inline void tim2_update_event_generate(void) {
  TIM2->EGR |= (1U << 0);
}

inline void tim2_capture_compare1_event_generate(void) {
  TIM2->EGR |= (1U << 1);
}

inline void tim2_capture_compare2_event_generate(void) {
  TIM2->EGR |= (1U << 2);
}

inline void tim2_capture_compare3_event_generate(void) {
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

inline void tim2_capture_compare1_channel_mode_set(TIM2_CC1_CHANNEL_MODE mode) {
  TIM2->CCMR1 = (TIM2->CCMR1 & TIM2_CC1_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM2_CC1_CHANNEL_MODE tim2_capture_compare1_channel_mode_read(void) {
  return (TIM2_CC1_CHANNEL_MODE)(TIM2->CCMR1 & ~TIM2_CC1_CHANNEL_MODE_CLR_MASK);
}

/* Output mode functions */
inline void tim2_capture_compare1_preload_enable(void) {
  TIM2->CCMR1 |= (1U << 3);
}

inline void tim2_capture_compare1_preload_disable(void) {
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
  return (TIM2_INPUT_CAPTURE_FILTER)(TIM2->CCMR1 >> 4) & 0x0F;
}



/* TIM2 Capture/Compare mode register 2 (CCMR2) */
/* Generic Functions */
typedef enum {
  TIM2_CC2_OUTPUT    = 0x00,
  TIM2_CC2_INPUT_TI2 = 0x01,
  TIM2_CC2_INPUT_TI1 = 0x02  
} TIM2_CC2_CHANNEL_MODE;

#define TIM2_CC2_CHANNEL_MODE_CLR_MASK 0xFC

inline void tim2_capture_compare2_channel_mode_set(TIM2_CC2_CHANNEL_MODE mode) {
  TIM2->CCMR2 = (TIM2->CCMR2 & TIM2_CC2_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM2_CC2_CHANNEL_MODE tim2_capture_compare2_channel_mode_read(void) {
  return (TIM2_CC2_CHANNEL_MODE)(TIM2->CCMR2 & 0x03);
}

/* Output mode functions */
inline void tim2_capture_compare2_preload_enable(void) {
  TIM2->CCMR2 |= (1U << 3);
}

inline void tim2_capture_compare2_preload_disable(void) {
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

inline void tim2_capture_compare3_channel_mode_set(TIM2_CC3_CHANNEL_MODE mode) {
  TIM2->CCMR3 = (TIM2->CCMR3 & TIM2_CC3_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM2_CC3_CHANNEL_MODE tim2_capture_compare3_channel_mode_read(void) {
  return (TIM2_CC3_CHANNEL_MODE)(TIM2->CCMR3 & 0x03);
}

/* Output mode functions */
inline void tim2_capture_compare3_preload_enable(void) {
  TIM2->CCMR3 |= (1U << 3);
}

inline void tim2_capture_compare3_preload_disable(void) {
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
inline void tim2_capture_compare1_enable(void) {
  TIM2->CCER1 |= (1U << 0);
}

inline void tim2_capture_compare1_disable(void) {
  TIM2->CCER1 &= ~(1U << 0);
}


inline void tim2_capture_compare1_polarity_high(void) {
  TIM2->CCER1 &= ~(1U << 1);
}

inline void tim2_capture_compare1_polarity_low(void) {
  TIM2->CCER1 |= (1U << 1);
}


inline void tim2_capture_compare2_enable(void) {
  TIM2->CCER1 |= (1U << 4);
}

inline void tim2_capture_compare2_disable(void) {
  TIM2->CCER1 &= ~(1U << 4);
}


inline void tim2_capture_compare2_polarity_high(void) {
  TIM2->CCER1 &= ~(1U << 5);
}

inline void tim2_capture_compare2_polarity_low(void) {
  TIM2->CCER1 |= (1U << 5);
}



/* TIM2 Capture/Compare enable register 2 (CCER2) */
inline void tim2_capture_compare3_enable(void) {
  TIM2->CCER2 |= (1U << 0);
}

inline void tim2_capture_compare3_disable(void) {
  TIM2->CCER2 &= ~(1U << 0);
}

inline void tim2_capture_compare3_polarity_high(void) {
  TIM2->CCER2 &= ~(1U << 1);
}

inline void tim2_capture_compare3_polarity_low(void) {
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
inline void tim2_capture_compare1_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM2->CCR1H = (uint8_t)((value >> 8) & 0xFF);
  TIM2->CCR1L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim2_capture_compare1_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM2->CCR1H;
  uint8_t low_byte = TIM2->CCR1L;
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM2 Capture/Compare2 register (CCR2H/CCR2L) */
inline void tim2_capture_compare2_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM2->CCR2H = (uint8_t)((value >> 8) & 0xFF);
  TIM2->CCR2L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim2_capture_compare2_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM2->CCR2H;
  uint8_t low_byte = TIM2->CCR2L;
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM2 Capture/Compare3 register (CCR3H/CCR3L) */
inline void tim2_capture_compare3_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM2->CCR3H = (uint8_t)((value >> 8) & 0xFF);
  TIM2->CCR3L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim2_capture_compare3_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM2->CCR3H;
  uint8_t low_byte = TIM2->CCR3L;
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM1 Control Register 1 (CR1) */
inline void tim1_counter_enable(void) {
  TIM1->CR1 |= (1U << 0);
}

inline void tim1_counter_disable(void) {
  TIM1->CR1 &= ~(1U << 0);
}


inline void tim1_auto_update_event_enable(void) {
  TIM1->CR1 &= ~(1U << 1);
}

inline void tim1_auto_update_event_disable(void) {
  TIM1->CR1 |= (1U << 1);
}


inline void tim1_update_req_src_any_event_set(void) {
  TIM1->CR1 &= ~(1U << 2);
}

inline void tim1_update_req_src_overflow_underflow_only_set(void) {
  TIM1->CR1 |= (1U << 2);
}


inline void tim1_one_pulse_mode_enable(void) {
  TIM1->CR1 |= (1U << 3);
}

inline void tim1_one_pulse_mode_disable(void) {
  TIM1->CR1 &= ~(1U << 3);
}


inline void tim1_direction_up_counter(void) {
  TIM1->CR1 &= ~(1U << 4);
}

inline void tim1_direction_down_counter(void) {
  TIM1->CR1 |= (1U << 4);
}


typedef enum {
    TIM1_EDGE_ALIGNED   = 0x00,  
    TIM1_CENTER_MODE1   = 0x01,  
    TIM1_CENTER_MODE2   = 0x02,  
    TIM1_CENTER_MODE3   = 0x03   
} TIM1_CENTER_ALIGNED_MODE;

#define TIM1_CENTER_ALIGNED_MODE_CLR_MASK 0x9F

inline void tim1_center_aligned_mode_set(TIM1_CENTER_ALIGNED_MODE mode) {
  TIM1->CR1 = (TIM1->CR1 & TIM1_CENTER_ALIGNED_MODE_CLR_MASK) | ((uint8_t)mode << 5);
}

inline TIM1_CENTER_ALIGNED_MODE tim1_center_aligned_mode_read(void) {
  return (TIM1_CENTER_ALIGNED_MODE)((TIM1->CR1 >> 5) & 0x03);
}


inline void tim1_auto_reload_preload_enable(void) {
  TIM1->CR1 |= (1U << 7);
}

inline void tim1_auto_reload_preload_disable(void) {
  TIM1->CR1 &= ~(1U << 7);
}



/* TIM1 Control Register 2 (CR2) */
inline void tim1_capture_compare_preload_control_enable(void) {
  TIM1->CR2 |= (1U << 0);
}

inline void tim1_capture_compare_preload_control_disable(void) {
  TIM1->CR2 &= ~(1U << 0);
}


inline void tim1_capture_compare_control_update_selection_enable(void) {
  TIM1->CR2 |= (1U << 1);
}

inline void tim1_capture_compare_control_update_selection_disable(void) {
  TIM1->CR2 &= ~(1U << 1);
}


typedef enum {
    TIM1_MASTER_MODE_RESET         = 0x00,
    TIM1_MASTER_MODE_ENABLE        = 0x01,
    TIM1_MASTER_MODE_UPDATE        = 0x02,
    TIM1_MASTER_MODE_COMPARE_PULSE = 0x03,
    TIM1_MASTER_MODE_OC1REF        = 0x04,
    TIM1_MASTER_MODE_OC2REF        = 0x05,
    TIM1_MASTER_MODE_OC3REF        = 0x06,
    TIM1_MASTER_MODE_OC4REF        = 0x07
} TIM1_MASTER_MODE;

#define TIM1_MASTER_MODE_SELECTION_CLR_MASK 0x8F

inline void tim1_master_mode_selection_set(TIM1_MASTER_MODE mode) {
  TIM1->CR2 = (TIM1->CR2 & TIM1_MASTER_MODE_SELECTION_CLR_MASK) | ((uint8_t)mode << 4);
}

inline TIM1_MASTER_MODE tim1_master_mode_selection_read(void) {
  return (TIM1_MASTER_MODE)((TIM1->CR2 >> 4) & 0x07);
}



/* TIM1 Slave Mode Control Register (SMCR) */
typedef enum {
    TIM1_SM_DISABLED         = 0x00,
    TIM1_SM_ENCODER1         = 0x01,
    TIM1_SM_ENCODER2         = 0x02,
    TIM1_SM_ENCODER3         = 0x03,
    TIM1_SM_RESET            = 0x04,
    TIM1_SM_TRIGGER_GATED    = 0x05,
    TIM1_SM_TRIGGER_STANDARD = 0x06,
    TIM1_SM_EXTERNAL_CLOCK1  = 0x07
} TIM1_SLAVE_MODE;

#define TIM1_SLAVE_MODE_CLR_MASK 0xF8

inline void tim1_slave_mode_set(TIM1_SLAVE_MODE mode) {
  TIM1->SMCR = (TIM1->SMCR & TIM1_SLAVE_MODE_CLR_MASK) | (mode & 0x07);
}

inline TIM1_SLAVE_MODE tim1_slave_mode_read(void) {
  return (TIM1_SLAVE_MODE)(TIM1->SMCR & 0x07);
}


typedef enum {
    TIM1_INTERNAL_TRIGGER_ITR0  = 0x00,
    TIM1_TRIGGER_RESERVED_0     = 0x01,
    TIM1_TRIGGER_RESERVED_1     = 0x02,
    TIM1_INTERNAL_TRIGGER_ITR3  = 0x03,
    TIM1_TI1_EDGE_DETECTOR      = 0x04,
    TIM1_FILTERED_TIMER_INPUT_1 = 0x05,
    TIM1_FILTERED_TIMER_INPUT_2 = 0x06,
    TIM1_EXTERNAL_TRIGGER_INPUT = 0x07
} TIM1_TRIGGER_SOURCE;

#define TIM1_TRIGGER_SELECTION_CLR_MASK 0x8F

inline void tim1_trigger_selection_set(TIM1_TRIGGER_SOURCE source) {
  TIM1->SMCR = (TIM1->SMCR & TIM1_TRIGGER_SELECTION_CLR_MASK) | ((uint8_t)source << 4);
}

inline TIM1_TRIGGER_SOURCE tim1_trigger_selection_read(void) {
  return (TIM1_TRIGGER_SOURCE)((TIM1->SMCR >> 4) & 0x07);
}


inline void tim1_master_slave_mode_enable(void) {
  TIM1->SMCR |= (1U << 7);
}

inline void tim1_master_slave_mode_disable(void) {
  TIM1->SMCR &= ~(1U << 7);
}



/* TIM1 External Trigger Register (ETR) */
typedef enum {
    TIM1_ETF_NO_FILTER      = 0x00,

    TIM1_ETF_FMASTER_N2     = 0x01,
    TIM1_ETF_FMASTER_N4     = 0x02,
    TIM1_ETF_FMASTER_N8     = 0x03,

    TIM1_ETF_FMASTER_2_N6   = 0x04,
    TIM1_ETF_FMASTER_2_N8   = 0x05,

    TIM1_ETF_FMASTER_4_N6   = 0x06,
    TIM1_ETF_FMASTER_4_N8   = 0x07,

    TIM1_ETF_FMASTER_8_N6   = 0x08,
    TIM1_ETF_FMASTER_8_N8   = 0x09,

    TIM1_ETF_FMASTER_16_N5  = 0x0A,
    TIM1_ETF_FMASTER_16_N6  = 0x0B,
    TIM1_ETF_FMASTER_16_N8  = 0x0C,

    TIM1_ETF_FMASTER_32_N5  = 0x0D,
    TIM1_ETF_FMASTER_32_N6  = 0x0E,
    TIM1_ETF_FMASTER_32_N8  = 0x0F
} TIM1_EXTERNAL_TRIGGER_FILTER;

#define TIM1_EXTERNAL_TRIGGER_PSC_CLR_MASK 0xF0

inline void tim1_external_trigger_filter_set(TIM1_EXTERNAL_TRIGGER_FILTER filter) {
  TIM1->ETR = (TIM1->ETR & TIM1_EXTERNAL_TRIGGER_PSC_CLR_MASK) | filter;
}

inline TIM1_EXTERNAL_TRIGGER_FILTER tim1_external_trigger_filter_read(void) {
  return (TIM1_EXTERNAL_TRIGGER_FILTER)(TIM1->ETR & 0x0F);
}


typedef enum {
    TIM1_PRESCALER_OFF   = 0x00,
    TIM1_PRESCALER_DIV2  = 0x01,
    TIM1_PRESCALER_DIV4  = 0x02,
    TIM1_PRESCALER_DIV8  = 0x03
} TIM1_EXTERNAL_TRIGGER_PRESCALER;

#define TIM1_EXTERNAL_TRIGGER_PRESCALER_CLR_MASK 0xCF

inline void tim1_external_trigger_prescaler_set(TIM1_EXTERNAL_TRIGGER_PRESCALER psc) {
  TIM1->ETR = (TIM1->ETR & TIM1_EXTERNAL_TRIGGER_PRESCALER_CLR_MASK) | ((uint8_t)psc << 4);
}

inline TIM1_EXTERNAL_TRIGGER_PRESCALER tim1_external_trigger_prescaler_read(void) {
  return (TIM1_EXTERNAL_TRIGGER_PRESCALER)((TIM1->ETR >> 4) & 0x03);
}


inline void tim1_external_clock_mode_2_enable(void) {
  TIM1->ETR |= (1U << 6);
}

inline void tim1_external_clock_mode_2_disable(void) {
  TIM1->ETR &= ~(1U << 6);
}


inline void tim1_external_trigger_polarity_high(void) {
  TIM1->ETR &= ~(1U << 7);
}

inline void tim1_external_trigger_polarity_low(void) {
  TIM1->ETR |= (1U << 7);
}



/* TIM1 Interrupt Enable Register (IER) */
typedef enum {
  TIM1_UPDATE_IRQ      = 0,
  TIM1_COMMUTATION_IRQ = 5,
  TIM1_TRIGGER_IRQ     = 6,
  TIM1_BREAK_IRQ       = 7
} TIM1_IRQ;

inline void tim1_irq_enable(TIM1_IRQ irq) {
  TIM1->IER |= (1U << irq);
}

inline void tim1_irq_disable(TIM1_IRQ irq) {
  TIM1->IER &= ~(1U << irq);
}

typedef enum {
    TIM1_CC1_IRQ = 1,
    TIM1_CC2_IRQ = 2,
    TIM1_CC3_IRQ = 3,
    TIM1_CC4_IRQ = 4
} TIM1_CAPTURE_COMPARE_IRQ;

inline void tim1_capture_compare_irq_enable(TIM1_CAPTURE_COMPARE_IRQ cc_irq) {
  TIM1->IER |= (1U << cc_irq);
}

inline void tim1_capture_compare_irq_disable(TIM1_CAPTURE_COMPARE_IRQ cc_irq) {
  TIM1->IER &= ~(1U << cc_irq);
}



/* TIM1 Status Register 1 (SR1) */
typedef enum {
  TIM1_UPDATE_IRQ_FLAG      = 0,
  TIM1_COMMUTATION_IRQ_FLAG = 5,
  TIM1_TRIGGER_IRQ_FLAG     = 6,
  TIM1_BREAK_IRQ_FLAG       = 7
} TIM1_IRQ_FLAG;

inline void tim1_irq_flag_clear(TIM1_IRQ_FLAG irq_flag) {
  TIM1->SR1 &= ~(1U << irq_flag);
}

inline uint8_t tim1_irq_flag_read(TIM1_IRQ_FLAG irq_flag) {
  return ((TIM1->SR1 >> irq_flag) & 1);
}

typedef enum {
    TIM1_CC1_IRQ_FLAG = 1,
    TIM1_CC2_IRQ_FLAG = 2,
    TIM1_CC3_IRQ_FLAG = 3,
    TIM1_CC4_IRQ_FLAG = 4
} TIM1_CAPTURE_COMPARE_IRQ_FLAG;

inline void tim1_capture_compare_irq_flag_clear(TIM1_CAPTURE_COMPARE_IRQ_FLAG cc_irq_flag) {
  TIM1->SR1 &= ~(1U << cc_irq_flag);
}

inline uint8_t tim1_capture_compare_irq_flag_read(TIM1_CAPTURE_COMPARE_IRQ_FLAG cc_irq_flag) {
  return ((TIM1->SR1 >> cc_irq_flag) & 1);
}



/* TIM1 Status Register 2 (SR2) */
typedef enum {
  TIM1_CC1_OVER_CAPTURE_FLAG = 1,
  TIM1_CC2_OVER_CAPTURE_FLAG = 2,
  TIM1_CC3_OVER_CAPTURE_FLAG = 3,
  TIM1_CC4_OVER_CAPTURE_FLAG = 4
} TIM1_OVER_CAPTURE_FLAG;

inline void tim1_capture_compare_overcapture_flag_clear(TIM1_OVER_CAPTURE_FLAG oc_flag) {
  TIM1->SR2 &= ~(1U << oc_flag);
}

inline uint8_t tim1_capture_compare_overcapture_flag_read(TIM1_OVER_CAPTURE_FLAG oc_flag) {
  return ((TIM1->SR2 >> oc_flag) & 1);
}



/* TIM1 Event Generation Register (EGR) */
typedef enum {
  TIM1_UPDATE_EVENT             = 0,
  TIM1_CC_CONTROL_UPDATE_EVENT  = 5,
  TIM1_TRIGGER_EVENT            = 6,
  TIM1_BREAK_EVENT              = 7
} TIM1_EVENT;

inline void tim1_event_generate(TIM1_EVENT event) {
  TIM1->EGR |= (1U << event);
}

typedef enum {
  TIM1_CC1_EVENT = 1,
  TIM1_CC2_EVENT = 2,
  TIM1_CC3_EVENT = 3,
  TIM1_CC4_EVENT = 4
} TIM1_CAPTURE_COMPARE_EVENT;

inline void tim1_capture_compare_event_generate(TIM1_CAPTURE_COMPARE_EVENT cc_event) {
  TIM1->EGR |= (1U << cc_event);
}



/* TIM1 Capture/Compare Mode Register 1 (CCMR1) */
/* General Functions */
typedef enum {
    TIM1_CC1_CHANNEL_MODE_OUTPUT    = 0,
    TIM1_CC1_CHANNEL_MODE_INPUT_TI1 = 1,
    TIM1_CC1_CHANNEL_MODE_INPUT_TI2 = 2,
    TIM1_CC1_CHANNEL_MODE_INPUT_TRC = 3
} TIM1_CC1_CHANNEL_MODE;

#define TIM1_CC1_CHANNEL_MODE_CLR_MASK 0xFC

inline void tim1_capture_compare1_channel_mode_set(TIM1_CC1_CHANNEL_MODE mode) {
  TIM1->CCMR1 = (TIM1->CCMR1 & TIM1_CC1_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM1_CC1_CHANNEL_MODE tim1_capture_compare1_channel_mode_read(void) {
  return (TIM1_CC1_CHANNEL_MODE)(TIM1->CCMR1 & 0x03);
}

/* Output Mode */
inline void tim1_capture_compare1_fast_enable(void) {
  TIM1->CCMR1 |= (1U << 2);
}

inline void tim1_capture_compare1_fast_disable(void) {
  TIM1->CCMR1 &= ~(1U << 2);
}


inline void tim1_capture_compare1_preload_enable(void) {
  TIM1->CCMR1 |= (1U << 3);
}

inline void tim1_capture_compare1_preload_disable(void) {
  TIM1->CCMR1 &= ~(1U << 3);
}


typedef enum {
    TIM1_OUTPUT_COMPARE_MODE_FROZEN            = 0,
    TIM1_OUTPUT_COMPARE_MODE_ACTIVE_ON_MATCH   = 1,
    TIM1_OUTPUT_COMPARE_MODE_INACTIVE_ON_MATCH = 2,
    TIM1_OUTPUT_COMPARE_MODE_TOGGLE            = 3,
    TIM1_OUTPUT_COMPARE_MODE_FORCE_INACTIVE    = 4,
    TIM1_OUTPUT_COMPARE_MODE_FORCE_ACTIVE      = 5,
    TIM1_OUTPUT_COMPARE_MODE_PWM_MODE_1        = 6,
    TIM1_OUTPUT_COMPARE_MODE_PWM_MODE_2        = 7
} TIM1_OUTPUT_COMPARE_MODE;

#define TIM1_OUTPUT_COMPARE1_MODE_CLR_MASK 0x8F

inline void tim1_output_compare1_mode_set(TIM1_OUTPUT_COMPARE_MODE mode) {
  TIM1->CCMR1 = (TIM1->CCMR1 & TIM1_OUTPUT_COMPARE1_MODE_CLR_MASK) | ((uint8_t)mode << 4);
}

inline TIM1_OUTPUT_COMPARE_MODE tim1_output_compare1_mode_read(void) {
  return (TIM1_OUTPUT_COMPARE_MODE)((TIM1->CCMR1 >> 4) & 0x07);
}


inline void tim1_output_compare1_clear_enable(void) {
  TIM1->CCMR1 |= (1U << 7);
}

inline void tim1_output_compare1_clear_disable(void) {
  TIM1->CCMR1 &= ~(1U << 7);
}

/* Input Mode */
typedef enum {
    TIM1_INPUT_CAPTURE_PSC_OFF = 0,
    TIM1_INPUT_CAPTURE_PSC_DIV2 = 1,
    TIM1_INPUT_CAPTURE_PSC_DIV4 = 2,
    TIM1_INPUT_CAPTURE_PSC_DIV8 = 3
} TIM1_INPUT_CAPTURE_PRESCALER;

#define TIM1_INPUT_CAPTURE1_PRESCALER_CLR_MASK 0xF3

inline void tim1_input_capture1_prescaler_set(TIM1_INPUT_CAPTURE_PRESCALER psc) {
  TIM1->CCMR1 = (TIM1->CCMR1 & TIM1_INPUT_CAPTURE1_PRESCALER_CLR_MASK) | ((uint8_t)psc << 2);
}

inline TIM1_INPUT_CAPTURE_PRESCALER tim1_input_capture1_prescaler_read(void) {
  return (TIM1_INPUT_CAPTURE_PRESCALER)((TIM1->CCMR1 >> 2) & 0x03);
}


typedef enum {
    TIM1_IC_FILTER_NO_FILTER      = 0x00,

    TIM1_IC_FILTER_FMASTER_N2     = 0x01,
    TIM1_IC_FILTER_FMASTER_N4     = 0x02,
    TIM1_IC_FILTER_FMASTER_N8     = 0x03,

    TIM1_IC_FILTER_FMASTER_2_N6   = 0x04,
    TIM1_IC_FILTER_FMASTER_2_N8   = 0x05,

    TIM1_IC_FILTER_FMASTER_4_N6   = 0x06,
    TIM1_IC_FILTER_FMASTER_4_N8   = 0x07,

    TIM1_IC_FILTER_FMASTER_8_N6   = 0x08,
    TIM1_IC_FILTER_FMASTER_8_N8   = 0x09,

    TIM1_IC_FILTER_FMASTER_16_N5  = 0x0A,
    TIM1_IC_FILTER_FMASTER_16_N6  = 0x0B,
    TIM1_IC_FILTER_FMASTER_16_N8  = 0x0C,

    TIM1_IC_FILTER_FMASTER_32_N5  = 0x0D,
    TIM1_IC_FILTER_FMASTER_32_N6  = 0x0E,
    TIM1_IC_FILTER_FMASTER_32_N8  = 0x0F
} TIM1_INPUT_CAPTURE_FILTER;

#define TIM1_INPUT_CAPTURE1_FILTER_CLR_MASK 0x0F

inline void tim1_input_capture1_filter_set(TIM1_INPUT_CAPTURE_FILTER filter) {
  TIM1->CCMR1 = (TIM1->CCMR1 & TIM1_INPUT_CAPTURE1_FILTER_CLR_MASK) | ((uint8_t)filter << 4);
}

inline TIM1_INPUT_CAPTURE_FILTER tim1_input_capture1_filter_read(void) {
  return (TIM1_INPUT_CAPTURE_FILTER)((TIM1->CCMR1 >> 4) & 0x0F);
}



/* TIM1 Capture/Compare Mode Register 2 (CCMR2) */
/* Generic Functions */
typedef enum {
    TIM1_CC2_CHANNEL_MODE_OUTPUT    = 0,
    TIM1_CC2_CHANNEL_MODE_INPUT_TI2 = 1,
    TIM1_CC2_CHANNEL_MODE_INPUT_TI1 = 2    
} TIM1_CC2_CHANNEL_MODE;

#define TIM1_CC2_CHANNEL_MODE_CLR_MASK 0xFC

inline void tim1_capture_compare2_channel_mode_set(TIM1_CC2_CHANNEL_MODE mode) {
  TIM1->CCMR2 = (TIM1->CCMR2 & TIM1_CC2_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM1_CC2_CHANNEL_MODE tim1_capture_compare2_channel_mode_read(void) {
  return (TIM1_CC2_CHANNEL_MODE)(TIM1->CCMR2 & 0x03);
}

/* Output Mode */
inline void tim1_capture_compare2_fast_enable(void) {
  TIM1->CCMR2 |= (1U << 2);
}

inline void tim1_capture_compare2_fast_disable(void) {
  TIM1->CCMR2 &= ~(1U << 2);
}


inline void tim1_capture_compare2_preload_enable(void) {
  TIM1->CCMR2 |= (1U << 3);
}

inline void tim1_capture_compare2_preload_disable(void) {
  TIM1->CCMR2 &= ~(1U << 3);
}


#define TIM1_OUTPUT_COMPARE2_MODE_CLR_MASK 0x8F

inline void tim1_output_compare2_mode_set(TIM1_OUTPUT_COMPARE_MODE mode) {
  TIM1->CCMR2 = (TIM1->CCMR2 & TIM1_OUTPUT_COMPARE2_MODE_CLR_MASK) | ((uint8_t)mode << 4);
}

inline TIM1_OUTPUT_COMPARE_MODE tim1_output_compare2_mode_read(void) {
  return (TIM1_OUTPUT_COMPARE_MODE)((TIM1->CCMR2 >> 4) & 0x07);
}


inline void tim1_output_compare2_clear_enable(void) {
  TIM1->CCMR2 |= (1U << 7);
}

inline void tim1_output_compare2_clear_disable(void) {
  TIM1->CCMR2 &= ~(1U << 7);
}

/* Input Mode */
#define TIM1_INPUT_CAPTURE2_PRESCALER_CLR_MASK 0xF3

inline void tim1_input_capture2_prescaler_set(TIM1_INPUT_CAPTURE_PRESCALER psc) {
  TIM1->CCMR2 = (TIM1->CCMR2 & TIM1_INPUT_CAPTURE2_PRESCALER_CLR_MASK) | ((uint8_t)psc << 2);
}

inline TIM1_INPUT_CAPTURE_PRESCALER tim1_input_capture2_prescaler_read(void) {
  return (TIM1_INPUT_CAPTURE_PRESCALER)((TIM1->CCMR2 >> 2) & 0x03);
}


#define TIM1_INPUT_CAPTURE2_FILTER_CLR_MASK 0x0F

inline void tim1_input_capture2_filter_set(TIM1_INPUT_CAPTURE_FILTER filter) {
  TIM1->CCMR2 = (TIM1->CCMR2 & TIM1_INPUT_CAPTURE2_FILTER_CLR_MASK) | ((uint8_t)filter << 4);
}

inline TIM1_INPUT_CAPTURE_FILTER tim1_input_capture2_filter_read(void) {
  return (TIM1_INPUT_CAPTURE_FILTER)((TIM1->CCMR2 >> 4) & 0x0F);
}



/* TIM1 Capture/Compare Mode Register 3 (CCMR3) */
/* General Mode */
typedef enum {
    TIM1_CC3_CHANNEL_MODE_OUTPUT    = 0,
    TIM1_CC3_CHANNEL_MODE_INPUT_TI3 = 1,
    TIM1_CC3_CHANNEL_MODE_INPUT_TI4 = 2    
} TIM1_CC3_CHANNEL_MODE;

#define TIM1_CC3_CHANNEL_MODE_CLR_MASK 0xFC

inline void tim1_capture_compare3_channel_mode_set(TIM1_CC3_CHANNEL_MODE mode) {
  TIM1->CCMR3 = (TIM1->CCMR3 & TIM1_CC3_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM1_CC3_CHANNEL_MODE tim1_capture_compare3_channel_mode_read(void) {
  return (TIM1_CC3_CHANNEL_MODE)(TIM1->CCMR3 & 0x03);
}

/* Output Mode */
inline void tim1_capture_compare3_fast_enable(void) {
  TIM1->CCMR3 |= (1U << 2);
}

inline void tim1_capture_compare3_fast_disable(void) {
  TIM1->CCMR3 &= ~(1U << 2);
}


inline void tim1_capture_compare3_preload_enable(void) {
  TIM1->CCMR3 |= (1U << 3);
}

inline void tim1_capture_compare3_preload_disable(void) {
  TIM1->CCMR3 &= ~(1U << 3);
}


#define TIM1_OUTPUT_COMPARE3_MODE_CLR_MASK 0x8F

inline void tim1_output_compare3_mode_set(TIM1_OUTPUT_COMPARE_MODE mode) {
  TIM1->CCMR3 = (TIM1->CCMR3 & TIM1_OUTPUT_COMPARE3_MODE_CLR_MASK) | ((uint8_t)mode << 4);
}

inline TIM1_OUTPUT_COMPARE_MODE tim1_output_compare3_mode_read(void) {
  return (TIM1_OUTPUT_COMPARE_MODE)((TIM1->CCMR3 >> 4) & 0x07);
}


inline void tim1_output_compare3_clear_enable(void) {
  TIM1->CCMR3 |= (1U << 7);
}

inline void tim1_output_compare3_clear_disable(void) {
  TIM1->CCMR3 &= ~(1U << 7);
}

/* Input Mode */
#define TIM1_INPUT_CAPTURE3_PRESCALER_CLR_MASK 0xF3

inline void tim1_input_capture3_prescaler_set(TIM1_INPUT_CAPTURE_PRESCALER psc) {
  TIM1->CCMR3 = (TIM1->CCMR3 & TIM1_INPUT_CAPTURE3_PRESCALER_CLR_MASK) | ((uint8_t)psc << 2);
}

inline TIM1_INPUT_CAPTURE_PRESCALER tim1_input_capture3_prescaler_read(void) {
  return (TIM1_INPUT_CAPTURE_PRESCALER)((TIM1->CCMR3 >> 2) & 0x03);
}


#define TIM1_INPUT_CAPTURE3_FILTER_CLR_MASK 0x0F

inline void tim1_input_capture3_filter_set(TIM1_INPUT_CAPTURE_FILTER filter) {
  TIM1->CCMR3 = (TIM1->CCMR3 & TIM1_INPUT_CAPTURE3_FILTER_CLR_MASK) | ((uint8_t)filter << 4);
}

inline TIM1_INPUT_CAPTURE_FILTER tim1_input_capture3_filter_read(void) {
  return (TIM1_INPUT_CAPTURE_FILTER)((TIM1->CCMR3 >> 4) & 0x0F);
}



/* TIM1 Capture/Compare Mode Register 4 (CCMR4) */
/* General Mode */
typedef enum {
    TIM1_CC4_CHANNEL_MODE_OUTPUT    = 0,
    TIM1_CC4_CHANNEL_MODE_INPUT_TI4 = 1,
    TIM1_CC4_CHANNEL_MODE_INPUT_TI3 = 2    
} TIM1_CC4_CHANNEL_MODE;

#define TIM1_CC4_CHANNEL_MODE_CLR_MASK 0xFC

inline void tim1_capture_compare4_channel_mode_set(TIM1_CC4_CHANNEL_MODE mode) {
  TIM1->CCMR4 = (TIM1->CCMR4 & TIM1_CC4_CHANNEL_MODE_CLR_MASK) | mode;
}

inline TIM1_CC4_CHANNEL_MODE tim1_capture_compare4_channel_mode_read(void) {
  return (TIM1_CC4_CHANNEL_MODE)(TIM1->CCMR4 & 0x03);
}

/* Output Mode */
inline void tim1_capture_compare4_fast_enable(void) {
  TIM1->CCMR4 |= (1U << 2);
}

inline void tim1_capture_compare4_fast_disable(void) {
  TIM1->CCMR4 &= ~(1U << 2);
}


inline void tim1_capture_compare4_preload_enable(void) {
  TIM1->CCMR4 |= (1U << 3);
}

inline void tim1_capture_compare4_preload_disable(void) {
  TIM1->CCMR4 &= ~(1U << 3);
}


#define TIM1_OUTPUT_COMPARE4_MODE_CLR_MASK 0x8F

inline void tim1_output_compare4_mode_set(TIM1_OUTPUT_COMPARE_MODE mode) {
  TIM1->CCMR4 = (TIM1->CCMR4 & TIM1_OUTPUT_COMPARE4_MODE_CLR_MASK) | ((uint8_t)mode << 4);
}

inline TIM1_OUTPUT_COMPARE_MODE tim1_output_compare4_mode_read(void) {
  return (TIM1_OUTPUT_COMPARE_MODE)((TIM1->CCMR4 >> 4) & 0x07);
}


inline void tim1_output_compare4_clear_enable(void) {
  TIM1->CCMR4 |= (1U << 7);
}

inline void tim1_output_compare4_clear_disable(void) {
  TIM1->CCMR4 &= ~(1U << 7);
}

/* Input Mode */
#define TIM1_INPUT_CAPTURE4_PRESCALER_CLR_MASK 0xF3

inline void tim1_input_capture4_prescaler_set(TIM1_INPUT_CAPTURE_PRESCALER psc) {
  TIM1->CCMR4 = (TIM1->CCMR4 & TIM1_INPUT_CAPTURE4_PRESCALER_CLR_MASK) | ((uint8_t)psc << 2);
}

inline TIM1_INPUT_CAPTURE_PRESCALER tim1_input_capture4_prescaler_read(void) {
  return (TIM1_INPUT_CAPTURE_PRESCALER)((TIM1->CCMR4 >> 2) & 0x03);
}


#define TIM1_INPUT_CAPTURE4_FILTER_CLR_MASK 0x0F

inline void tim1_input_capture4_filter_set(TIM1_INPUT_CAPTURE_FILTER filter) {
  TIM1->CCMR4 = (TIM1->CCMR4 & TIM1_INPUT_CAPTURE4_FILTER_CLR_MASK) | ((uint8_t)filter << 4);
}

inline TIM1_INPUT_CAPTURE_FILTER tim1_input_capture4_filter_read(void) {
  return (TIM1_INPUT_CAPTURE_FILTER)((TIM1->CCMR4 >> 4) & 0x0F);
}



/* TIM1 Capture/Compare Enable Register 1 (CCER1) */
typedef enum {
  TIM1_CC1 = 0,
  TIM1_CC2 = 4
} TIM1_CAPTURE_COMPARE_1_2_OUTPUT_ENABLE;

inline void tim1_capture_compare_1_2_output_enable(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_ENABLE cc_enable) {
  TIM1->CCER1 |= (1U << cc_enable);
}

inline void tim1_capture_compare_1_2_output_disable(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_ENABLE cc_enable) {
  TIM1->CCER1 &= ~(1U << cc_enable);
}

inline uint8_t tim1_capture_compare_1_2_output_is_enabled(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_ENABLE cc_enable) {
  return ((TIM1->CCER1 >> cc_enable) & 1);
}


typedef enum {
  TIM1_CC1_POLARITY = 1,
  TIM1_CC2_POLARITY = 5
} TIM1_CAPTURE_COMPARE_1_2_OUTPUT_POLARITY;

inline void tim1_capture_compare_1_2_output_polarity_high(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_POLARITY polarity) {
  TIM1->CCER1 &= ~(1U << polarity);
}

inline void tim1_capture_compare_1_2_output_polarity_low(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_POLARITY polarity) {
  TIM1->CCER1 |= (1U << polarity);
}

inline uint8_t tim1_capture_compare_1_2_output_polarity_is_high(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_POLARITY polarity) {
  return ((TIM1->CCER1 >> polarity) & 1) == 0;
}


typedef enum {
  TIM1_CC1_COMPLEMENTARY = 2,
  TIM1_CC2_COMPLEMENTARY = 6
} TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_ENABLE;

inline void tim1_capture_compare_1_2_complementary_output_enable(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
  TIM1->CCER1 |= (1U << cc_enable);
}

inline void tim1_capture_compare_1_2_complementary_output_disable(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
  TIM1->CCER1 &= ~(1U << cc_enable);
}

inline uint8_t tim1_capture_compare_1_2_complementary_output_is_enabled(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
  return ((TIM1->CCER1 >> cc_enable) & 1);
}


typedef enum {
  TIM1_CC1_COMPLEMENTARY_POLARITY = 3,
  TIM1_CC2_COMPLEMENTARY_POLARITY = 7
} TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_POLARITY;

inline void tim1_capture_compare_1_2_complementary_output_polarity_high(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
  TIM1->CCER1 &= ~(1U << polarity);
}

inline void tim1_capture_compare_1_2_complementary_output_polarity_low(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
  TIM1->CCER1 |= (1U << polarity);
}

inline uint8_t tim1_capture_compare_1_2_complementary_output_polarity_is_high(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
  return ((TIM1->CCER1 >> polarity) & 1) == 0;
}



/* TIM1 Capture/Compare Enable Register 2 (CCER2) */
typedef enum {
  TIM1_CC3 = 0,
  TIM1_CC4 = 4
} TIM1_CAPTURE_COMPARE_3_4_OUTPUT_ENABLE;

inline void tim1_capture_compare_3_4_output_enable(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_ENABLE cc_enable) {
  TIM1->CCER2 |= (1U << cc_enable);
}

inline void tim1_capture_compare_3_4_output_disable(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_ENABLE cc_enable) {
  TIM1->CCER2 &= ~(1U << cc_enable);
}

inline uint8_t tim1_capture_compare_3_4_output_is_enabled(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_ENABLE cc_enable) {
  return ((TIM1->CCER2 >> cc_enable) & 1);
}


typedef enum {
  TIM1_CC3_POLARITY = 1,
  TIM1_CC4_POLARITY = 5
} TIM1_CAPTURE_COMPARE_3_4_OUTPUT_POLARITY;

inline void tim1_capture_compare_3_4_output_polarity_high(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_POLARITY polarity) {
  TIM1->CCER2 &= ~(1U << polarity);
}

inline void tim1_capture_compare_3_4_output_polarity_low(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_POLARITY polarity) {
  TIM1->CCER2 |= (1U << polarity);
}

inline uint8_t tim1_capture_compare_3_4_output_polarity_is_high(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_POLARITY polarity) {
  return ((TIM1->CCER2 >> polarity) & 1) == 0;
} 


typedef enum {
  TIM1_CC3_COMPLEMENTARY = 2  
} TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_ENABLE;

inline void tim1_capture_compare_3_complementary_output_enable(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
  TIM1->CCER2 |= (1U << cc_enable);
}

inline void tim1_capture_compare_3_complementary_output_disable(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
  TIM1->CCER2 &= ~(1U << cc_enable);
}

inline uint8_t tim1_capture_compare_3_complementary_output_is_enabled(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
  return ((TIM1->CCER2 >> cc_enable) & 1);
}


typedef enum {
  TIM1_CC3_COMPLEMENTARY_POLARITY = 3  
} TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_POLARITY;

inline void tim1_capture_compare_3_complementary_output_polarity_high(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
  TIM1->CCER2 &= ~(1U << polarity);
}

inline void tim1_capture_compare_3_complementary_output_polarity_low(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
  TIM1->CCER2 |= (1U << polarity);
}

inline uint8_t tim1_capture_compare_3_complementary_output_polarity_is_high(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
  return ((TIM1->CCER2 >> polarity) & 1) == 0;
}



/* TIM1 Counter Register (CNTRH/CNTRL) */
inline void tim1_counter_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM1->CNTRH = (uint8_t)((value >> 8) & 0xFF);
  TIM1->CNTRL = (uint8_t)(value & 0xFF);
}

inline uint16_t tim1_counter_read(void) {
  // Read high byte first to automatically latch the low byte 
  uint8_t high_byte = TIM1->CNTRH; 
  uint8_t low_byte = TIM1->CNTRL;  
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM1 Prescaler Register (PSCRH/PSCRL) */
inline void tim1_prescaler_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM1->PSCRH = (uint8_t)((value >> 8) & 0xFF);
  TIM1->PSCRL = (uint8_t)(value & 0xFF);
}

inline uint16_t tim1_prescaler_read(void) {
  // Read high byte first to automatically latch the low byte 
  uint8_t high_byte = TIM1->PSCRH; 
  uint8_t low_byte = TIM1->PSCRL;  
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM1 Auto Reload Register (ARRH/ARRL) */
inline void tim1_auto_reload_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM1->ARRH = (uint8_t)((value >> 8) & 0xFF);
  TIM1->ARRL = (uint8_t)(value & 0xFF);
}

inline uint16_t tim1_auto_reload_read(void) {
  // Read high byte first to automatically latch the low byte 
  uint8_t high_byte = TIM1->ARRH; 
  uint8_t low_byte = TIM1->ARRL;  
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM1 Repetition Counter Register (RCR) */
inline void tim1_repetition_counter_write(uint8_t value) {
  TIM1->RCR = value;
}

inline uint8_t tim1_repetition_counter_read(void) {
  return TIM1->RCR;
}



/* TIM1 Capture/Compare Register 1 (CCR1H/CCR1L) */
inline void tim1_capture_compare1_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM1->CCR1H = (uint8_t)((value >> 8) & 0xFF);
  TIM1->CCR1L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim1_capture_compare1_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM1->CCR1H; 
  uint8_t low_byte = TIM1->CCR1L;  
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM1 Capture/Compare Register 2 (CCR2H/CCR2L) */
inline void tim1_capture_compare2_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM1->CCR2H = (uint8_t)((value >> 8) & 0xFF);
  TIM1->CCR2L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim1_capture_compare2_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM1->CCR2H; 
  uint8_t low_byte = TIM1->CCR2L;  
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM1 Capture/Compare Register 3 (CCR3H/CCR3L) */
inline void tim1_capture_compare3_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM1->CCR3H = (uint8_t)((value >> 8) & 0xFF);
  TIM1->CCR3L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim1_capture_compare3_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM1->CCR3H; 
  uint8_t low_byte = TIM1->CCR3L;  
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM1 Capture/Compare Register 4 (CCR4H/CCR4L) */
inline void tim1_capture_compare4_write(uint16_t value) {
  // Write high byte first to automatically latch the low byte
  TIM1->CCR4H = (uint8_t)((value >> 8) & 0xFF);
  TIM1->CCR4L = (uint8_t)(value & 0xFF);
}

inline uint16_t tim1_capture_compare4_read(void) {
  // Read high byte first to automatically latch the low byte
  uint8_t high_byte = TIM1->CCR4H; 
  uint8_t low_byte = TIM1->CCR4L;  
  return ((uint16_t)high_byte << 8) | low_byte;
}



/* TIM1 Break Register (BKR) */
typedef enum {
  TIM1_LOCK_LEVEL_OFF = 0,
  TIM1_LOCK_LEVEL_1   = 1,
  TIM1_LOCK_LEVEL_2   = 2,
  TIM1_LOCK_LEVEL_3   = 3
} TIM1_LOCK_CONTROL;

#define TIM1_LOCK_CONTROL_CLR_MASK 0xFC

inline void tim1_lock_control_set(TIM1_LOCK_CONTROL lock) {
  TIM1->BKR = (TIM1->BKR & TIM1_LOCK_CONTROL_CLR_MASK) | lock;
}

inline TIM1_LOCK_CONTROL tim1_lock_control_read(void) {
  return (TIM1_LOCK_CONTROL)(TIM1->BKR & 0x03);
}


typedef enum {
    TIM1_OSSI_OUTPUTS_DISABLED = 0,
    TIM1_OSSI_OUTPUTS_IDLE_STATE = 1
} TIM1_OFF_STATE_IDLE_MODE;

inline void tim1_off_state_idle_mode_set(TIM1_OFF_STATE_IDLE_MODE mode) {
  TIM1->BKR = (TIM1->BKR & ~(1U << 2)) | (mode << 2);
}


typedef enum {
    TIM1_OSSR_OUTPUTS_DISABLED = 0,
    TIM1_OSSR_OUTPUTS_IDLE_STATE = 1
} TIM1_OFF_STATE_RUN_MODE;

inline void tim1_off_state_run_mode_set(TIM1_OFF_STATE_RUN_MODE mode) {
  TIM1->BKR = (TIM1->BKR & ~(1U << 3)) | (mode << 3);
}


inline void tim1_break_input_enable(void) {
  TIM1->BKR |= (1U << 4);
}

inline void tim1_break_input_disable(void) {
  TIM1->BKR &= ~(1U << 4);
}


inline void tim1_break_input_polarity_high(void) {
  TIM1->BKR |= (1U << 5);
}

inline void tim1_break_input_polarity_low(void) {
  TIM1->BKR &= ~(1U << 5);
}


inline void tim1_automatic_output_enable(void) {
  TIM1->BKR |= (1U << 6);
}

inline void tim1_automatic_output_disable(void) {
  TIM1->BKR &= ~(1U << 6);
}


inline void tim1_main_output_enable(void) {
  TIM1->BKR |= (1U << 7);
}

inline void tim1_main_output_disable(void) {
  TIM1->BKR &= ~(1U << 7);
}



/* TIM1 Dead Time Register (DTR) */
inline void tim1_dead_time_set(uint8_t dead_time) {
  TIM1->DTR = dead_time;
}

inline uint8_t tim1_dead_time_read(void) {
  return TIM1->DTR;
}



/* TIM1 Output Idle State Register (OISR) */
typedef enum {
    TIM1_IDLE_STATE_LOW  = 0,
    TIM1_IDLE_STATE_HIGH = 1
} TIM1_IDLE_STATE;

typedef enum {
    TIM1_CHANNEL_1  = 0,
    TIM1_CHANNEL_1N = 1,
    TIM1_CHANNEL_2  = 2,
    TIM1_CHANNEL_2N = 3,
    TIM1_CHANNEL_3  = 4,
    TIM1_CHANNEL_3N = 5,    
    TIM1_CHANNEL_4  = 6
} TIM1_OUTPUT_COMPARE_CHANNEL;

inline void tim1_output_compare_idle_state_set(TIM1_OUTPUT_COMPARE_CHANNEL channel, TIM1_IDLE_STATE state) {
  TIM1->OISR = (TIM1->OISR & ~(1U << channel)) | ((uint8_t)state << channel);
}

#endif