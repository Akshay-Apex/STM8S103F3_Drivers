;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module ws2812_spi
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _clk_context_restore
	.globl _clk_context_get_and_switch
	.globl _WS2812_BRIGHTNESS
	.globl _ws2812_spi_init
	.globl _ws2812_send_frame
	.globl _ws2812_frame_pixel_write
	.globl _ws2812_frame_bcd_digit_write
	.globl _ws2812_frame_bcd_number_write
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_WS2812_BRIGHTNESS::
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
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 28: void ws2812_spi_init(void) {
;	-----------------------------------------
;	 function ws2812_spi_init
;	-----------------------------------------
_ws2812_spi_init:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/clk.h: 271: CLK->PCKENR1 |= (1U << periph);
	bset	0x50c7, #1
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/gpio.h: 112: port->DDR |= (pin_mask);
	bset	0x500c, #6
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/gpio.h: 113: port->CR1 |= (pin_mask);
	bset	0x500d, #6
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/gpio.h: 114: port->CR2 |= (pin_mask);
	bset	0x500e, #6
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/gpio.h: 173: port->ODR &= ~(1U << pin);
	bres	0x500a, #6
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 31: gpio_output_clear(GPIO_C, 6);
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 32: }
	ret
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 37: void ws2812_send_frame(uint8_t *frame, uint8_t frame_len) {
;	-----------------------------------------
;	 function ws2812_send_frame
;	-----------------------------------------
_ws2812_send_frame:
	sub	sp, #16
	ldw	(0x0d, sp), x
	ld	(0x0c, sp), a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 38: global_interrupt_disable();  
	sim
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 39: CLK_CONTEXT context = clk_context_get_and_switch(CLK_MASTER_SRC_HSI, CLK_HSI_DIV_1, CLK_CPU_DIV_1);
	push	#0x00
	push	#0x00
	ld	a, #0xe1
	ldw	x, sp
	addw	x, #6
	pushw	x
	call	_clk_context_get_and_switch
	addw	sp, #4
	ldw	x, sp
	addw	x, #4
	push	#0x03
	push	#0x00
	pushw	x
	ldw	x, sp
	addw	x, #5
	call	___memcpy
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/spi.h: 63: SPI->CR1 = (SPI->CR1 & ~(1U << 2)) | (mode << 2);
	ld	a, 0x5200
	and	a, #0xfb
	or	a, #0x04
	ld	0x5200, a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/spi.h: 85: SPI->CR1 = (SPI->CR1 & ~(SPI_BAUD_RATE_PSC_MASK)) | ((uint8_t)prescaler << 3);
	ld	a, 0x5200
	and	a, #0xc7
	ld	0x5200, a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/spi.h: 94: SPI->CR1 |= (1U << 6);
	bset	0x5200, #6
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 45: uint16_t accumulator = 0x0000;  
	clrw	x
	clr	(0x0a, sp)
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 46: for(uint8_t i = 0; i < frame_len; i++) {
	clr	(0x0f, sp)
00129$:
	ld	a, (0x0f, sp)
	cp	a, (0x0c, sp)
	jrnc	00109$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 47: uint8_t frame_byte = frame[i];      
	clrw	y
	ld	a, (0x0f, sp)
	ld	yl, a
	addw	y, (0x0d, sp)
	ld	a, (y)
	ld	(0x07, sp), a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 49: for(uint8_t mask = 0x80; mask > 0; mask >>= 1) {
	ld	a, #0x80
	ld	(0x10, sp), a
00126$:
	tnz	(0x10, sp)
	jreq	00130$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 51: accumulator = (uint16_t)(accumulator << 8) | BIT_1;        
	clr	a
	rlwa	x
	ldw	(0x08, sp), x
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 50: if(frame_byte & mask) {        
	ld	a, (0x07, sp)
	and	a, (0x10, sp)
	jreq	00102$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 51: accumulator = (uint16_t)(accumulator << 8) | BIT_1;        
	clr	a
	ld	xl, a
	ld	a, (0x08, sp)
	or	a, #0x3f
	ld	(0x0a, sp), a
	jra	00104$
00102$:
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 53: accumulator = (uint16_t)(accumulator << 8) | BIT_0;
	clr	(0x0b, sp)
	ld	a, (0x08, sp)
	or	a, #0x38
	ld	(0x0a, sp), a
	clr	a
	ld	xl, a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 56: while(!spi_tx_buffer_status_read());
00104$:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/spi.h: 262: return (SPI_TX_BUFFER_STATUS)((SPI->SR >> 1) & 1);
	ld	a, 0x5203
	srl	a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 56: while(!spi_tx_buffer_status_read());
	and	a, #0x01
	jreq	00104$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 57: spi_tx_data_write((uint8_t)(accumulator >> 8));
	ld	a, (0x0a, sp)
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/spi.h: 294: SPI->DR = data;
	ld	0x5204, a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 49: for(uint8_t mask = 0x80; mask > 0; mask >>= 1) {
	srl	(0x10, sp)
	jra	00126$
00130$:
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 46: for(uint8_t i = 0; i < frame_len; i++) {
	inc	(0x0f, sp)
	jra	00129$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 61: while(spi_busy_status_read());  
00109$:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/spi.h: 287: return (uint8_t)((SPI->SR >> 7) & 1);
	ld	a, 0x5203
	jrmi	00109$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 61: while(spi_busy_status_read());  
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L0_Drivers/spi.h: 98: SPI->CR1 &= ~(1U << 6);
	ld	a, 0x5200
	and	a, #0xbf
	ld	0x5200, a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	ldw	x, #0x012c
00119$:
	tnzw	x
	jreq	00124$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	y, x
	decw	y
	jreq	00121$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00121$:
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 41: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 42: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 43: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 44: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 45: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 46: us--;
	decw	x
	jra	00119$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 63: time_delay_us_16mhz(300U);
00124$:
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 65: clk_context_restore(&context);
	ldw	x, sp
	incw	x
	call	_clk_context_restore
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 66: global_interrupt_enable();
	rim
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 67: }
	addw	sp, #16
	ret
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 73: void ws2812_frame_pixel_write(uint8_t *frame, uint8_t pixel_index, uint8_t r, uint8_t g, uint8_t b) {
;	-----------------------------------------
;	 function ws2812_frame_pixel_write
;	-----------------------------------------
_ws2812_frame_pixel_write:
	pushw	x
	ld	yl, a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 74: pixel_index *= 3;
	ld	a, #0x03
	mul	y, a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 76: frame[pixel_index + 0] = g;
	clr	a
	ld	yh, a
	ldw	x, y
	addw	x, (0x01, sp)
	ld	a, (0x06, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 77: frame[pixel_index + 1] = r;
	ldw	x, y
	incw	x
	addw	x, (0x01, sp)
	ld	a, (0x05, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 78: frame[pixel_index + 2] = b;
	ldw	x, y
	incw	x
	incw	x
	addw	x, (0x01, sp)
	ld	a, (0x07, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 79: }
	ldw	x, (3, sp)
	addw	sp, #7
	jp	(x)
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 83: void ws2812_frame_bcd_digit_write(uint8_t *frame, uint8_t start_index, uint8_t lower_nibble_flag, uint8_t digit,  uint8_t r, uint8_t g, uint8_t b) {
;	-----------------------------------------
;	 function ws2812_frame_bcd_digit_write
;	-----------------------------------------
_ws2812_frame_bcd_digit_write:
	sub	sp, #2
	ld	(0x01, sp), a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 85: while(count--) {
	ld	a, #0x04
	ld	(0x02, sp), a
00107$:
	ld	a, (0x02, sp)
	dec	(0x02, sp)
	tnz	a
	jreq	00110$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 86: if(digit & 1) {
	ld	a, (0x06, sp)
	srl	a
	jrnc	00105$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 87: ws2812_frame_pixel_write(frame, start_index, r, g, b);
	pushw	x
	ld	a, (0x0b, sp)
	push	a
	ld	a, (0x0b, sp)
	push	a
	ld	a, (0x0b, sp)
	push	a
	ld	a, (0x06, sp)
	call	_ws2812_frame_pixel_write
	popw	x
	jra	00106$
00105$:
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 89: if(lower_nibble_flag) {
	tnz	(0x05, sp)
	jreq	00102$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 90: ws2812_frame_pixel_write(frame, start_index, 1, 1, 1);        
	pushw	x
	push	#0x01
	push	#0x01
	push	#0x01
	ld	a, (0x06, sp)
	call	_ws2812_frame_pixel_write
	popw	x
	jra	00106$
00102$:
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 92: ws2812_frame_pixel_write(frame, start_index, 1, 0, 1);        
	pushw	x
	push	#0x01
	push	#0x00
	push	#0x01
	ld	a, (0x06, sp)
	call	_ws2812_frame_pixel_write
	popw	x
00106$:
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 96: start_index++;
	inc	(0x01, sp)
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 97: digit >>= 1;
	srl	(0x06, sp)
	jra	00107$
00110$:
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 99: }
	ldw	x, (3, sp)
	addw	sp, #9
	jp	(x)
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 103: void ws2812_frame_bcd_number_write(uint8_t *frame, uint8_t size, uint16_t number) {
;	-----------------------------------------
;	 function ws2812_frame_bcd_number_write
;	-----------------------------------------
_ws2812_frame_bcd_number_write:
	sub	sp, #5
	ldw	(0x04, sp), x
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 104: uint8_t index = 0;
	clr	(0x03, sp)
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 105: uint8_t pixel_length = size / 3;
	clrw	x
	ld	xl, a
	ld	a, #0x03
	div	x, a
	ld	a, xl
	ld	(0x01, sp), a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 106: while(index < pixel_length) {
00101$:
	ld	a, (0x03, sp)
	cp	a, (0x01, sp)
	jrnc	00104$
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 107: uint8_t digit_1 = number % 10;
	ldw	x, (0x08, sp)
	pushw	x
	ldw	y, #0x000a
	divw	x, y
	ld	a, yl
	popw	x
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 108: number = number / 10;
	ldw	y, #0x000a
	divw	x, y
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 109: uint8_t digit_2 = number % 10;
	ldw	(0x08, sp), x
	pushw	x
	ldw	y, #0x000a
	divw	x, y
	popw	x
	exg	a, yl
	ld	(0x02, sp), a
	exg	a, yl
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 110: number = number / 10;
	ldw	y, #0x000a
	divw	x, y
	ldw	(0x08, sp), x
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 112: ws2812_frame_bcd_digit_write(frame, index, 1, digit_1, 0, WS2812_BRIGHTNESS, 0);
	push	#0x00
	push	_WS2812_BRIGHTNESS+0
	push	#0x00
	push	a
	push	#0x01
	ld	a, (0x08, sp)
	ldw	x, (0x09, sp)
	call	_ws2812_frame_bcd_digit_write
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 113: index += 4;
	ld	a, (0x03, sp)
	add	a, #0x04
	ld	(0x03, sp), a
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 114: ws2812_frame_bcd_digit_write(frame, index, 0, digit_2, 0, 0, WS2812_BRIGHTNESS);
	push	_WS2812_BRIGHTNESS+0
	push	#0x00
	push	#0x00
	ld	a, (0x05, sp)
	push	a
	push	#0x00
	ld	a, (0x08, sp)
	ldw	x, (0x09, sp)
	call	_ws2812_frame_bcd_digit_write
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 115: index += 4;
	ld	a, (0x03, sp)
	add	a, #0x04
	ld	(0x03, sp), a
	jra	00101$
00104$:
;	..\STM8S103F3_L1_Drivers\ws2812_spi.c: 117: }
	ldw	x, (6, sp)
	addw	sp, #9
	jp	(x)
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__WS2812_BRIGHTNESS:
	.db #0xff	; 255
	.area CABS (ABS)
