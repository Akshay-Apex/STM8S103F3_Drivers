#include "../STM8S103F3_L0_Drivers/clk.h"

#include "../STM8S103F3_L1_Drivers/time.h"
#include "./ds18b20.h"

/* Interrupt Enable and Disable */
#define global_interrupt_enable()  __asm__("rim") 
#define global_interrupt_disable() __asm__("sim")

// Global Variables
GPIO_PORT_REG *ds18b20_port_id;
uint8_t ds18b20_pin_number;

// Local Variable
uint8_t TEMP_CONV_PROCESS_INITIATED = 0;


void ds18b20_init(GPIO_PORT_REG *port, uint8_t pin) {
  ds18b20_port_id = port;
  ds18b20_pin_number = pin;
  gpio_out_open_drain(ds18b20_port_id, ds18b20_pin_number);
  gpio_output_set(ds18b20_port_id, ds18b20_pin_number);
}


uint8_t ds18b20_reset_and_detect_slave(void) {
  gpio_output_clear(ds18b20_port_id, ds18b20_pin_number);
  time_delay_us_16mhz(480U);

  gpio_output_set(ds18b20_port_id, ds18b20_pin_number);  
  time_delay_us_16mhz(60U);

  uint16_t timeout = 250U;
  uint8_t device_present = 0;
  if(!gpio_input_read(ds18b20_port_id, ds18b20_pin_number)) {    
    while(!gpio_input_read(ds18b20_port_id, ds18b20_pin_number) && timeout--) {
      time_delay_us_16mhz(1);
    }       
     
    if(timeout != 0) {
      device_present = 1; 
    } 
  }

  return device_present;
}


void ds18b20_byte_write(uint8_t data) {
  uint8_t counter = 8;
  while(counter--) {
    if(data & 1) {
      gpio_output_clear(ds18b20_port_id, ds18b20_pin_number);
      time_delay_us_16mhz(1);
      gpio_output_set(ds18b20_port_id, ds18b20_pin_number);
      time_delay_us_16mhz(60U);
    } else {
      gpio_output_clear(ds18b20_port_id, ds18b20_pin_number);
      time_delay_us_16mhz(60U);
      gpio_output_set(ds18b20_port_id, ds18b20_pin_number);
      time_delay_us_16mhz(1);
    }
    data >>= 1;
  }
}


uint8_t ds18b20_byte_read(void) {
  uint8_t data = 0;  
  for(uint8_t i = 0; i < 8; i++) {
    gpio_output_clear(ds18b20_port_id, ds18b20_pin_number);
    time_delay_us_16mhz(1);
    gpio_output_set(ds18b20_port_id, ds18b20_pin_number);
    time_delay_us_16mhz(15U);    
    data |= gpio_input_read(ds18b20_port_id, ds18b20_pin_number) << i;
    time_delay_us_16mhz(45U);
  }  
  return data;
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


uint16_t ds18b20_temperature_blocking_read(void) {
  global_interrupt_disable();  
  CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
  
  uint16_t temp = DS18B20_ERROR_CODE;
  // Reset And Check For Device Presense
  if(ds18b20_reset_and_detect_slave()) {
    // Skip ROM
    ds18b20_byte_write(0xCC); 
    // Send Convert Temperature Command
    ds18b20_byte_write(0x44);
    // Wait for 750 ms for the convertion to finish
    time_delay_ms(750U);


    // Reset And Check For Device Presense
    if(ds18b20_reset_and_detect_slave()) {
      // Skip ROM
      ds18b20_byte_write(0xCC); 
      // Send Read Command
      ds18b20_byte_write(0xBE);
      // Read Converted Temperature
      uint8_t lsb = ds18b20_byte_read();
      uint8_t msb = ds18b20_byte_read();
  
      temp = ((uint16_t)msb << 8) | lsb;
    } 
  } 
  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();

  return temp;
}



uint16_t ds18b20_temperature_non_blocking_read(void) {
  if(!gpio_input_read(ds18b20_port_id, ds18b20_pin_number)) {
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
    if(ds18b20_reset_and_detect_slave()) {
      // Skip ROM
      ds18b20_byte_write(0xCC); 
      // Send Read Command
      ds18b20_byte_write(0xBE);
      // Read Converted Temperature
      uint8_t lsb = ds18b20_byte_read();
      uint8_t msb = ds18b20_byte_read();
        
      temp = ((uint16_t)msb << 8) | lsb;
    }
    TEMP_CONV_PROCESS_INITIATED = 0;
    
  } else if(!TEMP_CONV_PROCESS_INITIATED) {
    // Reset And Check For Device Presense
    if(ds18b20_reset_and_detect_slave()) {
      // Skip ROM
      ds18b20_byte_write(0xCC); 
      // Send Convert Temperature Command
      ds18b20_byte_write(0x44);
      
      TEMP_CONV_PROCESS_INITIATED = 1;    
      temp = DS18B20_PROCESSING_TEMP;
    }
  }
  
  
  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();
   
  return temp;
}