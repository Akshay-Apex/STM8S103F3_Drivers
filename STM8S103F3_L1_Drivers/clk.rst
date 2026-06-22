                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module clk
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _HSE_OSC_FREQ_KHZ
                                     11 	.globl _clk_fmaster_freq_khz_get
                                     12 ;--------------------------------------------------------
                                     13 ; ram data
                                     14 ;--------------------------------------------------------
                                     15 	.area DATA
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area INITIALIZED
      000001                         20 _HSE_OSC_FREQ_KHZ::
      000001                         21 	.ds 2
                                     22 ;--------------------------------------------------------
                                     23 ; absolute external ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DABS (ABS)
                                     26 
                                     27 ; default segment ordering for linker
                                     28 	.area HOME
                                     29 	.area GSINIT
                                     30 	.area GSFINAL
                                     31 	.area CONST
                                     32 	.area INITIALIZER
                                     33 	.area CODE
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; global & static initialisations
                                     37 ;--------------------------------------------------------
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area GSINIT
                                     42 ;--------------------------------------------------------
                                     43 ; Home
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area HOME
                                     47 ;--------------------------------------------------------
                                     48 ; code
                                     49 ;--------------------------------------------------------
                                     50 	.area CODE
                                     51 ;	.\clk.c: 34: uint16_t clk_fmaster_freq_khz_get(void) {
                                     52 ;	-----------------------------------------
                                     53 ;	 function clk_fmaster_freq_khz_get
                                     54 ;	-----------------------------------------
      0080C7                         55 _clk_fmaster_freq_khz_get:
                                     56 ;	.\clk.c: 35: CLK_MASTER_SRC fmaster_src = clk_master_get_source();  
      0080C7 C6 50 C3         [ 1]   57 	ld	a, 0x50c3
                                     58 ;	.\clk.c: 37: if(fmaster_src == CLK_MASTER_SRC_HSE) {
      0080CA A1 B4            [ 1]   59 	cp	a, #0xb4
      0080CC 26 04            [ 1]   60 	jrne	00107$
                                     61 ;	.\clk.c: 38: return HSE_OSC_FREQ_KHZ;    
      0080CE CE 00 01         [ 2]   62 	ldw	x, _HSE_OSC_FREQ_KHZ+0
      0080D1 81               [ 4]   63 	ret
      0080D2                         64 00107$:
                                     65 ;	.\clk.c: 40: } else if(fmaster_src == CLK_MASTER_SRC_HSI) {
      0080D2 A1 E1            [ 1]   66 	cp	a, #0xe1
      0080D4 26 10            [ 1]   67 	jrne	00104$
                                     68 ;	.\clk.c: 42: HSI_DIV_PRESCALAR hsi_div_psc = clk_hsi_div_prescalar_read();  
      0080D6 C6 50 C6         [ 1]   69 	ld	a, 0x50c6
      0080D9 A4 18            [ 1]   70 	and	a, #0x18
                                     71 ;	.\clk.c: 44: return (HSI_MAX_FREQ >> hsi_div_psc);
      0080DB AE 3E 80         [ 2]   72 	ldw	x, #0x3e80
      0080DE 4D               [ 1]   73 	tnz	a
      0080DF 27 04            [ 1]   74 	jreq	00141$
      0080E1                         75 00140$:
      0080E1 54               [ 2]   76 	srlw	x
      0080E2 4A               [ 1]   77 	dec	a
      0080E3 26 FC            [ 1]   78 	jrne	00140$
      0080E5                         79 00141$:
      0080E5 81               [ 4]   80 	ret
      0080E6                         81 00104$:
                                     82 ;	.\clk.c: 46: } else if(fmaster_src == CLK_MASTER_SRC_LSI) {
      0080E6 A1 D2            [ 1]   83 	cp	a, #0xd2
      0080E8 26 04            [ 1]   84 	jrne	00108$
                                     85 ;	.\clk.c: 47: return 128U;    
      0080EA AE 00 80         [ 2]   86 	ldw	x, #0x0080
      0080ED 81               [ 4]   87 	ret
      0080EE                         88 00108$:
                                     89 ;	.\clk.c: 50: return 0;
      0080EE 5F               [ 1]   90 	clrw	x
                                     91 ;	.\clk.c: 51: }
      0080EF 81               [ 4]   92 	ret
                                     93 	.area CODE
                                     94 	.area CONST
                                     95 	.area INITIALIZER
      00802D                         96 __xinit__HSE_OSC_FREQ_KHZ:
      00802D 00 00                   97 	.dw #0x0000
                                     98 	.area CABS (ABS)
