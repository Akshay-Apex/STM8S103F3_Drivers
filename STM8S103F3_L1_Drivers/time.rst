                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module time
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _main
                                     11 	.globl _delay_us
                                     12 ;--------------------------------------------------------
                                     13 ; ram data
                                     14 ;--------------------------------------------------------
                                     15 	.area DATA
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area INITIALIZED
                                     20 ;--------------------------------------------------------
                                     21 ; Stack segment in internal ram
                                     22 ;--------------------------------------------------------
                                     23 	.area SSEG
      000001                         24 __start__stack:
      000001                         25 	.ds	1
                                     26 
                                     27 ;--------------------------------------------------------
                                     28 ; absolute external ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DABS (ABS)
                                     31 
                                     32 ; default segment ordering for linker
                                     33 	.area HOME
                                     34 	.area GSINIT
                                     35 	.area GSFINAL
                                     36 	.area CONST
                                     37 	.area INITIALIZER
                                     38 	.area CODE
                                     39 
                                     40 ;--------------------------------------------------------
                                     41 ; interrupt vector
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
      008000                         44 __interrupt_vect:
      008000 82 00 80 07             45 	int s_GSINIT ; reset
                                     46 ;--------------------------------------------------------
                                     47 ; global & static initialisations
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
                                     50 	.area GSINIT
                                     51 	.area GSFINAL
                                     52 	.area GSINIT
      008007 CD 80 3B         [ 4]   53 	call	___sdcc_external_startup
      00800A 4D               [ 1]   54 	tnz	a
      00800B 27 03            [ 1]   55 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   56 	jp	__sdcc_program_startup
      008010                         57 __sdcc_init_data:
                                     58 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   59 	ldw x, #l_DATA
      008013 27 07            [ 1]   60 	jreq	00002$
      008015                         61 00001$:
      008015 72 4F 00 00      [ 1]   62 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   63 	decw x
      00801A 26 F9            [ 1]   64 	jrne	00001$
      00801C                         65 00002$:
      00801C AE 00 00         [ 2]   66 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   67 	jreq	00004$
      008021                         68 00003$:
      008021 D6 80 2C         [ 1]   69 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   70 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   71 	decw	x
      008028 26 F7            [ 1]   72 	jrne	00003$
      00802A                         73 00004$:
                                     74 ; stm8_genXINIT() end
                                     75 	.area GSFINAL
      00802A CC 80 04         [ 2]   76 	jp	__sdcc_program_startup
                                     77 ;--------------------------------------------------------
                                     78 ; Home
                                     79 ;--------------------------------------------------------
                                     80 	.area HOME
                                     81 	.area HOME
      008004                         82 __sdcc_program_startup:
      008004 CC 80 32         [ 2]   83 	jp	_main
                                     84 ;	return from main will return to caller
                                     85 ;--------------------------------------------------------
                                     86 ; code
                                     87 ;--------------------------------------------------------
                                     88 	.area CODE
                                     89 ;	.\time.c: 7: void delay_us(uint16_t us) {  
                                     90 ;	-----------------------------------------
                                     91 ;	 function delay_us
                                     92 ;	-----------------------------------------
      00802D                         93 _delay_us:
                                     94 ;	.\..\STM8S103F3_L0_Drivers\clk.h: 37: CLK->ICKR &= ~(1U << 5);
      00802D 72 1B 50 C0      [ 1]   95 	bres	0x50c0, #5
                                     96 ;	.\time.c: 8: clk_active_halt_mvr_enable();
                                     97 ;	.\time.c: 9: }
      008031 81               [ 4]   98 	ret
                                     99 ;	.\time.c: 11: int main(void) {
                                    100 ;	-----------------------------------------
                                    101 ;	 function main
                                    102 ;	-----------------------------------------
      008032                        103 _main:
                                    104 ;	.\time.c: 12: delay_us(25);
      008032 AE 00 19         [ 2]  105 	ldw	x, #0x0019
      008035 CD 80 2D         [ 4]  106 	call	_delay_us
                                    107 ;	.\time.c: 13: while(1);
      008038                        108 00102$:
      008038 20 FE            [ 2]  109 	jra	00102$
                                    110 ;	.\time.c: 14: }
      00803A 81               [ 4]  111 	ret
                                    112 	.area CODE
                                    113 	.area CONST
                                    114 	.area INITIALIZER
                                    115 	.area CABS (ABS)
