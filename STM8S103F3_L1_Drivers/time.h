#ifndef TIME_H
#define TIME_H

#include <stdint.h>

/*=============================================================*
* 
* Time Public API Declarations BEGIN 
*
*=============================================================*/

/* Global Variable and Constant Declarations */
extern uint8_t TIM4_PSC_VAL_FOR_125KHZ;


/* Timing Parameters Calibration Function */
void time_timing_calibrate(void);


/* Time Initialization Function */
void time_init(void);


/* Low Precision Clock based delay functions 128KHz */
void time_delay_lsi_ms(uint16_t ms);

void time_delay_lsi_sec(uint16_t sec);


/* High Precision Clock based delay functions */
/* @Note: When n > 1 the delay will be 62.5 nano seconds shorter
          so adding a __asm__("nop") instruction at the end of the 
          function will fix the error */
inline void time_delay_us_16mhz(uint16_t us) {  
  while(us) {
    if(us != 1) {      
      __asm__("nop");
      __asm__("nop");
    }     
    
    __asm__("nop");
    __asm__("nop");
    __asm__("nop");
    __asm__("nop");
    __asm__("nop");
    us--;
  }
}

/* Dynamic-Clock delay functions (16, 8, 4, 2, 1) MHz */
void time_delay_ms(uint16_t ms);

void time_delay_sec(uint16_t sec);

/*=============================================================*
 * Time Public API Declarations END
 *=============================================================*/

#endif