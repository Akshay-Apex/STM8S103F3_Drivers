#include "../STM8S103F3_L0_Drivers/clk.h"

#include "../STM8S103F3_L1_Drivers/time.h"
#include "./ds18b20.h"

/* Interrupt Enable and Disable */
#define global_interrupt_enable()  __asm__("rim") 
#define global_interrupt_disable() __asm__("sim")


// Local Variable
uint8_t TEMP_CONV_PROCESS_INITIATED = 0;


ONE_WIRE_BUS ds18b20_init(GPIO_PORT_REG *port, uint8_t pin) {  
  ONE_WIRE_BUS ds18b20_bus = {port, pin};
  one_wire_init(&ds18b20_bus);
  return ds18b20_bus;
}



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
    // Wait for 750 ms for the convertion to finish
    time_delay_ms(750U);


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



uint16_t ds18b20_temperature_non_blocking_read(ONE_WIRE_BUS *ow_bus) {
  if(!gpio_input_read(ow_bus->gpio_port, ow_bus->gpio_pin)) {
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
