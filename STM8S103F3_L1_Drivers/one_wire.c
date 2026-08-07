#include "../STM8S103F3_L1_Drivers/time.h"
#include "./one_wire.h"


/*=============================================================*
 * 
 * One_Wire Public API Definitions
 *
 *=============================================================*/

/* One Wire Initialization Function */
void one_wire_init(ONE_WIRE_BUS *ow_bus) {        
  gpio_output_mode_open_drain_init(ow_bus->gpio_port, ow_bus->gpio_pin);
  gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);
}


/* One Wire Driver Core Functions */
/* Function that resets and detects the slave presense */
uint8_t one_wire_reset_and_detect_slave(ONE_WIRE_BUS *ow_bus) {
  gpio_output_clear(ow_bus->gpio_port, ow_bus->gpio_pin);
  time_delay_us_16mhz(480U);

  gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);  
  time_delay_us_16mhz(60U);

  uint16_t timeout = 250U;
  uint8_t device_present = 0;
  if(!gpio_input_read(ow_bus->gpio_port, ow_bus->gpio_pin)) {    
    while(!gpio_input_read(ow_bus->gpio_port, ow_bus->gpio_pin) && timeout--) {
      time_delay_us_16mhz(1);
    }       
     
    if(timeout != 0) {
      device_present = 1; 
    } 
  }

  return device_present;
}


/* Writes a Bit to the one wire bus */
void one_wire_bit_write(ONE_WIRE_BUS *ow_bus, uint8_t bit) {
  if(bit) {
    gpio_output_clear(ow_bus->gpio_port, ow_bus->gpio_pin);
    time_delay_us_16mhz(1);
    gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);
    time_delay_us_16mhz(60U);
  } else {
    gpio_output_clear(ow_bus->gpio_port, ow_bus->gpio_pin);
    time_delay_us_16mhz(60U);
    gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);
    time_delay_us_16mhz(1);
  }    
}


/* Writes a Byte to the one wire bus */
void one_wire_byte_write(ONE_WIRE_BUS *ow_bus, uint8_t data) {
  uint8_t counter = 8;
  while(counter--) {    
    one_wire_bit_write(ow_bus, data & 1);
    data >>= 1;
  }
}


/* Reads a Bit from the one wire bus */
uint8_t one_wire_bit_read(ONE_WIRE_BUS *ow_bus) {
  uint8_t data = 0;    
  gpio_output_clear(ow_bus->gpio_port, ow_bus->gpio_pin);
  time_delay_us_16mhz(1);
  gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);
  time_delay_us_16mhz(15U);    
  data = gpio_input_read(ow_bus->gpio_port, ow_bus->gpio_pin);
  time_delay_us_16mhz(45U);
  
  return data;
}


/* Reads a Byte from the one wire bus */
uint8_t one_wire_byte_read(ONE_WIRE_BUS *ow_bus) {
  uint8_t data = 0;  
  for(uint8_t i = 0; i < 8; i++) {       
    data |= one_wire_bit_read(ow_bus) << i;    
  }  
  return data;
}
