;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _ws2812_send_frame
	.globl _ws2812_spi_init
	.globl _time_delay_lsi_ms
	.globl _time_init
	.globl _clk_fmaster_switch_src_auto_mode
	.globl _led_buffer
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_led_buffer::
	.ds 48
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
;	.\main.c: 15: int main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #9
;	.\../STM8S103F3_L0_Drivers/gpio.h: 111: port->DDR |= (pin_mask);
	bset	0x5011, #4
;	.\../STM8S103F3_L0_Drivers/gpio.h: 112: port->CR1 |= (pin_mask);
	bset	0x5012, #4
;	.\../STM8S103F3_L0_Drivers/gpio.h: 113: port->CR2 |= (pin_mask);
	bset	0x5013, #4
;	.\../STM8S103F3_L0_Drivers/gpio.h: 97: port->DDR |= (pin_mask);
	bset	0x5007, #5
;	.\../STM8S103F3_L0_Drivers/gpio.h: 98: port->CR1 |= (pin_mask);
	bset	0x5008, #5
;	.\../STM8S103F3_L0_Drivers/gpio.h: 99: port->CR2 &= ~(pin_mask);
	bres	0x5009, #5
;	.\main.c: 20: clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_LSI);  
	ld	a, #0xd2
	call	_clk_fmaster_switch_src_auto_mode
;	.\../STM8S103F3_L0_Drivers/clk.h: 211: CLK->CKDIVR = ((CLK->CKDIVR & CLK_CKDIVR_CPU_CLR_MASK) | ((uint8_t)value) << 0);
	ld	a, 0x50c6
	and	a, #0xf8
	ld	0x50c6, a
;	.\../STM8S103F3_L0_Drivers/gpio.h: 174: port->ODR |= (1U << pin);
	bset	0x5005, #5
;	.\main.c: 25: time_init();  
	call	_time_init
;	.\main.c: 26: ws2812_spi_init();
	call	_ws2812_spi_init
;	.\main.c: 31: while(1) {
	clrw	x
	ldw	(0x07, sp), x
;	.\main.c: 33: for(uint8_t bit = 0; bit < NUM_LEDS; bit++) {
00120$:
	clr	(0x09, sp)
00114$:
	ld	a, (0x09, sp)
	cp	a, #0x10
	jrnc	00104$
;	.\main.c: 35: if((binary_counter >> bit) & 0x01) {
	ldw	y, (0x07, sp)
	ld	a, (0x09, sp)
	jreq	00149$
00148$:
	srlw	y
	dec	a
	jrne	00148$
00149$:
;	.\main.c: 36: led_buffer[bit * 3]     = 0xFF; // G (Green ON)
	ld	a, (0x09, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
;	.\main.c: 37: led_buffer[bit * 3 + 1] = 0x00; // R
	ld	a, (0x09, sp)
;	.\main.c: 36: led_buffer[bit * 3]     = 0xFF; // G (Green ON)
	ldw	x, (0x01, sp)
	sllw	x
	addw	x, (0x01, sp)
	ldw	(0x04, sp), x
;	.\main.c: 37: led_buffer[bit * 3 + 1] = 0x00; // R
	exg	a, xl
	ld	a, #0x03
	exg	a, xl
	mul	x, a
	ld	a, xl
	incw	x
;	.\main.c: 38: led_buffer[bit * 3 + 2] = 0x00; // B
	add	a, #0x02
;	.\main.c: 37: led_buffer[bit * 3 + 1] = 0x00; // R
;	.\main.c: 38: led_buffer[bit * 3 + 2] = 0x00; // B
	ld	(0x06, sp), a
;	.\main.c: 35: if((binary_counter >> bit) & 0x01) {
	srlw	y
	jrnc	00102$
;	.\main.c: 36: led_buffer[bit * 3]     = 0xFF; // G (Green ON)
	ldw	y, (0x04, sp)
	ld	a, #0xff
	ld	((_led_buffer+0), y), a
;	.\main.c: 37: led_buffer[bit * 3 + 1] = 0x00; // R
	clr	a
	ld	xh, a
	clr	((_led_buffer+0), x)
;	.\main.c: 38: led_buffer[bit * 3 + 2] = 0x00; // B
	clrw	x
	ld	a, (0x06, sp)
	ld	xl, a
	clr	((_led_buffer+0), x)
	jra	00115$
00102$:
;	.\main.c: 40: led_buffer[bit * 3]     = 0x00; // G (OFF)
	ldw	y, (0x04, sp)
	clr	((_led_buffer+0), y)
;	.\main.c: 41: led_buffer[bit * 3 + 1] = 0x00; // R
	clr	a
	ld	xh, a
	clr	((_led_buffer+0), x)
;	.\main.c: 42: led_buffer[bit * 3 + 2] = 0x00; // B
	clrw	x
	ld	a, (0x06, sp)
	ld	xl, a
	clr	((_led_buffer+0), x)
00115$:
;	.\main.c: 33: for(uint8_t bit = 0; bit < NUM_LEDS; bit++) {
	inc	(0x09, sp)
	jra	00114$
00104$:
;	.\../STM8S103F3_L0_Drivers/gpio.h: 190: port->ODR ^= (1U << pin);
	bcpl	0x5005, #5
;	.\main.c: 48: ws2812_send_frame(led_buffer, BUF_SIZE);
	ld	a, #0x30
	ldw	x, #(_led_buffer+0)
	call	_ws2812_send_frame
;	.\main.c: 51: binary_counter++;
	ldw	x, (0x07, sp)
	incw	x
	ldw	(0x07, sp), x
;	.\main.c: 54: time_delay_lsi_ms(10);
	ldw	x, #0x000a
	call	_time_delay_lsi_ms
;	.\main.c: 56: }
	jra	00120$
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
