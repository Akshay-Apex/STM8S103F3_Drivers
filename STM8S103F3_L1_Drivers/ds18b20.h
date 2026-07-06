#ifndef DS18B20_H
#define DS18B20_H

#include <stdint.h>
#include "../STM8S103F3_L0_Drivers/gpio.h"

void ds18b20_init(GPIO_PORT_REG *port, uint8_t pin);

// void sd18b20_write()


/* Non-Volatile EEPROM Memory Write Functions */
void ds18b20_alarm_ht_non_volatile_write(uint8_t value);

void ds18b20_alarm_lt_non_volatile_write(uint8_t value);

typedef enum {
  DS18B20_9_BIT_RES  = 0x00,
  DS18B20_10_bit_RES = 0x20,
  DS18B20_11_BIT_RES = 0x40,
  DS18B20_12_BIT_RES = 0x60
} DS18B20_RESOLUTION_CONFIG;

void ds18b20_thermometer_res_config_non_volatile_set(DS18B20_RESOLUTION_CONFIG value);


/* Non-Volatile EEPROM Memory Write Functions */
uint8_t ds18b20_alarm_ht_non_volatile_read(void);

uint8_t ds18b20_alarm_lt_non_volatile_read(void);

DS18B20_RESOLUTION_CONFIG ds18b20_thermometer_res_config_non_volatile_read(void);




#endif 