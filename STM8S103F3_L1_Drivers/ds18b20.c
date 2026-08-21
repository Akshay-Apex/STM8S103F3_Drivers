#include "../STM8S103F3_L0_Drivers/clk.h"

#include "../STM8S103F3_L1_Drivers/time.h"
#include "./ds18b20.h"

/*=============================================================*
 * 
 * DS18B20 Public API Definitions
 *
 *=============================================================*/


/* Interrupt Enable and Disable */
#define global_interrupt_enable()  __asm__("rim") 
#define global_interrupt_disable() __asm__("sim")


/* DS18B20 Initialization Function */
DS18B20_SENSOR ds18b20_init(GPIO_PORT_REG *port, uint8_t pin) {  
  DS18B20_SENSOR sensor;

  sensor.ow_bus.gpio_port = port;
  sensor.ow_bus.gpio_pin = pin;  
  one_wire_init(&(sensor.ow_bus));  
  sensor.temp_conv_process_initiated = 0;
  return sensor;
}


/* Temperature Read Functions */
/* Busy Waits till the temperature reading is received */
uint16_t ds18b20_temperature_blocking_read(DS18B20_SENSOR *sensor) {
  global_interrupt_disable();  
  CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
  
  ONE_WIRE_BUS *ow_bus = &(sensor->ow_bus);
  uint16_t temp = DS18B20_ERROR_CODE;
  // Reset And Check For Device Presense
  if(one_wire_reset_and_detect_slave(ow_bus)) {
    // Skip ROM
    one_wire_byte_write(ow_bus, 0xCC); 
    // Send Convert Temperature Command
    one_wire_byte_write(ow_bus, 0x44);

    // Waits for the one wire bit read on the bus to go high or the timeout to occur 
    uint16_t timeout = 750U;            
    while(!one_wire_bit_read(ow_bus) && timeout--) {
      time_delay_ms(1);
    } 


    // Reset And Check For Device Presense
    if(one_wire_reset_and_detect_slave(ow_bus)) {
      // Skip ROM
      one_wire_byte_write(ow_bus, 0xCC); 
      // Send Read Command
      one_wire_byte_write(ow_bus, 0xBE);
      // Read Converted Temperature
      uint8_t lsb = one_wire_byte_read(ow_bus);
      uint8_t msb = one_wire_byte_read(ow_bus);
  
      temp = ((uint16_t)msb << 8) | lsb;
    } 
  } 
  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();

  return temp;
}


/* Issues the convert temperature command and then doesn't busy wait to get the temp reading
 * If called multiple times after the convert temp command has been issued then it would check the status
 * When conversion is finished it will get the temperature reading 
 */
uint16_t ds18b20_temperature_non_blocking_read(DS18B20_SENSOR *sensor) {  
  global_interrupt_disable();  
  CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
  
  ONE_WIRE_BUS *ow_bus = &(sensor->ow_bus);
  uint16_t temp;
  if(sensor->temp_conv_process_initiated == 1 && !one_wire_bit_read(ow_bus)) {
    temp = DS18B20_PROCESSING_TEMP;
  } else {
    temp = DS18B20_ERROR_CODE;  
    // Reset And Check For Device Presense
    if(sensor->temp_conv_process_initiated) {
      if(one_wire_reset_and_detect_slave(ow_bus)) {
        // Skip ROM
        one_wire_byte_write(ow_bus, 0xCC); 
        // Send Read Command
        one_wire_byte_write(ow_bus, 0xBE);
        // Read Converted Temperature
        uint8_t lsb = one_wire_byte_read(ow_bus);
        uint8_t msb = one_wire_byte_read(ow_bus);
          
        temp = ((uint16_t)msb << 8) | lsb;
      }
      sensor->temp_conv_process_initiated = 0;
      
    } else if(!sensor->temp_conv_process_initiated) {
      // Reset And Check For Device Presense
      if(one_wire_reset_and_detect_slave(ow_bus)) {
        // Skip ROM
        one_wire_byte_write(ow_bus, 0xCC); 
        // Send Convert Temperature Command
        one_wire_byte_write(ow_bus, 0x44);
        
        sensor->temp_conv_process_initiated = 1;    
        temp = DS18B20_PROCESSING_TEMP;
      }
    }
  }
  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();
   
  return temp;
}



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
uint16_t ds18b20_temp_to_sign_encoded_fixed_point_max_99_celc(uint16_t temp) {
  uint16_t sign_en_fixed_point = temp & 0x8000;  
  if(sign_en_fixed_point) {
    temp = (~temp + 1);
  }
  uint16_t integer = ((temp >> 4));
  if(integer >= 100U) {
    integer = 99U * 100U;
  } else {
    integer *= 100U;
  }
  sign_en_fixed_point |= integer + ((temp & 0x000F) * 100U / 16U);
  return sign_en_fixed_point;
}



