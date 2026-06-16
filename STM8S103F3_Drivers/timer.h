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
  volatile uint8_t PSCR;  // IM2 prescaler register
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

typedef enum {
  TIM2_CC1_OUTPUT    = 0x00,
  TIM2_CC1_INPUT_TI1 = 0x01,
  TIM2_CC1_INPUT_TI2 = 0x02  
} TIM2_CC1_Channel_Mode;

#define TIM2_CC1_CHANNEL_MODE_CLR_MASK 0xFC

typedef enum {
    TIM2_OC1_FROZEN            = 0x00,
    TIM2_OC1_ACTIVE_ON_MATCH   = 0x01,
    TIM2_OC1_INACTIVE_ON_MATCH = 0x02,
    TIM2_OC1_TOGGLE            = 0x03,
    TIM2_OC1_FORCE_INACTIVE    = 0x04,
    TIM2_OC1_FORCE_ACTIVE      = 0x05,
    TIM2_OC1_PWM_MODE_1        = 0x06,
    TIM2_OC1_PWM_MODE_2        = 0x07
} TIM2_OUTPUT_COMPARE1_MODE;

typedef enum {
    TIM2_IC1_PRESCALER_1 = 0x00,  // Capture every event
    TIM2_IC1_PRESCALER_2 = 0x01,  // Capture every 2 events
    TIM2_IC1_PRESCALER_4 = 0x02,  // Capture every 4 events
    TIM2_IC1_PRESCALER_8 = 0x03   // Capture every 8 events
} TIM2_INPUT_CAPTURE1_PRESCALER;

typedef enum {
    TIM2_IC1_FILTER_NONE    = 0x00,
    TIM2_IC1_FILTER_FM_N2   = 0x01,
    TIM2_IC1_FILTER_FM_N4   = 0x02,
    TIM2_IC1_FILTER_FM_N8   = 0x03,

    TIM2_IC1_FILTER_FM2_N6  = 0x04,
    TIM2_IC1_FILTER_FM2_N8  = 0x05,

    TIM2_IC1_FILTER_FM4_N6  = 0x06,
    TIM2_IC1_FILTER_FM4_N8  = 0x07,

    TIM2_IC1_FILTER_FM8_N6  = 0x08,
    TIM2_IC1_FILTER_FM8_N8  = 0x09,

    TIM2_IC1_FILTER_FM16_N5 = 0x0A,
    TIM2_IC1_FILTER_FM16_N6 = 0x0B,
    TIM2_IC1_FILTER_FM16_N8 = 0x0C,

    TIM2_IC1_FILTER_FM32_N5 = 0x0D,
    TIM2_IC1_FILTER_FM32_N6 = 0x0E,
    TIM2_IC1_FILTER_FM32_N8 = 0x0F
} TIM2_INPUT_CAPTURE1_FILTER;

/* TIM4 Timer Functions */
/* TIM4 control register 1 (CR1) */
static inline void tim4_counter_enable(void) {
  TIM4->CR1 |= (1U << 0);
}

static inline void tim4_counter_disable(void) {
  TIM4->CR1 &= ~(1U << 0);
} 

static inline void tim4_auto_update_event_enable(void) {
  TIM4->CR1 &= ~(1U << 1);
}

static inline void tim4_auto_update_event_disable(void) {
  TIM4->CR1 |= (1U << 1);
}

static inline void tim4_update_req_src_any_event_set(void) {
  TIM4->CR1 &= ~(1U << 2);
}

static inline void tim4_update_req_src_overflow_underflow_only_set(void) {
  TIM4->CR1 |= (1U << 2);
}

static inline void tim4_one_pulse_mode_enable(void) {
  TIM4->CR1 |= (1U << 3);
}

static inline void tim4_one_pulse_mode_disable(void) {
  TIM4->CR1 &= ~(1U << 3);
}

static inline void tim4_auto_reload_preload_enable(void) {
  TIM4->CR1 |= (1U << 7);
}

static inline void tim4_auto_reload_preload_disable(void) {
  TIM4->CR1 &= ~(1U << 7);
}



