#ifndef DS18B20_H
#define DS18B20_H

#include <stdint.h>
#include "../STM8S103F3_L0_Drivers/gpio.h"

#define DS18B20_ERROR_CODE      0xEEEE // Error status code 
#define DS18B20_PROCESSING_TEMP 0xEEEF // Temp conversion in progress code

/* Global Variables */
extern GPIO_PORT_REG *ds18b20_port_id;
extern uint8_t ds18b20_pin_number;

/* DS18B20 Initialization Function */
void ds18b20_init(GPIO_PORT_REG *port, uint8_t pin);


/* Core Driver Functions */
uint8_t ds18b20_reset_and_detect_slave(void);

void ds18b20_byte_write(uint8_t data);

uint8_t ds18b20_byte_read(void);


/* Temperature Read Functions */
uint16_t ds18b20_temperature_blocking_read(void);

uint16_t ds18b20_temperature_non_blocking_read(void);


/**
 * Converts a DS18B20 raw temperature (Q11.4 two's complement) into a
 * sign-encoded fixed-point value with two decimal digits of precision.
 *
 * Return format:
 *   Bit 15 : Sign bit (0 = positive, 1 = negative)
 *   Bits 14:0 : Temperature magnitude in centi-degrees (°C × 100)
 *
 * Examples:
 *   +25.06°C -> 2506
 *   -25.06°C -> 0x8000 | 2506
 *   +99.99°C -> 9999
 *
 * Temperatures above +99.99°C are saturated to +99.99°C.
 *
 * The returned magnitude is always positive. Check and clear the sign bit
 * before using the magnitude.
 */
uint16_t ds18b20_temp_to_sign_encoded_fixed_point_max_99_celc(uint16_t temp);

#endif