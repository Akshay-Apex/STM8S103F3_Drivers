;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module ds18b20
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _one_wire_byte_read
	.globl _one_wire_bit_read
	.globl _one_wire_byte_write
	.globl _one_wire_reset_and_detect_slave
	.globl _one_wire_init
	.globl _time_delay_ms
	.globl _clk_context_restore
	.globl _clk_context_get_and_switch
	.globl _ds18b20_init
	.globl _ds18b20_temperature_blocking_read
	.globl _ds18b20_temperature_non_blocking_read
	.globl _ds18b20_temp_to_sign_encoded_abs_centi_celsius
	.globl _ds18b20_crc8_is_valid
	.globl _ds18b20_begin_temp_convertion
	.globl _ds18b20_scratchpad_read
	.globl _ds18b20_temp_from_scratchpad_get
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
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 19: DS18B20_SENSOR ds18b20_init(GPIO_PORT_REG *port, uint8_t pin) {  
;	-----------------------------------------
;	 function ds18b20_init
;	-----------------------------------------
_ds18b20_init:
	sub	sp, #4
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 22: sensor.ow_bus.gpio_port = port;
	ldw	(0x01, sp), x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 23: sensor.ow_bus.gpio_pin = pin;  
	ld	(0x03, sp), a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 24: one_wire_init(&(sensor.ow_bus));  
	ldw	x, sp
	incw	x
	call	_one_wire_init
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 25: sensor.temp_conv_process_initiated = 0;
	clr	(0x04, sp)
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 26: return sensor;
	ldw	x, (0x07, sp)
	ldw	y, (0x03, sp)
	ldw	(#2, x), y
	ldw	y, (0x01, sp)
	ldw	(x), y
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 27: }
	addw	sp, #4
	ret
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 32: uint16_t ds18b20_temperature_blocking_read(DS18B20_SENSOR *sensor) {
;	-----------------------------------------
;	 function ds18b20_temperature_blocking_read
;	-----------------------------------------
_ds18b20_temperature_blocking_read:
	sub	sp, #13
	ldw	(0x0c, sp), x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 33: global_interrupt_disable();  
	sim
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 34: CLK_CONTEXT context = clk_context_get_and_switch(CLK_MASTER_SRC_HSI, CLK_HSI_DIV_1, CLK_CPU_DIV_1);  
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
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 36: ONE_WIRE_BUS *ow_bus = &(sensor->ow_bus);
	ldw	y, (0x0c, sp)
	ldw	(0x07, sp), y
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 37: uint16_t temp = DS18B20_ERROR_CODE;
	ldw	x, #0xeeee
	ldw	(0x09, sp), x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 39: if(one_wire_reset_and_detect_slave(ow_bus)) {
	ldw	x, (0x07, sp)
	call	_one_wire_reset_and_detect_slave
	ld	(0x0b, sp), a
	jreq	00108$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 41: one_wire_byte_write(ow_bus, 0xCC); 
	ld	a, #0xcc
	ldw	x, (0x07, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 43: one_wire_byte_write(ow_bus, 0x44);
	ld	a, #0x44
	ldw	x, (0x07, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 47: while(!one_wire_bit_read(ow_bus) && timeout--) {
	ldw	x, #0x02ee
00102$:
	pushw	x
	ldw	x, (0x09, sp)
	call	_one_wire_bit_read
	popw	x
	tnz	a
	jrne	00104$
	ldw	y, x
	decw	x
	tnzw	y
	jreq	00104$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 48: time_delay_ms(1);
	pushw	x
	clrw	x
	incw	x
	call	_time_delay_ms
	popw	x
	jra	00102$
00104$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 53: if(one_wire_reset_and_detect_slave(ow_bus)) {
	ldw	x, (0x07, sp)
	call	_one_wire_reset_and_detect_slave
	tnz	a
	jreq	00108$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 55: one_wire_byte_write(ow_bus, 0xCC); 
	ld	a, #0xcc
	ldw	x, (0x07, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 57: one_wire_byte_write(ow_bus, 0xBE);
	ld	a, #0xbe
	ldw	x, (0x07, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 59: uint8_t lsb = one_wire_byte_read(ow_bus);
	ldw	x, (0x07, sp)
	call	_one_wire_byte_read
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 60: uint8_t msb = one_wire_byte_read(ow_bus);
	push	a
	ldw	x, (0x08, sp)
	call	_one_wire_byte_read
	ld	yl, a
	pop	a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 62: temp = ((uint16_t)msb << 8) | lsb;
	clr	(0x08, sp)
	ld	(0x0a, sp), a
	exg	a, yl
	ld	(0x09, sp), a
	exg	a, yl
00108$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 66: clk_context_restore(&context);
	ldw	x, sp
	incw	x
	call	_clk_context_restore
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 67: global_interrupt_enable();
	rim
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 69: return temp;
	ldw	x, (0x09, sp)
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 70: }
	addw	sp, #13
	ret
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 77: uint16_t ds18b20_temperature_non_blocking_read(DS18B20_SENSOR *sensor) {  
;	-----------------------------------------
;	 function ds18b20_temperature_non_blocking_read
;	-----------------------------------------
_ds18b20_temperature_non_blocking_read:
	sub	sp, #14
	ldw	(0x0d, sp), x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 78: global_interrupt_disable();  
	sim
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 79: CLK_CONTEXT context = clk_context_get_and_switch(CLK_MASTER_SRC_HSI, CLK_HSI_DIV_1, CLK_CPU_DIV_1);  
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
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 81: ONE_WIRE_BUS *ow_bus = &(sensor->ow_bus);
	ldw	y, (0x0d, sp)
	ldw	(0x0b, sp), y
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 83: if(sensor->temp_conv_process_initiated == 1 && !one_wire_bit_read(ow_bus)) {
	ldw	x, (0x0d, sp)
	addw	x, #0x0003
	ldw	(0x07, sp), x
	ld	a, (x)
	dec	a
	jrne	00111$
	ldw	x, (0x0b, sp)
	call	_one_wire_bit_read
	tnz	a
	jrne	00111$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 84: temp = DS18B20_PROCESSING_TEMP;
	ldw	x, #0xeeef
	jra	00112$
00111$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 86: temp = DS18B20_ERROR_CODE;  
	ldw	x, #0xeeee
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 88: if(sensor->temp_conv_process_initiated) {
	ldw	y, (0x07, sp)
	ld	a, (y)
	jreq	00108$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 89: if(one_wire_reset_and_detect_slave(ow_bus)) {
	pushw	x
	ldw	x, (0x0d, sp)
	call	_one_wire_reset_and_detect_slave
	popw	x
	tnz	a
	jreq	00102$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 91: one_wire_byte_write(ow_bus, 0xCC); 
	ld	a, #0xcc
	ldw	x, (0x0b, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 93: one_wire_byte_write(ow_bus, 0xBE);
	ld	a, #0xbe
	ldw	x, (0x0b, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 95: uint8_t lsb = one_wire_byte_read(ow_bus);
	ldw	x, (0x0b, sp)
	call	_one_wire_byte_read
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 96: uint8_t msb = one_wire_byte_read(ow_bus);
	push	a
	ldw	x, (0x0c, sp)
	call	_one_wire_byte_read
	ld	xh, a
	pop	a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 98: temp = ((uint16_t)msb << 8) | lsb;
	clr	(0x0b, sp)
	clr	(0x0a, sp)
	clr	(0x0b, sp)
	ld	xl, a
00102$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 100: sensor->temp_conv_process_initiated = 0;
	ldw	y, (0x07, sp)
	clr	(y)
	jra	00112$
00108$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 102: } else if(!sensor->temp_conv_process_initiated) {
	tnz	a
	jrne	00112$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 104: if(one_wire_reset_and_detect_slave(ow_bus)) {
	pushw	x
	ldw	x, (0x0d, sp)
	call	_one_wire_reset_and_detect_slave
	popw	x
	tnz	a
	jreq	00112$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 106: one_wire_byte_write(ow_bus, 0xCC); 
	ld	a, #0xcc
	ldw	x, (0x0b, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 108: one_wire_byte_write(ow_bus, 0x44);
	ld	a, #0x44
	ldw	x, (0x0b, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 110: sensor->temp_conv_process_initiated = 1;    
	ldw	x, (0x07, sp)
	ld	a, #0x01
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 111: temp = DS18B20_PROCESSING_TEMP;
	ldw	x, #0xeeef
00112$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 116: clk_context_restore(&context);
	pushw	x
	ldw	x, sp
	addw	x, #3
	call	_clk_context_restore
	popw	x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 117: global_interrupt_enable();
	rim
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 119: return temp;
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 120: }
	addw	sp, #14
	ret
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 142: uint16_t ds18b20_temp_to_sign_encoded_abs_centi_celsius(uint16_t temp) {
;	-----------------------------------------
;	 function ds18b20_temp_to_sign_encoded_abs_centi_celsius
;	-----------------------------------------
_ds18b20_temp_to_sign_encoded_abs_centi_celsius:
	sub	sp, #12
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 143: uint16_t sign_en_fixed_point = temp & 0x8000;  
	ldw	(0x0b, sp), x
	clr	a
	rlwa	x
	and	a, #0x80
	ld	xh, a
	exgw	x, y
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 145: if(sign_en_fixed_point) {
	tnzw	y
	jreq	00102$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 146: temp = (~temp + 1);
	ldw	x, (0x0b, sp)
	cplw	x
	incw	x
	ldw	(0x0b, sp), x
00102$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 149: uint16_t integer = ((temp >> 4));
	ldw	x, (0x0b, sp)
	ld	a, #0x10
	div	x, a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 151: if(integer >= 100U) {
	ldw	(0x09, sp), x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 153: return (sign_en_fixed_point | (integer + 99U));
	ldw	(0x03, sp), y
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 151: if(integer >= 100U) {
	ldw	x, (0x09, sp)
	cpw	x, #0x0064
	jrc	00104$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 153: return (sign_en_fixed_point | (integer + 99U));
	ld	a, #0x0f
	ld	xl, a
	ld	a, (0x03, sp)
	or	a, #0x27
	ld	xh, a
	jra	00106$
00104$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 155: integer *= 100U;
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, #0x0064
	call	__mulint
	ldw	(0x05, sp), x
	ldw	(0x08, sp), x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 158: uint8_t fraction = (((temp & 0x000F) * 100U) + 8) / 16U;
	ldw	y, (0x0b, sp)
	ldw	(0x01, sp), y
	ld	a, (0x02, sp)
	and	a, #0x0f
	ld	(0x07, sp), a
	clr	(0x06, sp)
	ldw	x, (0x06, sp)
	pushw	x
	ldw	x, #0x0064
	call	__mulint
	ldw	(0x01, sp), x
	addw	x, #0x0008
	ldw	(0x06, sp), x
	srl	(0x06, sp)
	rrc	(0x07, sp)
	srl	(0x06, sp)
	rrc	(0x07, sp)
	srl	(0x06, sp)
	rrc	(0x07, sp)
	srl	(0x06, sp)
	rrc	(0x07, sp)
	ld	a, (0x07, sp)
	ld	(0x0a, sp), a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 159: sign_en_fixed_point |= integer + fraction;
	ldw	y, (0x08, sp)
	ldw	(0x05, sp), y
	ld	a, (0x0a, sp)
	ld	(0x08, sp), a
	clr	(0x07, sp)
	ldw	x, (0x05, sp)
	addw	x, (0x07, sp)
	ldw	(0x09, sp), x
	ld	a, (0x0a, sp)
	ld	(0x08, sp), a
	ld	a, (0x03, sp)
	or	a, (0x09, sp)
	ld	(0x07, sp), a
	ldw	y, (0x07, sp)
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 160: return sign_en_fixed_point;
	ldw	(0x09, sp), y
	ldw	x, y
00106$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 161: }
	addw	sp, #12
	ret
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 169: bool ds18b20_crc8_is_valid(uint8_t *scratchpad, uint8_t size) {
;	-----------------------------------------
;	 function ds18b20_crc8_is_valid
;	-----------------------------------------
_ds18b20_crc8_is_valid:
	sub	sp, #5
	ldw	(0x02, sp), x
	ld	(0x01, sp), a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 170: uint8_t crc = 0;
	clrw	x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 171: for(uint8_t i = 0; i < size; i ++) {
	clr	(0x04, sp)
00110$:
	ld	a, (0x04, sp)
	cp	a, (0x01, sp)
	jrnc	00105$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 172: crc ^= scratchpad[i];        
	clrw	y
	ld	a, (0x04, sp)
	ld	yl, a
	addw	y, (0x02, sp)
	ld	a, (y)
	pushw	x
	xor	a, (2, sp)
	popw	x
	ld	xl, a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 173: for(uint8_t j = 0; j < 8; j++) {            
	clr	(0x05, sp)
00107$:
	ld	a, (0x05, sp)
	cp	a, #0x08
	jrnc	00111$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 175: crc = (crc >> 1) ^ CRC_8_BIT_POLYNOMIAL_REFLECTED;
	ld	a, xl
	srl	a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 174: if(crc & 1) {
	srlw	x
	jrnc	00102$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 175: crc = (crc >> 1) ^ CRC_8_BIT_POLYNOMIAL_REFLECTED;
	xor	a, #0x8c
	ld	xl, a
	jra	00108$
00102$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 177: crc >>= 1;
	ld	xl, a
00108$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 173: for(uint8_t j = 0; j < 8; j++) {            
	inc	(0x05, sp)
	jra	00107$
00111$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 171: for(uint8_t i = 0; i < size; i ++) {
	inc	(0x04, sp)
	jra	00110$
00105$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 182: return crc == 0;
	ld	a, xl
	sub	a, #0x01
	clr	a
	rlc	a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 183: }
	addw	sp, #5
	ret
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 188: uint16_t ds18b20_begin_temp_convertion(DS18B20_SENSOR *sensor, bool blocking_temp_conversion) {
;	-----------------------------------------
;	 function ds18b20_begin_temp_convertion
;	-----------------------------------------
_ds18b20_begin_temp_convertion:
	sub	sp, #15
	ldw	(0x0c, sp), x
	ld	(0x0b, sp), a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 189: global_interrupt_disable();  
	sim
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 190: CLK_CONTEXT context = clk_context_get_and_switch(CLK_MASTER_SRC_HSI, CLK_HSI_DIV_1, CLK_CPU_DIV_1); 
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
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 192: ONE_WIRE_BUS *ow_bus = &(sensor->ow_bus);
	ldw	y, (0x0c, sp)
	ldw	(0x07, sp), y
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 193: uint16_t OPERATION_STATUS = DS18B20_ERROR_CODE;
	ldw	x, #0xeeee
	ldw	(0x0e, sp), x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 194: if(blocking_temp_conversion) {
	tnz	(0x0b, sp)
	jreq	00117$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 196: if(one_wire_reset_and_detect_slave(ow_bus)) {
	ldw	x, (0x07, sp)
	call	_one_wire_reset_and_detect_slave
	tnz	a
	jrne	00186$
	jp	00118$
00186$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 198: one_wire_byte_write(ow_bus, 0xCC); 
	ld	a, #0xcc
	ldw	x, (0x07, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 200: one_wire_byte_write(ow_bus, 0x44);
	ld	a, #0x44
	ldw	x, (0x07, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 204: while(!one_wire_bit_read(ow_bus) && timeout--) {
	ldw	x, #0x02ee
	ldw	(0x0e, sp), x
00102$:
	ldw	x, (0x07, sp)
	call	_one_wire_bit_read
	tnz	a
	jrne	00104$
	ldw	y, (0x0e, sp)
	ldw	(0x09, sp), y
	ldw	x, (0x0e, sp)
	decw	x
	ldw	(0x0e, sp), x
	ldw	x, (0x09, sp)
	jreq	00104$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 205: time_delay_ms(1);
	clrw	x
	incw	x
	call	_time_delay_ms
	jra	00102$
00104$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 208: OPERATION_STATUS = DS18B20_DONE_PROCESSING;
	ldw	x, #0xeef0
	ldw	(0x0e, sp), x
	jra	00118$
00117$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 212: if(sensor->temp_conv_process_initiated == 1 && !one_wire_bit_read(ow_bus)) {
	ldw	x, (0x0c, sp)
	addw	x, #0x0003
	ld	a, (x)
	dec	a
	jrne	00113$
	pushw	x
	ldw	x, (0x09, sp)
	call	_one_wire_bit_read
	popw	x
	tnz	a
	jrne	00113$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 213: OPERATION_STATUS = DS18B20_PROCESSING_TEMP;
	ldw	x, #0xeeef
	ldw	(0x0e, sp), x
	jra	00118$
00113$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 215: if(!sensor->temp_conv_process_initiated) {
	ld	a, (x)
	jrne	00110$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 217: if(one_wire_reset_and_detect_slave(ow_bus)) {
	pushw	x
	ldw	x, (0x09, sp)
	call	_one_wire_reset_and_detect_slave
	popw	x
	tnz	a
	jreq	00118$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 219: one_wire_byte_write(ow_bus, 0xCC); 
	pushw	x
	ld	a, #0xcc
	ldw	x, (0x09, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 221: one_wire_byte_write(ow_bus, 0x44);
	ld	a, #0x44
	ldw	x, (0x09, sp)
	call	_one_wire_byte_write
	popw	x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 223: sensor->temp_conv_process_initiated = 1;    
	ld	a, #0x01
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 224: OPERATION_STATUS = DS18B20_PROCESSING_TEMP;
	ldw	x, #0xeeef
	ldw	(0x0e, sp), x
	jra	00118$
00110$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 227: OPERATION_STATUS = DS18B20_DONE_PROCESSING;
	ldw	y, #0xeef0
	ldw	(0x0e, sp), y
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 228: sensor->temp_conv_process_initiated = 0;  
	clr	(x)
00118$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 233: clk_context_restore(&context);
	ldw	x, sp
	incw	x
	call	_clk_context_restore
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 234: global_interrupt_enable();
	rim
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 236: return OPERATION_STATUS; 
	ldw	x, (0x0e, sp)
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 237: }
	addw	sp, #15
	ret
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 246: uint16_t ds18b20_scratchpad_read(uint8_t *scratchpad, DS18B20_SENSOR *sensor) {
;	-----------------------------------------
;	 function ds18b20_scratchpad_read
;	-----------------------------------------
_ds18b20_scratchpad_read:
	sub	sp, #11
	ldw	(0x09, sp), x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 247: global_interrupt_disable();  
	sim
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 248: CLK_CONTEXT context = clk_context_get_and_switch(CLK_MASTER_SRC_HSI, CLK_HSI_DIV_1, CLK_CPU_DIV_1);  
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
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 250: ONE_WIRE_BUS *ow_bus = &(sensor->ow_bus);
	ldw	y, (0x0e, sp)
	ldw	(0x07, sp), y
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 251: uint16_t ERROR_CODE = DS18B20_ERROR_CODE;
	ldw	x, #0xeeee
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 253: if(one_wire_reset_and_detect_slave(ow_bus)) {
	pushw	x
	ldw	x, (0x09, sp)
	call	_one_wire_reset_and_detect_slave
	popw	x
	tnz	a
	jreq	00103$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 255: one_wire_byte_write(ow_bus, 0xCC); 
	ld	a, #0xcc
	ldw	x, (0x07, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 257: one_wire_byte_write(ow_bus, 0xBE);
	ld	a, #0xbe
	ldw	x, (0x07, sp)
	call	_one_wire_byte_write
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 259: for(uint8_t i = 0; i < 9; i++) {
	clr	(0x0b, sp)
00105$:
	ld	a, (0x0b, sp)
	cp	a, #0x09
	jrnc	00101$
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 260: scratchpad[i] = one_wire_byte_read(ow_bus);
	clrw	x
	ld	a, (0x0b, sp)
	ld	xl, a
	addw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	call	_one_wire_byte_read
	popw	x
	ld	(x), a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 259: for(uint8_t i = 0; i < 9; i++) {
	inc	(0x0b, sp)
	jra	00105$
00101$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 263: ERROR_CODE = 0;
	clrw	x
00103$:
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 267: clk_context_restore(&context);
	pushw	x
	ldw	x, sp
	addw	x, #3
	call	_clk_context_restore
	popw	x
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 268: global_interrupt_enable();
	rim
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 270: return ERROR_CODE; 
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 271: }
	addw	sp, #11
	popw	y
	addw	sp, #2
	jp	(y)
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 276: uint16_t ds18b20_temp_from_scratchpad_get(uint8_t *scratchpad) {  
;	-----------------------------------------
;	 function ds18b20_temp_from_scratchpad_get
;	-----------------------------------------
_ds18b20_temp_from_scratchpad_get:
	sub	sp, #4
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 277: uint8_t lsb = scratchpad[0];
	ld	a, (x)
	ld	yl, a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 278: uint8_t msb = scratchpad[1];
	ld	a, (0x1, x)
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 280: return ((uint16_t)msb << 8) | lsb; 
	clr	(0x02, sp)
	ldw	x, y
	clr	(0x03, sp)
	ld	xh, a
;	..\STM8S103F3_L1_Drivers\ds18b20.c: 281: }
	addw	sp, #4
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
