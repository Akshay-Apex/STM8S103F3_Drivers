;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module one_wire
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _one_wire_init
	.globl _one_wire_reset_and_detect_slave
	.globl _one_wire_bit_write
	.globl _one_wire_byte_write
	.globl _one_wire_bit_read
	.globl _one_wire_byte_read
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
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
;	..\STM8S103F3_L1_Drivers\one_wire.c: 12: void one_wire_init(ONE_WIRE_BUS *ow_bus) {        
;	-----------------------------------------
;	 function one_wire_init
;	-----------------------------------------
_one_wire_init:
	sub	sp, #5
;	..\STM8S103F3_L1_Drivers\one_wire.c: 13: gpio_output_mode_open_drain_init(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	y, x
	incw	x
	incw	x
	ldw	(0x01, sp), x
	ld	a, (x)
	ld	xl, a
	ldw	(0x03, sp), y
	ldw	y, (y)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 90: uint8_t pin_mask = (1U << pin);
	ld	a, #0x01
	ld	(0x05, sp), a
	ld	a, xl
	tnz	a
	jreq	00106$
00105$:
	sll	(0x05, sp)
	dec	a
	jrne	00105$
00106$:
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 91: port->DDR |= (pin_mask);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	or	a, (0x05, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 92: port->CR1 &= ~(pin_mask);
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	push	a
	cpl	(0x06, sp)
	pop	a
	and	a, (0x05, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 93: port->CR2 &= ~(pin_mask);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	and	a, (0x05, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\one_wire.c: 14: gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	x, (0x01, sp)
	ld	a, (x)
	ld	(0x05, sp), a
	ldw	x, (0x03, sp)
	ldw	x, (x)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 169: port->ODR |= (1U << pin);
	ld	a, (x)
	push	a
	ld	a, (0x06, sp)
	push	a
	ld	a, #0x01
	ld	(0x07, sp), a
	pop	a
	tnz	a
	jreq	00108$
00107$:
	sll	(0x06, sp)
	dec	a
	jrne	00107$
00108$:
	pop	a
	or	a, (0x05, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\one_wire.c: 14: gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);
;	..\STM8S103F3_L1_Drivers\one_wire.c: 15: }
	addw	sp, #5
	ret
;	..\STM8S103F3_L1_Drivers\one_wire.c: 20: uint8_t one_wire_reset_and_detect_slave(ONE_WIRE_BUS *ow_bus) {
;	-----------------------------------------
;	 function one_wire_reset_and_detect_slave
;	-----------------------------------------
_one_wire_reset_and_detect_slave:
	sub	sp, #7
;	..\STM8S103F3_L1_Drivers\one_wire.c: 21: gpio_output_clear(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	y, x
	incw	x
	incw	x
	ldw	(0x04, sp), x
	ld	a, (x)
	ld	(0x02, sp), a
	ldw	(0x06, sp), y
	ldw	x, y
	ldw	x, (x)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 173: port->ODR &= ~(1U << pin);
	ld	a, (x)
	ld	(0x03, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x03, sp)
	jreq	00236$
00235$:
	sll	(1, sp)
	dec	a
	jrne	00235$
00236$:
	pop	a
	cpl	a
	and	a, (0x03, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	ldw	x, #0x01e0
00110$:
	tnzw	x
	jreq	00115$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	y, x
	decw	y
	jreq	00112$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00112$:
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
	jra	00110$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 22: time_delay_us_16mhz(480U);
00115$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 24: gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);  
	ldw	x, (0x04, sp)
	ld	a, (x)
	ld	(0x03, sp), a
	ldw	x, (0x06, sp)
	ldw	x, (x)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 169: port->ODR |= (1U << pin);
	ld	a, (x)
	push	a
	ld	a, (0x04, sp)
	push	a
	ld	a, #0x01
	ld	(0x05, sp), a
	pop	a
	tnz	a
	jreq	00242$
00241$:
	sll	(0x04, sp)
	dec	a
	jrne	00241$
00242$:
	pop	a
	or	a, (0x03, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	ldw	x, #0x003c
00117$:
	tnzw	x
	jreq	00122$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	y, x
	decw	y
	jreq	00119$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00119$:
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
	jra	00117$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 25: time_delay_us_16mhz(60U);
00122$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 28: uint8_t device_present = 0;
	clr	(0x02, sp)
;	..\STM8S103F3_L1_Drivers\one_wire.c: 29: gpio_input_mode_pull_up_no_irq_init(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	x, (0x04, sp)
	ld	a, (x)
	ld	xl, a
	ldw	y, (0x06, sp)
	ldw	y, (y)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 67: uint8_t pin_mask = (1U << pin);
	ld	a, #0x01
	ld	(0x01, sp), a
	ld	a, xl
	tnz	a
	jreq	00248$
00247$:
	sll	(0x01, sp)
	dec	a
	jrne	00247$
00248$:
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 68: port->DDR &= ~(pin_mask);
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	push	a
	ld	a, (0x02, sp)
	cpl	a
	ld	(0x04, sp), a
	pop	a
	and	a, (0x03, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 69: port->CR1 |= (pin_mask);
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	or	a, (0x01, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 70: port->CR2 &= ~(pin_mask);
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	and	a, (0x03, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\one_wire.c: 30: if(!gpio_input_read(ow_bus->gpio_port, ow_bus->gpio_pin)) {    
	ldw	x, (0x04, sp)
	ld	a, (x)
	ld	(0x03, sp), a
	ldw	x, (0x06, sp)
	ldw	x, (x)
	ldw	(0x04, sp), x
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 180: return ((port->IDR >> pin) & 1);   
	push	a
	ld	a, (0x1, x)
	ld	xl, a
	pop	a
	tnz	a
	jreq	00250$
00249$:
	exg	a, xl
	srl	a
	exg	a, xl
	dec	a
	jrne	00249$
00250$:
	srlw	x
	jrc	00108$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 30: if(!gpio_input_read(ow_bus->gpio_port, ow_bus->gpio_pin)) {    
;	..\STM8S103F3_L1_Drivers\one_wire.c: 31: while(!gpio_input_read(ow_bus->gpio_port, ow_bus->gpio_pin) && timeout--) {
	ldw	x, #0x00fa
	ldw	(0x06, sp), x
00102$:
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 180: return ((port->IDR >> pin) & 1);   
	ldw	x, (0x04, sp)
	ld	a, (0x1, x)
	push	a
	ld	a, (0x04, sp)
	jreq	00253$
00252$:
	srl	(1, sp)
	dec	a
	jrne	00252$
00253$:
	pop	a
	srl	a
	jrc	00104$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 31: while(!gpio_input_read(ow_bus->gpio_port, ow_bus->gpio_pin) && timeout--) {
	ldw	x, (0x06, sp)
	ldw	y, (0x06, sp)
	decw	y
	ldw	(0x06, sp), y
	tnzw	x
	jreq	00104$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	clrw	x
	incw	x
00126$:
	tnzw	x
	jreq	00102$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	y, x
	decw	y
	jreq	00128$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00128$:
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
	jra	00126$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 32: time_delay_us_16mhz(1);
00104$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 35: if(timeout != 0) {
	ldw	x, (0x06, sp)
	jreq	00108$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 36: device_present = 1; 
	ld	a, #0x01
	ld	(0x02, sp), a
00108$:
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 90: uint8_t pin_mask = (1U << pin);
	ld	a, #0x01
	ld	(0x07, sp), a
	ld	a, (0x03, sp)
	jreq	00262$
00261$:
	sll	(0x07, sp)
	dec	a
	jrne	00261$
00262$:
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 91: port->DDR |= (pin_mask);
	ldw	x, (0x04, sp)
	incw	x
	incw	x
	ld	a, (x)
	or	a, (0x07, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 92: port->CR1 &= ~(pin_mask);
	ldw	x, (0x04, sp)
	addw	x, #0x0003
	ld	a, (x)
	push	a
	cpl	(0x08, sp)
	pop	a
	and	a, (0x07, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 93: port->CR2 &= ~(pin_mask);
	ldw	x, (0x04, sp)
	addw	x, #0x0004
	ld	a, (x)
	and	a, (0x07, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\one_wire.c: 41: return device_present;
	ld	a, (0x02, sp)
;	..\STM8S103F3_L1_Drivers\one_wire.c: 42: }
	addw	sp, #7
	ret
;	..\STM8S103F3_L1_Drivers\one_wire.c: 46: void one_wire_bit_write(ONE_WIRE_BUS *ow_bus, uint8_t bit) {
;	-----------------------------------------
;	 function one_wire_bit_write
;	-----------------------------------------
_one_wire_bit_write:
	sub	sp, #9
	exgw	x, y
	ld	(0x09, sp), a
;	..\STM8S103F3_L1_Drivers\one_wire.c: 48: gpio_output_clear(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	x, y
	incw	x
	incw	x
	ldw	(0x07, sp), x
	ld	a, (x)
	ld	(0x01, sp), a
	ldw	(0x02, sp), y
	ldw	x, y
	ldw	x, (x)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 173: port->ODR &= ~(1U << pin);
	ldw	(0x04, sp), x
	ld	a, (x)
	ld	(0x06, sp), a
;	..\STM8S103F3_L1_Drivers\one_wire.c: 47: if(bit) {
	tnz	(0x09, sp)
	jreq	00102$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 48: gpio_output_clear(ow_bus->gpio_port, ow_bus->gpio_pin);
	ld	a, (0x01, sp)
	ld	xl, a
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 173: port->ODR &= ~(1U << pin);
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00231$
00230$:
	sll	(1, sp)
	dec	a
	jrne	00230$
00231$:
	pop	a
	cpl	a
	and	a, (0x06, sp)
	ldw	x, (0x04, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	clrw	x
	incw	x
	ldw	(0x05, sp), x
00105$:
	ldw	x, (0x05, sp)
	jreq	00110$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	x, (0x05, sp)
	decw	x
	jreq	00107$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00107$:
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
	ldw	x, (0x05, sp)
	decw	x
	ldw	(0x05, sp), x
	jra	00105$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 49: time_delay_us_16mhz(1);
00110$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 50: gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	x, (0x07, sp)
	ld	a, (x)
	ld	(0x06, sp), a
	ldw	x, (0x02, sp)
	ldw	x, (x)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 169: port->ODR |= (1U << pin);
	ld	a, (x)
	push	a
	ld	a, #0x01
	ld	(0x09, sp), a
	ld	a, (0x07, sp)
	jreq	00237$
00236$:
	sll	(0x09, sp)
	dec	a
	jrne	00236$
00237$:
	pop	a
	or	a, (0x08, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	ldw	x, #0x003c
00112$:
	tnzw	x
	jreq	00132$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	y, x
	decw	y
	jreq	00114$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00114$:
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
	jra	00112$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 51: time_delay_us_16mhz(60U);
00102$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 53: gpio_output_clear(ow_bus->gpio_port, ow_bus->gpio_pin);
	ld	a, (0x01, sp)
	ld	xl, a
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 173: port->ODR &= ~(1U << pin);
	ld	a, #0x01
	push	a
	ld	a, xl
	tnz	a
	jreq	00243$
00242$:
	sll	(1, sp)
	dec	a
	jrne	00242$
00243$:
	pop	a
	cpl	a
	and	a, (0x06, sp)
	ldw	x, (0x04, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	ldw	x, #0x003c
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
;	..\STM8S103F3_L1_Drivers\one_wire.c: 54: time_delay_us_16mhz(60U);
00124$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 55: gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	x, (0x07, sp)
	ld	a, (x)
	ld	(0x06, sp), a
	ldw	x, (0x02, sp)
	ldw	x, (x)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 169: port->ODR |= (1U << pin);
	ld	a, (x)
	ld	(0x08, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x07, sp)
	jreq	00249$
00248$:
	sll	(1, sp)
	dec	a
	jrne	00248$
00249$:
	pop	a
	or	a, (0x08, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	clrw	x
	incw	x
00126$:
	tnzw	x
	jreq	00132$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	(0x07, sp), x
	pushw	x
	ldw	x, (0x09, sp)
	decw	x
	popw	x
	jreq	00128$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00128$:
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
	jra	00126$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 56: time_delay_us_16mhz(1);
00132$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 58: }
	addw	sp, #9
	ret
;	..\STM8S103F3_L1_Drivers\one_wire.c: 62: void one_wire_byte_write(ONE_WIRE_BUS *ow_bus, uint8_t data) {
;	-----------------------------------------
;	 function one_wire_byte_write
;	-----------------------------------------
_one_wire_byte_write:
	sub	sp, #2
	ld	(0x01, sp), a
;	..\STM8S103F3_L1_Drivers\one_wire.c: 64: while(counter--) {    
	ld	a, #0x08
	ld	(0x02, sp), a
00101$:
	ld	a, (0x02, sp)
	dec	(0x02, sp)
	tnz	a
	jreq	00104$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 65: one_wire_bit_write(ow_bus, data & 1);
	ld	a, (0x01, sp)
	and	a, #0x01
	pushw	x
	call	_one_wire_bit_write
	popw	x
;	..\STM8S103F3_L1_Drivers\one_wire.c: 66: data >>= 1;
	srl	(0x01, sp)
	jra	00101$
00104$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 68: }
	addw	sp, #2
	ret
;	..\STM8S103F3_L1_Drivers\one_wire.c: 72: uint8_t one_wire_bit_read(ONE_WIRE_BUS *ow_bus) {
;	-----------------------------------------
;	 function one_wire_bit_read
;	-----------------------------------------
_one_wire_bit_read:
	sub	sp, #6
;	..\STM8S103F3_L1_Drivers\one_wire.c: 74: gpio_output_clear(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	y, x
	incw	x
	incw	x
	ldw	(0x02, sp), x
	ld	a, (x)
	ld	(0x01, sp), a
	ldw	(0x04, sp), y
	ldw	x, y
	ldw	x, (x)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 173: port->ODR &= ~(1U << pin);
	ld	a, (x)
	ld	(0x06, sp), a
	ld	a, #0x01
	push	a
	ld	a, (0x02, sp)
	jreq	00191$
00190$:
	sll	(1, sp)
	dec	a
	jrne	00190$
00191$:
	pop	a
	cpl	a
	and	a, (0x06, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	clrw	x
	incw	x
00102$:
	tnzw	x
	jreq	00107$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	y, x
	decw	y
	jreq	00104$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00104$:
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
	jra	00102$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 75: time_delay_us_16mhz(1);
00107$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 76: gpio_output_set(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	x, (0x02, sp)
	ld	a, (x)
	ld	(0x06, sp), a
	ldw	x, (0x04, sp)
	ldw	x, (x)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 169: port->ODR |= (1U << pin);
	ld	a, (x)
	push	a
	ld	a, (0x07, sp)
	push	a
	ld	a, #0x01
	ld	(0x08, sp), a
	pop	a
	tnz	a
	jreq	00197$
00196$:
	sll	(0x07, sp)
	dec	a
	jrne	00196$
00197$:
	pop	a
	or	a, (0x06, sp)
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	ldw	x, #0x000f
00109$:
	tnzw	x
	jreq	00114$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	y, x
	decw	y
	jreq	00111$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00111$:
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
	jra	00109$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 77: time_delay_us_16mhz(15U);    
00114$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 78: data = gpio_input_read(ow_bus->gpio_port, ow_bus->gpio_pin);
	ldw	x, (0x02, sp)
	ld	a, (x)
	ld	(0x06, sp), a
	ldw	x, (0x04, sp)
	ldw	x, (x)
;	..\STM8S103F3_L1_Drivers\./../STM8S103F3_L0_Drivers/gpio.h: 180: return ((port->IDR >> pin) & 1);   
	ld	a, (0x1, x)
	push	a
	ld	a, (0x07, sp)
	jreq	00203$
00202$:
	srl	(1, sp)
	dec	a
	jrne	00202$
00203$:
	pop	a
	and	a, #0x01
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 35: while(us) {
	ldw	x, #0x002d
00116$:
	tnzw	x
	jreq	00121$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 36: if(us != 1) {      
	ldw	y, x
	decw	y
	jreq	00118$
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 37: __asm__("nop");
	nop
;	..\STM8S103F3_L1_Drivers\../STM8S103F3_L1_Drivers/time.h: 38: __asm__("nop");
	nop
00118$:
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
	jra	00116$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 79: time_delay_us_16mhz(45U);
00121$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 81: return data;
;	..\STM8S103F3_L1_Drivers\one_wire.c: 82: }
	addw	sp, #6
	ret
;	..\STM8S103F3_L1_Drivers\one_wire.c: 86: uint8_t one_wire_byte_read(ONE_WIRE_BUS *ow_bus) {
;	-----------------------------------------
;	 function one_wire_byte_read
;	-----------------------------------------
_one_wire_byte_read:
	sub	sp, #2
;	..\STM8S103F3_L1_Drivers\one_wire.c: 87: uint8_t data = 0;  
	clr	(0x01, sp)
;	..\STM8S103F3_L1_Drivers\one_wire.c: 88: for(uint8_t i = 0; i < 8; i++) {       
	clr	(0x02, sp)
00103$:
	ld	a, (0x02, sp)
	cp	a, #0x08
	jrnc	00101$
;	..\STM8S103F3_L1_Drivers\one_wire.c: 89: data |= one_wire_bit_read(ow_bus) << i;    
	pushw	x
	call	_one_wire_bit_read
	popw	x
	push	a
	ld	a, (0x03, sp)
	jreq	00124$
00123$:
	sll	(1, sp)
	dec	a
	jrne	00123$
00124$:
	pop	a
	or	a, (0x01, sp)
	ld	(0x01, sp), a
;	..\STM8S103F3_L1_Drivers\one_wire.c: 88: for(uint8_t i = 0; i < 8; i++) {       
	inc	(0x02, sp)
	jra	00103$
00101$:
;	..\STM8S103F3_L1_Drivers\one_wire.c: 91: return data;
	ld	a, (0x01, sp)
;	..\STM8S103F3_L1_Drivers\one_wire.c: 92: }
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
