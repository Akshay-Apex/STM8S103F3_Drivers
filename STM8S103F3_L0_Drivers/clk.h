/**
 * @file clk.h
 * @brief STM8S103F3 clock driver.
 *
 * @details Provides an API for configuring and controlling the STM8S103F3
 *          Clock peripheral.
 */

#ifndef CLK_H
#define CLK_H

#include <stdint.h>

/* Clock Register Definitions */
typedef struct {
  volatile uint8_t ICKR;     // Internal clock control register
  volatile uint8_t ECKR;     // External clock control register
  volatile uint8_t RESERVED_0;
  volatile uint8_t CMSR;     // Clock master status register
  volatile uint8_t SWR;      // Clock master switch register
  volatile uint8_t SWCR;     // Clock switch control register
  volatile uint8_t CKDIVR;   // Clock divider register
  volatile uint8_t PCKENR1;  // Peripheral clock gating register 1
  volatile uint8_t CSSR;     // Clock security system register
  volatile uint8_t CCOR;     // Configurable clock control register
  volatile uint8_t PCKENR2;  // Peripheral clock gating register 2
  volatile uint8_t RESERVED_1;  
  volatile uint8_t HSITRIMR; // HSI clock calibration trimming
  volatile uint8_t SWIMCCR;  // SWIM clock control register
} CLK_REG;

#define CLK ((CLK_REG *)0x50C0) // Base address binding of clock registers


/*=============================================================*
* 
* Clock Public API Declarations BEGIN 
*
*=============================================================*/

/* Global Variable and Constant Declarations */
extern uint16_t HSE_OSC_FREQ_KHZ;

uint16_t clk_fmaster_freq_khz_get(void);

/* Clock Master Source Selection and Comparision Constants */
typedef enum {
  CLK_MASTER_SRC_HSI = 0xE1,
  CLK_MASTER_SRC_LSI = 0xD2,
  CLK_MASTER_SRC_HSE = 0xB4
} CLK_MASTER_SRC;

void clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC src);

/*=============================================================*
 * Clock Public API Declarations END
 *=============================================================*/


/* Main voltage regulator (MVR) */
inline void clk_active_halt_mvr_enable(void) {
  CLK->ICKR &= ~(1U << 5);
}

inline void clk_active_halt_mvr_disable(void) {
  CLK->ICKR |= (1U << 5);
}

inline uint8_t clk_active_halt_mvr_is_enabled(void) {
  return !((CLK->ICKR >> 5) & 1);
}



/* Low speed internal oscillator ready */
inline uint8_t clk_lsi_osc_is_ready(void) {
  return ((CLK->ICKR >> 4) & 1);
}

/* Low speed internal RC oscillator enable */
inline uint8_t clk_lsi_osc_is_enabled(void) {
  return ((CLK->ICKR >> 3) & 1);
}

inline void clk_lsi_osc_enable(void) {
  CLK->ICKR |= (1U << 3);
}

inline void clk_lsi_osc_disable(void) {
  CLK->ICKR &= ~(1U << 3);
}



/* Fast wakeup from Halt/Active-halt modes (FHWU) */
inline uint8_t clk_fast_hlt_wake_up_is_enabled(void) {
  return ((CLK->ICKR >> 2) & 1);
}

inline void clk_fast_hlt_wake_up_enable(void) {
  CLK->ICKR |= (1U << 2);
}

inline void clk_fast_hlt_wake_up_disable(void) {
  CLK->ICKR &= ~(1U << 2);
}



/* High speed internal oscillator ready */
inline uint8_t clk_hsi_osc_is_ready(void) {
  return ((CLK->ICKR >> 1) & 1);
}

/* High speed internal RC oscillator enable */
inline uint8_t clk_hsi_osc_is_enabled(void) {
  return ((CLK->ICKR >> 0) & 1);
}

inline void clk_hsi_osc_enable(void) {
  CLK->ICKR |= (1U << 0);
}

inline void clk_hsi_osc_disable(void) {
  CLK->ICKR &= ~(1U << 0);
}



/* High speed external crystal oscillator ready */
inline uint8_t clk_hse_osc_is_ready(void) {
  return ((CLK->ECKR >> 1) & 1);
}

