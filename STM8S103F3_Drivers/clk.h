d#ifndef CLK_H
#define CLK_H

#include <stdint.h>

/* Register Definitions */
#define CLK_ICKR (*(volatile uint8_t *)0x50C0) // Internal clock control register
#define CLK_ECKR (*(volatile uint8_t *)0x50C1) // External clock control register
#define CLK_CKDIVR (*(volatile uint8_t *)0x50C6) // Clock divider register

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



/* Main voltage regulator (MVR) */
// static inline void clk_set_main_volt_regu();


static inline void clk_set_hsi_and_cpu_div(uint8_t hsi_div_value, uint8_t cpu_div_value) {
  CLK_CKDIVR = (hsi_div_value << CLK_HSI_POSITION) | cpu_div_value;
}

static inline void clk_set_cpu_div(uint8_t cpu_div_value) {
  CLK_CKDIVR = (CLK_CKDIVR & CLK_CKDIVR_CLR_MASK) | cpu_div_value;
}

static inline uint8_t clk_is_hse_ready(void) {
  return (CLK_ECKR >> 1) & 1;
}


#endif