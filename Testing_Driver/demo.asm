;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module demo
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _ws2812_frame_bcd_number_write
	.globl _ws2812_frame_pixel_write
	.globl _ws2812_send_frame
	.globl _ws2812_spi_init
	.globl _time_init
	.globl _ds18b20_temp_from_scratchpad_get
	.globl _ds18b20_scratchpad_read
	.globl _ds18b20_begin_temp_convertion
	.globl _ds18b20_crc8_is_valid
	.globl _ds18b20_temp_to_sign_encoded_abs_centi_celsius
	.globl _ds18b20_init
	.globl _clk_fmaster_switch_src_auto_mode
	.globl _scratchpad
	.globl _frame
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_frame::
	.ds 48
_scratchpad::
	.ds 9
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
;	.\demo.c: 15: int main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #12
;	.\../STM8S103F3_L0_Drivers/clk.h: 233: CLK->CKDIVR = ((CLK->CKDIVR & CLK_CKDIVR_CPU_CLR_MASK) | ((uint8_t)value) << 0);
	ld	a, 0x50c6
	and	a, #0xf8
	ld	0x50c6, a
;	.\demo.c: 19: clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_LSI);
	ld	a, #0xd2
	call	_clk_fmaster_switch_src_auto_mode
;	.\../STM8S103F3_L0_Drivers/gpio.h: 98: port->DDR |= (pin_mask);
	bset	0x5007, #5
;	.\../STM8S103F3_L0_Drivers/gpio.h: 99: port->CR1 |= (pin_mask);
	bset	0x5008, #5
;	.\../STM8S103F3_L0_Drivers/gpio.h: 100: port->CR2 &= ~(pin_mask);
	bres	0x5009, #5
;	.\demo.c: 23: ws2812_spi_init();
	call	_ws2812_spi_init
;	.\demo.c: 24: WS2812_BRIGHTNESS = 40;
	mov	_WS2812_BRIGHTNESS+0, #0x28
;	.\demo.c: 26: DS18B20_SENSOR temp_sensor = ds18b20_init(DS18B20_GPIO_PIN);
	ld	a, #0x04
	ldw	x, #0x500f
	ldw	y, sp
	addw	y, #7
	pushw	y
	call	_ds18b20_init
	addw	sp, #2
	ldw	x, sp
	addw	x, #7
	push	#0x04
	push	#0x00
	pushw	x
	ldw	x, sp
	addw	x, #7
	call	___memcpy
;	.\demo.c: 28: time_init();
	call	_time_init
;	.\demo.c: 33: while(1) {
00113$:
;	.\../STM8S103F3_L0_Drivers/gpio.h: 191: port->ODR ^= (1U << pin);
	bcpl	0x5005, #5
;	.\demo.c: 36: CODE = ds18b20_begin_temp_convertion(&temp_sensor, false);
	clr	a
	ldw	x, sp
	addw	x, #3
	call	_ds18b20_begin_temp_convertion
;	.\demo.c: 37: if(CODE == DS18B20_ERROR_CODE) {
	ldw	(0x0b, sp), x
	cpw	x, #0xeeee
	jrne	00110$
;	.\demo.c: 38: for(uint8_t i = 0; i < sizeof(frame) / 3; i++) {
	clr	(0x0c, sp)
00119$:
	ld	a, (0x0c, sp)
	cp	a, #0x10
	jrnc	00111$
;	.\demo.c: 39: ws2812_frame_pixel_write(frame, i, 255, 0, 0);
	push	#0x00
	push	#0x00
	push	#0xff
	ld	a, (0x0f, sp)
	ldw	x, #(_frame+0)
	call	_ws2812_frame_pixel_write
;	.\demo.c: 38: for(uint8_t i = 0; i < sizeof(frame) / 3; i++) {
	inc	(0x0c, sp)
	jra	00119$
00110$:
;	.\demo.c: 41: } else if(CODE == DS18B20_DONE_PROCESSING) {
	ldw	x, (0x0b, sp)
	cpw	x, #0xeef0
	jrne	00111$
;	.\demo.c: 42: CODE = ds18b20_scratchpad_read(scratchpad, &temp_sensor);
	ldw	x, sp
	addw	x, #3
	pushw	x
	ldw	x, #(_scratchpad+0)
	call	_ds18b20_scratchpad_read
;	.\demo.c: 44: if(CODE == DS18B20_ERROR_CODE || !ds18b20_crc8_is_valid(scratchpad, sizeof(scratchpad))) {
	cpw	x, #0xeeee
	jreq	00132$
	ld	a, #0x09
	ldw	x, #(_scratchpad+0)
	call	_ds18b20_crc8_is_valid
	tnz	a
	jrne	00104$
;	.\demo.c: 45: for(uint8_t i = 0; i < sizeof(frame) / 3; i++) {
00132$:
	clr	(0x0c, sp)
00122$:
	ld	a, (0x0c, sp)
	cp	a, #0x10
	jrnc	00111$
;	.\demo.c: 46: ws2812_frame_pixel_write(frame, i, 255, 0, 0);
	push	#0x00
	push	#0x00
	push	#0xff
	ld	a, (0x0f, sp)
	ldw	x, #(_frame+0)
	call	_ws2812_frame_pixel_write
;	.\demo.c: 45: for(uint8_t i = 0; i < sizeof(frame) / 3; i++) {
	inc	(0x0c, sp)
	jra	00122$
00104$:
;	.\demo.c: 49: temp = ds18b20_temp_from_scratchpad_get(scratchpad);
	ldw	x, #(_scratchpad+0)
	call	_ds18b20_temp_from_scratchpad_get
;	.\demo.c: 50: temp = ds18b20_temp_to_sign_encoded_abs_centi_celsius(temp) - 19;
	call	_ds18b20_temp_to_sign_encoded_abs_centi_celsius
	ldw	(0x0b, sp), x
	ldw	(0x01, sp), x
	subw	x, #0x0013
;	.\demo.c: 51: ws2812_frame_bcd_number_write(frame, sizeof(frame), temp);
	ldw	(0x0b, sp), x
	pushw	x
	ld	a, #0x30
	ldw	x, #(_frame+0)
	call	_ws2812_frame_bcd_number_write
00111$:
;	.\demo.c: 55: ws2812_send_frame(frame, sizeof(frame));
	ld	a, #0x30
	ldw	x, #(_frame+0)
	call	_ws2812_send_frame
;	.\demo.c: 57: }
	jp	00113$
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