inline void clk_hse_osc_enable(uint16_t hse_osc_crystal_freq) {
  HSE_OSC_FREQ_KHZ = hse_osc_crystal_freq;
  CLK->ECKR |= (1U << 0);
}

inline void clk_hse_osc_disable(void) {
  CLK->ECKR &= ~(1U << 0);
}



/* Clock master status register (CLK_CMSR) */
inline CLK_MASTER_SRC clk_master_get_source(void) {
  return (CLK_MASTER_SRC)CLK->CMSR;
}

/* Clock master switch register (CLK_SWR) */
inline void clk_master_switch_src(CLK_MASTER_SRC src) {
  CLK->SWR = src;
}

/* Switch control register (CLK_SWCR) */
inline uint8_t clk_switch_is_ongoing(void) {
  return ((CLK->SWCR >> 0) & 1);
}

inline void clk_switch_process_reset(void) {
  CLK->SWCR &= ~(1U << 0);
}

inline void clk_switch_exec_enable(void) {
  CLK->SWCR |= (1U << 1);
}

inline void clk_switch_exec_disable(void) {
  CLK->SWCR &= ~(1U << 1);
}

inline void clk_switch_irq_enable(void) {
  CLK->SWCR |= (1U << 2);
}

inline void clk_switch_irq_disable(void) {
  CLK->SWCR &= ~(1U << 2);
}

inline uint8_t clk_target_src_clk_ready_manual_mode(void) {
  return ((CLK->SWCR >> 3) & 1) ;
}

inline uint8_t clk_switch_event_occured_auto_mode(void) {
  return ((CLK->SWCR >> 3) & 1) ;
}

inline void clk_switch_irq_flag_clear(void) {
  CLK->SWCR &= ~(1U << 3);
}




/* Clock divider register (CLK_CKDIVR) */
/* CPU Divider Values */
typedef enum {
  CLK_CPU_DIV_1   = 0,
  CLK_CPU_DIV_2   = 1,
  CLK_CPU_DIV_4   = 2,
  CLK_CPU_DIV_8   = 3,
  CLK_CPU_DIV_16  = 4,
  CLK_CPU_DIV_32  = 5,
  CLK_CPU_DIV_64  = 6,
  CLK_CPU_DIV_128 = 7
} CPU_DIV_PRESCALAR;

#define CLK_CKDIVR_CPU_CLR_MASK 0xF8

inline void clk_cpu_div_prescalar_set(CPU_DIV_PRESCALAR value) {
  CLK->CKDIVR = ((CLK->CKDIVR & CLK_CKDIVR_CPU_CLR_MASK) | ((uint8_t)value) << 0);
}

inline CPU_DIV_PRESCALAR clk_cpu_div_prescalar_read(void) {
  return ((CPU_DIV_PRESCALAR)(CLK->CKDIVR & ~(CLK_CKDIVR_CPU_CLR_MASK)));
}


/* HSI Divider Values */
typedef enum {
  CLK_HSI_DIV_1 = 0,
  CLK_HSI_DIV_2 = 1,
  CLK_HSI_DIV_4 = 2,
  CLK_HSI_DIV_8 = 3
} HSI_DIV_PRESCALAR;

#define CLK_CKDIVR_HSI_CLR_MASK 0xE7

inline void clk_hsi_div_prescalar_set(HSI_DIV_PRESCALAR value) {
  CLK->CKDIVR = (CLK->CKDIVR & CLK_CKDIVR_HSI_CLR_MASK) | ((uint8_t)value << 3);
}

inline HSI_DIV_PRESCALAR clk_hsi_div_prescalar_read(void) {
  return ((HSI_DIV_PRESCALAR)(CLK->CKDIVR & ~(CLK_CKDIVR_HSI_CLR_MASK)));
}

inline void  clk_hsi_and_cpu_div_prescalar_set(HSI_DIV_PRESCALAR hsi_value, CPU_DIV_PRESCALAR cpu_value) {
  CLK->CKDIVR = (CLK->CKDIVR & (CLK_CKDIVR_HSI_CLR_MASK & CLK_CKDIVR_CPU_CLR_MASK)) 
                  | ((((uint8_t)hsi_value << 3) | ((uint8_t)cpu_value) << 0));
}