/* Validates full 9-byte scratchpad integrity, returns true if data is valid */
/* @Note: Must pass the full 9-byte Scratchpad from the sensor */
#define CRC_8_BIT_POLYNOMIAL_REFLECTED 0x8C

bool ds18b20_crc8_is_valid(uint8_t *scratchpad, uint8_t size) {
  uint8_t crc = 0;
  for(uint8_t i = 0; i < size; i ++) {
    crc ^= scratchpad[i];        
    for(uint8_t j = 0; j < 8; j++) {            
      if(crc & 1) {
        crc = (crc >> 1) ^ CRC_8_BIT_POLYNOMIAL_REFLECTED;
      } else {
        crc >>= 1;
      }
    }
  }
  
  return crc == 0;
}



/* Issues Temperature Convertion Command with either Blocking or Non-Blocking Mode */
uint16_t ds18b20_begin_temp_convertion(DS18B20_SENSOR *sensor, bool blocking_temp_conversion) {
  global_interrupt_disable();  
  CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
  
  ONE_WIRE_BUS *ow_bus = &(sensor->ow_bus);
  uint16_t OPERATION_STATUS = DS18B20_ERROR_CODE;
  if(blocking_temp_conversion) {
    // Reset And Check For Device Presense
    if(one_wire_reset_and_detect_slave(ow_bus)) {
      // Skip ROM
      one_wire_byte_write(ow_bus, 0xCC); 
      // Send Convert Temperature Command
      one_wire_byte_write(ow_bus, 0x44);

      // Waits for the one wire bit read on the bus to go high or the timeout to occur 
      uint16_t timeout = 750U;            
      while(!one_wire_bit_read(ow_bus) && timeout--) {
        time_delay_ms(1);
      }   

      OPERATION_STATUS = DS18B20_DONE_PROCESSING;
    }  

  } else {    
    if(sensor->temp_conv_process_initiated == 1 && !one_wire_bit_read(ow_bus)) {
      OPERATION_STATUS = DS18B20_PROCESSING_TEMP;
    } else {      
      if(!sensor->temp_conv_process_initiated) {
        // Reset And Check For Device Presense
        if(one_wire_reset_and_detect_slave(ow_bus)) {
          // Skip ROM
          one_wire_byte_write(ow_bus, 0xCC); 
          // Send Convert Temperature Command
          one_wire_byte_write(ow_bus, 0x44);
          
          sensor->temp_conv_process_initiated = 1;    
          OPERATION_STATUS = DS18B20_PROCESSING_TEMP;
        }
      } else {
        OPERATION_STATUS = DS18B20_DONE_PROCESSING;
        sensor->temp_conv_process_initiated = 0;  
      }
    }        
  }
  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();

  return OPERATION_STATUS; 
}



/* Scratchpad Read Function */
/* @Note: 
 * - Returns DS18B20_ERROR_CODE if error is encountered
 * - Returns 0 otherwise        
 */
uint16_t ds18b20_scratchpad_read(uint8_t *scratchpad, DS18B20_SENSOR *sensor) {
  global_interrupt_disable();  
  CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
    
  ONE_WIRE_BUS *ow_bus = &(sensor->ow_bus);
  uint16_t ERROR_CODE = DS18B20_ERROR_CODE;
  // Reset And Check For Device Presense
  if(one_wire_reset_and_detect_slave(ow_bus)) {
    // Skip ROM
    one_wire_byte_write(ow_bus, 0xCC); 
    // Send Read Command
    one_wire_byte_write(ow_bus, 0xBE);
    // Reads the full 9-byte Scratchpad
    for(uint8_t i = 0; i < 9; i++) {
      scratchpad[i] = one_wire_byte_read(ow_bus);
    }  
    
    ERROR_CODE = 0;
  } 

  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();

  return ERROR_CODE; 
}



/* Get Temperature from Scratchpad */
uint16_t ds18b20_temp_from_scratchpad_get(uint8_t *scratchpad) {  
  uint8_t lsb = scratchpad[0];
  uint8_t msb = scratchpad[1];
    
  return ((uint16_t)msb << 8) | lsb; 
}