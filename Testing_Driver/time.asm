;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module time
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _clk_fmaster_freq_khz_get
	.globl _TIM4_PSC_VAL_FOR_125KHZ
	.globl _time_timing_calibrate
	.globl _time_init
	.globl _time_delay_lsi_ms
	.globl _time_delay_lsi_sec
	.globl _time_delay_ms
	.globl _time_delay_sec
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_TIM4_PSC_VAL_FOR_125KHZ::
	.ds 1
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
;	..\STM8S103F3_L1_Drivers\time.c: 17: void time_timing_calibrate(void) {  
;	-----------------------------------------
;	 function time_timing_calibrate
;	-----------------------------------------
_time_timing_calibrate:
;	..\STM8S103F3_L1_Drivers\time.c: 18: uint8_t fmaster_freq_mhz = (clk_fmaster_freq_khz_get() / 1000U);    
	call	_clk_fmaster_freq_khz_get
	ldw	y, #0x03e8
	divw	x, y
	ld	a, xl
;	..\STM8S103F3_L1_Drivers\time.c: 21: switch(fmaster_freq_mhz) {
	cp	a, #0x01
	jreq	00105$
	cp	a, #0x02
	jreq	00104$
	cp	a, #0x04
	jreq	00103$
	cp	a, #0x08
	jreq	00102$
	cp	a, #0x10
	jrne	00106$
;	..\STM8S103F3_L1_Drivers\time.c: 23: TIM4_PSC_VAL_FOR_125KHZ = 7;
	mov	_TIM4_PSC_VAL_FOR_125KHZ+0, #0x07
;	..\STM8S103F3_L1_Drivers\time.c: 24: break;
	ret
;	..\STM8S103F3_L1_Drivers\time.c: 25: case 8:
00102$:
;	..\STM8S103F3_L1_Drivers\time.c: 26: TIM4_PSC_VAL_FOR_125KHZ = 6;
	mov	_TIM4_PSC_VAL_FOR_125KHZ+0, #0x06
;	..\STM8S103F3_L1_Drivers\time.c: 27: break;
	ret
;	..\STM8S103F3_L1_Drivers\time.c: 28: case 4:
00103$:
;	..\STM8S103F3_L1_Drivers\time.c: 29: TIM4_PSC_VAL_FOR_125KHZ = 5;
	mov	_TIM4_PSC_VAL_FOR_125KHZ+0, #0x05
;	..\STM8S103F3_L1_Drivers\time.c: 30: break;
	ret
;	..\STM8S103F3_L1_Drivers\time.c: 31: case 2:
00104$:
;	..\STM8S103F3_L1_Drivers\time.c: 32: TIM4_PSC_VAL_FOR_125KHZ = 4;
	mov	_TIM4_PSC_VAL_FOR_125KHZ+0, #0x04
;	..\STM8S103F3_L1_Drivers\time.c: 33: break;
	ret
;	..\STM8S103F3_L1_Drivers\time.c: 34: case 1:
00105$:
;	..\STM8S103F3_L1_Drivers\time.c: 35: TIM4_PSC_VAL_FOR_125KHZ = 3;
	mov	_TIM4_PSC_VAL_FOR_125KHZ+0, #0x03
;	..\STM8S103F3_L1_Drivers\time.c: 36: break;
	ret
;	..\STM8S103F3_L1_Drivers\time.c: 37: default:
00106$:
;	..\STM8S103F3_L1_Drivers\time.c: 38: TIM4_PSC_VAL_FOR_125KHZ = 0;
	clr	_TIM4_PSC_VAL_FOR_125KHZ+0
;	..\STM8S103F3_L1_Drivers\time.c: 40: }    
;	..\STM8S103F3_L1_Drivers\time.c: 41: }
	ret
;	..\STM8S103F3_L1_Drivers\time.c: 45: void time_init(void) {  
;	-----------------------------------------
;	 function time_init
;	-----------------------------------------
_time_init:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/clk.h: 271: CLK->PCKENR1 |= (1U << periph);
	bset	0x50c7, #4
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 152: TIM4->CR1 |= (1U << 7);
	bset	0x5340, #7
;	..\STM8S103F3_L1_Drivers\time.c: 48: time_timing_calibrate();
;	..\STM8S103F3_L1_Drivers\time.c: 49: }
	jp	_time_timing_calibrate
