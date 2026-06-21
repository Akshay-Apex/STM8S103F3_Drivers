;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module time
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _time_delay_sec
	.globl _time_delay_ms
	.globl _time_delay_us
	.globl _clk_fmaster_freq_get
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
;	.\time.c: 6: void time_delay_us(uint16_t us) {
;	-----------------------------------------
;	 function time_delay_us
;	-----------------------------------------
_time_delay_us:
	sub	sp, #10
	ldw	(0x09, sp), x
;	.\time.c: 7: uint32_t fmaster_freq = clk_fmaster_freq_get();
	call	_clk_fmaster_freq_get
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	ldw	y, (0x03, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x05, sp), y
;	.\time.c: 9: if(fmaster_freq == 0 || us == 0) {
	ldw	x, (0x03, sp)
	jrne	00182$
	ldw	x, (0x01, sp)
	jreq	00121$
00182$:
	ldw	x, (0x09, sp)
;	.\time.c: 10: return;
	jreq	00121$
;	.\time.c: 13: uint8_t divisor = fmaster_freq / 1000000UL;
	push	#0x40
	push	#0x42
	push	#0x0f
	push	#0x00
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	call	__divulong
	addw	sp, #8
;	.\time.c: 16: while(divisor > 1) {
	clr	a
00104$:
	push	a
	ld	a, xl
	cp	a, #0x01
	pop	a
	jrule	00106$
;	.\time.c: 17: divisor >>= 1;
	exg	a, xl
	srl	a
	exg	a, xl
;	.\time.c: 18: prescaler++;
	inc	a
	jra	00104$
00106$:
;	.\../STM8S103F3_L0_Drivers/timer.h: 213: TIM4->PSCR = value;
	ld	0x5347, a
;	.\time.c: 23: while(us > 0) {
00110$:
	ldw	x, (0x09, sp)
	jreq	00112$
;	.\time.c: 24: uint16_t chunk = (us >= 256) ? 256 : us;
	ldw	x, (0x09, sp)
	cpw	x, #0x0100
	jrc	00123$
	ldw	x, #0x0100
	.byte 0xc5
00123$:
	ldw	x, (0x09, sp)
00124$:
	ldw	(0x07, sp), x
;	.\time.c: 25: tim4_auto_reload_set((chunk - 1));
	ld	a, (0x08, sp)
	dec	a
;	.\../STM8S103F3_L0_Drivers/timer.h: 224: TIM4->ARR = value;
	ld	0x5348, a
;	.\../STM8S103F3_L0_Drivers/timer.h: 184: TIM4->EGR |= (1U << 0);
	bset	0x5345, #0
;	.\../STM8S103F3_L0_Drivers/timer.h: 173: TIM4->SR &= ~(1U << 0);
	bres	0x5344, #0
;	.\../STM8S103F3_L0_Drivers/timer.h: 115: TIM4->CR1 |= (1U << 0);
	bset	0x5340, #0
;	.\time.c: 31: while(!tim4_update_irq_flag_read());
00107$:
;	.\../STM8S103F3_L0_Drivers/timer.h: 177: return ((TIM4->SR >> 0) & 1);
;	.\time.c: 31: while(!tim4_update_irq_flag_read());
	btjf	0x5344, #0, 00107$
;	.\../STM8S103F3_L0_Drivers/timer.h: 119: TIM4->CR1 &= ~(1U << 0);
	bres	0x5340, #0
;	.\time.c: 34: us -= chunk;
	ldw	x, (0x09, sp)
	subw	x, (0x07, sp)
	ldw	(0x09, sp), x
	jra	00110$
00112$:
;	.\../STM8S103F3_L0_Drivers/timer.h: 173: TIM4->SR &= ~(1U << 0);
	bres	0x5344, #0
;	.\time.c: 37: tim4_update_irq_flag_clear();  
00121$:
;	.\time.c: 38: }
	addw	sp, #10
	ret
;	.\time.c: 41: void time_delay_ms(uint16_t ms) {
;	-----------------------------------------
;	 function time_delay_ms
;	-----------------------------------------
_time_delay_ms:
;	.\time.c: 42: while(ms--) {
00101$:
	ldw	y, x
	decw	x
	tnzw	y
	jrne	00121$
	ret
00121$:
;	.\time.c: 43: time_delay_us(1000);
	pushw	x
	ldw	x, #0x03e8
	call	_time_delay_us
	popw	x
	jra	00101$
;	.\time.c: 45: }
	ret
;	.\time.c: 48: void time_delay_sec(uint16_t sec) {
;	-----------------------------------------
;	 function time_delay_sec
;	-----------------------------------------
_time_delay_sec:
;	.\time.c: 49: while(sec--) {
00101$:
	ldw	y, x
	decw	x
	tnzw	y
	jrne	00121$
	ret
00121$:
;	.\time.c: 50: time_delay_ms(1000);
	pushw	x
	ldw	x, #0x03e8
	call	_time_delay_ms
	popw	x
	jra	00101$
;	.\time.c: 52: }
	ret
;	.\time.c: 55: int main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	.\time.c: 56: time_delay_ms(250);
	ldw	x, #0x00fa
	call	_time_delay_ms
;	.\time.c: 58: while(1);
00102$:
	jra	00102$
;	.\time.c: 59: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
