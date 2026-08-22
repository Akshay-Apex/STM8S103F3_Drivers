#include "./clk.h"

/*=============================================================*
 * 
 * Clock Public API Definitions 
 *
 *=============================================================*/

/* Definition of global clock frequency variables (shared via extern in clk.h) */
uint16_t HSE_OSC_FREQ_KHZ = 0;


uint16_t clk_fmaster_freq_khz_get(void) {
  CLK_MASTER_SRC fmaster_src = clk_master_get_source();  

  if(fmaster_src == CLK_MASTER_SRC_HSE) {
    // Returns the HSE Oscillator frequency
    return HSE_OSC_FREQ_KHZ;    

  } else if(fmaster_src == CLK_MASTER_SRC_HSI) {
    const uint16_t HSI_MAX_FREQ = 16000U;
    HSI_DIV_PRESCALAR hsi_div_psc = clk_hsi_div_prescalar_read();  

    // Divides the max HSI frequency by the HSI prescaler to get the fmaster frequency   
    return (HSI_MAX_FREQ >> hsi_div_psc);
    
  } else if(fmaster_src == CLK_MASTER_SRC_LSI) {
    // Returns the LSI Oscillator frequency
    return 128U;    
  }

  return 0;
}


void clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC src) {
  if(clk_master_get_source() == src) {
    return;
  }
  
  clk_switch_irq_flag_clear();
  clk_switch_exec_enable();
  clk_master_switch_src(src);  
  while(!clk_switch_event_occured_auto_mode());
  clk_switch_irq_flag_clear();
}


/* Clock Context Switch and Restore */
CLK_CONTEXT clk_context_get_and_switch(CLK_MASTER_SRC src, HSI_DIV_PRESCALAR hsi_value, CPU_DIV_PRESCALAR cpu_value) {
  CLK_CONTEXT context;
  context.current_clock_src = clk_master_get_source();  
  context.current_cpu_divider = clk_cpu_div_prescalar_read();
  context.current_hsi_divider = clk_hsi_div_prescalar_read();

  clk_fmaster_switch_src_auto_mode(src);
  clk_hsi_and_cpu_div_prescalar_set(hsi_value, cpu_value);
    
  return context;
}

void clk_context_restore(CLK_CONTEXT *context) {
  clk_fmaster_switch_src_auto_mode(context->current_clock_src);
  clk_hsi_and_cpu_div_prescalar_set(context->current_hsi_divider, context->current_cpu_divider);
}