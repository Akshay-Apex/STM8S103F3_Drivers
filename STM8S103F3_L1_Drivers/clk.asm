;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (MINGW64)
;--------------------------------------------------------
	.module clk
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _HSE_OSC_FREQ_KHZ
	.globl _clk_fmaster_freq_khz_get
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_HSE_OSC_FREQ_KHZ::
	.ds 2
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
;	.\clk.c: 34: uint16_t clk_fmaster_freq_khz_get(void) {
;	-----------------------------------------
;	 function clk_fmaster_freq_khz_get
;	-----------------------------------------
_clk_fmaster_freq_khz_get:
;	.\clk.c: 35: CLK_MASTER_SRC fmaster_src = clk_master_get_source();  
	ld	a, 0x50c3
;	.\clk.c: 37: if(fmaster_src == CLK_MASTER_SRC_HSE) {
	cp	a, #0xb4
	jrne	00107$
;	.\clk.c: 38: return HSE_OSC_FREQ_KHZ;    
	ldw	x, _HSE_OSC_FREQ_KHZ+0
	ret
00107$:
;	.\clk.c: 40: } else if(fmaster_src == CLK_MASTER_SRC_HSI) {
	cp	a, #0xe1
	jrne	00104$
;	.\clk.c: 42: HSI_DIV_PRESCALAR hsi_div_psc = clk_hsi_div_prescalar_read();  
	ld	a, 0x50c6
	and	a, #0x18
;	.\clk.c: 44: return (HSI_MAX_FREQ >> hsi_div_psc);
	ldw	x, #0x3e80
	tnz	a
	jreq	00141$
00140$:
	srlw	x
	dec	a
	jrne	00140$
00141$:
	ret
00104$:
;	.\clk.c: 46: } else if(fmaster_src == CLK_MASTER_SRC_LSI) {
	cp	a, #0xd2
	jrne	00108$
;	.\clk.c: 47: return 128U;    
	ldw	x, #0x0080
	ret
00108$:
;	.\clk.c: 50: return 0;
	clrw	x
;	.\clk.c: 51: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__HSE_OSC_FREQ_KHZ:
	.dw #0x0000
	.area CABS (ABS)
