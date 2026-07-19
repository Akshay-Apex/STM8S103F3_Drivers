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


/* Local Variable */
uint8_t TEMP_CONV_PROCESS_INITIATED = 0;


/* DS18B20 Initialization Function */
ONE_WIRE_BUS ds18b20_init(GPIO_PORT_REG *port, uint8_t pin) {  
  ONE_WIRE_BUS ds18b20_bus = {port, pin};
  one_wire_init(&ds18b20_bus);
  return ds18b20_bus;
}



/* Temperature Read Functions */
/* Busy Waits till the temperature reading is received */
uint16_t ds18b20_temperature_blocking_read(ONE_WIRE_BUS *ow_bus) {
  global_interrupt_disable();  
  CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
  
  uint16_t temp = DS18B20_ERROR_CODE;
  // Reset And Check For Device Presense
  if(one_wire_reset_and_detect_slave(ow_bus)) {
    // Skip ROM
    one_wire_byte_write(ow_bus, 0xCC); 
    // Send Convert Temperature Command
    one_wire_byte_write(ow_bus, 0x44);

    // Waits for the one wire bus to go high or the timeout to occur
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
uint16_t ds18b20_temperature_non_blocking_read(ONE_WIRE_BUS *ow_bus) {
  if(TEMP_CONV_PROCESS_INITIATED == 1 && !one_wire_bit_read(ow_bus)) {
    return DS18B20_PROCESSING_TEMP;
  }

  global_interrupt_disable();  
  CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
  
  uint16_t temp = DS18B20_ERROR_CODE;  
  // Reset And Check For Device Presense
  if(TEMP_CONV_PROCESS_INITIATED) {
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
    TEMP_CONV_PROCESS_INITIATED = 0;
    
  } else if(!TEMP_CONV_PROCESS_INITIATED) {
    // Reset And Check For Device Presense
    if(one_wire_reset_and_detect_slave(ow_bus)) {
      // Skip ROM
      one_wire_byte_write(ow_bus, 0xCC); 
      // Send Convert Temperature Command
      one_wire_byte_write(ow_bus, 0x44);
      
      TEMP_CONV_PROCESS_INITIATED = 1;    
      temp = DS18B20_PROCESSING_TEMP;
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
