d#ifndef CLK_H
#define CLK_H

#include <stdint.h>

/* Register Definitions */
#define CLK_ICKR    (*(volatile uint8_t *)0x50C0) // Internal clock control register
#define CLK_ECKR    (*(volatile uint8_t *)0x50C1) // External clock control register
#define CLK_CMSR    (*(volatile uint8_t *)0x50C3) // Clock master status register
#define CLK_SWR     (*(volatile uint8_t *)0x50C4) // Clock master switch register
#define CLK_CKDIVR  (*(volatile uint8_t *)0x50C6) // Clock divider register

/* HSI Divider Values */
#define CLK_HSI_DIV_1 0x00
#define CLK_HSI_DIV_2 0x01
#define CLK_HSI_DIV_4 0x02
#define CLK_HSI_DIV_8 0x03

/* CPU Divider Values */
#define CLK_CPU_DIV_1   0x00
#define CLK_CPU_DIV_2   0x01
#define CLK_CPU_DIV_4   0x02
#define CLK_CPU_DIV_8   0x03
#define CLK_CPU_DIV_16  0x04
#define CLK_CPU_DIV_32  0x05
#define CLK_CPU_DIV_64  0x06
#define CLK_CPU_DIV_128 0x07

#define CLK_HSI_POSITION    3
#define CLK_CKDIVR_CLR_MASK 0xF8

/* Clock master source status register values */
#define CLK_MASTER_HSI 0xE1
#define CLK_MASTER_LSI 0xD2
#define CLK_MASTER_HSE 0xB4


/* Main voltage regulator (MVR) */
static inline void clk_active_halt_mvr_enable(void) {
  CLK_ICKR &= ~(1U << 5);
}

static inline void clk_active_halt_mvr_disable(void) {
  CLK_ICKR |= (1U << 5);
}

static inline uint8_t clk_is_active_halt_mvr_enabled(void) {
  return !((CLK_ICKR >> 5) & 1);
}



/* Low speed internal oscillator ready */
static inline uint8_t clk_is_lsi_osc_ready(void) {
  return ((CLK_ICKR >> 4) & 1);
}

/* Low speed internal RC oscillator enable */
static inline uint8_t clk_is_lsi_osc_enabled(void) {
  return ((CLK_ICKR >> 3) & 1);
}

static inline void clk_lsi_osc_enable(void) {
  CLK_ICKR |= (1U << 3);
}

static inline void clk_lsi_osc_disable(void) {
  CLK_ICKR &= ~(1U << 3);
}



/* Fast wakeup from Halt/Active-halt modes (FHWU) */
static inline uint8_t clk_is_fast_hlt_wake_up_enabled(void) {
  return ((CLK_ICKR >> 2) & 1);
}

static inline void clk_fast_hlt_wake_up_enable(void) {
  CLK_ICKR |= (1U << 2);
}

static inline void clk_fast_hlt_wake_up_disable(void) {
  CLK_ICKR &= ~(1U << 2);
}



/* High speed internal oscillator ready */
static inline uint8_t clk_is_hsi_osc_ready(void) {
  return ((CLK_ICKR >> 1) & 1);
}

/* High speed internal RC oscillator enable */
static inline uint8_t clk_is_hsi_osc_enabled(void) {
  return ((CLK_ICKR >> 0) & 1);
}

static inline void clk_hsi_osc_enable(void) {
  CLK_ICKR |= (1U << 0);
}

static inline void clk_hsi_osc_disable(void) {
  CLK_ICKR &= ~(1U << 0);
}



/* High speed external crystal oscillator ready */
static inline uint8_t clk_is_hse_osc_ready(void) {
  return ((CLK_ECKR >> 1) & 1);
}

static inline void clk_hse_osc_enable(void) {
  CLK_ECKR |= (1U << 0);
}

static inline void clk_hse_osc_disable(void) {
  CLK_ECKR &= ~(1U << 0);
}



/* Clock master status bits */
static inline uint8_t clk_get_master_clock_source(void) {
  return CLK_CMSR;
}



/* Clock master switch register */
// Pending from here so delete this comment when work resumes

static inline void clk_set_hsi_and_cpu_div(uint8_t hsi_div_value, uint8_t cpu_div_value) {
  CLK_CKDIVR = (hsi_div_value << CLK_HSI_POSITION) | cpu_div_value;
}

static inline void clk_set_cpu_div(uint8_t cpu_div_value) {
  CLK_CKDIVR = (CLK_CKDIVR & CLK_CKDIVR_CLR_MASK) | cpu_div_value;
}




#endif