                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module clk
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _clk_fmaster_freq_get
                                     11 ;--------------------------------------------------------
                                     12 ; ram data
                                     13 ;--------------------------------------------------------
                                     14 	.area DATA
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area INITIALIZED
                                     19 ;--------------------------------------------------------
                                     20 ; absolute external ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DABS (ABS)
                                     23 
                                     24 ; default segment ordering for linker
                                     25 	.area HOME
                                     26 	.area GSINIT
                                     27 	.area GSFINAL
                                     28 	.area CONST
                                     29 	.area INITIALIZER
                                     30 	.area CODE
                                     31 
                                     32 ;--------------------------------------------------------
                                     33 ; global & static initialisations
                                     34 ;--------------------------------------------------------
                                     35 	.area HOME
                                     36 	.area GSINIT
                                     37 	.area GSFINAL
                                     38 	.area GSINIT
                                     39 ;--------------------------------------------------------
                                     40 ; Home
                                     41 ;--------------------------------------------------------
                                     42 	.area HOME
                                     43 	.area HOME
                                     44 ;--------------------------------------------------------
                                     45 ; code
                                     46 ;--------------------------------------------------------
                                     47 	.area CODE
                                     48 ;	.\clk.c: 11: uint32_t clk_fmaster_freq_get(void) {
                                     49 ;	-----------------------------------------
                                     50 ;	 function clk_fmaster_freq_get
                                     51 ;	-----------------------------------------
      0080DD                         52 _clk_fmaster_freq_get:
      0080DD 52 04            [ 2]   53 	sub	sp, #4
                                     54 ;	.\clk.c: 12: CLK_MASTER_SRC fmaster_src = clk_master_get_source();
      0080DF C6 50 C3         [ 1]   55 	ld	a, 0x50c3
                                     56 ;	.\clk.c: 13: uint32_t base_freq = 0;
      0080E2 5F               [ 1]   57 	clrw	x
      0080E3 1F 03            [ 2]   58 	ldw	(0x03, sp), x
      0080E5 1F 01            [ 2]   59 	ldw	(0x01, sp), x
                                     60 ;	.\clk.c: 15: if(fmaster_src == CLK_MASTER_SRC_HSE) {
      0080E7 A1 B4            [ 1]   61 	cp	a, #0xb4
      0080E9 26 05            [ 1]   62 	jrne	00107$
                                     63 ;	.\clk.c: 16: return base_freq;    
      0080EB 5F               [ 1]   64 	clrw	x
      0080EC 90 5F            [ 1]   65 	clrw	y
      0080EE 20 30            [ 2]   66 	jra	00111$
      0080F0                         67 00107$:
                                     68 ;	.\clk.c: 18: } else if(fmaster_src == CLK_MASTER_SRC_HSI) {
      0080F0 A1 E1            [ 1]   69 	cp	a, #0xe1
      0080F2 26 1B            [ 1]   70 	jrne	00104$
                                     71 ;	.\clk.c: 20: HSI_DIV_PRESCALAR hsi_div_psc = clk_hsi_div_prescalar_read();    
      0080F4 C6 50 C6         [ 1]   72 	ld	a, 0x50c6
      0080F7 A4 18            [ 1]   73 	and	a, #0x18
                                     74 ;	.\clk.c: 21: base_freq = (HSI_MAX_FREQ >> hsi_div_psc);
      0080F9 AE 24 00         [ 2]   75 	ldw	x, #0x2400
      0080FC 90 AE 00 F4      [ 2]   76 	ldw	y, #0x00f4
      008100 4D               [ 1]   77 	tnz	a
      008101 27 06            [ 1]   78 	jreq	00141$
      008103                         79 00140$:
      008103 90 54            [ 2]   80 	srlw	y
      008105 56               [ 2]   81 	rrcw	x
      008106 4A               [ 1]   82 	dec	a
      008107 26 FA            [ 1]   83 	jrne	00140$
      008109                         84 00141$:
      008109 1F 03            [ 2]   85 	ldw	(0x03, sp), x
      00810B 17 01            [ 2]   86 	ldw	(0x01, sp), y
      00810D 20 0D            [ 2]   87 	jra	00108$
      00810F                         88 00104$:
                                     89 ;	.\clk.c: 23: } else if(fmaster_src == CLK_MASTER_SRC_LSI) {
      00810F A1 D2            [ 1]   90 	cp	a, #0xd2
      008111 26 09            [ 1]   91 	jrne	00108$
                                     92 ;	.\clk.c: 24: base_freq = 128000UL;    
      008113 AE F4 00         [ 2]   93 	ldw	x, #0xf400
      008116 1F 03            [ 2]   94 	ldw	(0x03, sp), x
      008118 5F               [ 1]   95 	clrw	x
      008119 5C               [ 1]   96 	incw	x
      00811A 1F 01            [ 2]   97 	ldw	(0x01, sp), x
      00811C                         98 00108$:
                                     99 ;	.\clk.c: 27: return base_freq;
      00811C 1E 03            [ 2]  100 	ldw	x, (0x03, sp)
      00811E 16 01            [ 2]  101 	ldw	y, (0x01, sp)
      008120                        102 00111$:
                                    103 ;	.\clk.c: 28: }
      008120 5B 04            [ 2]  104 	addw	sp, #4
      008122 81               [ 4]  105 	ret
                                    106 	.area CODE
                                    107 	.area CONST
                                    108 	.area INITIALIZER
                                    109 	.area CABS (ABS)