;	..\STM8S103F3_L1_Drivers\time.c: 54: void time_delay_lsi_ms(uint16_t ms) {
;	-----------------------------------------
;	 function time_delay_lsi_ms
;	-----------------------------------------
_time_delay_lsi_ms:
;	..\STM8S103F3_L1_Drivers\time.c: 55: if(ms == 0) return;
	tnzw	x
	jrne	00102$
	ret
00102$:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 214: TIM4->PSCR = value;
	mov	0x5347+0, #0x00
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 225: TIM4->ARR = value;
	mov	0x5348+0, #0x7f
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 185: TIM4->EGR |= (1U << 0);
	bset	0x5345, #0
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 174: TIM4->SR &= ~(1U << 0);
	bres	0x5344, #0
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 116: TIM4->CR1 |= (1U << 0);
	bset	0x5340, #0
;	..\STM8S103F3_L1_Drivers\time.c: 65: while(ms--) {
00106$:
	ldw	y, x
	decw	x
	tnzw	y
	jreq	00108$
;	..\STM8S103F3_L1_Drivers\time.c: 66: while(!tim4_update_irq_flag_read());
00103$:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 178: return ((TIM4->SR >> 0) & 1);
;	..\STM8S103F3_L1_Drivers\time.c: 66: while(!tim4_update_irq_flag_read());
	btjf	0x5344, #0, 00103$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 174: TIM4->SR &= ~(1U << 0);
	bres	0x5344, #0
;	..\STM8S103F3_L1_Drivers\time.c: 67: tim4_update_irq_flag_clear();
	jra	00106$
00108$:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 120: TIM4->CR1 &= ~(1U << 0);
	bres	0x5340, #0
;	..\STM8S103F3_L1_Drivers\time.c: 70: tim4_counter_disable();
;	..\STM8S103F3_L1_Drivers\time.c: 71: }
	ret
;	..\STM8S103F3_L1_Drivers\time.c: 74: void time_delay_lsi_sec(uint16_t sec) {  
;	-----------------------------------------
;	 function time_delay_lsi_sec
;	-----------------------------------------
_time_delay_lsi_sec:
;	..\STM8S103F3_L1_Drivers\time.c: 75: while(sec--) {
00101$:
	ldw	y, x
	decw	x
	tnzw	y
	jrne	00121$
	ret
00121$:
;	..\STM8S103F3_L1_Drivers\time.c: 76: time_delay_lsi_ms(1000U);
	pushw	x
	ldw	x, #0x03e8
	call	_time_delay_lsi_ms
	popw	x
	jra	00101$
;	..\STM8S103F3_L1_Drivers\time.c: 78: }
	ret
;	..\STM8S103F3_L1_Drivers\time.c: 83: void time_delay_ms(uint16_t ms) {
;	-----------------------------------------
;	 function time_delay_ms
;	-----------------------------------------
_time_delay_ms:
;	..\STM8S103F3_L1_Drivers\time.c: 84: if(ms == 0) return;
	tnzw	x
	jrne	00102$
	ret
00102$:
;	..\STM8S103F3_L1_Drivers\time.c: 86: tim4_prescaler_set(TIM4_PSC_VAL_FOR_125KHZ);
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 214: TIM4->PSCR = value;
	mov	0x5347, _TIM4_PSC_VAL_FOR_125KHZ+0
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 225: TIM4->ARR = value;
	mov	0x5348+0, #0x7c
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 185: TIM4->EGR |= (1U << 0);
	bset	0x5345, #0
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 174: TIM4->SR &= ~(1U << 0);
	bres	0x5344, #0
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 116: TIM4->CR1 |= (1U << 0);
	bset	0x5340, #0
;	..\STM8S103F3_L1_Drivers\time.c: 94: while(ms--) {
00106$:
	ldw	y, x
	decw	x
	tnzw	y
	jreq	00108$
;	..\STM8S103F3_L1_Drivers\time.c: 95: while(!tim4_update_irq_flag_read());
00103$:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 178: return ((TIM4->SR >> 0) & 1);
;	..\STM8S103F3_L1_Drivers\time.c: 95: while(!tim4_update_irq_flag_read());
	btjf	0x5344, #0, 00103$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 174: TIM4->SR &= ~(1U << 0);
	bres	0x5344, #0
;	..\STM8S103F3_L1_Drivers\time.c: 96: tim4_update_irq_flag_clear();
	jra	00106$
00108$:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/timer.h: 120: TIM4->CR1 &= ~(1U << 0);
	bres	0x5340, #0
;	..\STM8S103F3_L1_Drivers\time.c: 99: tim4_counter_disable();
;	..\STM8S103F3_L1_Drivers\time.c: 100: }
	ret
;	..\STM8S103F3_L1_Drivers\time.c: 103: void time_delay_sec(uint16_t sec) {  
;	-----------------------------------------
;	 function time_delay_sec
;	-----------------------------------------
_time_delay_sec:
;	..\STM8S103F3_L1_Drivers\time.c: 104: while(sec--) {
00101$:
	ldw	y, x
	decw	x
	tnzw	y
	jrne	00121$
	ret
00121$:
;	..\STM8S103F3_L1_Drivers\time.c: 105: time_delay_ms(1000U);
	pushw	x
	ldw	x, #0x03e8
	call	_time_delay_ms
	popw	x
	jra	00101$
;	..\STM8S103F3_L1_Drivers\time.c: 107: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__TIM4_PSC_VAL_FOR_125KHZ:
	.db #0x00	; 0
	.area CABS (ABS)