/* TIM4 interrupt enable register (IER) */
static inline void tim4_update_irq_enable(void) {
  TIM4->IER |= (1U << 0);
}

static inline void tim4_update_irq_disable(void) {
  TIM4->IER &= ~(1U << 0);
}



/* TIM4 status register (SR) */
static inline void tim4_update_irq_flag_clear(void) {
  TIM4->SR &= ~(1U << 0);
}

static inline uint8_t tim4_update_irq_flag_read(void) {
  return ((TIM4->SR >> 0) & 1);
}



/* TIM4 event generation register (EGR) */
static inline void tim4_update_event_generate(void) {
  TIM4->EGR |= (1U << 0);
}



/* TIM4 counter (CNTR) */
static inline void tim4_counter_write(uint8_t value) {
  TIM4->CNTR = value;    
}

static inline uint8_t tim4_counter_read(void) {
  return TIM4->CNTR;
}



/* TIM4 prescaler register (PSCR) */
static inline void tim4_prescaler_set(uint8_t value) {
  TIM4->PSCR = value & 0x0F;
}

static inline uint8_t tim4_prescalar_read(void) {
  return TIM4->PSCR;
}



/* TIM4 auto-reload register (ARR) */
static inline void tim4_auto_reload_set(uint8_t value) {
  TIM4->ARR = value;
}

static inline uint8_t tim4_auto_reload_read(void) {
  return TIM4->ARR;
}



/* TIM2 Timer Functions */
/* TIM2 control register 1 (CR1) */
static inline void tim2_counter_enable(void) {
  TIM2->CR1 |= (1U << 0);
}

static inline void tim2_counter_disable(void) {
  TIM2->CR1 &= ~(1U << 0);
}

static inline void tim2_auto_update_event_enable(void) {
  TIM2->CR1 &= ~(1U << 1);
}

static inline void tim2_auto_update_event_disable(void) {
  TIM2->CR1 |= (1U << 1);
}

static inline void tim2_update_req_src_any_event_set(void) {
  TIM2->CR1 &= ~(1U << 2);
}

static inline void tim2_update_req_src_overflow_underflow_only_set(void) {
  TIM2->CR1 |= (1U << 2);
}

static inline void tim2_one_pulse_mode_enable(void) {
  TIM2->CR1 |= (1U << 3);
}

static inline void tim2_one_pulse_mode_disable(void) {
  TIM2->CR1 &= ~(1U << 3);
}

static inline void tim2_auto_reload_preload_enable(void) {
  TIM2->CR1 |= (1U << 7);
}

static inline void tim2_auto_reload_preload_disable(void) {
  TIM2->CR1 &= ~(1U << 7);
}



/* TIM2 interrupt enable register (IER) */
static inline void tim2_update_irq_enable(void) {
  TIM2->IER |= (1U << 0);
}

static inline void tim2_update_irq_disable(void) {
  TIM2->IER &= ~(1U << 0);
}

static inline void tim2_capture_compare1_irq_enable(void) {
  TIM2->IER |= (1U << 1);
}

static inline void tim2_capture_compare1_irq_disable(void) {
  TIM2->IER &= ~(1U << 1);
}

static inline void tim2_capture_compare2_irq_enable(void) {
  TIM2->IER |= (1U << 2);
}

static inline void tim2_capture_compare2_irq_disable(void) {
  TIM2->IER &= ~(1U << 2);
}

static inline void tim2_capture_compare3_irq_enable(void) {
  TIM2->IER |= (1U << 3);
}

static inline void tim2_capture_compare3_irq_disable(void) {
  TIM2->IER &= ~(1U << 3);
}



/* TIM2 status register 1 (SR1) */
static inline void tim2_update_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 0);
}

static inline uint8_t tim2_update_irq_flag_read(void) {
  return ((TIM2->SR1 >> 0) & 1);
}

static inline void tim2_capture_compare1_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 1);
}

static inline uint8_t tim2_capture_compare1_irq_flag_read(void) {
  return ((TIM2->SR1 >> 1) & 1);
}

static inline void tim2_capture_compare2_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 2);
}

static inline uint8_t tim2_capture_compare2_irq_flag_read(void) {
  return ((TIM2->SR1 >> 2) & 1);
}

