;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module main
	
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
;	main.c: 19: static void tim4_init(void)
;	-----------------------------------------
;	 function tim4_init
;	-----------------------------------------
_tim4_init:
;	main.c: 29: TIM4_PSCR = 0x07;   /* Prescaler = 128 */
	mov	0x5347+0, #0x07
;	main.c: 30: TIM4_ARR  = 124;    /* 1 ms period */
	mov	0x5348+0, #0x7c
;	main.c: 31: TIM4_CR1  = 0x01;   /* Enable timer */
	mov	0x5340+0, #0x01
;	main.c: 32: }
	ret
;	main.c: 34: static void delay_ms(uint16_t ms)
;	-----------------------------------------
;	 function delay_ms
;	-----------------------------------------
_delay_ms:
;	main.c: 36: while(ms--)
00104$:
	ldw	y, x
	decw	x
	tnzw	y
	jrne	00138$
	ret
00138$:
;	main.c: 38: TIM4_SR = 0;
	mov	0x5344+0, #0x00
;	main.c: 40: while((TIM4_SR & 0x01) == 0)
00101$:
	btjt	0x5344, #0, 00104$
	jra	00101$
;	main.c: 45: }
	ret
;	main.c: 47: static void led_on(void)
;	-----------------------------------------
;	 function led_on
;	-----------------------------------------
_led_on:
;	main.c: 50: PB_ODR &= ~(1 << 5);
	bres	0x5005, #5
;	main.c: 51: }
	ret
;	main.c: 53: static void led_off(void)
;	-----------------------------------------
;	 function led_off
;	-----------------------------------------
_led_off:
;	main.c: 55: PB_ODR |= (1 << 5);
	bset	0x5005, #5
;	main.c: 56: }
	ret
;	main.c: 58: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	main.c: 61: CLK_CKDIVR = 0x00;
	mov	0x50c6+0, #0x00
;	main.c: 64: led_off();
	call	_led_off
;	main.c: 67: PB_DDR |= (1 << 5);
	bset	0x5007, #5
;	main.c: 68: PB_CR1 |= (1 << 5);
	bset	0x5008, #5
;	main.c: 69: PB_CR2 &= ~(1 << 5);
	bres	0x5009, #5
;	main.c: 72: tim4_init();
	call	_tim4_init
;	main.c: 74: while(1)
00102$:
;	main.c: 78: led_on();
	call	_led_on
;	main.c: 79: delay_ms(50);
	ldw	x, #0x0032
	call	_delay_ms
;	main.c: 81: led_off();
	call	_led_off
;	main.c: 82: delay_ms(60);
	ldw	x, #0x003c
	call	_delay_ms
;	main.c: 84: led_on();
	call	_led_on
;	main.c: 85: delay_ms(50);
	ldw	x, #0x0032
	call	_delay_ms
;	main.c: 87: led_off();
	call	_led_off
;	main.c: 88: delay_ms(840);
	ldw	x, #0x0348
	call	_delay_ms
	jra	00102$
;	main.c: 90: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
