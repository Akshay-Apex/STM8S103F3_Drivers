;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module clk
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
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
;	.\clk.c: 11: uint32_t clk_fmaster_freq_get(void) {
;	-----------------------------------------
;	 function clk_fmaster_freq_get
;	-----------------------------------------
_clk_fmaster_freq_get:
	sub	sp, #4
;	.\clk.c: 12: CLK_MASTER_SRC fmaster_src = clk_master_get_source();
	ld	a, 0x50c3
;	.\clk.c: 13: uint32_t base_freq = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
;	.\clk.c: 15: if(fmaster_src == CLK_MASTER_SRC_HSE) {
	cp	a, #0xb4
	jrne	00107$
;	.\clk.c: 16: return base_freq;    
	clrw	x
	clrw	y
	jra	00111$
00107$:
;	.\clk.c: 18: } else if(fmaster_src == CLK_MASTER_SRC_HSI) {
	cp	a, #0xe1
	jrne	00104$
;	.\clk.c: 20: HSI_DIV_PRESCALAR hsi_div_psc = clk_hsi_div_prescalar_read();    
	ld	a, 0x50c6
	and	a, #0x18
;	.\clk.c: 21: base_freq = (HSI_MAX_FREQ >> hsi_div_psc);
	ldw	x, #0x2400
	ldw	y, #0x00f4
	tnz	a
	jreq	00141$
00140$:
	srlw	y
	rrcw	x
	dec	a
	jrne	00140$
00141$:
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	jra	00108$
00104$:
;	.\clk.c: 23: } else if(fmaster_src == CLK_MASTER_SRC_LSI) {
	cp	a, #0xd2
	jrne	00108$
;	.\clk.c: 24: base_freq = 128000UL;    
	ldw	x, #0xf400
	ldw	(0x03, sp), x
	clrw	x
	incw	x
	ldw	(0x01, sp), x
00108$:
;	.\clk.c: 27: return base_freq;
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
00111$:
;	.\clk.c: 28: }
	addw	sp, #4
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
