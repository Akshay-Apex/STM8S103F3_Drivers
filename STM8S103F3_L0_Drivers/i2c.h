#ifndef I2C_H
#define I2C_H

#include <stdint.h>

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





#endif
