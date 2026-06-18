;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module ws2812
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _clk_active_halt_mvr_enable
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
;	.\../STM8S103F3_Drivers/clk.h: 100: void clk_active_halt_mvr_enable(void) {
;	-----------------------------------------
;	 function clk_active_halt_mvr_enable
;	-----------------------------------------
_clk_active_halt_mvr_enable:
;	.\../STM8S103F3_Drivers/clk.h: 101: CLK->ICKR &= ~(1U << 5);
	bres	0x50c0, #5
;	.\../STM8S103F3_Drivers/clk.h: 102: }
	ret
;	.\ws2812.c: 7: int main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	.\ws2812.c: 8: clk_active_halt_mvr_enable();
	call	_clk_active_halt_mvr_enable
;	.\ws2812.c: 9: while (1) {
00102$:
	jra	00102$
;	.\ws2812.c: 12: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
