#include "../STM8S103F3_L0_Drivers/clk.h"

#include "../STM8S103F3_L1_Drivers/time.h"
#include "./ds18b20.h"

/* Interrupt Enable and Disable */
#define global_interrupt_enable()  __asm__("rim") 
#define global_interrupt_disable() __asm__("sim")

GPIO_PORT_REG *ds18b20_port_id;
uint8_t ds18b20_pin_number;

void ds18b20_init(GPIO_PORT_REG *port, uint8_t pin) {
  ds18b20_port_id = port;
  ds18b20_pin_number = pin;
  gpio_out_open_drain(ds18b20_port_id, ds18b20_pin_number);
  gpio_output_set(ds18b20_port_id, ds18b20_pin_number);
}

uint8_t ds18b20_reset_and_detect_slave(void) {
  global_interrupt_disable();  
  CLK_MASTER_SRC current_clock_src = clk_master_get_source();  
  CPU_DIV_PRESCALAR current_cpu_divider = clk_cpu_div_prescalar_read();
  HSI_DIV_PRESCALAR current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_HSI);
  clk_hsi_and_cpu_div_prescalar_set(CLK_HSI_DIV_1, CLK_CPU_DIV_1);
  
  gpio_output_clear(ds18b20_port_id, ds18b20_pin_number);
  time_delay_us_16mhz(500U);

  gpio_output_set(ds18b20_port_id, ds18b20_pin_number);  
  time_delay_us_16mhz(70U);

  uint16_t timeout = 260U;
  uint8_t device_present = 0;
  if(!gpio_input_read(ds18b20_port_id, ds18b20_pin_number)) {    
    while(!gpio_input_read(ds18b20_port_id, ds18b20_pin_number) && timeout--) {
      time_delay_us_16mhz(1);
    }       
     
    if(timeout != 0) {
      device_present = 1; 
    } 
  }

  clk_fmaster_switch_src_auto_mode(current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(current_hsi_divider, current_cpu_divider);
  global_interrupt_enable();

  return device_present;
}


uint16_t ds18b20_temp_conv_sign_encoded_fixed_point(uint16_t temp) {
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


void ds18b20_byte_write(uint8_t data) {
  uint8_t counter = 8;
  while(counter--) {
    if(data & 1) {
      gpio_output_clear(ds18b20_port_id, ds18b20_pin_number);
      time_delay_us_16mhz(5);
      gpio_output_set(ds18b20_port_id, ds18b20_pin_number);
      time_delay_us_16mhz(65);
    } else {
      gpio_output_clear(ds18b20_port_id, ds18b20_pin_number);
      time_delay_us_16mhz(65);
      gpio_output_set(ds18b20_port_id, ds18b20_pin_number);
      time_delay_us_16mhz(5);
    }
    data >>= 1;
  }
}


uint8_t ds18b20_byte_read(void) {
  uint8_t data = 0;  
  for(uint8_t i = 0; i < 8; i++) {
    gpio_output_clear(ds18b20_port_id, ds18b20_pin_number);
    time_delay_us_16mhz(5);
    gpio_output_set(ds18b20_port_id, ds18b20_pin_number);
    time_delay_us_16mhz(25);    
    data |= gpio_input_read(ds18b20_port_id, ds18b20_pin_number) << i;
    time_delay_us_16mhz(40);
  }  
  return data;
}