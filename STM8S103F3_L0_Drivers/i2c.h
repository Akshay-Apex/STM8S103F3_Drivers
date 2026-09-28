#ifndef I2C_H
#define I2C_H

#include <stdint.h>
#include <stdbool.h>

/* I2C Register Definitions */
typedef struct {
  volatile uint8_t CR1;       // I2C control register 1
  volatile uint8_t CR2;       // I2C control register 2
  volatile uint8_t FREQR;     // I2C frequency register
  volatile uint8_t OARL;      // I2C Own address register low
  volatile uint8_t OARH;      // I2C Own address register high
  volatile uint8_t RESERVED; 
  volatile uint8_t DR;        // I2C data register
  volatile uint8_t SR1;       // I2C status register 1
  volatile uint8_t SR2;       // I2C status register 2
  volatile uint8_t SR3;       // I2C status register 3
  volatile uint8_t ITR;       // I2C interrupt control register
  volatile uint8_t CCRL;      // I2C Clock control register low
  volatile uint8_t CCRH;      // I2C Clock control register high
  volatile uint8_t TRISER;    // I2C TRISE register
  volatile uint8_t PECR;      // I2C packet error checking register
} I2C_REG;

#define I2C ((I2C_REG *)0x5210) // Base address binding of I2C registers


/* I2C control register 1 (CR1) */
inline void i2c_peripheral_enable(void) {
  I2C->CR1 |= (1U << 0);
}

inline void i2c_peripheral_disable(void) {
  I2C->CR1 &= ~(1U << 0);
}


inline void i2c_general_call_enable(void) {
  I2C->CR1 |= (1U << 6);
}

inline void i2c_general_call_disable(void) {
  I2C->CR1 &= ~(1U << 6);
}


inline void i2c_slave_mode_clock_stretching_enable(void) {
  I2C->CR1 &= ~(1U << 7);
}

inline void i2c_slave_mode_clock_stretching_disable(void) {
  I2C->CR1 |= (1U << 7);
}



/* I2C control register 2 (CR2) */
inline void i2c_start_generation_enable(void) {
  I2C->CR2 |= (1U << 0);
}

inline void i2c_start_generation_disable(void) {
  I2C->CR2 &= ~(1U << 0);
}


inline void i2c_stop_generation_disable(void) {
  I2C->CR2 &= ~(1U << 1);
}

inline void i2c_stop_generation_enable(void) {
  I2C->CR2 |= (1U << 1);
}


inline void i2c_acknowledge_enable(void) {
  I2C->CR2 |= (1U << 2);
}

inline void i2c_acknowledge_disable(void) {
  I2C->CR2 &= ~(1U << 2);
}


/* @Note: For Data Reception */
inline void i2c_acknowledge_position_next_byte(void) {
  I2C->CR2 |= (1U << 3);
}

inline void i2c_acknowledge_position_current_byte(void) {
  I2C->CR2 &= ~(1U << 3);
}


inline void i2c_software_reset_enter(void) {
  I2C->CR2 |= (1U << 7);
}

inline void i2c_software_reset_exit(void) {
  I2C->CR2 &= ~(1U << 7);
}



/* I2C frequency register (FREQR) */
/* @Note: The minimum peripheral clock frequencies for respecting the I2C bus timings are:
 * 1 MHz for standard mode and 4 MHz for fast mode 
 */
inline void i2c_peripheral_clock_frequency_set(uint8_t fmaster_freq_mhz) {
  I2C->FREQR = fmaster_freq_mhz; 
}



/* I2C Own address register low/high (OARL/OARH) */
#define I2C_10BIT_ADDRESS_LOW_MASK  0xFF
#define I2C_10BIT_ADDRESS_HIGH_MASK 0x06

#define I2C_7BIT_ADDRESS_MODE_MASK  0x40 
#define I2C_10BIT_ADDRESS_MODE_MASK 0xC0

inline void i2c_interface_address_7_bit_mode_set(uint8_t address) {
  I2C->OARL = (address << 1);
  I2C->OARH = I2C_7BIT_ADDRESS_MODE_MASK;
}

inline void i2c_interface_address_10_bit_mode_set(uint16_t address) {
  I2C->OARL = (address & I2C_10BIT_ADDRESS_LOW_MASK);
  I2C->OARH = (I2C->OARH & ~(I2C_10BIT_ADDRESS_HIGH_MASK)) | 
              ((address >> 7) & I2C_10BIT_ADDRESS_HIGH_MASK) |
              I2C_10BIT_ADDRESS_MODE_MASK;
}



/* I2C data register (DR) */
inline void i2c_data_register_write(uint8_t data) {
  I2C->DR = data;
}

inline uint8_t i2c_data_register_read(void) {
  return I2C->DR;
}



/* I2C status register 1 (SR1) */


#endif