static inline void tim2_capture_compare3_irq_flag_clear(void) {
  TIM2->SR1 &= ~(1U << 3);
}

static inline uint8_t tim2_capture_compare3_irq_flag_read(void) {
  return ((TIM2->SR1 >> 3) & 1);
}


/* TIM2 status register 2 (SR2) */
static inline void tim2_capture_compare1_overcapture_flag_clear(void) {
  TIM2->SR2 &= ~(1U << 1);
}

static inline uint8_t tim2_capture_compare1_overcapture_flag_read(void) {
  return ((TIM2->SR2 >> 1) & 1);
}

static inline void tim2_capture_compare2_overcapture_flag_clear(void) {
  TIM2->SR2 &= ~(1U << 2);
}

static inline uint8_t tim2_capture_compare2_overcapture_flag_read(void) {
  return ((TIM2->SR2 >> 2) & 1);
}

static inline void tim2_capture_compare3_overcapture_flag_clear(void) {
  TIM2->SR2 &= ~(1U << 3);
}

static inline uint8_t tim2_capture_compare3_overcapture_flag_read(void) {
  return ((TIM2->SR2 >> 3) & 1);
}



/* TIM2 event generation register (EGR) */
static inline void tim2_update_event_generate(void) {
  TIM2->EGR |= (1U << 0);
}

static inline void tim2_capture_compare1_event_generate(void) {
  TIM2->EGR |= (1U << 1);
}

static inline void tim2_capture_compare2_event_generate(void) {
  TIM2->EGR |= (1U << 2);
}

static inline void tim2_capture_compare3_event_generate(void) {
  TIM2->EGR |= (1U << 3);
}



/* TIM2 Capture/Compare mode register 1 (CCMR1) */
/* Generic Functions */
static inline void tim2_capture_compare1_channel_mode_set(TIM2_CC1_Channel_Mode mode) {
  TIM2->CCMR1 = (TIM2->CCMR1 & TIM2_CC1_CHANNEL_MODE_CLR_MASK) | mode;
}

static inline TIM2_CC1_Channel_Mode tim2_capture_compare1_channel_mode_read(void) {
  return (TIM2_CC1_Channel_Mode)(TIM2->CCMR1 & ~TIM2_CC1_CHANNEL_MODE_CLR_MASK);
}

/* Output mode functions */
static inline void tim2_capture_compare1_preload_enable(void) {
  TIM2->CCMR1 |= (1U << 3);
}

static inline void tim2_capture_compare1_preload_disable(void) {
  TIM2->CCMR1 &= ~(1U << 3);
}

static inline void tim2_output_compare1_mode_set(TIM2_OUTPUT_COMPARE1_MODE mode) {
  TIM2->CCMR1 = (TIM2->CCMR1 & 0x8F) | ((uint8_t)mode << 4);
}

static inline TIM2_OUTPUT_COMPARE1_MODE tim2_output_compare1_mode_read(void) {
  return (TIM2_OUTPUT_COMPARE1_MODE)((TIM2->CCMR1 >> 4) & 0x07);
}

/* Input mode functions */

static inline void tim2_input_capture1_prescaler_set(TIM2_INPUT_CAPTURE1_PRESCALER psc) {
  TIM2->CCMR1 = (TIM2->CCMR1 & 0xF3) | ((uint8_t)psc << 2);
}

static inline TIM2_INPUT_CAPTURE1_PRESCALER tim2_input_capture1_prescaler_read(void) {
  return (TIM2_INPUT_CAPTURE1_PRESCALER)((TIM2->CCMR1 >> 2) & 0x03));
}

static inline void tim2_input_capture1_filter_set(TIM2_INPUT_CAPTURE1_FILTER filter) {
  TIM2->CCMR1 = (TIM2->CCMR1 & 0x0F) | ((uint8_t)filter << 4);
}

static inline TIM2_INPUT_CAPTURE1_FILTER tim2_input_capture1_filter_read(void) {
  return (TIM2_INPUT_CAPTURE1_FILTER)(TIM2->CCMR1 >> 4) & 0x0F;
}


#endif