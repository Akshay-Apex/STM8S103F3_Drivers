#include "../STM8S103F3_L0_Drivers/gpio.h"
#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/timer.h"
#include "./ws2812.h"


/*=============================================================*
 * 
 * WS2812 Public API Definitions
 *
 *=============================================================*/

/* Definition of global WS2812 service variables (shared via extern in ws2812.h) */


/* Timing Parameters Calibration Function */
void ws2812_timing_calibrate(void) {

}


void ws2812_init(GPIO_PORT_REG *port, uint8_t pin) {  
  gpio_out_push_pull_fast_mode(port, pin);
  
}
