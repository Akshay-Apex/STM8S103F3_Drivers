#ifndef DS18B20_H
#define DS18B20_H

#include <stdint.h>
#include "../STM8S103F3_L0_Drivers/gpio.h"

extern GPIO_PORT_REG *ds18b20_port_id;
extern uint8_t ds18b20_pin_number;

void ds18b20_init(GPIO_PORT_REG *port, uint8_t pin);

uint8_t ds18b20_reset_and_detect_slave(void);

uint16_t ds18b20_temp_conv_sign_encoded_fixed_point(uint16_t temp);

void ds18b20_byte_write(uint8_t data);

uint8_t ds18b20_byte_read(void);

#endif