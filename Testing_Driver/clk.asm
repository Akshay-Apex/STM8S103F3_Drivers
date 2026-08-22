;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module clk
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _HSE_OSC_FREQ_KHZ
	.globl _clk_fmaster_freq_khz_get
	.globl _clk_fmaster_switch_src_auto_mode
	.globl _clk_context_get_and_switch
	.globl _clk_context_restore
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_HSE_OSC_FREQ_KHZ::
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	..\STM8S103F3_L0_Drivers\clk.c: 13: uint16_t clk_fmaster_freq_khz_get(void) {
;	-----------------------------------------
;	 function clk_fmaster_freq_khz_get
;	-----------------------------------------
_clk_fmaster_freq_khz_get:
;	..\STM8S103F3_L0_Drivers\clk.c: 14: CLK_MASTER_SRC fmaster_src = clk_master_get_source();  
	ld	a, 0x50c3
;	..\STM8S103F3_L0_Drivers\clk.c: 16: if(fmaster_src == CLK_MASTER_SRC_HSE) {
	cp	a, #0xb4
	jrne	00107$
;	..\STM8S103F3_L0_Drivers\clk.c: 18: return HSE_OSC_FREQ_KHZ;    
	ldw	x, _HSE_OSC_FREQ_KHZ+0
	ret
00107$:
;	..\STM8S103F3_L0_Drivers\clk.c: 20: } else if(fmaster_src == CLK_MASTER_SRC_HSI) {
	cp	a, #0xe1
	jrne	00104$
;	..\STM8S103F3_L0_Drivers\clk.c: 22: HSI_DIV_PRESCALAR hsi_div_psc = clk_hsi_div_prescalar_read();  
	ld	a, 0x50c6
	and	a, #0x18
;	..\STM8S103F3_L0_Drivers\clk.c: 25: return (HSI_MAX_FREQ >> hsi_div_psc);
	ldw	x, #0x3e80
	tnz	a
	jreq	00141$
00140$:
	srlw	x
	dec	a
	jrne	00140$
00141$:
	ret
00104$:
;	..\STM8S103F3_L0_Drivers\clk.c: 27: } else if(fmaster_src == CLK_MASTER_SRC_LSI) {
	cp	a, #0xd2
	jrne	00108$
;	..\STM8S103F3_L0_Drivers\clk.c: 29: return 128U;    
	ldw	x, #0x0080
	ret
00108$:
;	..\STM8S103F3_L0_Drivers\clk.c: 32: return 0;
	clrw	x
;	..\STM8S103F3_L0_Drivers\clk.c: 33: }
	ret
;	..\STM8S103F3_L0_Drivers\clk.c: 36: void clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC src) {
;	-----------------------------------------
;	 function clk_fmaster_switch_src_auto_mode
;	-----------------------------------------
_clk_fmaster_switch_src_auto_mode:
	push	a
	ld	(0x01, sp), a
;	..\STM8S103F3_L0_Drivers\./clk.h: 181: return (CLK_MASTER_SRC)CLK->CMSR;
	ld	a, 0x50c3
;	..\STM8S103F3_L0_Drivers\clk.c: 37: if(clk_master_get_source() == src) {
	cp	a, (0x01, sp)
	jreq	00112$
;	..\STM8S103F3_L0_Drivers\clk.c: 38: return;
;	..\STM8S103F3_L0_Drivers\./clk.h: 223: CLK->SWCR &= ~(1U << 3);
	bres	0x50c5, #3
;	..\STM8S103F3_L0_Drivers\./clk.h: 199: CLK->SWCR |= (1U << 1);
	bset	0x50c5, #1
;	..\STM8S103F3_L0_Drivers\./clk.h: 186: CLK->SWR = src;
	ldw	x, #0x50c4
	ld	a, (0x01, sp)
	ld	(x), a
;	..\STM8S103F3_L0_Drivers\clk.c: 44: while(!clk_switch_event_occured_auto_mode());
00103$:
;	..\STM8S103F3_L0_Drivers\./clk.h: 219: return ((CLK->SWCR >> 3) & 1) ;
	ld	a, 0x50c5
	swap	a
	sll	a
	clr	a
;	..\STM8S103F3_L0_Drivers\clk.c: 44: while(!clk_switch_event_occured_auto_mode());
	rlc	a
	jreq	00103$
;	..\STM8S103F3_L0_Drivers\./clk.h: 223: CLK->SWCR &= ~(1U << 3);
	bres	0x50c5, #3
;	..\STM8S103F3_L0_Drivers\clk.c: 45: clk_switch_irq_flag_clear();
00112$:
;	..\STM8S103F3_L0_Drivers\clk.c: 46: }
	pop	a
	ret
;	..\STM8S103F3_L0_Drivers\clk.c: 50: CLK_CONTEXT clk_context_get_and_switch(CLK_MASTER_SRC src, HSI_DIV_PRESCALAR hsi_value, CPU_DIV_PRESCALAR cpu_value) {
;	-----------------------------------------
;	 function clk_context_get_and_switch
;	-----------------------------------------
_clk_context_get_and_switch:
	sub	sp, #4
	ld	xl, a
;	..\STM8S103F3_L0_Drivers\clk.c: 52: context.current_clock_src = clk_master_get_source();  
;	..\STM8S103F3_L0_Drivers\./clk.h: 181: return (CLK_MASTER_SRC)CLK->CMSR;
	ld	a, 0x50c3
;	..\STM8S103F3_L0_Drivers\clk.c: 52: context.current_clock_src = clk_master_get_source();  
	ld	(0x01, sp), a
;	..\STM8S103F3_L0_Drivers\clk.c: 53: context.current_cpu_divider = clk_cpu_div_prescalar_read();
;	..\STM8S103F3_L0_Drivers\./clk.h: 237: return ((CPU_DIV_PRESCALAR)(CLK->CKDIVR & ~(CLK_CKDIVR_CPU_CLR_MASK)));
	ld	a, 0x50c6
	and	a, #0x07
;	..\STM8S103F3_L0_Drivers\clk.c: 53: context.current_cpu_divider = clk_cpu_div_prescalar_read();
	ld	(0x02, sp), a
;	..\STM8S103F3_L0_Drivers\clk.c: 54: context.current_hsi_divider = clk_hsi_div_prescalar_read();
;	..\STM8S103F3_L0_Drivers\./clk.h: 249: return ((HSI_DIV_PRESCALAR)(CLK->CKDIVR & ~(CLK_CKDIVR_HSI_CLR_MASK)));
	ld	a, 0x50c6
	and	a, #0x18
;	..\STM8S103F3_L0_Drivers\clk.c: 54: context.current_hsi_divider = clk_hsi_div_prescalar_read();
	ld	(0x03, sp), a
;	..\STM8S103F3_L0_Drivers\clk.c: 56: clk_fmaster_switch_src_auto_mode(src);
	ld	a, xl
	call	_clk_fmaster_switch_src_auto_mode
;	..\STM8S103F3_L0_Drivers\clk.c: 57: clk_hsi_and_cpu_div_prescalar_set(hsi_value, cpu_value);
	ld	a, (0x0a, sp)
	ld	xl, a
	ld	a, (0x09, sp)
	ld	xh, a
;	..\STM8S103F3_L0_Drivers\./clk.h: 253: CLK->CKDIVR = (CLK->CKDIVR & (CLK_CKDIVR_HSI_CLR_MASK & CLK_CKDIVR_CPU_CLR_MASK)) 
	ld	a, 0x50c6
	and	a, #0xe0
	ld	(0x04, sp), a
;	..\STM8S103F3_L0_Drivers\./clk.h: 254: | ((((uint8_t)hsi_value << 3) | ((uint8_t)cpu_value) << 0));
	ld	a, xh
	sll	a
	sll	a
	sll	a
	pushw	x
	or	a, (2, sp)
	popw	x
	or	a, (0x04, sp)
	ld	0x50c6, a
;	..\STM8S103F3_L0_Drivers\clk.c: 59: return context;
	ldw	x, (0x07, sp)
	ldw	y, (0x02, sp)
	ldw	(#1, x), y
	ld	a, (0x01, sp)
	ld	(x), a
;	..\STM8S103F3_L0_Drivers\clk.c: 60: }
	addw	sp, #4
	ret
;	..\STM8S103F3_L0_Drivers\clk.c: 62: void clk_context_restore(CLK_CONTEXT *context) {
;	-----------------------------------------
;	 function clk_context_restore
;	-----------------------------------------
_clk_context_restore:
	push	a
;	..\STM8S103F3_L0_Drivers\clk.c: 63: clk_fmaster_switch_src_auto_mode(context->current_clock_src);
	ld	a, (x)
	pushw	x
	call	_clk_fmaster_switch_src_auto_mode
	popw	x
;	..\STM8S103F3_L0_Drivers\clk.c: 64: clk_hsi_and_cpu_div_prescalar_set(context->current_hsi_divider, context->current_cpu_divider);
	ldw	y, x
	ld	a, (0x1, y)
	ld	yl, a
	ld	a, (0x2, x)
	ld	xl, a
;	..\STM8S103F3_L0_Drivers\./clk.h: 253: CLK->CKDIVR = (CLK->CKDIVR & (CLK_CKDIVR_HSI_CLR_MASK & CLK_CKDIVR_CPU_CLR_MASK)) 
	ld	a, 0x50c6
	and	a, #0xe0
	ld	(0x01, sp), a
;	..\STM8S103F3_L0_Drivers\./clk.h: 254: | ((((uint8_t)hsi_value << 3) | ((uint8_t)cpu_value) << 0));
	ld	a, xl
	sll	a
	sll	a
	sll	a
	ldw	x, y
	pushw	x
	or	a, (2, sp)
	popw	x
	or	a, (0x01, sp)
	ld	0x50c6, a
;	..\STM8S103F3_L0_Drivers\clk.c: 64: clk_hsi_and_cpu_div_prescalar_set(context->current_hsi_divider, context->current_cpu_divider);
;	..\STM8S103F3_L0_Drivers\clk.c: 65: }
	pop	a
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__HSE_OSC_FREQ_KHZ:
	.dw #0x0000
	.area CABS (ABS)
