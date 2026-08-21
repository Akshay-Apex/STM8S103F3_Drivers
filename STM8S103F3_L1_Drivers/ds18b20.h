#ifndef DS18B20_H
#define DS18B20_H

#include <stdint.h>
#include <stdbool.h>
#include "../STM8S103F3_L0_Drivers/gpio.h"

#include "../STM8S103F3_L1_Drivers/one_wire.h"


/*=============================================================*
* 
* DS18B20 Public API Declarations BEGIN 
*
*=============================================================*/


#define DS18B20_ERROR_CODE      0xEEEE // Error status code 
#define DS18B20_PROCESSING_TEMP 0xEEEF // Temp conversion in progress code
#define DS18B20_DONE_PROCESSING 0xEEF0 // Temp Conversion finished code


/* DS18B20 Initialization Structure */
typedef struct {
  ONE_WIRE_BUS ow_bus;
  uint8_t temp_conv_process_initiated;
} DS18B20_SENSOR;


/* DS18B20 Initialization Function */
DS18B20_SENSOR ds18b20_init(GPIO_PORT_REG *port, uint8_t pin);


/* Temperature Read Functions */
/* Busy Waits till the temperature reading is received */
uint16_t ds18b20_temperature_blocking_read(DS18B20_SENSOR *sensor);


/* Issues the convert temperature command and then doesn't busy wait to get the temp reading
 * If called multiple times after the convert temp command has been issued then it would check the status
 * When conversion is finished it will get the temperature reading 
 */
uint16_t ds18b20_temperature_non_blocking_read(DS18B20_SENSOR *sensor);


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



/* Validates full 9-byte scratchpad integrity, returns true if data is valid */
/* @Note: Must pass the full 9-byte Scratchpad from the DS18B20 sensor */
bool ds18b20_crc8_is_valid(uint8_t *scratchpad, uint8_t size);    



/* Issues Temperature Convertion Command with either Blocking or Non-Blocking Mode */
uint16_t ds18b20_begin_temp_convertion(DS18B20_SENSOR *sensor, bool blocking_temp_conversion);



/* Scratchpad Read Function */
/* @Note: 
 * - Returns DS18B20_ERROR_CODE if error is encountered
 * - Returns 0 otherwise        
 */
uint16_t ds18b20_scratchpad_read(uint8_t *scratchpad, DS18B20_SENSOR *sensor);



/* Get Temperature from Scratchpad */
uint16_t ds18b20_temp_from_scratchpad_get(uint8_t *scratchpad);

/*=============================================================*
 * DS18B20 Public API Declarations END
 *=============================================================*/

#endif