#ifndef ONE_WIRE_H
#define ONE_WIRE_H

#include <stdint.h>
#include "../STM8S103F3_L0_Drivers/gpio.h"


/* One Wire Bus Initialization Structure */
typedef struct {
  GPIO_PORT_REG *gpio_port;
  uint8_t gpio_pin;
} ONE_WIRE_BUS;


/* One Wire Initialization Function */
void one_wire_init(ONE_WIRE_BUS *ow_bus);


/* One Wire Driver Core Functions */
uint8_t one_wire_reset_and_detect_slave(ONE_WIRE_BUS *ow_bus);


void one_wire_bit_write(ONE_WIRE_BUS *ow_bus, uint8_t bit);

void one_wire_byte_write(ONE_WIRE_BUS *ow_bus, uint8_t data);


uint8_t one_wire_bit_read(ONE_WIRE_BUS *ow_bus);

uint8_t one_wire_byte_read(ONE_WIRE_BUS *ow_bus);

#endif