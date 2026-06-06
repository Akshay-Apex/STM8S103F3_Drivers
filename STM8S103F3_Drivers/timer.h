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

#define TIM1 ((TIM1_REG *)0x5250) // Base address binding of TIM1 registers

#endif