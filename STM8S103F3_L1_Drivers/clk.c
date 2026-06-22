#include "../STM8S103F3_L0_Drivers/clk.h"


/*=============================================================*
 * 
 * Clock Public API Definitions BEGIN 
 *
 *=============================================================*/

uint16_t clk_fmaster_freq_khz_get(void) {
  CLK_MASTER_SRC fmaster_src = clk_master_get_source();
  uint16_t base_freq = 0;

  if(fmaster_src == CLK_MASTER_SRC_HSE) {
    return HSE_OSC_FREQ_KHZ;    

  } else if(fmaster_src == CLK_MASTER_SRC_HSI) {
    const uint16_t HSI_MAX_FREQ = 16000U;
    HSI_DIV_PRESCALAR hsi_div_psc = clk_hsi_div_prescalar_read();  
    // Divides the max HSI frequency by the prescaler to get the base frequency   
    base_freq = (HSI_MAX_FREQ >> hsi_div_psc);
    
  } else if(fmaster_src == CLK_MASTER_SRC_LSI) {
    base_freq = 128U;    
  }

  return base_freq;
}