/* Peripheral clock gating register 1 (CLK_PCKENR1) */
/* Peripheral clock gating bit assignments in CLK_PCKENR1/2 registers */
typedef enum {
  CLK_I2C   = 0,
  CLK_SPI   = 1,
  CLK_UART1 = 3,
  CLK_TIM4  = 4,
  CLK_TIM2  = 5,
  CLK_TIM1  = 7
} PERIPHERAL_1_CLK;

inline void clk_peripheral_1_clock_enable(PERIPHERAL_1_CLK periph) {
  CLK->PCKENR1 |= (1U << periph);
}

inline void clk_peripheral_1_clock_disable(PERIPHERAL_1_CLK periph) {
  CLK->PCKENR1 &= ~(1U << periph);
}

typedef enum {
  AWU = 2,
  ADC = 3  
} PERIPHERAL_2_CLK;

inline void clk_peripheral_2_clock_enable(PERIPHERAL_2_CLK periph) {
  CLK->PCKENR2 |= (1U << periph);
}

inline void clk_peripheral_2_clock_disable(PERIPHERAL_2_CLK periph) {
  CLK->PCKENR2 &= ~(1U << periph);
}



/* Clock security system register (CLK_CSSR) */
inline void clk_security_sys_enable(void) {
  CLK->CSSR |= (1U << 0);
}

inline void clk_security_sys_disable(void) {
  CLK->CSSR &= ~(1U << 0);
}

inline uint8_t clk_aux_clock_is_active(void) {
  return ((CLK->CSSR >> 1) & 1);
}

inline void clk_security_sys_irq_enable(void) {
  CLK->CSSR |= (1U << 2);
}

inline void clk_security_sys_irq_disable(void) {
  CLK->CSSR &= ~(1U << 2);
}

inline uint8_t clk_hse_clock_disturbance_is_detected(void) {
  return ((CLK->CSSR >> 3) & 1);
}

inline void clk_hse_clock_disturbance_detect_reg_clear(void) {
  CLK->CSSR &= ~(1U << 3);
}



/* Configurable clock output register (CLK_CCOR) */
inline void clk_configurable_clock_output_enable(void) {
  CLK->CCOR |= (1U << 0);
}

inline void clk_configurable_clock_output_disable(void) {
  CLK->CCOR &= ~(1U << 0);
}

/* Configurable clock output selection */
typedef enum {
  CLK_CCO_HSIDIV      = 0,
  CLK_CCO_LSI         = 1,
  CLK_CCO_HSE         = 2,
  CLK_CCO_CPU         = 4,
  CLK_CCO_CPU_DIV_2   = 5,
  CLK_CCO_CPU_DIV_4   = 6,
  CLK_CCO_CPU_DIV_8   = 7,
  CLK_CCO_CPU_DIV_16  = 8,
  CLK_CCO_CPU_DIV_32  = 9,
  CLK_CCO_CPU_DIV_64  = 10,
  CLK_CCO_HSI         = 11,
  CLK_CCO_MASTER      = 12
} CLK_CCO_SOURCE;

inline void clk_output_source_set(CLK_CCO_SOURCE source) {
    CLK->CCOR = (CLK->CCOR & ~(0x0F << 1)) | ((uint8_t)source << 1);
}

inline uint8_t clk_configurable_clock_output_is_ready(void) {
    return ((CLK->CCOR >> 5) & 1);
}

inline uint8_t clk_configurable_clock_output_src_is_switching(void) {
    return ((CLK->CCOR >> 6) & 1);
}



/* HSI clock calibration trimming register (CLK_HSITRIMR) */
#define CLK_HSI_TRIM_CLR_MASK 0xF8 

inline void clk_hsi_osc_trim_value_set(uint8_t trim_val) {
  CLK->HSITRIMR = ((CLK->HSITRIMR & CLK_HSI_TRIM_CLR_MASK) | (trim_val & 0x07));
}



/* SWIM clock control register (CLK_SWIMCCR) */
inline void clk_swim_clock_div2_enable(void) {
  CLK->SWIMCCR &= ~(1U << 0);
}

inline void clk_swim_clock_div2_disable(void) {
  CLK->SWIMCCR |= (1U << 0);
}


#endif