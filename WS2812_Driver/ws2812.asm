;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module ws2812
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

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
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	.\../STM8S103F3_Drivers/clk.h: 100: static inline void clk_active_halt_mvr_enable(void) {
;	-----------------------------------------
;	 function clk_active_halt_mvr_enable
;	-----------------------------------------
_clk_active_halt_mvr_enable:
;	.\../STM8S103F3_Drivers/clk.h: 101: CLK->ICKR &= ~(1U << 5);
	bres	0x50c0, #5
;	.\../STM8S103F3_Drivers/clk.h: 102: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 104: static inline void clk_active_halt_mvr_disable(void) {
;	-----------------------------------------
;	 function clk_active_halt_mvr_disable
;	-----------------------------------------
_clk_active_halt_mvr_disable:
;	.\../STM8S103F3_Drivers/clk.h: 105: CLK->ICKR |= (1U << 5);
	bset	0x50c0, #5
;	.\../STM8S103F3_Drivers/clk.h: 106: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 108: static inline uint8_t clk_active_halt_mvr_is_enabled(void) {
;	-----------------------------------------
;	 function clk_active_halt_mvr_is_enabled
;	-----------------------------------------
_clk_active_halt_mvr_is_enabled:
;	.\../STM8S103F3_Drivers/clk.h: 109: return !((CLK->ICKR >> 5) & 1);
	ld	a, 0x50c0
	swap	a
	srl	a
	and	a, #0x01
	xor	a, #0x01
;	.\../STM8S103F3_Drivers/clk.h: 110: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 115: static inline uint8_t clk_lsi_osc_is_ready(void) {
;	-----------------------------------------
;	 function clk_lsi_osc_is_ready
;	-----------------------------------------
_clk_lsi_osc_is_ready:
;	.\../STM8S103F3_Drivers/clk.h: 116: return ((CLK->ICKR >> 4) & 1);
	ld	a, 0x50c0
	srl	a
	srl	a
	srl	a
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/clk.h: 117: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 120: static inline uint8_t clk_lsi_osc_is_enabled(void) {
;	-----------------------------------------
;	 function clk_lsi_osc_is_enabled
;	-----------------------------------------
_clk_lsi_osc_is_enabled:
;	.\../STM8S103F3_Drivers/clk.h: 121: return ((CLK->ICKR >> 3) & 1);
	ld	a, 0x50c0
	swap	a
	sll	a
	clr	a
	rlc	a
;	.\../STM8S103F3_Drivers/clk.h: 122: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 124: static inline void clk_lsi_osc_enable(void) {
;	-----------------------------------------
;	 function clk_lsi_osc_enable
;	-----------------------------------------
_clk_lsi_osc_enable:
;	.\../STM8S103F3_Drivers/clk.h: 125: CLK->ICKR |= (1U << 3);
	bset	0x50c0, #3
;	.\../STM8S103F3_Drivers/clk.h: 126: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 128: static inline void clk_lsi_osc_disable(void) {
;	-----------------------------------------
;	 function clk_lsi_osc_disable
;	-----------------------------------------
_clk_lsi_osc_disable:
;	.\../STM8S103F3_Drivers/clk.h: 129: CLK->ICKR &= ~(1U << 3);
	bres	0x50c0, #3
;	.\../STM8S103F3_Drivers/clk.h: 130: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 135: static inline uint8_t clk_fast_hlt_wake_up_is_enabled(void) {
;	-----------------------------------------
;	 function clk_fast_hlt_wake_up_is_enabled
;	-----------------------------------------
_clk_fast_hlt_wake_up_is_enabled:
;	.\../STM8S103F3_Drivers/clk.h: 136: return ((CLK->ICKR >> 2) & 1);
	ld	a, 0x50c0
	srl	a
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/clk.h: 137: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 139: static inline void clk_fast_hlt_wake_up_enable(void) {
;	-----------------------------------------
;	 function clk_fast_hlt_wake_up_enable
;	-----------------------------------------
_clk_fast_hlt_wake_up_enable:
;	.\../STM8S103F3_Drivers/clk.h: 140: CLK->ICKR |= (1U << 2);
	bset	0x50c0, #2
;	.\../STM8S103F3_Drivers/clk.h: 141: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 143: static inline void clk_fast_hlt_wake_up_disable(void) {
;	-----------------------------------------
;	 function clk_fast_hlt_wake_up_disable
;	-----------------------------------------
_clk_fast_hlt_wake_up_disable:
;	.\../STM8S103F3_Drivers/clk.h: 144: CLK->ICKR &= ~(1U << 2);
	bres	0x50c0, #2
;	.\../STM8S103F3_Drivers/clk.h: 145: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 150: static inline uint8_t clk_hsi_osc_is_ready(void) {
;	-----------------------------------------
;	 function clk_hsi_osc_is_ready
;	-----------------------------------------
_clk_hsi_osc_is_ready:
;	.\../STM8S103F3_Drivers/clk.h: 151: return ((CLK->ICKR >> 1) & 1);
	ld	a, 0x50c0
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/clk.h: 152: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 155: static inline uint8_t clk_hsi_osc_is_enabled(void) {
;	-----------------------------------------
;	 function clk_hsi_osc_is_enabled
;	-----------------------------------------
_clk_hsi_osc_is_enabled:
;	.\../STM8S103F3_Drivers/clk.h: 156: return ((CLK->ICKR >> 0) & 1);
	ld	a, 0x50c0
	and	a, #0x01
;	.\../STM8S103F3_Drivers/clk.h: 157: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 159: static inline void clk_hsi_osc_enable(void) {
;	-----------------------------------------
;	 function clk_hsi_osc_enable
;	-----------------------------------------
_clk_hsi_osc_enable:
;	.\../STM8S103F3_Drivers/clk.h: 160: CLK->ICKR |= (1U << 0);
	bset	0x50c0, #0
;	.\../STM8S103F3_Drivers/clk.h: 161: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 163: static inline void clk_hsi_osc_disable(void) {
;	-----------------------------------------
;	 function clk_hsi_osc_disable
;	-----------------------------------------
_clk_hsi_osc_disable:
;	.\../STM8S103F3_Drivers/clk.h: 164: CLK->ICKR &= ~(1U << 0);
	bres	0x50c0, #0
;	.\../STM8S103F3_Drivers/clk.h: 165: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 170: static inline uint8_t clk_hse_osc_is_ready(void) {
;	-----------------------------------------
;	 function clk_hse_osc_is_ready
;	-----------------------------------------
_clk_hse_osc_is_ready:
;	.\../STM8S103F3_Drivers/clk.h: 171: return ((CLK->ECKR >> 1) & 1);
	ld	a, 0x50c1
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/clk.h: 172: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 174: static inline void clk_hse_osc_enable(void) {
;	-----------------------------------------
;	 function clk_hse_osc_enable
;	-----------------------------------------
_clk_hse_osc_enable:
;	.\../STM8S103F3_Drivers/clk.h: 175: CLK->ECKR |= (1U << 0);
	bset	0x50c1, #0
;	.\../STM8S103F3_Drivers/clk.h: 176: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 178: static inline void clk_hse_osc_disable(void) {
;	-----------------------------------------
;	 function clk_hse_osc_disable
;	-----------------------------------------
_clk_hse_osc_disable:
;	.\../STM8S103F3_Drivers/clk.h: 179: CLK->ECKR &= ~(1U << 0);
	bres	0x50c1, #0
;	.\../STM8S103F3_Drivers/clk.h: 180: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 185: static inline uint8_t clk_master_clock_get_source(void) {
;	-----------------------------------------
;	 function clk_master_clock_get_source
;	-----------------------------------------
_clk_master_clock_get_source:
;	.\../STM8S103F3_Drivers/clk.h: 186: return CLK->CMSR;
	ld	a, 0x50c3
;	.\../STM8S103F3_Drivers/clk.h: 187: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 190: static inline void clk_master_switch_src(MASTER_CLK_SRC src) {
;	-----------------------------------------
;	 function clk_master_switch_src
;	-----------------------------------------
_clk_master_switch_src:
;	.\../STM8S103F3_Drivers/clk.h: 191: CLK->SWR = src;
	ld	0x50c4, a
;	.\../STM8S103F3_Drivers/clk.h: 192: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 195: static inline uint8_t clk_switch_is_ongoing(void) {
;	-----------------------------------------
;	 function clk_switch_is_ongoing
;	-----------------------------------------
_clk_switch_is_ongoing:
;	.\../STM8S103F3_Drivers/clk.h: 196: return ((CLK->SWCR >> 0) & 1);
	ld	a, 0x50c5
	and	a, #0x01
;	.\../STM8S103F3_Drivers/clk.h: 197: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 199: static inline void clk_switch_process_reset(void) {
;	-----------------------------------------
;	 function clk_switch_process_reset
;	-----------------------------------------
_clk_switch_process_reset:
;	.\../STM8S103F3_Drivers/clk.h: 200: CLK->SWCR &= ~(1U << 0);
	bres	0x50c5, #0
;	.\../STM8S103F3_Drivers/clk.h: 201: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 203: static inline void clk_switch_exec_enable(void) {
;	-----------------------------------------
;	 function clk_switch_exec_enable
;	-----------------------------------------
_clk_switch_exec_enable:
;	.\../STM8S103F3_Drivers/clk.h: 204: CLK->SWCR |= (1U << 1);
	bset	0x50c5, #1
;	.\../STM8S103F3_Drivers/clk.h: 205: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 207: static inline void clk_switch_exec_disable(void) {
;	-----------------------------------------
;	 function clk_switch_exec_disable
;	-----------------------------------------
_clk_switch_exec_disable:
;	.\../STM8S103F3_Drivers/clk.h: 208: CLK->SWCR &= ~(1U << 1);
	bres	0x50c5, #1
;	.\../STM8S103F3_Drivers/clk.h: 209: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 211: static inline void clk_switch_irq_enable(void) {
;	-----------------------------------------
;	 function clk_switch_irq_enable
;	-----------------------------------------
_clk_switch_irq_enable:
;	.\../STM8S103F3_Drivers/clk.h: 212: CLK->SWCR |= (1U << 2);
	bset	0x50c5, #2
;	.\../STM8S103F3_Drivers/clk.h: 213: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 215: static inline void clk_switch_irq_disable(void) {
;	-----------------------------------------
;	 function clk_switch_irq_disable
;	-----------------------------------------
_clk_switch_irq_disable:
;	.\../STM8S103F3_Drivers/clk.h: 216: CLK->SWCR &= ~(1U << 2);
	bres	0x50c5, #2
;	.\../STM8S103F3_Drivers/clk.h: 217: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 219: static inline uint8_t clk_target_src_clk_ready_manual_mode(void) {
;	-----------------------------------------
;	 function clk_target_src_clk_ready_manual_mode
;	-----------------------------------------
_clk_target_src_clk_ready_manual_mode:
;	.\../STM8S103F3_Drivers/clk.h: 220: return ((CLK->SWCR >> 3) & 1) ;
	ld	a, 0x50c5
	swap	a
	sll	a
	clr	a
	rlc	a
;	.\../STM8S103F3_Drivers/clk.h: 221: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 223: static inline uint8_t clk_switch_event_occured_auto_mode(void) {
;	-----------------------------------------
;	 function clk_switch_event_occured_auto_mode
;	-----------------------------------------
_clk_switch_event_occured_auto_mode:
;	.\../STM8S103F3_Drivers/clk.h: 224: return ((CLK->SWCR >> 3) & 1) ;
	ld	a, 0x50c5
	swap	a
	sll	a
	clr	a
	rlc	a
;	.\../STM8S103F3_Drivers/clk.h: 225: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 227: static inline void clk_switch_irq_flag_clear(void) {
;	-----------------------------------------
;	 function clk_switch_irq_flag_clear
;	-----------------------------------------
_clk_switch_irq_flag_clear:
;	.\../STM8S103F3_Drivers/clk.h: 228: CLK->SWCR &= ~(1U << 3);
	bres	0x50c5, #3
;	.\../STM8S103F3_Drivers/clk.h: 229: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 235: static inline void clk_cpu_div_prescalar_set(CPU_DIV_PRESCALAR value) {
;	-----------------------------------------
;	 function clk_cpu_div_prescalar_set
;	-----------------------------------------
_clk_cpu_div_prescalar_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/clk.h: 236: CLK->CKDIVR = ((CLK->CKDIVR & CLK_CKDIVR_CPU_CLR_MASK) | ((uint8_t)value) << 0);
	ld	a, 0x50c6
	and	a, #0xf8
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x50c6, a
;	.\../STM8S103F3_Drivers/clk.h: 237: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 239: static inline CPU_DIV_PRESCALAR clk_cpu_div_prescalar_read(void) {
;	-----------------------------------------
;	 function clk_cpu_div_prescalar_read
;	-----------------------------------------
_clk_cpu_div_prescalar_read:
;	.\../STM8S103F3_Drivers/clk.h: 240: return ((CPU_DIV_PRESCALAR)(CLK->CKDIVR & ~(CLK_CKDIVR_CPU_CLR_MASK)));
	ld	a, 0x50c6
	and	a, #0x07
;	.\../STM8S103F3_Drivers/clk.h: 241: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 243: static inline void clk_hsi_div_prescalar_set(HSI_DIV_PRESCALAR value) {
;	-----------------------------------------
;	 function clk_hsi_div_prescalar_set
;	-----------------------------------------
_clk_hsi_div_prescalar_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/clk.h: 244: CLK->CKDIVR = (CLK->CKDIVR & CLK_CKDIVR_HSI_CLR_MASK) | ((uint8_t)value << 3);
	ld	a, 0x50c6
	and	a, #0xe7
	sllw	x
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x50c6, a
;	.\../STM8S103F3_Drivers/clk.h: 245: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 247: static inline HSI_DIV_PRESCALAR clk_hsi_div_prescalar_read(void) {
;	-----------------------------------------
;	 function clk_hsi_div_prescalar_read
;	-----------------------------------------
_clk_hsi_div_prescalar_read:
;	.\../STM8S103F3_Drivers/clk.h: 248: return ((HSI_DIV_PRESCALAR)(CLK->CKDIVR & ~(CLK_CKDIVR_HSI_CLR_MASK)));
	ld	a, 0x50c6
	and	a, #0x18
;	.\../STM8S103F3_Drivers/clk.h: 249: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 251: static inline void  clk_hsi_and_cpu_div_prescalar_set(HSI_DIV_PRESCALAR hsi_value, CPU_DIV_PRESCALAR cpu_value) {
;	-----------------------------------------
;	 function clk_hsi_and_cpu_div_prescalar_set
;	-----------------------------------------
_clk_hsi_and_cpu_div_prescalar_set:
	push	a
	ld	xh, a
;	.\../STM8S103F3_Drivers/clk.h: 252: CLK->CKDIVR = (CLK->CKDIVR & (CLK_CKDIVR_HSI_CLR_MASK & CLK_CKDIVR_CPU_CLR_MASK)) 
	ld	a, 0x50c6
	and	a, #0xe0
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/clk.h: 253: | ((((uint8_t)hsi_value << 3) | ((uint8_t)cpu_value) << 0));
	rlwa	x
	sll	a
	sll	a
	sll	a
	rrwa	x
	ld	a, (0x04, sp)
	pushw	x
	or	a, (1, sp)
	popw	x
	or	a, (0x01, sp)
	ld	0x50c6, a
;	.\../STM8S103F3_Drivers/clk.h: 254: }
	pop	a
	popw	x
	pop	a
	jp	(x)
;	.\../STM8S103F3_Drivers/clk.h: 259: static inline void clk_periph_1_clock_enable(PERIPHERAL_1_CLK periph) {
;	-----------------------------------------
;	 function clk_periph_1_clock_enable
;	-----------------------------------------
_clk_periph_1_clock_enable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/clk.h: 260: CLK->PCKENR1 |= (1U << periph);
	ld	a, 0x50c7
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x50c7, a
;	.\../STM8S103F3_Drivers/clk.h: 261: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/clk.h: 263: static inline void clk_periph_1_clock_disable(PERIPHERAL_1_CLK periph) {
;	-----------------------------------------
;	 function clk_periph_1_clock_disable
;	-----------------------------------------
_clk_periph_1_clock_disable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/clk.h: 264: CLK->PCKENR1 &= ~(1U << periph);
	ld	a, 0x50c7
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x50c7, a
;	.\../STM8S103F3_Drivers/clk.h: 265: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/clk.h: 267: static inline void clk_periph_2_clock_enable(PERIPHERAL_2_CLK periph) {
;	-----------------------------------------
;	 function clk_periph_2_clock_enable
;	-----------------------------------------
_clk_periph_2_clock_enable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/clk.h: 268: CLK->PCKENR2 |= (1U << periph);
	ld	a, 0x50ca
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x50ca, a
;	.\../STM8S103F3_Drivers/clk.h: 269: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/clk.h: 271: static inline void clk_periph_2_clock_disable(PERIPHERAL_2_CLK periph) {
;	-----------------------------------------
;	 function clk_periph_2_clock_disable
;	-----------------------------------------
_clk_periph_2_clock_disable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/clk.h: 272: CLK->PCKENR2 &= ~(1U << periph);
	ld	a, 0x50ca
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x50ca, a
;	.\../STM8S103F3_Drivers/clk.h: 273: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/clk.h: 278: static inline void clk_security_sys_enable(void) {
;	-----------------------------------------
;	 function clk_security_sys_enable
;	-----------------------------------------
_clk_security_sys_enable:
;	.\../STM8S103F3_Drivers/clk.h: 279: CLK->CSSR |= (1U << 0);
	bset	0x50c8, #0
;	.\../STM8S103F3_Drivers/clk.h: 280: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 282: static inline void clk_security_sys_disable(void) {
;	-----------------------------------------
;	 function clk_security_sys_disable
;	-----------------------------------------
_clk_security_sys_disable:
;	.\../STM8S103F3_Drivers/clk.h: 283: CLK->CSSR &= ~(1U << 0);
	bres	0x50c8, #0
;	.\../STM8S103F3_Drivers/clk.h: 284: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 286: static inline uint8_t clk_aux_clock_is_active(void) {
;	-----------------------------------------
;	 function clk_aux_clock_is_active
;	-----------------------------------------
_clk_aux_clock_is_active:
;	.\../STM8S103F3_Drivers/clk.h: 287: return ((CLK->CSSR >> 1) & 1);
	ld	a, 0x50c8
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/clk.h: 288: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 290: static inline void clk_security_sys_irq_enable(void) {
;	-----------------------------------------
;	 function clk_security_sys_irq_enable
;	-----------------------------------------
_clk_security_sys_irq_enable:
;	.\../STM8S103F3_Drivers/clk.h: 291: CLK->CSSR |= (1U << 2);
	bset	0x50c8, #2
;	.\../STM8S103F3_Drivers/clk.h: 292: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 294: static inline void clk_security_sys_irq_disable(void) {
;	-----------------------------------------
;	 function clk_security_sys_irq_disable
;	-----------------------------------------
_clk_security_sys_irq_disable:
;	.\../STM8S103F3_Drivers/clk.h: 295: CLK->CSSR &= ~(1U << 2);
	bres	0x50c8, #2
;	.\../STM8S103F3_Drivers/clk.h: 296: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 298: static inline uint8_t clk_hse_clock_disturbance_is_detected(void) {
;	-----------------------------------------
;	 function clk_hse_clock_disturbance_is_detected
;	-----------------------------------------
_clk_hse_clock_disturbance_is_detected:
;	.\../STM8S103F3_Drivers/clk.h: 299: return ((CLK->CSSR >> 3) & 1);
	ld	a, 0x50c8
	swap	a
	sll	a
	clr	a
	rlc	a
;	.\../STM8S103F3_Drivers/clk.h: 300: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 302: static inline void clk_hse_clock_disturbance_detect_reg_clear(void) {
;	-----------------------------------------
;	 function clk_hse_clock_disturbance_detect_reg_clear
;	-----------------------------------------
_clk_hse_clock_disturbance_detect_reg_clear:
;	.\../STM8S103F3_Drivers/clk.h: 303: CLK->CSSR &= ~(1U << 3);
	bres	0x50c8, #3
;	.\../STM8S103F3_Drivers/clk.h: 304: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 309: static inline void clk_configurable_clock_output_enable(void) {
;	-----------------------------------------
;	 function clk_configurable_clock_output_enable
;	-----------------------------------------
_clk_configurable_clock_output_enable:
;	.\../STM8S103F3_Drivers/clk.h: 310: CLK->CCOR |= (1U << 0);
	bset	0x50c9, #0
;	.\../STM8S103F3_Drivers/clk.h: 311: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 313: static inline void clk_configurable_clock_output_disable(void) {
;	-----------------------------------------
;	 function clk_configurable_clock_output_disable
;	-----------------------------------------
_clk_configurable_clock_output_disable:
;	.\../STM8S103F3_Drivers/clk.h: 314: CLK->CCOR &= ~(1U << 0);
	bres	0x50c9, #0
;	.\../STM8S103F3_Drivers/clk.h: 315: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 317: static inline void clk_output_source_set(CLK_CCO_SOURCE source) {
;	-----------------------------------------
;	 function clk_output_source_set
;	-----------------------------------------
_clk_output_source_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/clk.h: 318: CLK->CCOR = (CLK->CCOR & ~(0x0F << 1)) | ((uint8_t)source << 1);
	ld	a, 0x50c9
	and	a, #0xe1
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x50c9, a
;	.\../STM8S103F3_Drivers/clk.h: 319: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 321: static inline uint8_t clk_configurable_clock_output_is_ready(void) {
;	-----------------------------------------
;	 function clk_configurable_clock_output_is_ready
;	-----------------------------------------
_clk_configurable_clock_output_is_ready:
;	.\../STM8S103F3_Drivers/clk.h: 322: return ((CLK->CCOR >> 5) & 1);
	ld	a, 0x50c9
	swap	a
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/clk.h: 323: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 325: static inline uint8_t clk_configurable_clock_output_src_is_switching(void) {
;	-----------------------------------------
;	 function clk_configurable_clock_output_src_is_switching
;	-----------------------------------------
_clk_configurable_clock_output_src_is_switching:
;	.\../STM8S103F3_Drivers/clk.h: 326: return ((CLK->CCOR >> 6) & 1);
	ld	a, 0x50c9
	sll	a
	sll	a
	clr	a
	rlc	a
;	.\../STM8S103F3_Drivers/clk.h: 327: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 332: static inline void clk_hsi_osc_trim_value_set(uint8_t trim_val) {
;	-----------------------------------------
;	 function clk_hsi_osc_trim_value_set
;	-----------------------------------------
_clk_hsi_osc_trim_value_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/clk.h: 333: CLK->HSITRIMR = ((CLK->HSITRIMR & CLK_HSI_TRIM_CLR_MASK) | (trim_val & 0x07));
	ld	a, 0x50cc
	and	a, #0xf8
	ld	(0x01, sp), a
	ld	a, xl
	and	a, #0x07
	or	a, (0x01, sp)
	ld	0x50cc, a
;	.\../STM8S103F3_Drivers/clk.h: 334: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/clk.h: 339: static inline void clk_swim_clock_div2_enable(void) {
;	-----------------------------------------
;	 function clk_swim_clock_div2_enable
;	-----------------------------------------
_clk_swim_clock_div2_enable:
;	.\../STM8S103F3_Drivers/clk.h: 340: CLK->SWIMCCR &= ~(1U << 0);
	bres	0x50cd, #0
;	.\../STM8S103F3_Drivers/clk.h: 341: }
	ret
;	.\../STM8S103F3_Drivers/clk.h: 343: static inline void clk_swim_clock_div2_disable(void) {
;	-----------------------------------------
;	 function clk_swim_clock_div2_disable
;	-----------------------------------------
_clk_swim_clock_div2_disable:
;	.\../STM8S103F3_Drivers/clk.h: 344: CLK->SWIMCCR |= (1U << 0);
	bset	0x50cd, #0
;	.\../STM8S103F3_Drivers/clk.h: 345: }
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 50: static inline void gpio_multi_mode_fast_config(GPIO_PORT_REG *port, GPIO_MULTI_MODE mode, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_multi_mode_fast_config
;	-----------------------------------------
_gpio_multi_mode_fast_config:
	sub	sp, #9
	ldw	(0x08, sp), x
	ld	(0x07, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 51: uint8_t pin_mask = (1U << pin);
	ld	a, #0x01
	ld	(0x01, sp), a
	ld	a, (0x0c, sp)
	jreq	00131$
00130$:
	sll	(0x01, sp)
	dec	a
	jrne	00130$
00131$:
;	.\../STM8S103F3_Drivers/gpio.h: 52: port->DDR = (DDR_SET_HIGH(mode)) ? (port->DDR | pin_mask) : (port->DDR & ~(pin_mask));
	ldw	x, (0x08, sp)
	incw	x
	incw	x
	ldw	(0x02, sp), x
	ld	a, (0x07, sp)
	srl	a
	srl	a
	and	a, #0x01
	ld	(0x04, sp), a
	ldw	x, (0x02, sp)
	ld	a, (x)
	ld	(0x05, sp), a
	ld	a, (0x01, sp)
	cpl	a
	ld	(0x06, sp), a
	tnz	(0x04, sp)
	jreq	00103$
	ld	a, (0x05, sp)
	or	a, (0x01, sp)
	jra	00104$
00103$:
	ld	a, (0x05, sp)
	and	a, (0x06, sp)
00104$:
	ldw	x, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 53: port->CR1 = (CR1_SET_HIGH(mode)) ? (port->CR1 | pin_mask) : (port->CR1 & ~(pin_mask));
	ldw	x, (0x08, sp)
	addw	x, #0x0003
	ldw	(0x03, sp), x
	ld	a, (0x07, sp)
	srl	a
	and	a, #0x01
	ld	(0x05, sp), a
	ldw	x, (0x03, sp)
	ld	a, (x)
	tnz	(0x05, sp)
	jreq	00105$
	or	a, (0x01, sp)
	jra	00106$
00105$:
	and	a, (0x06, sp)
00106$:
	ldw	x, (0x03, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 54: port->CR2 = (CR2_SET_HIGH(mode)) ? (port->CR2 | pin_mask) : (port->CR2 & ~(pin_mask));
	ldw	x, (0x08, sp)
	addw	x, #0x0004
	ld	a, (0x07, sp)
	and	a, #0x01
	ld	(0x05, sp), a
	ld	a, (x)
	tnz	(0x05, sp)
	jreq	00107$
	or	a, (0x01, sp)
	jra	00108$
00107$:
	and	a, (0x06, sp)
00108$:
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 55: }
	addw	sp, #9
	popw	x
	pop	a
	jp	(x)
;	.\../STM8S103F3_Drivers/gpio.h: 60: static inline void gpio_in_float_no_irq(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_in_float_no_irq
;	-----------------------------------------
_gpio_in_float_no_irq:
	sub	sp, #3
	exgw	x, y
	ld	(0x03, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 61: port->DDR &= ~(1U << pin);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x04, sp)
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	ld	(0x02, sp), a
	ld	a, (0x01, sp)
	and	a, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 62: port->CR1 &= ~(1U << pin);
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	and	a, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 63: port->CR2 &= ~(1U << pin);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	and	a, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 64: }
	addw	sp, #3
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 66: static inline void gpio_in_pull_up_no_irq(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_in_pull_up_no_irq
;	-----------------------------------------
_gpio_in_pull_up_no_irq:
	sub	sp, #4
	exgw	x, y
	ld	(0x04, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 67: port->DDR &= ~(1U << pin);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x04, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	ld	a, (0x02, sp)
	cpl	a
	ld	(0x03, sp), a
	ld	a, (0x01, sp)
	and	a, (0x03, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 68: port->CR1 |= (1U << pin);
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	or	a, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 69: port->CR2 &= ~(1U << pin);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	and	a, (0x03, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 70: }
	addw	sp, #4
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 72: static inline void gpio_in_float_with_irq(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_in_float_with_irq
;	-----------------------------------------
_gpio_in_float_with_irq:
	sub	sp, #4
	exgw	x, y
	ld	(0x04, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 73: port->DDR &= ~(1U << pin);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x04, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	ld	a, (0x02, sp)
	cpl	a
	ld	(0x03, sp), a
	ld	a, (0x01, sp)
	and	a, (0x03, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 74: port->CR1 &= ~(1U << pin);
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	and	a, (0x03, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 75: port->CR2 |= (1U << pin);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	or	a, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 76: }
	addw	sp, #4
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 78: static inline void gpio_in_pull_up_with_irq(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_in_pull_up_with_irq
;	-----------------------------------------
_gpio_in_pull_up_with_irq:
	sub	sp, #3
	exgw	x, y
	ld	(0x03, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 79: port->DDR &= ~(1U << pin);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	ld	a, (0x02, sp)
	cpl	a
	and	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 80: port->CR1 |= (1U << pin); 
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	or	a, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 81: port->CR2 |= (1U << pin);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	or	a, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 82: }
	addw	sp, #3
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 86: static inline void gpio_out_open_drain(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_out_open_drain
;	-----------------------------------------
_gpio_out_open_drain:
	sub	sp, #2
	exgw	x, y
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 87: port->DDR |= (1U << pin);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 88: port->CR1 &= ~(1U << pin);
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	push	a
	cpl	(0x02, sp)
	pop	a
	and	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 89: port->CR2 &= ~(1U << pin);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	and	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 90: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 92: static inline void gpio_out_push_pull(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_out_push_pull
;	-----------------------------------------
_gpio_out_push_pull:
	sub	sp, #3
	exgw	x, y
	ld	(0x03, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 93: port->DDR |= (1U << pin);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x04, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 94: port->CR1 |= (1U << pin);
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 95: port->CR2 &= ~(1U << pin);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	ld	(0x02, sp), a
	ld	a, (0x01, sp)
	cpl	a
	and	a, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 96: }
	addw	sp, #3
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 98: static inline void gpio_out_open_drain_fast_mode(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_out_open_drain_fast_mode
;	-----------------------------------------
_gpio_out_open_drain_fast_mode:
	sub	sp, #3
	exgw	x, y
	ld	(0x03, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 99: port->DDR |= (1U << pin);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x04, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 100: port->CR1 &= ~(1U << pin);
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	ld	(0x02, sp), a
	ld	a, (0x01, sp)
	cpl	a
	and	a, (0x02, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 101: port->CR2 |= (1U << pin);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 102: }
	addw	sp, #3
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 104: static inline void gpio_out_push_pull_fast_mode(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_out_push_pull_fast_mode
;	-----------------------------------------
_gpio_out_push_pull_fast_mode:
	sub	sp, #2
	exgw	x, y
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 105: port->DDR |= (1U << pin);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 106: port->CR1 |= (1U << pin);
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 107: port->CR2 |= (1U << pin);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 108: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 113: static inline void gpio_mode_output_init(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_mode_output_init
;	-----------------------------------------
_gpio_mode_output_init:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 114: port->DDR |= (1U << pin);
	incw	x
	incw	x
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 115: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 117: static inline void gpio_mode_input_init(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_mode_input_init
;	-----------------------------------------
_gpio_mode_input_init:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 118: port->DDR &= ~(1U << pin);
	incw	x
	incw	x
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 119: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 123: static inline void gpio_in_pull_up_enable(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_in_pull_up_enable
;	-----------------------------------------
_gpio_in_pull_up_enable:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 124: port->CR1 |= (1U << pin);
	addw	x, #0x0003
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 125: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 127: static inline void gpio_in_pull_up_disable(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_in_pull_up_disable
;	-----------------------------------------
_gpio_in_pull_up_disable:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 128: port->CR1 &= ~(1U << pin);
	addw	x, #0x0003
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 129: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 131: static inline void gpio_in_irq_enable(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_in_irq_enable
;	-----------------------------------------
_gpio_in_irq_enable:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 132: port->CR2 |= (1U << pin);
	addw	x, #0x0004
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 133: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 135: static inline void gpio_in_irq_disable(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_in_irq_disable
;	-----------------------------------------
_gpio_in_irq_disable:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 136: port->CR2 &= ~(1U << pin);
	addw	x, #0x0004
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 137: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 141: static inline void gpio_out_push_pull_enable(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_out_push_pull_enable
;	-----------------------------------------
_gpio_out_push_pull_enable:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 142: port->CR1 |= (1U << pin);
	addw	x, #0x0003
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 143: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 145: static inline void gpio_out_open_drain_enable(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_out_open_drain_enable
;	-----------------------------------------
_gpio_out_open_drain_enable:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 146: port->CR1 &= ~(1U << pin);
	addw	x, #0x0003
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 147: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 149: static inline void gpio_out_fast_mode_enable(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_out_fast_mode_enable
;	-----------------------------------------
_gpio_out_fast_mode_enable:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 150: port->CR2 |= (1U << pin);
	addw	x, #0x0004
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 151: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 153: static inline void gpio_out_fast_mode_disable(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_out_fast_mode_disable
;	-----------------------------------------
_gpio_out_fast_mode_disable:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 154: port->CR2 &= ~(1U << pin);
	addw	x, #0x0004
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 155: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 161: static inline uint8_t gpio_input_fast_read(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_input_fast_read
;	-----------------------------------------
_gpio_input_fast_read:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 162: return ((port->IDR >> pin) & 1);   
	ld	a, (0x1, x)
	push	a
	ld	a, (0x02, sp)
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/gpio.h: 163: }
	addw	sp, #1
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 171: static inline void gpio_output_fast_set(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_output_fast_set
;	-----------------------------------------
_gpio_output_fast_set:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 172: port->ODR |= (1U << pin);
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 173: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 177: static inline void gpio_output_fast_clear(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_output_fast_clear
;	-----------------------------------------
_gpio_output_fast_clear:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 178: port->ODR &= ~(1U << pin);
	ld	a, (x)
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 179: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 185: static inline uint8_t gpio_output_fast_read(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_output_fast_read
;	-----------------------------------------
_gpio_output_fast_read:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 186: return ((port->ODR >> pin) & 1);
	ld	a, (x)
	push	a
	ld	a, (0x02, sp)
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/gpio.h: 187: }
	addw	sp, #1
	ret
;	.\../STM8S103F3_Drivers/gpio.h: 193: static inline void gpio_output_fast_toggle(GPIO_PORT_REG *port, uint8_t pin) {
;	-----------------------------------------
;	 function gpio_output_fast_toggle
;	-----------------------------------------
_gpio_output_fast_toggle:
	sub	sp, #2
	ld	(0x02, sp), a
;	.\../STM8S103F3_Drivers/gpio.h: 194: port->ODR ^= (1U << pin);
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, (0x03, sp)
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	xor	a, (0x01, sp)
	ld	(x), a
;	.\../STM8S103F3_Drivers/gpio.h: 195: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 244: static inline void tim4_counter_enable(void) {
;	-----------------------------------------
;	 function tim4_counter_enable
;	-----------------------------------------
_tim4_counter_enable:
;	.\../STM8S103F3_Drivers/timer.h: 245: TIM4->CR1 |= (1U << 0);
	bset	0x5340, #0
;	.\../STM8S103F3_Drivers/timer.h: 246: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 248: static inline void tim4_counter_disable(void) {
;	-----------------------------------------
;	 function tim4_counter_disable
;	-----------------------------------------
_tim4_counter_disable:
;	.\../STM8S103F3_Drivers/timer.h: 249: TIM4->CR1 &= ~(1U << 0);
	bres	0x5340, #0
;	.\../STM8S103F3_Drivers/timer.h: 250: } 
	ret
;	.\../STM8S103F3_Drivers/timer.h: 252: static inline void tim4_auto_update_event_enable(void) {
;	-----------------------------------------
;	 function tim4_auto_update_event_enable
;	-----------------------------------------
_tim4_auto_update_event_enable:
;	.\../STM8S103F3_Drivers/timer.h: 253: TIM4->CR1 &= ~(1U << 1);
	bres	0x5340, #1
;	.\../STM8S103F3_Drivers/timer.h: 254: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 256: static inline void tim4_auto_update_event_disable(void) {
;	-----------------------------------------
;	 function tim4_auto_update_event_disable
;	-----------------------------------------
_tim4_auto_update_event_disable:
;	.\../STM8S103F3_Drivers/timer.h: 257: TIM4->CR1 |= (1U << 1);
	bset	0x5340, #1
;	.\../STM8S103F3_Drivers/timer.h: 258: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 260: static inline void tim4_update_req_src_any_event_set(void) {
;	-----------------------------------------
;	 function tim4_update_req_src_any_event_set
;	-----------------------------------------
_tim4_update_req_src_any_event_set:
;	.\../STM8S103F3_Drivers/timer.h: 261: TIM4->CR1 &= ~(1U << 2);
	bres	0x5340, #2
;	.\../STM8S103F3_Drivers/timer.h: 262: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 264: static inline void tim4_update_req_src_overflow_underflow_only_set(void) {
;	-----------------------------------------
;	 function tim4_update_req_src_overflow_underflow_only_set
;	-----------------------------------------
_tim4_update_req_src_overflow_underflow_only_set:
;	.\../STM8S103F3_Drivers/timer.h: 265: TIM4->CR1 |= (1U << 2);
	bset	0x5340, #2
;	.\../STM8S103F3_Drivers/timer.h: 266: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 268: static inline void tim4_one_pulse_mode_enable(void) {
;	-----------------------------------------
;	 function tim4_one_pulse_mode_enable
;	-----------------------------------------
_tim4_one_pulse_mode_enable:
;	.\../STM8S103F3_Drivers/timer.h: 269: TIM4->CR1 |= (1U << 3);
	bset	0x5340, #3
;	.\../STM8S103F3_Drivers/timer.h: 270: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 272: static inline void tim4_one_pulse_mode_disable(void) {
;	-----------------------------------------
;	 function tim4_one_pulse_mode_disable
;	-----------------------------------------
_tim4_one_pulse_mode_disable:
;	.\../STM8S103F3_Drivers/timer.h: 273: TIM4->CR1 &= ~(1U << 3);
	bres	0x5340, #3
;	.\../STM8S103F3_Drivers/timer.h: 274: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 276: static inline void tim4_auto_reload_preload_enable(void) {
;	-----------------------------------------
;	 function tim4_auto_reload_preload_enable
;	-----------------------------------------
_tim4_auto_reload_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 277: TIM4->CR1 |= (1U << 7);
	bset	0x5340, #7
;	.\../STM8S103F3_Drivers/timer.h: 278: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 280: static inline void tim4_auto_reload_preload_disable(void) {
;	-----------------------------------------
;	 function tim4_auto_reload_preload_disable
;	-----------------------------------------
_tim4_auto_reload_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 281: TIM4->CR1 &= ~(1U << 7);
	bres	0x5340, #7
;	.\../STM8S103F3_Drivers/timer.h: 282: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 287: static inline void tim4_update_irq_enable(void) {
;	-----------------------------------------
;	 function tim4_update_irq_enable
;	-----------------------------------------
_tim4_update_irq_enable:
;	.\../STM8S103F3_Drivers/timer.h: 288: TIM4->IER |= (1U << 0);
	bset	0x5343, #0
;	.\../STM8S103F3_Drivers/timer.h: 289: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 291: static inline void tim4_update_irq_disable(void) {
;	-----------------------------------------
;	 function tim4_update_irq_disable
;	-----------------------------------------
_tim4_update_irq_disable:
;	.\../STM8S103F3_Drivers/timer.h: 292: TIM4->IER &= ~(1U << 0);
	bres	0x5343, #0
;	.\../STM8S103F3_Drivers/timer.h: 293: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 298: static inline void tim4_update_irq_flag_clear(void) {
;	-----------------------------------------
;	 function tim4_update_irq_flag_clear
;	-----------------------------------------
_tim4_update_irq_flag_clear:
;	.\../STM8S103F3_Drivers/timer.h: 299: TIM4->SR &= ~(1U << 0);
	bres	0x5344, #0
;	.\../STM8S103F3_Drivers/timer.h: 300: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 302: static inline uint8_t tim4_update_irq_flag_read(void) {
;	-----------------------------------------
;	 function tim4_update_irq_flag_read
;	-----------------------------------------
_tim4_update_irq_flag_read:
;	.\../STM8S103F3_Drivers/timer.h: 303: return ((TIM4->SR >> 0) & 1);
	ld	a, 0x5344
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 304: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 309: static inline void tim4_update_event_generate(void) {
;	-----------------------------------------
;	 function tim4_update_event_generate
;	-----------------------------------------
_tim4_update_event_generate:
;	.\../STM8S103F3_Drivers/timer.h: 310: TIM4->EGR |= (1U << 0);
	bset	0x5345, #0
;	.\../STM8S103F3_Drivers/timer.h: 311: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 316: static inline void tim4_counter_write(uint8_t value) {
;	-----------------------------------------
;	 function tim4_counter_write
;	-----------------------------------------
_tim4_counter_write:
;	.\../STM8S103F3_Drivers/timer.h: 317: TIM4->CNTR = value;    
	ld	0x5346, a
;	.\../STM8S103F3_Drivers/timer.h: 318: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 320: static inline uint8_t tim4_counter_read(void) {
;	-----------------------------------------
;	 function tim4_counter_read
;	-----------------------------------------
_tim4_counter_read:
;	.\../STM8S103F3_Drivers/timer.h: 321: return TIM4->CNTR;
	ld	a, 0x5346
;	.\../STM8S103F3_Drivers/timer.h: 322: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 327: static inline void tim4_prescaler_set(uint8_t value) {
;	-----------------------------------------
;	 function tim4_prescaler_set
;	-----------------------------------------
_tim4_prescaler_set:
;	.\../STM8S103F3_Drivers/timer.h: 328: TIM4->PSCR = value & 0x0F;
	and	a, #0x0f
	ld	0x5347, a
;	.\../STM8S103F3_Drivers/timer.h: 329: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 331: static inline uint8_t tim4_prescaler_read(void) {
;	-----------------------------------------
;	 function tim4_prescaler_read
;	-----------------------------------------
_tim4_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 332: return TIM4->PSCR;
	ld	a, 0x5347
;	.\../STM8S103F3_Drivers/timer.h: 333: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 338: static inline void tim4_auto_reload_set(uint8_t value) {
;	-----------------------------------------
;	 function tim4_auto_reload_set
;	-----------------------------------------
_tim4_auto_reload_set:
;	.\../STM8S103F3_Drivers/timer.h: 339: TIM4->ARR = value;
	ld	0x5348, a
;	.\../STM8S103F3_Drivers/timer.h: 340: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 342: static inline uint8_t tim4_auto_reload_read(void) {
;	-----------------------------------------
;	 function tim4_auto_reload_read
;	-----------------------------------------
_tim4_auto_reload_read:
;	.\../STM8S103F3_Drivers/timer.h: 343: return TIM4->ARR;
	ld	a, 0x5348
;	.\../STM8S103F3_Drivers/timer.h: 344: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 350: static inline void tim2_counter_enable(void) {
;	-----------------------------------------
;	 function tim2_counter_enable
;	-----------------------------------------
_tim2_counter_enable:
;	.\../STM8S103F3_Drivers/timer.h: 351: TIM2->CR1 |= (1U << 0);
	bset	0x5300, #0
;	.\../STM8S103F3_Drivers/timer.h: 352: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 354: static inline void tim2_counter_disable(void) {
;	-----------------------------------------
;	 function tim2_counter_disable
;	-----------------------------------------
_tim2_counter_disable:
;	.\../STM8S103F3_Drivers/timer.h: 355: TIM2->CR1 &= ~(1U << 0);
	bres	0x5300, #0
;	.\../STM8S103F3_Drivers/timer.h: 356: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 358: static inline void tim2_auto_update_event_enable(void) {
;	-----------------------------------------
;	 function tim2_auto_update_event_enable
;	-----------------------------------------
_tim2_auto_update_event_enable:
;	.\../STM8S103F3_Drivers/timer.h: 359: TIM2->CR1 &= ~(1U << 1);
	bres	0x5300, #1
;	.\../STM8S103F3_Drivers/timer.h: 360: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 362: static inline void tim2_auto_update_event_disable(void) {
;	-----------------------------------------
;	 function tim2_auto_update_event_disable
;	-----------------------------------------
_tim2_auto_update_event_disable:
;	.\../STM8S103F3_Drivers/timer.h: 363: TIM2->CR1 |= (1U << 1);
	bset	0x5300, #1
;	.\../STM8S103F3_Drivers/timer.h: 364: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 366: static inline void tim2_update_req_src_any_event_set(void) {
;	-----------------------------------------
;	 function tim2_update_req_src_any_event_set
;	-----------------------------------------
_tim2_update_req_src_any_event_set:
;	.\../STM8S103F3_Drivers/timer.h: 367: TIM2->CR1 &= ~(1U << 2);
	bres	0x5300, #2
;	.\../STM8S103F3_Drivers/timer.h: 368: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 370: static inline void tim2_update_req_src_overflow_underflow_only_set(void) {
;	-----------------------------------------
;	 function tim2_update_req_src_overflow_underflow_only_set
;	-----------------------------------------
_tim2_update_req_src_overflow_underflow_only_set:
;	.\../STM8S103F3_Drivers/timer.h: 371: TIM2->CR1 |= (1U << 2);
	bset	0x5300, #2
;	.\../STM8S103F3_Drivers/timer.h: 372: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 374: static inline void tim2_one_pulse_mode_enable(void) {
;	-----------------------------------------
;	 function tim2_one_pulse_mode_enable
;	-----------------------------------------
_tim2_one_pulse_mode_enable:
;	.\../STM8S103F3_Drivers/timer.h: 375: TIM2->CR1 |= (1U << 3);
	bset	0x5300, #3
;	.\../STM8S103F3_Drivers/timer.h: 376: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 378: static inline void tim2_one_pulse_mode_disable(void) {
;	-----------------------------------------
;	 function tim2_one_pulse_mode_disable
;	-----------------------------------------
_tim2_one_pulse_mode_disable:
;	.\../STM8S103F3_Drivers/timer.h: 379: TIM2->CR1 &= ~(1U << 3);
	bres	0x5300, #3
;	.\../STM8S103F3_Drivers/timer.h: 380: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 382: static inline void tim2_auto_reload_preload_enable(void) {
;	-----------------------------------------
;	 function tim2_auto_reload_preload_enable
;	-----------------------------------------
_tim2_auto_reload_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 383: TIM2->CR1 |= (1U << 7);
	bset	0x5300, #7
;	.\../STM8S103F3_Drivers/timer.h: 384: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 386: static inline void tim2_auto_reload_preload_disable(void) {
;	-----------------------------------------
;	 function tim2_auto_reload_preload_disable
;	-----------------------------------------
_tim2_auto_reload_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 387: TIM2->CR1 &= ~(1U << 7);
	bres	0x5300, #7
;	.\../STM8S103F3_Drivers/timer.h: 388: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 393: static inline void tim2_update_irq_enable(void) {
;	-----------------------------------------
;	 function tim2_update_irq_enable
;	-----------------------------------------
_tim2_update_irq_enable:
;	.\../STM8S103F3_Drivers/timer.h: 394: TIM2->IER |= (1U << 0);
	bset	0x5303, #0
;	.\../STM8S103F3_Drivers/timer.h: 395: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 397: static inline void tim2_update_irq_disable(void) {
;	-----------------------------------------
;	 function tim2_update_irq_disable
;	-----------------------------------------
_tim2_update_irq_disable:
;	.\../STM8S103F3_Drivers/timer.h: 398: TIM2->IER &= ~(1U << 0);
	bres	0x5303, #0
;	.\../STM8S103F3_Drivers/timer.h: 399: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 401: static inline void tim2_capture_compare1_irq_enable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_irq_enable
;	-----------------------------------------
_tim2_capture_compare1_irq_enable:
;	.\../STM8S103F3_Drivers/timer.h: 402: TIM2->IER |= (1U << 1);
	bset	0x5303, #1
;	.\../STM8S103F3_Drivers/timer.h: 403: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 405: static inline void tim2_capture_compare1_irq_disable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_irq_disable
;	-----------------------------------------
_tim2_capture_compare1_irq_disable:
;	.\../STM8S103F3_Drivers/timer.h: 406: TIM2->IER &= ~(1U << 1);
	bres	0x5303, #1
;	.\../STM8S103F3_Drivers/timer.h: 407: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 409: static inline void tim2_capture_compare2_irq_enable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_irq_enable
;	-----------------------------------------
_tim2_capture_compare2_irq_enable:
;	.\../STM8S103F3_Drivers/timer.h: 410: TIM2->IER |= (1U << 2);
	bset	0x5303, #2
;	.\../STM8S103F3_Drivers/timer.h: 411: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 413: static inline void tim2_capture_compare2_irq_disable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_irq_disable
;	-----------------------------------------
_tim2_capture_compare2_irq_disable:
;	.\../STM8S103F3_Drivers/timer.h: 414: TIM2->IER &= ~(1U << 2);
	bres	0x5303, #2
;	.\../STM8S103F3_Drivers/timer.h: 415: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 417: static inline void tim2_capture_compare3_irq_enable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_irq_enable
;	-----------------------------------------
_tim2_capture_compare3_irq_enable:
;	.\../STM8S103F3_Drivers/timer.h: 418: TIM2->IER |= (1U << 3);
	bset	0x5303, #3
;	.\../STM8S103F3_Drivers/timer.h: 419: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 421: static inline void tim2_capture_compare3_irq_disable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_irq_disable
;	-----------------------------------------
_tim2_capture_compare3_irq_disable:
;	.\../STM8S103F3_Drivers/timer.h: 422: TIM2->IER &= ~(1U << 3);
	bres	0x5303, #3
;	.\../STM8S103F3_Drivers/timer.h: 423: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 428: static inline void tim2_update_irq_flag_clear(void) {
;	-----------------------------------------
;	 function tim2_update_irq_flag_clear
;	-----------------------------------------
_tim2_update_irq_flag_clear:
;	.\../STM8S103F3_Drivers/timer.h: 429: TIM2->SR1 &= ~(1U << 0);
	bres	0x5304, #0
;	.\../STM8S103F3_Drivers/timer.h: 430: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 432: static inline uint8_t tim2_update_irq_flag_read(void) {
;	-----------------------------------------
;	 function tim2_update_irq_flag_read
;	-----------------------------------------
_tim2_update_irq_flag_read:
;	.\../STM8S103F3_Drivers/timer.h: 433: return ((TIM2->SR1 >> 0) & 1);
	ld	a, 0x5304
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 434: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 436: static inline void tim2_capture_compare1_irq_flag_clear(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_irq_flag_clear
;	-----------------------------------------
_tim2_capture_compare1_irq_flag_clear:
;	.\../STM8S103F3_Drivers/timer.h: 437: TIM2->SR1 &= ~(1U << 1);
	bres	0x5304, #1
;	.\../STM8S103F3_Drivers/timer.h: 438: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 440: static inline uint8_t tim2_capture_compare1_irq_flag_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_irq_flag_read
;	-----------------------------------------
_tim2_capture_compare1_irq_flag_read:
;	.\../STM8S103F3_Drivers/timer.h: 441: return ((TIM2->SR1 >> 1) & 1);
	ld	a, 0x5304
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 442: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 444: static inline void tim2_capture_compare2_irq_flag_clear(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_irq_flag_clear
;	-----------------------------------------
_tim2_capture_compare2_irq_flag_clear:
;	.\../STM8S103F3_Drivers/timer.h: 445: TIM2->SR1 &= ~(1U << 2);
	bres	0x5304, #2
;	.\../STM8S103F3_Drivers/timer.h: 446: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 448: static inline uint8_t tim2_capture_compare2_irq_flag_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_irq_flag_read
;	-----------------------------------------
_tim2_capture_compare2_irq_flag_read:
;	.\../STM8S103F3_Drivers/timer.h: 449: return ((TIM2->SR1 >> 2) & 1);
	ld	a, 0x5304
	srl	a
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 450: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 452: static inline void tim2_capture_compare3_irq_flag_clear(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_irq_flag_clear
;	-----------------------------------------
_tim2_capture_compare3_irq_flag_clear:
;	.\../STM8S103F3_Drivers/timer.h: 453: TIM2->SR1 &= ~(1U << 3);
	bres	0x5304, #3
;	.\../STM8S103F3_Drivers/timer.h: 454: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 456: static inline uint8_t tim2_capture_compare3_irq_flag_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_irq_flag_read
;	-----------------------------------------
_tim2_capture_compare3_irq_flag_read:
;	.\../STM8S103F3_Drivers/timer.h: 457: return ((TIM2->SR1 >> 3) & 1);
	ld	a, 0x5304
	swap	a
	sll	a
	clr	a
	rlc	a
;	.\../STM8S103F3_Drivers/timer.h: 458: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 462: static inline void tim2_capture_compare1_overcapture_flag_clear(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_overcapture_flag_clear
;	-----------------------------------------
_tim2_capture_compare1_overcapture_flag_clear:
;	.\../STM8S103F3_Drivers/timer.h: 463: TIM2->SR2 &= ~(1U << 1);
	bres	0x5305, #1
;	.\../STM8S103F3_Drivers/timer.h: 464: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 466: static inline uint8_t tim2_capture_compare1_overcapture_flag_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_overcapture_flag_read
;	-----------------------------------------
_tim2_capture_compare1_overcapture_flag_read:
;	.\../STM8S103F3_Drivers/timer.h: 467: return ((TIM2->SR2 >> 1) & 1);
	ld	a, 0x5305
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 468: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 470: static inline void tim2_capture_compare2_overcapture_flag_clear(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_overcapture_flag_clear
;	-----------------------------------------
_tim2_capture_compare2_overcapture_flag_clear:
;	.\../STM8S103F3_Drivers/timer.h: 471: TIM2->SR2 &= ~(1U << 2);
	bres	0x5305, #2
;	.\../STM8S103F3_Drivers/timer.h: 472: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 474: static inline uint8_t tim2_capture_compare2_overcapture_flag_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_overcapture_flag_read
;	-----------------------------------------
_tim2_capture_compare2_overcapture_flag_read:
;	.\../STM8S103F3_Drivers/timer.h: 475: return ((TIM2->SR2 >> 2) & 1);
	ld	a, 0x5305
	srl	a
	srl	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 476: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 478: static inline void tim2_capture_compare3_overcapture_flag_clear(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_overcapture_flag_clear
;	-----------------------------------------
_tim2_capture_compare3_overcapture_flag_clear:
;	.\../STM8S103F3_Drivers/timer.h: 479: TIM2->SR2 &= ~(1U << 3);
	bres	0x5305, #3
;	.\../STM8S103F3_Drivers/timer.h: 480: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 482: static inline uint8_t tim2_capture_compare3_overcapture_flag_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_overcapture_flag_read
;	-----------------------------------------
_tim2_capture_compare3_overcapture_flag_read:
;	.\../STM8S103F3_Drivers/timer.h: 483: return ((TIM2->SR2 >> 3) & 1);
	ld	a, 0x5305
	swap	a
	sll	a
	clr	a
	rlc	a
;	.\../STM8S103F3_Drivers/timer.h: 484: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 489: static inline void tim2_update_event_generate(void) {
;	-----------------------------------------
;	 function tim2_update_event_generate
;	-----------------------------------------
_tim2_update_event_generate:
;	.\../STM8S103F3_Drivers/timer.h: 490: TIM2->EGR |= (1U << 0);
	bset	0x5306, #0
;	.\../STM8S103F3_Drivers/timer.h: 491: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 493: static inline void tim2_capture_compare1_event_generate(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_event_generate
;	-----------------------------------------
_tim2_capture_compare1_event_generate:
;	.\../STM8S103F3_Drivers/timer.h: 494: TIM2->EGR |= (1U << 1);
	bset	0x5306, #1
;	.\../STM8S103F3_Drivers/timer.h: 495: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 497: static inline void tim2_capture_compare2_event_generate(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_event_generate
;	-----------------------------------------
_tim2_capture_compare2_event_generate:
;	.\../STM8S103F3_Drivers/timer.h: 498: TIM2->EGR |= (1U << 2);
	bset	0x5306, #2
;	.\../STM8S103F3_Drivers/timer.h: 499: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 501: static inline void tim2_capture_compare3_event_generate(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_event_generate
;	-----------------------------------------
_tim2_capture_compare3_event_generate:
;	.\../STM8S103F3_Drivers/timer.h: 502: TIM2->EGR |= (1U << 3);
	bset	0x5306, #3
;	.\../STM8S103F3_Drivers/timer.h: 503: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 509: static inline void tim2_capture_compare1_channel_mode_set(TIM2_CC1_CHANNEL_MODE mode) {
;	-----------------------------------------
;	 function tim2_capture_compare1_channel_mode_set
;	-----------------------------------------
_tim2_capture_compare1_channel_mode_set:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/timer.h: 510: TIM2->CCMR1 = (TIM2->CCMR1 & TIM2_CC1_CHANNEL_MODE_CLR_MASK) | mode;
	ld	a, 0x5307
	and	a, #0xfc
	or	a, (0x01, sp)
	ld	0x5307, a
;	.\../STM8S103F3_Drivers/timer.h: 511: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 513: static inline TIM2_CC1_CHANNEL_MODE tim2_capture_compare1_channel_mode_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_channel_mode_read
;	-----------------------------------------
_tim2_capture_compare1_channel_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 514: return (TIM2_CC1_CHANNEL_MODE)(TIM2->CCMR1 & ~TIM2_CC1_CHANNEL_MODE_CLR_MASK);
	ld	a, 0x5307
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 515: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 518: static inline void tim2_capture_compare1_preload_enable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_preload_enable
;	-----------------------------------------
_tim2_capture_compare1_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 519: TIM2->CCMR1 |= (1U << 3);
	bset	0x5307, #3
;	.\../STM8S103F3_Drivers/timer.h: 520: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 522: static inline void tim2_capture_compare1_preload_disable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_preload_disable
;	-----------------------------------------
_tim2_capture_compare1_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 523: TIM2->CCMR1 &= ~(1U << 3);
	bres	0x5307, #3
;	.\../STM8S103F3_Drivers/timer.h: 524: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 526: static inline void tim2_output_compare1_mode_set(TIM2_OUTPUT_COMPARE_MODE mode) {
;	-----------------------------------------
;	 function tim2_output_compare1_mode_set
;	-----------------------------------------
_tim2_output_compare1_mode_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 527: TIM2->CCMR1 = (TIM2->CCMR1 & 0x8F) | ((uint8_t)mode << 4);
	ld	a, 0x5307
	and	a, #0x8f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5307, a
;	.\../STM8S103F3_Drivers/timer.h: 528: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 530: static inline TIM2_OUTPUT_COMPARE_MODE tim2_output_compare1_mode_read(void) {
;	-----------------------------------------
;	 function tim2_output_compare1_mode_read
;	-----------------------------------------
_tim2_output_compare1_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 531: return (TIM2_OUTPUT_COMPARE_MODE)((TIM2->CCMR1 >> 4) & 0x07);
	ld	a, 0x5307
	swap	a
	and	a, #7
;	.\../STM8S103F3_Drivers/timer.h: 532: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 536: static inline void tim2_input_capture1_prescaler_set(TIM2_INPUT_CAPTURE_PRESCALER psc) {
;	-----------------------------------------
;	 function tim2_input_capture1_prescaler_set
;	-----------------------------------------
_tim2_input_capture1_prescaler_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 537: TIM2->CCMR1 = (TIM2->CCMR1 & 0xF3) | ((uint8_t)psc << 2);
	ld	a, 0x5307
	and	a, #0xf3
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x5307, a
;	.\../STM8S103F3_Drivers/timer.h: 538: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 540: static inline TIM2_INPUT_CAPTURE_PRESCALER tim2_input_capture1_prescaler_read(void) {
;	-----------------------------------------
;	 function tim2_input_capture1_prescaler_read
;	-----------------------------------------
_tim2_input_capture1_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 541: return (TIM2_INPUT_CAPTURE_PRESCALER)((TIM2->CCMR1 >> 2) & 0x03);
	ld	a, 0x5307
	srl	a
	srl	a
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 542: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 544: static inline void tim2_input_capture1_filter_set(TIM2_INPUT_CAPTURE_FILTER filter) {
;	-----------------------------------------
;	 function tim2_input_capture1_filter_set
;	-----------------------------------------
_tim2_input_capture1_filter_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 545: TIM2->CCMR1 = (TIM2->CCMR1 & 0x0F) | ((uint8_t)filter << 4);
	ld	a, 0x5307
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5307, a
;	.\../STM8S103F3_Drivers/timer.h: 546: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 548: static inline TIM2_INPUT_CAPTURE_FILTER tim2_input_capture1_filter_read(void) {
;	-----------------------------------------
;	 function tim2_input_capture1_filter_read
;	-----------------------------------------
_tim2_input_capture1_filter_read:
;	.\../STM8S103F3_Drivers/timer.h: 549: return (TIM2_INPUT_CAPTURE_FILTER)(TIM2->CCMR1 >> 4) & 0x0F;
	ld	a, 0x5307
	swap	a
	and	a, #15
;	.\../STM8S103F3_Drivers/timer.h: 550: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 556: static inline void tim2_capture_compare2_channel_mode_set(TIM2_CC2_CHANNEL_MODE mode) {
;	-----------------------------------------
;	 function tim2_capture_compare2_channel_mode_set
;	-----------------------------------------
_tim2_capture_compare2_channel_mode_set:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/timer.h: 557: TIM2->CCMR2 = (TIM2->CCMR2 & 0xFC) | mode;
	ld	a, 0x5308
	and	a, #0xfc
	or	a, (0x01, sp)
	ld	0x5308, a
;	.\../STM8S103F3_Drivers/timer.h: 558: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 560: static inline TIM2_CC2_CHANNEL_MODE tim2_capture_compare2_channel_mode_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_channel_mode_read
;	-----------------------------------------
_tim2_capture_compare2_channel_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 561: return (TIM2_CC2_CHANNEL_MODE)(TIM2->CCMR2 & 0x03);
	ld	a, 0x5308
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 562: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 565: static inline void tim2_capture_compare2_preload_enable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_preload_enable
;	-----------------------------------------
_tim2_capture_compare2_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 566: TIM2->CCMR2 |= (1U << 3);
	bset	0x5308, #3
;	.\../STM8S103F3_Drivers/timer.h: 567: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 569: static inline void tim2_capture_compare2_preload_disable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_preload_disable
;	-----------------------------------------
_tim2_capture_compare2_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 570: TIM2->CCMR2 &= ~(1U << 3);
	bres	0x5308, #3
;	.\../STM8S103F3_Drivers/timer.h: 571: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 573: static inline void tim2_output_compare2_mode_set(TIM2_OUTPUT_COMPARE_MODE mode) {
;	-----------------------------------------
;	 function tim2_output_compare2_mode_set
;	-----------------------------------------
_tim2_output_compare2_mode_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 574: TIM2->CCMR2 = (TIM2->CCMR2 & 0x8F) | ((uint8_t)mode << 4);
	ld	a, 0x5308
	and	a, #0x8f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5308, a
;	.\../STM8S103F3_Drivers/timer.h: 575: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 577: static inline TIM2_OUTPUT_COMPARE_MODE tim2_output_compare2_mode_read(void) {
;	-----------------------------------------
;	 function tim2_output_compare2_mode_read
;	-----------------------------------------
_tim2_output_compare2_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 578: return (TIM2_OUTPUT_COMPARE_MODE)((TIM2->CCMR2 >> 4) & 0x07);
	ld	a, 0x5308
	swap	a
	and	a, #7
;	.\../STM8S103F3_Drivers/timer.h: 579: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 582: static inline void tim2_input_capture2_prescaler_set(TIM2_INPUT_CAPTURE_PRESCALER psc) {
;	-----------------------------------------
;	 function tim2_input_capture2_prescaler_set
;	-----------------------------------------
_tim2_input_capture2_prescaler_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 583: TIM2->CCMR2 = (TIM2->CCMR2 & 0xF3) | ((uint8_t)psc << 2);
	ld	a, 0x5308
	and	a, #0xf3
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x5308, a
;	.\../STM8S103F3_Drivers/timer.h: 584: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 586: static inline TIM2_INPUT_CAPTURE_PRESCALER tim2_input_capture2_prescaler_read(void) {
;	-----------------------------------------
;	 function tim2_input_capture2_prescaler_read
;	-----------------------------------------
_tim2_input_capture2_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 587: return (TIM2_INPUT_CAPTURE_PRESCALER)((TIM2->CCMR2 >> 2) & 0x03);
	ld	a, 0x5308
	srl	a
	srl	a
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 588: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 590: static inline void tim2_input_capture2_filter_set(TIM2_INPUT_CAPTURE_FILTER filter) {
;	-----------------------------------------
;	 function tim2_input_capture2_filter_set
;	-----------------------------------------
_tim2_input_capture2_filter_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 591: TIM2->CCMR2 = (TIM2->CCMR2 & 0x0F) | ((uint8_t)filter << 4);
	ld	a, 0x5308
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5308, a
;	.\../STM8S103F3_Drivers/timer.h: 592: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 594: static inline TIM2_INPUT_CAPTURE_FILTER tim2_input_capture2_filter_read(void) {
;	-----------------------------------------
;	 function tim2_input_capture2_filter_read
;	-----------------------------------------
_tim2_input_capture2_filter_read:
;	.\../STM8S103F3_Drivers/timer.h: 595: return (TIM2_INPUT_CAPTURE_FILTER)((TIM2->CCMR2 >> 4) & 0x0F);
	ld	a, 0x5308
	swap	a
	and	a, #15
;	.\../STM8S103F3_Drivers/timer.h: 596: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 602: static inline void tim2_capture_compare3_channel_mode_set(TIM2_CC3_CHANNEL_MODE mode) {
;	-----------------------------------------
;	 function tim2_capture_compare3_channel_mode_set
;	-----------------------------------------
_tim2_capture_compare3_channel_mode_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 603: TIM2->CCMR3 = (TIM2->CCMR3 & 0xFC) | mode;
	ld	a, 0x5309
	and	a, #0xfc
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x5309, a
;	.\../STM8S103F3_Drivers/timer.h: 604: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 606: static inline TIM2_CC3_CHANNEL_MODE tim2_capture_compare3_channel_mode_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_channel_mode_read
;	-----------------------------------------
_tim2_capture_compare3_channel_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 607: return (TIM2_CC3_CHANNEL_MODE)(TIM2->CCMR3 & 0x03);
	ld	a, 0x5309
	and	a, #0x03
	neg	a
	clr	a
	rlc	a
;	.\../STM8S103F3_Drivers/timer.h: 608: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 611: static inline void tim2_capture_compare3_preload_enable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_preload_enable
;	-----------------------------------------
_tim2_capture_compare3_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 612: TIM2->CCMR3 |= (1U << 3);
	bset	0x5309, #3
;	.\../STM8S103F3_Drivers/timer.h: 613: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 615: static inline void tim2_capture_compare3_preload_disable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_preload_disable
;	-----------------------------------------
_tim2_capture_compare3_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 616: TIM2->CCMR3 &= ~(1U << 3);
	bres	0x5309, #3
;	.\../STM8S103F3_Drivers/timer.h: 617: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 619: static inline void tim2_output_compare3_mode_set(TIM2_OUTPUT_COMPARE_MODE mode) {
;	-----------------------------------------
;	 function tim2_output_compare3_mode_set
;	-----------------------------------------
_tim2_output_compare3_mode_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 620: TIM2->CCMR3 = (TIM2->CCMR3 & 0x8F) | ((uint8_t)mode << 4);
	ld	a, 0x5309
	and	a, #0x8f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5309, a
;	.\../STM8S103F3_Drivers/timer.h: 621: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 623: static inline TIM2_OUTPUT_COMPARE_MODE tim2_output_compare3_mode_read(void) {
;	-----------------------------------------
;	 function tim2_output_compare3_mode_read
;	-----------------------------------------
_tim2_output_compare3_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 624: return (TIM2_OUTPUT_COMPARE_MODE)((TIM2->CCMR3 >> 4) & 0x07);
	ld	a, 0x5309
	swap	a
	and	a, #7
;	.\../STM8S103F3_Drivers/timer.h: 625: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 628: static inline void tim2_input_capture3_prescaler_set(TIM2_INPUT_CAPTURE_PRESCALER psc) {
;	-----------------------------------------
;	 function tim2_input_capture3_prescaler_set
;	-----------------------------------------
_tim2_input_capture3_prescaler_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 629: TIM2->CCMR3 = (TIM2->CCMR3 & 0xF3) | ((uint8_t)psc << 2);
	ld	a, 0x5309
	and	a, #0xf3
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x5309, a
;	.\../STM8S103F3_Drivers/timer.h: 630: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 632: static inline TIM2_INPUT_CAPTURE_PRESCALER tim2_input_capture3_prescaler_read(void) {
;	-----------------------------------------
;	 function tim2_input_capture3_prescaler_read
;	-----------------------------------------
_tim2_input_capture3_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 633: return (TIM2_INPUT_CAPTURE_PRESCALER)((TIM2->CCMR3 >> 2) & 0x03);
	ld	a, 0x5309
	srl	a
	srl	a
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 634: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 636: static inline void tim2_input_capture3_filter_set(TIM2_INPUT_CAPTURE_FILTER filter) {
;	-----------------------------------------
;	 function tim2_input_capture3_filter_set
;	-----------------------------------------
_tim2_input_capture3_filter_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 637: TIM2->CCMR3 = (TIM2->CCMR3 & 0x0F) | ((uint8_t)filter << 4);
	ld	a, 0x5309
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5309, a
;	.\../STM8S103F3_Drivers/timer.h: 638: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 640: static inline TIM2_INPUT_CAPTURE_FILTER tim2_input_capture3_filter_read(void) {
;	-----------------------------------------
;	 function tim2_input_capture3_filter_read
;	-----------------------------------------
_tim2_input_capture3_filter_read:
;	.\../STM8S103F3_Drivers/timer.h: 641: return (TIM2_INPUT_CAPTURE_FILTER)((TIM2->CCMR3 >> 4) & 0x0F);
	ld	a, 0x5309
	swap	a
	and	a, #15
;	.\../STM8S103F3_Drivers/timer.h: 642: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 647: static inline void tim2_capture_compare1_enable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_enable
;	-----------------------------------------
_tim2_capture_compare1_enable:
;	.\../STM8S103F3_Drivers/timer.h: 648: TIM2->CCER1 |= (1U << 0);
	bset	0x530a, #0
;	.\../STM8S103F3_Drivers/timer.h: 649: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 651: static inline void tim2_capture_compare1_disable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_disable
;	-----------------------------------------
_tim2_capture_compare1_disable:
;	.\../STM8S103F3_Drivers/timer.h: 652: TIM2->CCER1 &= ~(1U << 0);
	bres	0x530a, #0
;	.\../STM8S103F3_Drivers/timer.h: 653: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 655: static inline void tim2_capture_compare1_polarity_high(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_polarity_high
;	-----------------------------------------
_tim2_capture_compare1_polarity_high:
;	.\../STM8S103F3_Drivers/timer.h: 656: TIM2->CCER1 &= ~(1U << 1);
	bres	0x530a, #1
;	.\../STM8S103F3_Drivers/timer.h: 657: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 659: static inline void tim2_capture_compare1_polarity_low(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_polarity_low
;	-----------------------------------------
_tim2_capture_compare1_polarity_low:
;	.\../STM8S103F3_Drivers/timer.h: 660: TIM2->CCER1 |= (1U << 1);
	bset	0x530a, #1
;	.\../STM8S103F3_Drivers/timer.h: 661: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 663: static inline void tim2_capture_compare2_enable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_enable
;	-----------------------------------------
_tim2_capture_compare2_enable:
;	.\../STM8S103F3_Drivers/timer.h: 664: TIM2->CCER1 |= (1U << 4);
	bset	0x530a, #4
;	.\../STM8S103F3_Drivers/timer.h: 665: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 667: static inline void tim2_capture_compare2_disable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_disable
;	-----------------------------------------
_tim2_capture_compare2_disable:
;	.\../STM8S103F3_Drivers/timer.h: 668: TIM2->CCER1 &= ~(1U << 4);
	bres	0x530a, #4
;	.\../STM8S103F3_Drivers/timer.h: 669: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 671: static inline void tim2_capture_compare2_polarity_high(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_polarity_high
;	-----------------------------------------
_tim2_capture_compare2_polarity_high:
;	.\../STM8S103F3_Drivers/timer.h: 672: TIM2->CCER1 &= ~(1U << 5);
	bres	0x530a, #5
;	.\../STM8S103F3_Drivers/timer.h: 673: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 675: static inline void tim2_capture_compare2_polarity_low(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_polarity_low
;	-----------------------------------------
_tim2_capture_compare2_polarity_low:
;	.\../STM8S103F3_Drivers/timer.h: 676: TIM2->CCER1 |= (1U << 5);
	bset	0x530a, #5
;	.\../STM8S103F3_Drivers/timer.h: 677: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 682: static inline void tim2_capture_compare3_enable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_enable
;	-----------------------------------------
_tim2_capture_compare3_enable:
;	.\../STM8S103F3_Drivers/timer.h: 683: TIM2->CCER2 |= (1U << 0);
	bset	0x530b, #0
;	.\../STM8S103F3_Drivers/timer.h: 684: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 686: static inline void tim2_capture_compare3_disable(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_disable
;	-----------------------------------------
_tim2_capture_compare3_disable:
;	.\../STM8S103F3_Drivers/timer.h: 687: TIM2->CCER2 &= ~(1U << 0);
	bres	0x530b, #0
;	.\../STM8S103F3_Drivers/timer.h: 688: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 690: static inline void tim2_capture_compare3_polarity_high(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_polarity_high
;	-----------------------------------------
_tim2_capture_compare3_polarity_high:
;	.\../STM8S103F3_Drivers/timer.h: 691: TIM2->CCER2 &= ~(1U << 1);
	bres	0x530b, #1
;	.\../STM8S103F3_Drivers/timer.h: 692: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 694: static inline void tim2_capture_compare3_polarity_low(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_polarity_low
;	-----------------------------------------
_tim2_capture_compare3_polarity_low:
;	.\../STM8S103F3_Drivers/timer.h: 695: TIM2->CCER2 |= (1U << 1);
	bset	0x530b, #1
;	.\../STM8S103F3_Drivers/timer.h: 696: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 701: static inline void tim2_counter_write(uint16_t value) {
;	-----------------------------------------
;	 function tim2_counter_write
;	-----------------------------------------
_tim2_counter_write:
;	.\../STM8S103F3_Drivers/timer.h: 703: TIM2->CNTRH = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x530c, a
;	.\../STM8S103F3_Drivers/timer.h: 704: TIM2->CNTRL = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x530d, a
;	.\../STM8S103F3_Drivers/timer.h: 705: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 707: static inline uint16_t tim2_counter_read(void) {
;	-----------------------------------------
;	 function tim2_counter_read
;	-----------------------------------------
_tim2_counter_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 709: uint8_t high_byte = TIM2->CNTRH; 
	ld	a, 0x530c
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 710: uint8_t low_byte = TIM2->CNTRL;  
	ld	a, 0x530d
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 711: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 712: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 717: static inline void tim2_prescaler_set(uint8_t prescaler) {
;	-----------------------------------------
;	 function tim2_prescaler_set
;	-----------------------------------------
_tim2_prescaler_set:
;	.\../STM8S103F3_Drivers/timer.h: 718: TIM2->PSCR = (prescaler & 0x07);
	and	a, #0x07
	ld	0x530e, a
;	.\../STM8S103F3_Drivers/timer.h: 719: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 721: static inline uint8_t tim2_prescaler_read(void) {
;	-----------------------------------------
;	 function tim2_prescaler_read
;	-----------------------------------------
_tim2_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 722: return (TIM2->PSCR & 0x07);
	ld	a, 0x530e
	and	a, #0x07
;	.\../STM8S103F3_Drivers/timer.h: 723: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 728: static inline void tim2_auto_reload_write(uint16_t value) {
;	-----------------------------------------
;	 function tim2_auto_reload_write
;	-----------------------------------------
_tim2_auto_reload_write:
;	.\../STM8S103F3_Drivers/timer.h: 730: TIM2->ARRH = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x530f, a
;	.\../STM8S103F3_Drivers/timer.h: 731: TIM2->ARRL = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x5310, a
;	.\../STM8S103F3_Drivers/timer.h: 732: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 734: static inline uint16_t tim2_auto_reload_read(void) {
;	-----------------------------------------
;	 function tim2_auto_reload_read
;	-----------------------------------------
_tim2_auto_reload_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 736: uint8_t high_byte = TIM2->ARRH;
	ld	a, 0x530f
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 737: uint8_t low_byte = TIM2->ARRL;
	ld	a, 0x5310
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 738: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 739: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 744: static inline void tim2_capture_compare1_write(uint16_t value) {
;	-----------------------------------------
;	 function tim2_capture_compare1_write
;	-----------------------------------------
_tim2_capture_compare1_write:
;	.\../STM8S103F3_Drivers/timer.h: 746: TIM2->CCR1H = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x5311, a
;	.\../STM8S103F3_Drivers/timer.h: 747: TIM2->CCR1L = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x5312, a
;	.\../STM8S103F3_Drivers/timer.h: 748: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 750: static inline uint16_t tim2_capture_compare1_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare1_read
;	-----------------------------------------
_tim2_capture_compare1_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 752: uint8_t high_byte = TIM2->CCR1H;
	ld	a, 0x5311
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 753: uint8_t low_byte = TIM2->CCR1L;
	ld	a, 0x5312
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 754: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 755: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 760: static inline void tim2_capture_compare2_write(uint16_t value) {
;	-----------------------------------------
;	 function tim2_capture_compare2_write
;	-----------------------------------------
_tim2_capture_compare2_write:
;	.\../STM8S103F3_Drivers/timer.h: 762: TIM2->CCR2H = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x5313, a
;	.\../STM8S103F3_Drivers/timer.h: 763: TIM2->CCR2L = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x5314, a
;	.\../STM8S103F3_Drivers/timer.h: 764: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 766: static inline uint16_t tim2_capture_compare2_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare2_read
;	-----------------------------------------
_tim2_capture_compare2_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 768: uint8_t high_byte = TIM2->CCR2H;
	ld	a, 0x5313
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 769: uint8_t low_byte = TIM2->CCR2L;
	ld	a, 0x5314
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 770: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 771: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 774: static inline void tim2_capture_compare3_write(uint16_t value) {
;	-----------------------------------------
;	 function tim2_capture_compare3_write
;	-----------------------------------------
_tim2_capture_compare3_write:
;	.\../STM8S103F3_Drivers/timer.h: 776: TIM2->CCR3H = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x5315, a
;	.\../STM8S103F3_Drivers/timer.h: 777: TIM2->CCR3L = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x5316, a
;	.\../STM8S103F3_Drivers/timer.h: 778: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 780: static inline uint16_t tim2_capture_compare3_read(void) {
;	-----------------------------------------
;	 function tim2_capture_compare3_read
;	-----------------------------------------
_tim2_capture_compare3_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 782: uint8_t high_byte = TIM2->CCR3H;
	ld	a, 0x5315
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 783: uint8_t low_byte = TIM2->CCR3L;
	ld	a, 0x5316
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 784: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 785: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 790: static inline void tim1_counter_enable(void) {
;	-----------------------------------------
;	 function tim1_counter_enable
;	-----------------------------------------
_tim1_counter_enable:
;	.\../STM8S103F3_Drivers/timer.h: 791: TIM1->CR1 |= (1U << 0);
	bset	0x5250, #0
;	.\../STM8S103F3_Drivers/timer.h: 792: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 794: static inline void tim1_counter_disable(void) {
;	-----------------------------------------
;	 function tim1_counter_disable
;	-----------------------------------------
_tim1_counter_disable:
;	.\../STM8S103F3_Drivers/timer.h: 795: TIM1->CR1 &= ~(1U << 0);
	bres	0x5250, #0
;	.\../STM8S103F3_Drivers/timer.h: 796: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 798: static inline void tim1_auto_update_event_enable(void) {
;	-----------------------------------------
;	 function tim1_auto_update_event_enable
;	-----------------------------------------
_tim1_auto_update_event_enable:
;	.\../STM8S103F3_Drivers/timer.h: 799: TIM1->CR1 &= ~(1U << 1);
	bres	0x5250, #1
;	.\../STM8S103F3_Drivers/timer.h: 800: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 802: static inline void tim1_auto_update_event_disable(void) {
;	-----------------------------------------
;	 function tim1_auto_update_event_disable
;	-----------------------------------------
_tim1_auto_update_event_disable:
;	.\../STM8S103F3_Drivers/timer.h: 803: TIM1->CR1 |= (1U << 1);
	bset	0x5250, #1
;	.\../STM8S103F3_Drivers/timer.h: 804: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 806: static inline void tim1_update_req_src_any_event_set(void) {
;	-----------------------------------------
;	 function tim1_update_req_src_any_event_set
;	-----------------------------------------
_tim1_update_req_src_any_event_set:
;	.\../STM8S103F3_Drivers/timer.h: 807: TIM1->CR1 &= ~(1U << 2);
	bres	0x5250, #2
;	.\../STM8S103F3_Drivers/timer.h: 808: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 810: static inline void tim1_update_req_src_overflow_underflow_only_set(void) {
;	-----------------------------------------
;	 function tim1_update_req_src_overflow_underflow_only_set
;	-----------------------------------------
_tim1_update_req_src_overflow_underflow_only_set:
;	.\../STM8S103F3_Drivers/timer.h: 811: TIM1->CR1 |= (1U << 2);
	bset	0x5250, #2
;	.\../STM8S103F3_Drivers/timer.h: 812: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 814: static inline void tim1_one_pulse_mode_enable(void) {
;	-----------------------------------------
;	 function tim1_one_pulse_mode_enable
;	-----------------------------------------
_tim1_one_pulse_mode_enable:
;	.\../STM8S103F3_Drivers/timer.h: 815: TIM1->CR1 |= (1U << 3);
	bset	0x5250, #3
;	.\../STM8S103F3_Drivers/timer.h: 816: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 818: static inline void tim1_one_pulse_mode_disable(void) {
;	-----------------------------------------
;	 function tim1_one_pulse_mode_disable
;	-----------------------------------------
_tim1_one_pulse_mode_disable:
;	.\../STM8S103F3_Drivers/timer.h: 819: TIM1->CR1 &= ~(1U << 3);
	bres	0x5250, #3
;	.\../STM8S103F3_Drivers/timer.h: 820: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 822: static inline void tim1_direction_up_counter(void) {
;	-----------------------------------------
;	 function tim1_direction_up_counter
;	-----------------------------------------
_tim1_direction_up_counter:
;	.\../STM8S103F3_Drivers/timer.h: 823: TIM1->CR1 &= ~(1U << 4);
	bres	0x5250, #4
;	.\../STM8S103F3_Drivers/timer.h: 824: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 826: static inline void tim1_direction_down_counter(void) {
;	-----------------------------------------
;	 function tim1_direction_down_counter
;	-----------------------------------------
_tim1_direction_down_counter:
;	.\../STM8S103F3_Drivers/timer.h: 827: TIM1->CR1 |= (1U << 4);
	bset	0x5250, #4
;	.\../STM8S103F3_Drivers/timer.h: 828: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 830: static inline void tim1_center_aligned_mode_set(TIM1_CENTER_ALIGNED_MODE mode) {
;	-----------------------------------------
;	 function tim1_center_aligned_mode_set
;	-----------------------------------------
_tim1_center_aligned_mode_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 831: TIM1->CR1 = (TIM1->CR1 & 0x9F) | ((uint8_t)mode << 5);
	ld	a, 0x5250
	and	a, #0x9f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	sll	a
	or	a, (0x01, sp)
	ld	0x5250, a
;	.\../STM8S103F3_Drivers/timer.h: 832: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 834: static inline TIM1_CENTER_ALIGNED_MODE tim1_center_aligned_mode_read(void) {
;	-----------------------------------------
;	 function tim1_center_aligned_mode_read
;	-----------------------------------------
_tim1_center_aligned_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 835: return (TIM1_CENTER_ALIGNED_MODE)((TIM1->CR1 >> 5) & 0x03);
	ld	a, 0x5250
	swap	a
	and	a, #0x0f
	srl	a
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 836: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 838: static inline void tim1_auto_reload_preload_enable(void) {
;	-----------------------------------------
;	 function tim1_auto_reload_preload_enable
;	-----------------------------------------
_tim1_auto_reload_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 839: TIM1->CR1 |= (1U << 7);
	bset	0x5250, #7
;	.\../STM8S103F3_Drivers/timer.h: 840: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 842: static inline void tim1_auto_reload_preload_disable(void) {
;	-----------------------------------------
;	 function tim1_auto_reload_preload_disable
;	-----------------------------------------
_tim1_auto_reload_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 843: TIM1->CR1 &= ~(1U << 7);
	bres	0x5250, #7
;	.\../STM8S103F3_Drivers/timer.h: 844: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 849: static inline void tim1_capture_compare_preload_control_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare_preload_control_enable
;	-----------------------------------------
_tim1_capture_compare_preload_control_enable:
;	.\../STM8S103F3_Drivers/timer.h: 850: TIM1->CR2 |= (1U << 0);
	bset	0x5251, #0
;	.\../STM8S103F3_Drivers/timer.h: 851: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 853: static inline void tim1_capture_compare_preload_control_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare_preload_control_disable
;	-----------------------------------------
_tim1_capture_compare_preload_control_disable:
;	.\../STM8S103F3_Drivers/timer.h: 854: TIM1->CR2 &= ~(1U << 0);
	bres	0x5251, #0
;	.\../STM8S103F3_Drivers/timer.h: 855: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 857: static inline void tim1_capture_compare_control_update_selection_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare_control_update_selection_enable
;	-----------------------------------------
_tim1_capture_compare_control_update_selection_enable:
;	.\../STM8S103F3_Drivers/timer.h: 858: TIM1->CR2 |= (1U << 1);
	bset	0x5251, #1
;	.\../STM8S103F3_Drivers/timer.h: 859: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 861: static inline void tim1_capture_compare_control_update_selection_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare_control_update_selection_disable
;	-----------------------------------------
_tim1_capture_compare_control_update_selection_disable:
;	.\../STM8S103F3_Drivers/timer.h: 862: TIM1->CR2 &= ~(1U << 1);
	bres	0x5251, #1
;	.\../STM8S103F3_Drivers/timer.h: 863: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 865: static inline void tim1_master_mode_selection_set(TIM1_MASTER_MODE mode) {
;	-----------------------------------------
;	 function tim1_master_mode_selection_set
;	-----------------------------------------
_tim1_master_mode_selection_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 866: TIM1->CR2 = (TIM1->CR2 & TIM1_MASTER_MODE_SELECTION_CLR_MASK) | ((uint8_t)mode << 4);
	ld	a, 0x5251
	and	a, #0x8f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5251, a
;	.\../STM8S103F3_Drivers/timer.h: 867: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 869: static inline TIM1_MASTER_MODE tim1_master_mode_selection_read(void) {
;	-----------------------------------------
;	 function tim1_master_mode_selection_read
;	-----------------------------------------
_tim1_master_mode_selection_read:
;	.\../STM8S103F3_Drivers/timer.h: 870: return (TIM1_MASTER_MODE)((TIM1->CR2 >> 4) & 0x07);
	ld	a, 0x5251
	swap	a
	and	a, #7
;	.\../STM8S103F3_Drivers/timer.h: 871: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 876: static inline void tim1_slave_mode_set(TIM1_SLAVE_MODE mode) {
;	-----------------------------------------
;	 function tim1_slave_mode_set
;	-----------------------------------------
_tim1_slave_mode_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 877: TIM1->SMCR = (TIM1->SMCR & TIM1_SLAVE_MODE_CLR_MASK) | (mode & 0x07);
	ld	a, 0x5252
	and	a, #0xf8
	ld	(0x01, sp), a
	ld	a, xl
	and	a, #0x07
	or	a, (0x01, sp)
	ld	0x5252, a
;	.\../STM8S103F3_Drivers/timer.h: 878: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 880: static inline TIM1_SLAVE_MODE tim1_slave_mode_read(void) {
;	-----------------------------------------
;	 function tim1_slave_mode_read
;	-----------------------------------------
_tim1_slave_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 881: return (TIM1_SLAVE_MODE)(TIM1->SMCR & 0x07);
	ld	a, 0x5252
	and	a, #0x07
;	.\../STM8S103F3_Drivers/timer.h: 882: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 884: static inline void tim1_trigger_selection_set(TIM1_TRIGGER_SOURCE source) {
;	-----------------------------------------
;	 function tim1_trigger_selection_set
;	-----------------------------------------
_tim1_trigger_selection_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 885: TIM1->SMCR = (TIM1->SMCR & TIM1_TRIGGER_SELECTION_CLR_MASK) | ((uint8_t)source << 4);
	ld	a, 0x5252
	and	a, #0x8f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5252, a
;	.\../STM8S103F3_Drivers/timer.h: 886: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 888: static inline TIM1_TRIGGER_SOURCE tim1_trigger_selection_read(void) {
;	-----------------------------------------
;	 function tim1_trigger_selection_read
;	-----------------------------------------
_tim1_trigger_selection_read:
;	.\../STM8S103F3_Drivers/timer.h: 889: return (TIM1_TRIGGER_SOURCE)((TIM1->SMCR >> 4) & 0x07);
	ld	a, 0x5252
	swap	a
	and	a, #7
;	.\../STM8S103F3_Drivers/timer.h: 890: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 892: static inline void tim1_master_slave_mode_enable(void) {
;	-----------------------------------------
;	 function tim1_master_slave_mode_enable
;	-----------------------------------------
_tim1_master_slave_mode_enable:
;	.\../STM8S103F3_Drivers/timer.h: 893: TIM1->SMCR |= (1U << 7);
	bset	0x5252, #7
;	.\../STM8S103F3_Drivers/timer.h: 894: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 896: static inline void tim1_master_slave_mode_disable(void) {
;	-----------------------------------------
;	 function tim1_master_slave_mode_disable
;	-----------------------------------------
_tim1_master_slave_mode_disable:
;	.\../STM8S103F3_Drivers/timer.h: 897: TIM1->SMCR &= ~(1U << 7);
	bres	0x5252, #7
;	.\../STM8S103F3_Drivers/timer.h: 898: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 903: static inline void tim1_external_trigger_filter_set(TIM1_EXTERNAL_TRIGGER_FILTER filter) {
;	-----------------------------------------
;	 function tim1_external_trigger_filter_set
;	-----------------------------------------
_tim1_external_trigger_filter_set:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/timer.h: 904: TIM1->ETR = (TIM1->ETR & TIM1_EXTERNAL_TRIGGER_PSC_CLR_MASK) | filter;
	ld	a, 0x5253
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5253, a
;	.\../STM8S103F3_Drivers/timer.h: 905: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 907: static inline TIM1_EXTERNAL_TRIGGER_FILTER tim1_external_trigger_filter_read(void) {
;	-----------------------------------------
;	 function tim1_external_trigger_filter_read
;	-----------------------------------------
_tim1_external_trigger_filter_read:
;	.\../STM8S103F3_Drivers/timer.h: 908: return (TIM1_EXTERNAL_TRIGGER_FILTER)(TIM1->ETR & 0x0F);
	ld	a, 0x5253
	and	a, #0x0f
;	.\../STM8S103F3_Drivers/timer.h: 909: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 911: static inline void tim1_external_trigger_prescaler_set(TIM1_EXTERNAL_TRIGGER_PRESCALER psc) {
;	-----------------------------------------
;	 function tim1_external_trigger_prescaler_set
;	-----------------------------------------
_tim1_external_trigger_prescaler_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 912: TIM1->ETR = (TIM1->ETR & TIM1_EXTERNAL_TRIGGER_PRESCALER_CLR_MASK) | ((uint8_t)psc << 4);
	ld	a, 0x5253
	and	a, #0xcf
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5253, a
;	.\../STM8S103F3_Drivers/timer.h: 913: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 915: static inline TIM1_EXTERNAL_TRIGGER_PRESCALER tim1_external_trigger_prescaler_read(void) {
;	-----------------------------------------
;	 function tim1_external_trigger_prescaler_read
;	-----------------------------------------
_tim1_external_trigger_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 916: return (TIM1_EXTERNAL_TRIGGER_PRESCALER)((TIM1->ETR >> 4) & 0x03);
	ld	a, 0x5253
	swap	a
	and	a, #3
;	.\../STM8S103F3_Drivers/timer.h: 917: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 919: static inline void tim1_external_clock_mode_2_enable(void) {
;	-----------------------------------------
;	 function tim1_external_clock_mode_2_enable
;	-----------------------------------------
_tim1_external_clock_mode_2_enable:
;	.\../STM8S103F3_Drivers/timer.h: 920: TIM1->ETR |= (1U << 6);
	bset	0x5253, #6
;	.\../STM8S103F3_Drivers/timer.h: 921: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 923: static inline void tim1_external_clock_mode_2_disable(void) {
;	-----------------------------------------
;	 function tim1_external_clock_mode_2_disable
;	-----------------------------------------
_tim1_external_clock_mode_2_disable:
;	.\../STM8S103F3_Drivers/timer.h: 924: TIM1->ETR &= ~(1U << 6);
	bres	0x5253, #6
;	.\../STM8S103F3_Drivers/timer.h: 925: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 927: static inline void tim1_external_trigger_polarity_high(void) {
;	-----------------------------------------
;	 function tim1_external_trigger_polarity_high
;	-----------------------------------------
_tim1_external_trigger_polarity_high:
;	.\../STM8S103F3_Drivers/timer.h: 928: TIM1->ETR &= ~(1U << 7);
	bres	0x5253, #7
;	.\../STM8S103F3_Drivers/timer.h: 929: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 931: static inline void tim1_external_trigger_polarity_low(void) {
;	-----------------------------------------
;	 function tim1_external_trigger_polarity_low
;	-----------------------------------------
_tim1_external_trigger_polarity_low:
;	.\../STM8S103F3_Drivers/timer.h: 932: TIM1->ETR |= (1U << 7);
	bset	0x5253, #7
;	.\../STM8S103F3_Drivers/timer.h: 933: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 945: static inline void tim1_irq_enable(TIM1_IRQ irq) {
;	-----------------------------------------
;	 function tim1_irq_enable
;	-----------------------------------------
_tim1_irq_enable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 946: TIM1->IER |= (1U << irq);
	ld	a, 0x5254
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x5254, a
;	.\../STM8S103F3_Drivers/timer.h: 947: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 949: static inline void tim1_irq_disable(TIM1_IRQ irq) {
;	-----------------------------------------
;	 function tim1_irq_disable
;	-----------------------------------------
_tim1_irq_disable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 950: TIM1->IER &= ~(1U << irq);
	ld	a, 0x5254
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x5254, a
;	.\../STM8S103F3_Drivers/timer.h: 951: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 960: static inline void tim1_capture_compare_irq_enable(TIM1_CAPTURE_COMPARE_IRQ cc_irq) {
;	-----------------------------------------
;	 function tim1_capture_compare_irq_enable
;	-----------------------------------------
_tim1_capture_compare_irq_enable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 961: TIM1->IER |= (1U << cc_irq);
	ld	a, 0x5254
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x5254, a
;	.\../STM8S103F3_Drivers/timer.h: 962: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 964: static inline void tim1_capture_compare_irq_disable(TIM1_CAPTURE_COMPARE_IRQ cc_irq) {
;	-----------------------------------------
;	 function tim1_capture_compare_irq_disable
;	-----------------------------------------
_tim1_capture_compare_irq_disable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 965: TIM1->IER &= ~(1U << cc_irq);
	ld	a, 0x5254
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x5254, a
;	.\../STM8S103F3_Drivers/timer.h: 966: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 978: static inline void tim1_irq_flag_clear(TIM1_IRQ_FLAG irq_flag) {
;	-----------------------------------------
;	 function tim1_irq_flag_clear
;	-----------------------------------------
_tim1_irq_flag_clear:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 979: TIM1->SR1 &= ~(1U << irq_flag);
	ld	a, 0x5255
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x5255, a
;	.\../STM8S103F3_Drivers/timer.h: 980: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 982: static inline uint8_t tim1_irq_flag_read(TIM1_IRQ_FLAG irq_flag) {
;	-----------------------------------------
;	 function tim1_irq_flag_read
;	-----------------------------------------
_tim1_irq_flag_read:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 983: return ((TIM1->SR1 >> irq_flag) & 1);
	ld	a, 0x5255
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 984: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 993: static inline void tim1_capture_compare_irq_flag_clear(TIM1_CAPTURE_COMPARE_IRQ_FLAG cc_irq_flag) {
;	-----------------------------------------
;	 function tim1_capture_compare_irq_flag_clear
;	-----------------------------------------
_tim1_capture_compare_irq_flag_clear:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 994: TIM1->SR1 &= ~(1U << cc_irq_flag);
	ld	a, 0x5255
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x5255, a
;	.\../STM8S103F3_Drivers/timer.h: 995: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 997: static inline uint8_t tim1_capture_compare_irq_flag_read(TIM1_CAPTURE_COMPARE_IRQ_FLAG cc_irq_flag) {
;	-----------------------------------------
;	 function tim1_capture_compare_irq_flag_read
;	-----------------------------------------
_tim1_capture_compare_irq_flag_read:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 998: return ((TIM1->SR1 >> cc_irq_flag) & 1);
	ld	a, 0x5255
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 999: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1011: static inline void tim1_capture_compare_overcapture_flag_clear(TIM1_OVER_CAPTURE_FLAG oc_flag) {
;	-----------------------------------------
;	 function tim1_capture_compare_overcapture_flag_clear
;	-----------------------------------------
_tim1_capture_compare_overcapture_flag_clear:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1012: TIM1->SR2 &= ~(1U << oc_flag);
	ld	a, 0x5256
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x5256, a
;	.\../STM8S103F3_Drivers/timer.h: 1013: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1015: static inline uint8_t tim1_capture_compare_overcapture_flag_read(TIM1_OVER_CAPTURE_FLAG oc_flag) {
;	-----------------------------------------
;	 function tim1_capture_compare_overcapture_flag_read
;	-----------------------------------------
_tim1_capture_compare_overcapture_flag_read:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1016: return ((TIM1->SR2 >> oc_flag) & 1);
	ld	a, 0x5256
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 1017: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1029: static inline void tim1_event_generate(TIM1_EVENT event) {
;	-----------------------------------------
;	 function tim1_event_generate
;	-----------------------------------------
_tim1_event_generate:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1030: TIM1->EGR |= (1U << event);
	ld	a, 0x5257
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x5257, a
;	.\../STM8S103F3_Drivers/timer.h: 1031: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1040: static inline void tim1_capture_compare_event_generate(TIM1_CAPTURE_COMPARE_EVENT cc_event) {
;	-----------------------------------------
;	 function tim1_capture_compare_event_generate
;	-----------------------------------------
_tim1_capture_compare_event_generate:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1041: TIM1->EGR |= (1U << cc_event);
	ld	a, 0x5257
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x5257, a
;	.\../STM8S103F3_Drivers/timer.h: 1042: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1056: static inline void tim1_capture_compare1_channel_mode_set(TIM1_CC1_CHANNEL_MODE mode) {
;	-----------------------------------------
;	 function tim1_capture_compare1_channel_mode_set
;	-----------------------------------------
_tim1_capture_compare1_channel_mode_set:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/timer.h: 1057: TIM1->CCMR1 = (TIM1->CCMR1 & TIM1_CC1_CHANNEL_MODE_CLR_MASK) | mode;
	ld	a, 0x5258
	and	a, #0xfc
	or	a, (0x01, sp)
	ld	0x5258, a
;	.\../STM8S103F3_Drivers/timer.h: 1058: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1060: static inline TIM1_CC1_CHANNEL_MODE tim1_capture_compare1_channel_mode_read(void) {
;	-----------------------------------------
;	 function tim1_capture_compare1_channel_mode_read
;	-----------------------------------------
_tim1_capture_compare1_channel_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 1061: return (TIM1_CC1_CHANNEL_MODE)(TIM1->CCMR1 & 0x03);
	ld	a, 0x5258
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 1062: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1065: static inline void tim1_capture_compare1_fast_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare1_fast_enable
;	-----------------------------------------
_tim1_capture_compare1_fast_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1066: TIM1->CCMR1 |= (1U << 2);
	bset	0x5258, #2
;	.\../STM8S103F3_Drivers/timer.h: 1067: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1069: static inline void tim1_capture_compare1_fast_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare1_fast_disable
;	-----------------------------------------
_tim1_capture_compare1_fast_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1070: TIM1->CCMR1 &= ~(1U << 2);
	bres	0x5258, #2
;	.\../STM8S103F3_Drivers/timer.h: 1071: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1073: static inline void tim1_capture_compare1_preload_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare1_preload_enable
;	-----------------------------------------
_tim1_capture_compare1_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1074: TIM1->CCMR1 |= (1U << 3);
	bset	0x5258, #3
;	.\../STM8S103F3_Drivers/timer.h: 1075: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1077: static inline void tim1_capture_compare1_preload_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare1_preload_disable
;	-----------------------------------------
_tim1_capture_compare1_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1078: TIM1->CCMR1 &= ~(1U << 3);
	bres	0x5258, #3
;	.\../STM8S103F3_Drivers/timer.h: 1079: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1092: static inline void tim1_output_compare1_mode_set(TIM1_OUTPUT_COMPARE_MODE mode) {
;	-----------------------------------------
;	 function tim1_output_compare1_mode_set
;	-----------------------------------------
_tim1_output_compare1_mode_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1093: TIM1->CCMR1 = (TIM1->CCMR1 & 0x8F) | ((uint8_t)mode << 4);
	ld	a, 0x5258
	and	a, #0x8f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5258, a
;	.\../STM8S103F3_Drivers/timer.h: 1094: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1096: static inline TIM1_OUTPUT_COMPARE_MODE tim1_output_compare1_mode_read(void) {
;	-----------------------------------------
;	 function tim1_output_compare1_mode_read
;	-----------------------------------------
_tim1_output_compare1_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 1097: return (TIM1_OUTPUT_COMPARE_MODE)((TIM1->CCMR1 >> 4) & 0x07);
	ld	a, 0x5258
	swap	a
	and	a, #7
;	.\../STM8S103F3_Drivers/timer.h: 1098: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1100: static inline void tim1_output_compare1_clear_enable(void) {
;	-----------------------------------------
;	 function tim1_output_compare1_clear_enable
;	-----------------------------------------
_tim1_output_compare1_clear_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1101: TIM1->CCMR1 |= (1U << 7);
	bset	0x5258, #7
;	.\../STM8S103F3_Drivers/timer.h: 1102: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1104: static inline void tim1_output_compare1_clear_disable(void) {
;	-----------------------------------------
;	 function tim1_output_compare1_clear_disable
;	-----------------------------------------
_tim1_output_compare1_clear_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1105: TIM1->CCMR1 &= ~(1U << 7);
	bres	0x5258, #7
;	.\../STM8S103F3_Drivers/timer.h: 1106: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1116: static inline void tim1_input_capture1_prescaler_set(TIM1_INPUT_CAPTURE_PRESCALER psc) {
;	-----------------------------------------
;	 function tim1_input_capture1_prescaler_set
;	-----------------------------------------
_tim1_input_capture1_prescaler_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1117: TIM1->CCMR1 = (TIM1->CCMR1 & 0xF3) | ((uint8_t)psc << 2);
	ld	a, 0x5258
	and	a, #0xf3
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x5258, a
;	.\../STM8S103F3_Drivers/timer.h: 1118: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1120: static inline TIM1_INPUT_CAPTURE_PRESCALER tim1_input_capture1_prescaler_read(void) {
;	-----------------------------------------
;	 function tim1_input_capture1_prescaler_read
;	-----------------------------------------
_tim1_input_capture1_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 1121: return (TIM1_INPUT_CAPTURE_PRESCALER)((TIM1->CCMR1 >> 2) & 0x03);
	ld	a, 0x5258
	srl	a
	srl	a
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 1122: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1149: static inline void tim1_input_capture1_filter_set(TIM1_INPUT_CAPTURE_FILTER filter) {
;	-----------------------------------------
;	 function tim1_input_capture1_filter_set
;	-----------------------------------------
_tim1_input_capture1_filter_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1150: TIM1->CCMR1 = (TIM1->CCMR1 & 0x0F) | ((uint8_t)filter << 4);
	ld	a, 0x5258
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5258, a
;	.\../STM8S103F3_Drivers/timer.h: 1151: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1153: static inline TIM1_INPUT_CAPTURE_FILTER tim1_input_capture1_filter_read(void) {
;	-----------------------------------------
;	 function tim1_input_capture1_filter_read
;	-----------------------------------------
_tim1_input_capture1_filter_read:
;	.\../STM8S103F3_Drivers/timer.h: 1154: return (TIM1_INPUT_CAPTURE_FILTER)((TIM1->CCMR1 >> 4) & 0x0F);
	ld	a, 0x5258
	swap	a
	and	a, #15
;	.\../STM8S103F3_Drivers/timer.h: 1155: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1168: static inline void tim1_capture_compare2_channel_mode_set(TIM1_CC2_CHANNEL_MODE mode) {
;	-----------------------------------------
;	 function tim1_capture_compare2_channel_mode_set
;	-----------------------------------------
_tim1_capture_compare2_channel_mode_set:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/timer.h: 1169: TIM1->CCMR2 = (TIM1->CCMR2 & TIM1_CC2_CHANNEL_MODE_CLR_MASK) | mode;
	ld	a, 0x5259
	and	a, #0xfc
	or	a, (0x01, sp)
	ld	0x5259, a
;	.\../STM8S103F3_Drivers/timer.h: 1170: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1172: static inline TIM1_CC2_CHANNEL_MODE tim1_capture_compare2_channel_mode_read(void) {
;	-----------------------------------------
;	 function tim1_capture_compare2_channel_mode_read
;	-----------------------------------------
_tim1_capture_compare2_channel_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 1173: return (TIM1_CC2_CHANNEL_MODE)(TIM1->CCMR2 & 0x03);
	ld	a, 0x5259
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 1174: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1177: static inline void tim1_capture_compare2_fast_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare2_fast_enable
;	-----------------------------------------
_tim1_capture_compare2_fast_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1178: TIM1->CCMR2 |= (1U << 2);
	bset	0x5259, #2
;	.\../STM8S103F3_Drivers/timer.h: 1179: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1181: static inline void tim1_capture_compare2_fast_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare2_fast_disable
;	-----------------------------------------
_tim1_capture_compare2_fast_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1182: TIM1->CCMR2 &= ~(1U << 2);
	bres	0x5259, #2
;	.\../STM8S103F3_Drivers/timer.h: 1183: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1185: static inline void tim1_capture_compare2_preload_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare2_preload_enable
;	-----------------------------------------
_tim1_capture_compare2_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1186: TIM1->CCMR2 |= (1U << 3);
	bset	0x5259, #3
;	.\../STM8S103F3_Drivers/timer.h: 1187: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1189: static inline void tim1_capture_compare2_preload_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare2_preload_disable
;	-----------------------------------------
_tim1_capture_compare2_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1190: TIM1->CCMR2 &= ~(1U << 3);
	bres	0x5259, #3
;	.\../STM8S103F3_Drivers/timer.h: 1191: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1193: static inline void tim1_output_compare2_mode_set(TIM1_OUTPUT_COMPARE_MODE mode) {
;	-----------------------------------------
;	 function tim1_output_compare2_mode_set
;	-----------------------------------------
_tim1_output_compare2_mode_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1194: TIM1->CCMR2 = (TIM1->CCMR2 & 0x8F) | ((uint8_t)mode << 4);
	ld	a, 0x5259
	and	a, #0x8f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5259, a
;	.\../STM8S103F3_Drivers/timer.h: 1195: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1197: static inline TIM1_OUTPUT_COMPARE_MODE tim1_output_compare2_mode_read(void) {
;	-----------------------------------------
;	 function tim1_output_compare2_mode_read
;	-----------------------------------------
_tim1_output_compare2_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 1198: return (TIM1_OUTPUT_COMPARE_MODE)((TIM1->CCMR2 >> 4) & 0x07);
	ld	a, 0x5259
	swap	a
	and	a, #7
;	.\../STM8S103F3_Drivers/timer.h: 1199: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1201: static inline void tim1_output_compare2_clear_enable(void) {
;	-----------------------------------------
;	 function tim1_output_compare2_clear_enable
;	-----------------------------------------
_tim1_output_compare2_clear_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1202: TIM1->CCMR2 |= (1U << 7);
	bset	0x5259, #7
;	.\../STM8S103F3_Drivers/timer.h: 1203: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1205: static inline void tim1_output_compare2_clear_disable(void) {
;	-----------------------------------------
;	 function tim1_output_compare2_clear_disable
;	-----------------------------------------
_tim1_output_compare2_clear_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1206: TIM1->CCMR2 &= ~(1U << 7);
	bres	0x5259, #7
;	.\../STM8S103F3_Drivers/timer.h: 1207: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1210: static inline void tim1_input_capture2_prescaler_set(TIM1_INPUT_CAPTURE_PRESCALER psc) {
;	-----------------------------------------
;	 function tim1_input_capture2_prescaler_set
;	-----------------------------------------
_tim1_input_capture2_prescaler_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1211: TIM1->CCMR2 = (TIM1->CCMR2 & 0xF3) | ((uint8_t)psc << 2);
	ld	a, 0x5259
	and	a, #0xf3
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x5259, a
;	.\../STM8S103F3_Drivers/timer.h: 1212: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1214: static inline TIM1_INPUT_CAPTURE_PRESCALER tim1_input_capture2_prescaler_read(void) {
;	-----------------------------------------
;	 function tim1_input_capture2_prescaler_read
;	-----------------------------------------
_tim1_input_capture2_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 1215: return (TIM1_INPUT_CAPTURE_PRESCALER)((TIM1->CCMR2 >> 2) & 0x03);
	ld	a, 0x5259
	srl	a
	srl	a
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 1216: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1218: static inline void tim1_input_capture2_filter_set(TIM1_INPUT_CAPTURE_FILTER filter) {
;	-----------------------------------------
;	 function tim1_input_capture2_filter_set
;	-----------------------------------------
_tim1_input_capture2_filter_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1219: TIM1->CCMR2 = (TIM1->CCMR2 & 0x0F) | ((uint8_t)filter << 4);
	ld	a, 0x5259
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x5259, a
;	.\../STM8S103F3_Drivers/timer.h: 1220: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1222: static inline TIM1_INPUT_CAPTURE_FILTER tim1_input_capture2_filter_read(void) {
;	-----------------------------------------
;	 function tim1_input_capture2_filter_read
;	-----------------------------------------
_tim1_input_capture2_filter_read:
;	.\../STM8S103F3_Drivers/timer.h: 1223: return (TIM1_INPUT_CAPTURE_FILTER)((TIM1->CCMR2 >> 4) & 0x0F);
	ld	a, 0x5259
	swap	a
	and	a, #15
;	.\../STM8S103F3_Drivers/timer.h: 1224: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1237: static inline void tim1_capture_compare3_channel_mode_set(TIM1_CC3_CHANNEL_MODE mode) {
;	-----------------------------------------
;	 function tim1_capture_compare3_channel_mode_set
;	-----------------------------------------
_tim1_capture_compare3_channel_mode_set:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/timer.h: 1238: TIM1->CCMR3 = (TIM1->CCMR3 & TIM1_CC3_CHANNEL_MODE_CLR_MASK) | mode;
	ld	a, 0x525a
	and	a, #0xfc
	or	a, (0x01, sp)
	ld	0x525a, a
;	.\../STM8S103F3_Drivers/timer.h: 1239: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1241: static inline TIM1_CC3_CHANNEL_MODE tim1_capture_compare3_channel_mode_read(void) {
;	-----------------------------------------
;	 function tim1_capture_compare3_channel_mode_read
;	-----------------------------------------
_tim1_capture_compare3_channel_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 1242: return (TIM1_CC3_CHANNEL_MODE)(TIM1->CCMR3 & 0x03);
	ld	a, 0x525a
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 1243: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1246: static inline void tim1_capture_compare3_fast_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare3_fast_enable
;	-----------------------------------------
_tim1_capture_compare3_fast_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1247: TIM1->CCMR3 |= (1U << 2);
	bset	0x525a, #2
;	.\../STM8S103F3_Drivers/timer.h: 1248: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1250: static inline void tim1_capture_compare3_fast_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare3_fast_disable
;	-----------------------------------------
_tim1_capture_compare3_fast_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1251: TIM1->CCMR3 &= ~(1U << 2);
	bres	0x525a, #2
;	.\../STM8S103F3_Drivers/timer.h: 1252: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1254: static inline void tim1_capture_compare3_preload_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare3_preload_enable
;	-----------------------------------------
_tim1_capture_compare3_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1255: TIM1->CCMR3 |= (1U << 3);
	bset	0x525a, #3
;	.\../STM8S103F3_Drivers/timer.h: 1256: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1258: static inline void tim1_capture_compare3_preload_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare3_preload_disable
;	-----------------------------------------
_tim1_capture_compare3_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1259: TIM1->CCMR3 &= ~(1U << 3);
	bres	0x525a, #3
;	.\../STM8S103F3_Drivers/timer.h: 1260: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1262: static inline void tim1_output_compare3_mode_set(TIM1_OUTPUT_COMPARE_MODE mode) {
;	-----------------------------------------
;	 function tim1_output_compare3_mode_set
;	-----------------------------------------
_tim1_output_compare3_mode_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1263: TIM1->CCMR3 = (TIM1->CCMR3 & 0x8F) | ((uint8_t)mode << 4);
	ld	a, 0x525a
	and	a, #0x8f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x525a, a
;	.\../STM8S103F3_Drivers/timer.h: 1264: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1266: static inline TIM1_OUTPUT_COMPARE_MODE tim1_output_compare3_mode_read(void) {
;	-----------------------------------------
;	 function tim1_output_compare3_mode_read
;	-----------------------------------------
_tim1_output_compare3_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 1267: return (TIM1_OUTPUT_COMPARE_MODE)((TIM1->CCMR3 >> 4) & 0x07);
	ld	a, 0x525a
	swap	a
	and	a, #7
;	.\../STM8S103F3_Drivers/timer.h: 1268: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1270: static inline void tim1_output_compare3_clear_enable(void) {
;	-----------------------------------------
;	 function tim1_output_compare3_clear_enable
;	-----------------------------------------
_tim1_output_compare3_clear_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1271: TIM1->CCMR3 |= (1U << 7);
	bset	0x525a, #7
;	.\../STM8S103F3_Drivers/timer.h: 1272: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1274: static inline void tim1_output_compare3_clear_disable(void) {
;	-----------------------------------------
;	 function tim1_output_compare3_clear_disable
;	-----------------------------------------
_tim1_output_compare3_clear_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1275: TIM1->CCMR3 &= ~(1U << 7);
	bres	0x525a, #7
;	.\../STM8S103F3_Drivers/timer.h: 1276: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1279: static inline void tim1_input_capture3_prescaler_set(TIM1_INPUT_CAPTURE_PRESCALER psc) {
;	-----------------------------------------
;	 function tim1_input_capture3_prescaler_set
;	-----------------------------------------
_tim1_input_capture3_prescaler_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1280: TIM1->CCMR3 = (TIM1->CCMR3 & 0xF3) | ((uint8_t)psc << 2);
	ld	a, 0x525a
	and	a, #0xf3
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x525a, a
;	.\../STM8S103F3_Drivers/timer.h: 1281: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1283: static inline TIM1_INPUT_CAPTURE_PRESCALER tim1_input_capture3_prescaler_read(void) {
;	-----------------------------------------
;	 function tim1_input_capture3_prescaler_read
;	-----------------------------------------
_tim1_input_capture3_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 1284: return (TIM1_INPUT_CAPTURE_PRESCALER)((TIM1->CCMR3 >> 2) & 0x03);
	ld	a, 0x525a
	srl	a
	srl	a
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 1285: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1287: static inline void tim1_input_capture3_filter_set(TIM1_INPUT_CAPTURE_FILTER filter) {
;	-----------------------------------------
;	 function tim1_input_capture3_filter_set
;	-----------------------------------------
_tim1_input_capture3_filter_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1288: TIM1->CCMR3 = (TIM1->CCMR3 & 0x0F) | ((uint8_t)filter << 4);
	ld	a, 0x525a
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x525a, a
;	.\../STM8S103F3_Drivers/timer.h: 1289: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1291: static inline TIM1_INPUT_CAPTURE_FILTER tim1_input_capture3_filter_read(void) {
;	-----------------------------------------
;	 function tim1_input_capture3_filter_read
;	-----------------------------------------
_tim1_input_capture3_filter_read:
;	.\../STM8S103F3_Drivers/timer.h: 1292: return (TIM1_INPUT_CAPTURE_FILTER)((TIM1->CCMR3 >> 4) & 0x0F);
	ld	a, 0x525a
	swap	a
	and	a, #15
;	.\../STM8S103F3_Drivers/timer.h: 1293: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1307: static inline void tim1_capture_compare4_channel_mode_set(TIM1_CC4_CHANNEL_MODE mode) {
;	-----------------------------------------
;	 function tim1_capture_compare4_channel_mode_set
;	-----------------------------------------
_tim1_capture_compare4_channel_mode_set:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/timer.h: 1308: TIM1->CCMR4 = (TIM1->CCMR4 & TIM1_CC4_CHANNEL_MODE_CLR_MASK) | mode;
	ld	a, 0x525b
	and	a, #0xfc
	or	a, (0x01, sp)
	ld	0x525b, a
;	.\../STM8S103F3_Drivers/timer.h: 1309: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1311: static inline TIM1_CC4_CHANNEL_MODE tim1_capture_compare4_channel_mode_read(void) {
;	-----------------------------------------
;	 function tim1_capture_compare4_channel_mode_read
;	-----------------------------------------
_tim1_capture_compare4_channel_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 1312: return (TIM1_CC4_CHANNEL_MODE)(TIM1->CCMR4 & 0x03);
	ld	a, 0x525b
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 1313: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1316: static inline void tim1_capture_compare4_fast_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare4_fast_enable
;	-----------------------------------------
_tim1_capture_compare4_fast_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1317: TIM1->CCMR4 |= (1U << 2);
	bset	0x525b, #2
;	.\../STM8S103F3_Drivers/timer.h: 1318: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1320: static inline void tim1_capture_compare4_fast_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare4_fast_disable
;	-----------------------------------------
_tim1_capture_compare4_fast_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1321: TIM1->CCMR4 &= ~(1U << 2);
	bres	0x525b, #2
;	.\../STM8S103F3_Drivers/timer.h: 1322: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1324: static inline void tim1_capture_compare4_preload_enable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare4_preload_enable
;	-----------------------------------------
_tim1_capture_compare4_preload_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1325: TIM1->CCMR4 |= (1U << 3);
	bset	0x525b, #3
;	.\../STM8S103F3_Drivers/timer.h: 1326: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1328: static inline void tim1_capture_compare4_preload_disable(void) {
;	-----------------------------------------
;	 function tim1_capture_compare4_preload_disable
;	-----------------------------------------
_tim1_capture_compare4_preload_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1329: TIM1->CCMR4 &= ~(1U << 3);
	bres	0x525b, #3
;	.\../STM8S103F3_Drivers/timer.h: 1330: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1332: static inline void tim1_output_compare4_mode_set(TIM1_OUTPUT_COMPARE_MODE mode) {
;	-----------------------------------------
;	 function tim1_output_compare4_mode_set
;	-----------------------------------------
_tim1_output_compare4_mode_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1333: TIM1->CCMR4 = (TIM1->CCMR4 & 0x8F) | ((uint8_t)mode << 4);
	ld	a, 0x525b
	and	a, #0x8f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x525b, a
;	.\../STM8S103F3_Drivers/timer.h: 1334: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1336: static inline TIM1_OUTPUT_COMPARE_MODE tim1_output_compare4_mode_read(void) {
;	-----------------------------------------
;	 function tim1_output_compare4_mode_read
;	-----------------------------------------
_tim1_output_compare4_mode_read:
;	.\../STM8S103F3_Drivers/timer.h: 1337: return (TIM1_OUTPUT_COMPARE_MODE)((TIM1->CCMR4 >> 4) & 0x07);
	ld	a, 0x525b
	swap	a
	and	a, #7
;	.\../STM8S103F3_Drivers/timer.h: 1338: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1340: static inline void tim1_output_compare4_clear_enable(void) {
;	-----------------------------------------
;	 function tim1_output_compare4_clear_enable
;	-----------------------------------------
_tim1_output_compare4_clear_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1341: TIM1->CCMR4 |= (1U << 7);
	bset	0x525b, #7
;	.\../STM8S103F3_Drivers/timer.h: 1342: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1344: static inline void tim1_output_compare4_clear_disable(void) {
;	-----------------------------------------
;	 function tim1_output_compare4_clear_disable
;	-----------------------------------------
_tim1_output_compare4_clear_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1345: TIM1->CCMR4 &= ~(1U << 7);
	bres	0x525b, #7
;	.\../STM8S103F3_Drivers/timer.h: 1346: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1349: static inline void tim1_input_capture4_prescaler_set(TIM1_INPUT_CAPTURE_PRESCALER psc) {
;	-----------------------------------------
;	 function tim1_input_capture4_prescaler_set
;	-----------------------------------------
_tim1_input_capture4_prescaler_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1350: TIM1->CCMR4 = (TIM1->CCMR4 & 0xF3) | ((uint8_t)psc << 2);
	ld	a, 0x525b
	and	a, #0xf3
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x525b, a
;	.\../STM8S103F3_Drivers/timer.h: 1351: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1353: static inline TIM1_INPUT_CAPTURE_PRESCALER tim1_input_capture4_prescaler_read(void) {
;	-----------------------------------------
;	 function tim1_input_capture4_prescaler_read
;	-----------------------------------------
_tim1_input_capture4_prescaler_read:
;	.\../STM8S103F3_Drivers/timer.h: 1354: return (TIM1_INPUT_CAPTURE_PRESCALER)((TIM1->CCMR4 >> 2) & 0x03);
	ld	a, 0x525b
	srl	a
	srl	a
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 1355: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1357: static inline void tim1_input_capture4_filter_set(TIM1_INPUT_CAPTURE_FILTER filter) {
;	-----------------------------------------
;	 function tim1_input_capture4_filter_set
;	-----------------------------------------
_tim1_input_capture4_filter_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1358: TIM1->CCMR4 = (TIM1->CCMR4 & 0x0F) | ((uint8_t)filter << 4);
	ld	a, 0x525b
	and	a, #0x0f
	ld	(0x01, sp), a
	ld	a, xl
	swap	a
	and	a, #0xf0
	or	a, (0x01, sp)
	ld	0x525b, a
;	.\../STM8S103F3_Drivers/timer.h: 1359: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1361: static inline TIM1_INPUT_CAPTURE_FILTER tim1_input_capture4_filter_read(void) {
;	-----------------------------------------
;	 function tim1_input_capture4_filter_read
;	-----------------------------------------
_tim1_input_capture4_filter_read:
;	.\../STM8S103F3_Drivers/timer.h: 1362: return (TIM1_INPUT_CAPTURE_FILTER)((TIM1->CCMR4 >> 4) & 0x0F);
	ld	a, 0x525b
	swap	a
	and	a, #15
;	.\../STM8S103F3_Drivers/timer.h: 1363: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1373: static inline void tim1_capture_compare_1_2_output_enable(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_output_enable
;	-----------------------------------------
_tim1_capture_compare_1_2_output_enable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1374: TIM1->CCER1 |= (1U << cc_enable);
	ld	a, 0x525c
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x525c, a
;	.\../STM8S103F3_Drivers/timer.h: 1375: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1377: static inline void tim1_capture_compare_1_2_output_disable(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_output_disable
;	-----------------------------------------
_tim1_capture_compare_1_2_output_disable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1378: TIM1->CCER1 &= ~(1U << cc_enable);
	ld	a, 0x525c
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x525c, a
;	.\../STM8S103F3_Drivers/timer.h: 1379: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1381: static inline uint8_t tim1_capture_compare_1_2_output_is_enabled(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_output_is_enabled
;	-----------------------------------------
_tim1_capture_compare_1_2_output_is_enabled:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1382: return ((TIM1->CCER1 >> cc_enable) & 1);
	ld	a, 0x525c
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 1383: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1391: static inline void tim1_capture_compare_1_2_output_polarity_high(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_output_polarity_high
;	-----------------------------------------
_tim1_capture_compare_1_2_output_polarity_high:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1392: TIM1->CCER1 &= ~(1U << polarity);
	ld	a, 0x525c
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x525c, a
;	.\../STM8S103F3_Drivers/timer.h: 1393: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1395: static inline void tim1_capture_compare_1_2_output_polarity_low(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_output_polarity_low
;	-----------------------------------------
_tim1_capture_compare_1_2_output_polarity_low:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1396: TIM1->CCER1 |= (1U << polarity);
	ld	a, 0x525c
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x525c, a
;	.\../STM8S103F3_Drivers/timer.h: 1397: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1399: static inline uint8_t tim1_capture_compare_1_2_output_polarity_is_high(TIM1_CAPTURE_COMPARE_1_2_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_output_polarity_is_high
;	-----------------------------------------
_tim1_capture_compare_1_2_output_polarity_is_high:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1400: return ((TIM1->CCER1 >> polarity) & 1) == 0;
	ld	a, 0x525c
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
	sub	a, #0x00
	jrne	00106$
	inc	a
	ret
00106$:
	clr	a
;	.\../STM8S103F3_Drivers/timer.h: 1401: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1409: static inline void tim1_capture_compare_1_2_complementary_output_enable(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_complementary_output_enable
;	-----------------------------------------
_tim1_capture_compare_1_2_complementary_output_enable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1410: TIM1->CCER1 |= (1U << cc_enable);
	ld	a, 0x525c
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x525c, a
;	.\../STM8S103F3_Drivers/timer.h: 1411: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1413: static inline void tim1_capture_compare_1_2_complementary_output_disable(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_complementary_output_disable
;	-----------------------------------------
_tim1_capture_compare_1_2_complementary_output_disable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1414: TIM1->CCER1 &= ~(1U << cc_enable);
	ld	a, 0x525c
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x525c, a
;	.\../STM8S103F3_Drivers/timer.h: 1415: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1417: static inline uint8_t tim1_capture_compare_1_2_complementary_output_is_enabled(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_complementary_output_is_enabled
;	-----------------------------------------
_tim1_capture_compare_1_2_complementary_output_is_enabled:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1418: return ((TIM1->CCER1 >> cc_enable) & 1);
	ld	a, 0x525c
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 1419: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1427: static inline void tim1_capture_compare_1_2_complementary_output_polarity_high(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_complementary_output_polarity_high
;	-----------------------------------------
_tim1_capture_compare_1_2_complementary_output_polarity_high:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1428: TIM1->CCER1 &= ~(1U << polarity);
	ld	a, 0x525c
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x525c, a
;	.\../STM8S103F3_Drivers/timer.h: 1429: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1431: static inline void tim1_capture_compare_1_2_complementary_output_polarity_low(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_complementary_output_polarity_low
;	-----------------------------------------
_tim1_capture_compare_1_2_complementary_output_polarity_low:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1432: TIM1->CCER1 |= (1U << polarity);
	ld	a, 0x525c
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x525c, a
;	.\../STM8S103F3_Drivers/timer.h: 1433: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1435: static inline uint8_t tim1_capture_compare_1_2_complementary_output_polarity_is_high(TIM1_CAPTURE_COMPARE_1_2_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_1_2_complementary_output_polarity_is_high
;	-----------------------------------------
_tim1_capture_compare_1_2_complementary_output_polarity_is_high:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1436: return ((TIM1->CCER1 >> polarity) & 1) == 0;
	ld	a, 0x525c
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
	sub	a, #0x00
	jrne	00106$
	inc	a
	ret
00106$:
	clr	a
;	.\../STM8S103F3_Drivers/timer.h: 1437: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1447: static inline void tim1_capture_compare_3_4_output_enable(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_4_output_enable
;	-----------------------------------------
_tim1_capture_compare_3_4_output_enable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1448: TIM1->CCER2 |= (1U << cc_enable);
	ld	a, 0x525d
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x525d, a
;	.\../STM8S103F3_Drivers/timer.h: 1449: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1451: static inline void tim1_capture_compare_3_4_output_disable(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_4_output_disable
;	-----------------------------------------
_tim1_capture_compare_3_4_output_disable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1452: TIM1->CCER2 &= ~(1U << cc_enable);
	ld	a, 0x525d
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x525d, a
;	.\../STM8S103F3_Drivers/timer.h: 1453: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1455: static inline uint8_t tim1_capture_compare_3_4_output_is_enabled(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_4_output_is_enabled
;	-----------------------------------------
_tim1_capture_compare_3_4_output_is_enabled:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1456: return ((TIM1->CCER2 >> cc_enable) & 1);
	ld	a, 0x525d
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 1457: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1464: static inline void tim1_capture_compare_3_4_output_polarity_high(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_4_output_polarity_high
;	-----------------------------------------
_tim1_capture_compare_3_4_output_polarity_high:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1465: TIM1->CCER2 &= ~(1U << polarity);
	ld	a, 0x525d
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x525d, a
;	.\../STM8S103F3_Drivers/timer.h: 1466: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1468: static inline void tim1_capture_compare_3_4_output_polarity_low(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_4_output_polarity_low
;	-----------------------------------------
_tim1_capture_compare_3_4_output_polarity_low:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1469: TIM1->CCER2 |= (1U << polarity);
	ld	a, 0x525d
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x525d, a
;	.\../STM8S103F3_Drivers/timer.h: 1470: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1472: static inline uint8_t tim1_capture_compare_3_4_output_polarity_is_high(TIM1_CAPTURE_COMPARE_3_4_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_4_output_polarity_is_high
;	-----------------------------------------
_tim1_capture_compare_3_4_output_polarity_is_high:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1473: return ((TIM1->CCER2 >> polarity) & 1) == 0;
	ld	a, 0x525d
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
	sub	a, #0x00
	jrne	00106$
	inc	a
	ret
00106$:
	clr	a
;	.\../STM8S103F3_Drivers/timer.h: 1474: } 
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1480: static inline void tim1_capture_compare_3_complementary_output_enable(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_complementary_output_enable
;	-----------------------------------------
_tim1_capture_compare_3_complementary_output_enable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1481: TIM1->CCER2 |= (1U << cc_enable);
	ld	a, 0x525d
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x525d, a
;	.\../STM8S103F3_Drivers/timer.h: 1482: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1484: static inline void tim1_capture_compare_3_complementary_output_disable(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_complementary_output_disable
;	-----------------------------------------
_tim1_capture_compare_3_complementary_output_disable:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1485: TIM1->CCER2 &= ~(1U << cc_enable);
	ld	a, 0x525d
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x525d, a
;	.\../STM8S103F3_Drivers/timer.h: 1486: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1488: static inline uint8_t tim1_capture_compare_3_complementary_output_is_enabled(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_ENABLE cc_enable) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_complementary_output_is_enabled
;	-----------------------------------------
_tim1_capture_compare_3_complementary_output_is_enabled:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1489: return ((TIM1->CCER2 >> cc_enable) & 1);
	ld	a, 0x525d
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
;	.\../STM8S103F3_Drivers/timer.h: 1490: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1496: static inline void tim1_capture_compare_3_complementary_output_polarity_high(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_complementary_output_polarity_high
;	-----------------------------------------
_tim1_capture_compare_3_complementary_output_polarity_high:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1497: TIM1->CCER2 &= ~(1U << polarity);
	ld	a, 0x525d
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	0x525d, a
;	.\../STM8S103F3_Drivers/timer.h: 1498: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1500: static inline void tim1_capture_compare_3_complementary_output_polarity_low(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_complementary_output_polarity_low
;	-----------------------------------------
_tim1_capture_compare_3_complementary_output_polarity_low:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1501: TIM1->CCER2 |= (1U << polarity);
	ld	a, 0x525d
	push	a
	ld	a, #0x01
	ld	(0x02, sp), a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(0x02, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	or	a, (0x01, sp)
	ld	0x525d, a
;	.\../STM8S103F3_Drivers/timer.h: 1502: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1504: static inline uint8_t tim1_capture_compare_3_complementary_output_polarity_is_high(TIM1_CAPTURE_COMPARE_3_COMPLEMENTARY_OUTPUT_POLARITY polarity) {
;	-----------------------------------------
;	 function tim1_capture_compare_3_complementary_output_polarity_is_high
;	-----------------------------------------
_tim1_capture_compare_3_complementary_output_polarity_is_high:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1505: return ((TIM1->CCER2 >> polarity) & 1) == 0;
	ld	a, 0x525d
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	srl	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	and	a, #0x01
	sub	a, #0x00
	jrne	00106$
	inc	a
	ret
00106$:
	clr	a
;	.\../STM8S103F3_Drivers/timer.h: 1506: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1511: static inline void tim1_counter_write(uint16_t value) {
;	-----------------------------------------
;	 function tim1_counter_write
;	-----------------------------------------
_tim1_counter_write:
;	.\../STM8S103F3_Drivers/timer.h: 1513: TIM1->CNTRH = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x525e, a
;	.\../STM8S103F3_Drivers/timer.h: 1514: TIM1->CNTRL = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x525f, a
;	.\../STM8S103F3_Drivers/timer.h: 1515: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1517: static inline uint16_t tim1_counter_read(void) {
;	-----------------------------------------
;	 function tim1_counter_read
;	-----------------------------------------
_tim1_counter_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 1519: uint8_t high_byte = TIM1->CNTRH; 
	ld	a, 0x525e
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 1520: uint8_t low_byte = TIM1->CNTRL;  
	ld	a, 0x525f
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1521: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 1522: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1527: static inline void tim1_prescaler_write(uint16_t value) {
;	-----------------------------------------
;	 function tim1_prescaler_write
;	-----------------------------------------
_tim1_prescaler_write:
;	.\../STM8S103F3_Drivers/timer.h: 1529: TIM1->PSCRH = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x5260, a
;	.\../STM8S103F3_Drivers/timer.h: 1530: TIM1->PSCRL = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x5261, a
;	.\../STM8S103F3_Drivers/timer.h: 1531: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1533: static inline uint16_t tim1_prescaler_read(void) {
;	-----------------------------------------
;	 function tim1_prescaler_read
;	-----------------------------------------
_tim1_prescaler_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 1535: uint8_t high_byte = TIM1->PSCRH; 
	ld	a, 0x5260
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 1536: uint8_t low_byte = TIM1->PSCRL;  
	ld	a, 0x5261
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1537: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 1538: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1543: static inline void tim1_auto_reload_write(uint16_t value) {
;	-----------------------------------------
;	 function tim1_auto_reload_write
;	-----------------------------------------
_tim1_auto_reload_write:
;	.\../STM8S103F3_Drivers/timer.h: 1545: TIM1->ARRH = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x5262, a
;	.\../STM8S103F3_Drivers/timer.h: 1546: TIM1->ARRL = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x5263, a
;	.\../STM8S103F3_Drivers/timer.h: 1547: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1549: static inline uint16_t tim1_auto_reload_read(void) {
;	-----------------------------------------
;	 function tim1_auto_reload_read
;	-----------------------------------------
_tim1_auto_reload_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 1551: uint8_t high_byte = TIM1->ARRH; 
	ld	a, 0x5262
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 1552: uint8_t low_byte = TIM1->ARRL;  
	ld	a, 0x5263
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1553: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 1554: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1559: static inline void tim1_repetition_counter_write(uint8_t value) {
;	-----------------------------------------
;	 function tim1_repetition_counter_write
;	-----------------------------------------
_tim1_repetition_counter_write:
;	.\../STM8S103F3_Drivers/timer.h: 1560: TIM1->RCR = value;
	ld	0x5264, a
;	.\../STM8S103F3_Drivers/timer.h: 1561: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1563: static inline uint8_t tim1_repetition_counter_read(void) {
;	-----------------------------------------
;	 function tim1_repetition_counter_read
;	-----------------------------------------
_tim1_repetition_counter_read:
;	.\../STM8S103F3_Drivers/timer.h: 1564: return TIM1->RCR;
	ld	a, 0x5264
;	.\../STM8S103F3_Drivers/timer.h: 1565: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1570: static inline void tim1_capture_compare1_write(uint16_t value) {
;	-----------------------------------------
;	 function tim1_capture_compare1_write
;	-----------------------------------------
_tim1_capture_compare1_write:
;	.\../STM8S103F3_Drivers/timer.h: 1572: TIM1->CCR1H = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x5265, a
;	.\../STM8S103F3_Drivers/timer.h: 1573: TIM1->CCR1L = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x5266, a
;	.\../STM8S103F3_Drivers/timer.h: 1574: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1576: static inline uint16_t tim1_capture_compare1_read(void) {
;	-----------------------------------------
;	 function tim1_capture_compare1_read
;	-----------------------------------------
_tim1_capture_compare1_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 1578: uint8_t high_byte = TIM1->CCR1H; 
	ld	a, 0x5265
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 1579: uint8_t low_byte = TIM1->CCR1L;  
	ld	a, 0x5266
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1580: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 1581: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1586: static inline void tim1_capture_compare2_write(uint16_t value) {
;	-----------------------------------------
;	 function tim1_capture_compare2_write
;	-----------------------------------------
_tim1_capture_compare2_write:
;	.\../STM8S103F3_Drivers/timer.h: 1588: TIM1->CCR2H = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x5267, a
;	.\../STM8S103F3_Drivers/timer.h: 1589: TIM1->CCR2L = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x5268, a
;	.\../STM8S103F3_Drivers/timer.h: 1590: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1592: static inline uint16_t tim1_capture_compare2_read(void) {
;	-----------------------------------------
;	 function tim1_capture_compare2_read
;	-----------------------------------------
_tim1_capture_compare2_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 1594: uint8_t high_byte = TIM1->CCR2H; 
	ld	a, 0x5267
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 1595: uint8_t low_byte = TIM1->CCR2L;  
	ld	a, 0x5268
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1596: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 1597: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1602: static inline void tim1_capture_compare3_write(uint16_t value) {
;	-----------------------------------------
;	 function tim1_capture_compare3_write
;	-----------------------------------------
_tim1_capture_compare3_write:
;	.\../STM8S103F3_Drivers/timer.h: 1604: TIM1->CCR3H = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x5269, a
;	.\../STM8S103F3_Drivers/timer.h: 1605: TIM1->CCR3L = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x526a, a
;	.\../STM8S103F3_Drivers/timer.h: 1606: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1608: static inline uint16_t tim1_capture_compare3_read(void) {
;	-----------------------------------------
;	 function tim1_capture_compare3_read
;	-----------------------------------------
_tim1_capture_compare3_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 1610: uint8_t high_byte = TIM1->CCR3H; 
	ld	a, 0x5269
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 1611: uint8_t low_byte = TIM1->CCR3L;  
	ld	a, 0x526a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1612: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 1613: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1618: static inline void tim1_capture_compare4_write(uint16_t value) {
;	-----------------------------------------
;	 function tim1_capture_compare4_write
;	-----------------------------------------
_tim1_capture_compare4_write:
;	.\../STM8S103F3_Drivers/timer.h: 1620: TIM1->CCR4H = (uint8_t)((value >> 8) & 0xFF);
	ld	a, xh
	ld	0x526b, a
;	.\../STM8S103F3_Drivers/timer.h: 1621: TIM1->CCR4L = (uint8_t)(value & 0xFF);
	ld	a, xl
	ld	0x526c, a
;	.\../STM8S103F3_Drivers/timer.h: 1622: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1624: static inline uint16_t tim1_capture_compare4_read(void) {
;	-----------------------------------------
;	 function tim1_capture_compare4_read
;	-----------------------------------------
_tim1_capture_compare4_read:
	sub	sp, #2
;	.\../STM8S103F3_Drivers/timer.h: 1626: uint8_t high_byte = TIM1->CCR4H; 
	ld	a, 0x526b
	ld	xh, a
;	.\../STM8S103F3_Drivers/timer.h: 1627: uint8_t low_byte = TIM1->CCR4L;  
	ld	a, 0x526c
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1628: return ((uint16_t)high_byte << 8) | low_byte;
	clr	(0x02, sp)
;	.\../STM8S103F3_Drivers/timer.h: 1629: }
	addw	sp, #2
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1641: static inline void tim1_lock_control_set(TIM1_LOCK_CONTROL lock) {
;	-----------------------------------------
;	 function tim1_lock_control_set
;	-----------------------------------------
_tim1_lock_control_set:
	push	a
	ld	(0x01, sp), a
;	.\../STM8S103F3_Drivers/timer.h: 1642: TIM1->BKR = (TIM1->BKR & 0xFC) | lock;
	ld	a, 0x526d
	and	a, #0xfc
	or	a, (0x01, sp)
	ld	0x526d, a
;	.\../STM8S103F3_Drivers/timer.h: 1643: }
	pop	a
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1645: static inline TIM1_LOCK_CONTROL tim1_lock_control_read(void) {
;	-----------------------------------------
;	 function tim1_lock_control_read
;	-----------------------------------------
_tim1_lock_control_read:
;	.\../STM8S103F3_Drivers/timer.h: 1646: return (TIM1_LOCK_CONTROL)(TIM1->BKR & 0x03);
	ld	a, 0x526d
	and	a, #0x03
;	.\../STM8S103F3_Drivers/timer.h: 1647: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1654: static inline void tim1_off_state_idle_mode_set(TIM1_OFF_STATE_IDLE_MODE mode) {
;	-----------------------------------------
;	 function tim1_off_state_idle_mode_set
;	-----------------------------------------
_tim1_off_state_idle_mode_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1655: TIM1->BKR = (TIM1->BKR & ~(1U << 2)) | (mode << 2);
	ld	a, 0x526d
	and	a, #0xfb
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x526d, a
;	.\../STM8S103F3_Drivers/timer.h: 1656: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1663: static inline void tim1_off_state_run_mode_set(TIM1_OFF_STATE_RUN_MODE mode) {
;	-----------------------------------------
;	 function tim1_off_state_run_mode_set
;	-----------------------------------------
_tim1_off_state_run_mode_set:
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1664: TIM1->BKR = (TIM1->BKR & ~(1U << 3)) | (mode << 3);
	ld	a, 0x526d
	and	a, #0xf7
	sllw	x
	sllw	x
	sllw	x
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	0x526d, a
;	.\../STM8S103F3_Drivers/timer.h: 1665: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1667: static inline void tim1_break_input_enable(void) {
;	-----------------------------------------
;	 function tim1_break_input_enable
;	-----------------------------------------
_tim1_break_input_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1668: TIM1->BKR |= (1U << 4);
	bset	0x526d, #4
;	.\../STM8S103F3_Drivers/timer.h: 1669: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1671: static inline void tim1_break_input_disable(void) {
;	-----------------------------------------
;	 function tim1_break_input_disable
;	-----------------------------------------
_tim1_break_input_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1672: TIM1->BKR &= ~(1U << 4);
	bres	0x526d, #4
;	.\../STM8S103F3_Drivers/timer.h: 1673: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1675: static inline void tim1_break_input_polarity_high(void) {
;	-----------------------------------------
;	 function tim1_break_input_polarity_high
;	-----------------------------------------
_tim1_break_input_polarity_high:
;	.\../STM8S103F3_Drivers/timer.h: 1676: TIM1->BKR |= (1U << 5);
	bset	0x526d, #5
;	.\../STM8S103F3_Drivers/timer.h: 1677: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1679: static inline void tim1_break_input_polarity_low(void) {
;	-----------------------------------------
;	 function tim1_break_input_polarity_low
;	-----------------------------------------
_tim1_break_input_polarity_low:
;	.\../STM8S103F3_Drivers/timer.h: 1680: TIM1->BKR &= ~(1U << 5);
	bres	0x526d, #5
;	.\../STM8S103F3_Drivers/timer.h: 1681: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1683: static inline void tim1_automatic_output_enable(void) {
;	-----------------------------------------
;	 function tim1_automatic_output_enable
;	-----------------------------------------
_tim1_automatic_output_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1684: TIM1->BKR |= (1U << 6);
	bset	0x526d, #6
;	.\../STM8S103F3_Drivers/timer.h: 1685: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1687: static inline void tim1_automatic_output_disable(void) {
;	-----------------------------------------
;	 function tim1_automatic_output_disable
;	-----------------------------------------
_tim1_automatic_output_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1688: TIM1->BKR &= ~(1U << 6);
	bres	0x526d, #6
;	.\../STM8S103F3_Drivers/timer.h: 1689: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1691: static inline void tim1_main_output_enable(void) {
;	-----------------------------------------
;	 function tim1_main_output_enable
;	-----------------------------------------
_tim1_main_output_enable:
;	.\../STM8S103F3_Drivers/timer.h: 1692: TIM1->BKR |= (1U << 7);
	bset	0x526d, #7
;	.\../STM8S103F3_Drivers/timer.h: 1693: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1695: static inline void tim1_main_output_disable(void) {
;	-----------------------------------------
;	 function tim1_main_output_disable
;	-----------------------------------------
_tim1_main_output_disable:
;	.\../STM8S103F3_Drivers/timer.h: 1696: TIM1->BKR &= ~(1U << 7);
	bres	0x526d, #7
;	.\../STM8S103F3_Drivers/timer.h: 1697: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1702: static inline void tim1_dead_time_set(uint8_t dead_time) {
;	-----------------------------------------
;	 function tim1_dead_time_set
;	-----------------------------------------
_tim1_dead_time_set:
;	.\../STM8S103F3_Drivers/timer.h: 1703: TIM1->DTR = dead_time;
	ld	0x526e, a
;	.\../STM8S103F3_Drivers/timer.h: 1704: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1706: static inline uint8_t tim1_dead_time_read(void) {
;	-----------------------------------------
;	 function tim1_dead_time_read
;	-----------------------------------------
_tim1_dead_time_read:
;	.\../STM8S103F3_Drivers/timer.h: 1707: return TIM1->DTR;
	ld	a, 0x526e
;	.\../STM8S103F3_Drivers/timer.h: 1708: }
	ret
;	.\../STM8S103F3_Drivers/timer.h: 1728: static inline void tim1_output_compare_idle_state_set(TIM1_OUTPUT_COMPARE_CHANNEL channel, TIM1_IDLE_STATE state) {
;	-----------------------------------------
;	 function tim1_output_compare_idle_state_set
;	-----------------------------------------
_tim1_output_compare_idle_state_set:
	push	a
	ld	xl, a
;	.\../STM8S103F3_Drivers/timer.h: 1729: TIM1->OISR = (TIM1->OISR & ~(1U << channel)) | ((uint8_t)state << channel);
	ld	a, 0x526f
	ld	(0x01, sp), a
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00104$
00103$:
	sll	(1, sp)
	dec	a
	jrne	00103$
00104$:
	pop	a
	cpl	a
	and	a, (0x01, sp)
	ld	(0x01, sp), a
	ld	a, (0x04, sp)
	push	a
	ld	a, xl
	tnz	a
	jreq	00106$
00105$:
	sll	(1, sp)
	dec	a
	jrne	00105$
00106$:
	pop	a
	or	a, (0x01, sp)
	ld	0x526f, a
;	.\../STM8S103F3_Drivers/timer.h: 1730: }
	pop	a
	popw	x
	pop	a
	jp	(x)
;	.\ws2812.c: 7: int main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	.\../STM8S103F3_Drivers/clk.h: 125: CLK->ICKR |= (1U << 3);
	bset	0x50c0, #3
;	.\ws2812.c: 10: return 0;
	clrw	x
;	.\ws2812.c: 11: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
