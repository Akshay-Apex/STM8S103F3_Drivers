#include "../STM8S103F3_L0_Drivers/clk.h"


/*=============================================================*
 * 
 * Clock Public API Definitions BEGIN 
 *
 *=============================================================*/

/*@Important: Returns 0 if the selected clock source is HSE */
uint32_t clk_fmaster_freq_get(void) {
  CLK_MASTER_SRC fmaster_src = clk_master_get_source();
  uint32_t base_freq = 0;

  if(fmaster_src == CLK_MASTER_SRC_HSE) {
    return base_freq;    

  } else if(fmaster_src == CLK_MASTER_SRC_HSI) {
    const uint32_t HSI_MAX_FREQ = 16000000UL;
    HSI_DIV_PRESCALAR hsi_div_psc = clk_hsi_div_prescalar_read();    
    base_freq = (HSI_MAX_FREQ >> hsi_div_psc);
    
  } else if(fmaster_src == CLK_MASTER_SRC_LSI) {
    base_freq = 128000UL;    
  }

  return base_freq;
}