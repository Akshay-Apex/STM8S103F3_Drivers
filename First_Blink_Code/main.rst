                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.5.0 #15242 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	
                                      7 ;--------------------------------------------------------
                                      8 ; Public variables in this module
                                      9 ;--------------------------------------------------------
                                     10 	.globl _main
                                     11 ;--------------------------------------------------------
                                     12 ; ram data
                                     13 ;--------------------------------------------------------
                                     14 	.area DATA
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area INITIALIZED
                                     19 ;--------------------------------------------------------
                                     20 ; Stack segment in internal ram
                                     21 ;--------------------------------------------------------
                                     22 	.area SSEG
      000001                         23 __start__stack:
      000001                         24 	.ds	1
                                     25 
                                     26 ;--------------------------------------------------------
                                     27 ; absolute external ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DABS (ABS)
                                     30 
                                     31 ; default segment ordering for linker
                                     32 	.area HOME
                                     33 	.area GSINIT
                                     34 	.area GSFINAL
                                     35 	.area CONST
                                     36 	.area INITIALIZER
                                     37 	.area CODE
                                     38 
                                     39 ;--------------------------------------------------------
                                     40 ; interrupt vector
                                     41 ;--------------------------------------------------------
                                     42 	.area HOME
      008000                         43 __interrupt_vect:
      008000 82 00 80 07             44 	int s_GSINIT ; reset
                                     45 ;--------------------------------------------------------
                                     46 ; global & static initialisations
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area GSINIT
                                     50 	.area GSFINAL
                                     51 	.area GSINIT
      008007 CD 80 95         [ 4]   52 	call	___sdcc_external_startup
      00800A 4D               [ 1]   53 	tnz	a
      00800B 27 03            [ 1]   54 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   55 	jp	__sdcc_program_startup
      008010                         56 __sdcc_init_data:
                                     57 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   58 	ldw x, #l_DATA
      008013 27 07            [ 1]   59 	jreq	00002$
      008015                         60 00001$:
      008015 72 4F 00 00      [ 1]   61 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   62 	decw x
      00801A 26 F9            [ 1]   63 	jrne	00001$
      00801C                         64 00002$:
      00801C AE 00 00         [ 2]   65 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   66 	jreq	00004$
      008021                         67 00003$:
      008021 D6 80 2C         [ 1]   68 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   69 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   70 	decw	x
      008028 26 F7            [ 1]   71 	jrne	00003$
      00802A                         72 00004$:
                                     73 ; stm8_genXINIT() end
                                     74 	.area GSFINAL
      00802A CC 80 04         [ 2]   75 	jp	__sdcc_program_startup
                                     76 ;--------------------------------------------------------
                                     77 ; Home
                                     78 ;--------------------------------------------------------
                                     79 	.area HOME
                                     80 	.area HOME
      008004                         81 __sdcc_program_startup:
      008004 CC 80 58         [ 2]   82 	jp	_main
                                     83 ;	return from main will return to caller
                                     84 ;--------------------------------------------------------
                                     85 ; code
                                     86 ;--------------------------------------------------------
                                     87 	.area CODE
                                     88 ;	main.c: 19: static void tim4_init(void)
                                     89 ;	-----------------------------------------
                                     90 ;	 function tim4_init
                                     91 ;	-----------------------------------------
      00802D                         92 _tim4_init:
                                     93 ;	main.c: 29: TIM4_PSCR = 0x07;   /* Prescaler = 128 */
      00802D 35 07 53 47      [ 1]   94 	mov	0x5347+0, #0x07
                                     95 ;	main.c: 30: TIM4_ARR  = 124;    /* 1 ms period */
      008031 35 7C 53 48      [ 1]   96 	mov	0x5348+0, #0x7c
                                     97 ;	main.c: 31: TIM4_CR1  = 0x01;   /* Enable timer */
      008035 35 01 53 40      [ 1]   98 	mov	0x5340+0, #0x01
                                     99 ;	main.c: 32: }
      008039 81               [ 4]  100 	ret
                                    101 ;	main.c: 34: static void delay_ms(uint16_t ms)
                                    102 ;	-----------------------------------------
                                    103 ;	 function delay_ms
                                    104 ;	-----------------------------------------
      00803A                        105 _delay_ms:
                                    106 ;	main.c: 36: while(ms--)
      00803A                        107 00104$:
      00803A 90 93            [ 1]  108 	ldw	y, x
      00803C 5A               [ 2]  109 	decw	x
      00803D 90 5D            [ 2]  110 	tnzw	y
      00803F 26 01            [ 1]  111 	jrne	00138$
      008041 81               [ 4]  112 	ret
      008042                        113 00138$:
                                    114 ;	main.c: 38: TIM4_SR = 0;
      008042 35 00 53 44      [ 1]  115 	mov	0x5344+0, #0x00
                                    116 ;	main.c: 40: while((TIM4_SR & 0x01) == 0)
      008046                        117 00101$:
      008046 72 00 53 44 EF   [ 2]  118 	btjt	0x5344, #0, 00104$
      00804B 20 F9            [ 2]  119 	jra	00101$
                                    120 ;	main.c: 45: }
      00804D 81               [ 4]  121 	ret
                                    122 ;	main.c: 47: static void led_on(void)
                                    123 ;	-----------------------------------------
                                    124 ;	 function led_on
                                    125 ;	-----------------------------------------
      00804E                        126 _led_on:
                                    127 ;	main.c: 50: PB_ODR &= ~(1 << 5);
      00804E 72 1B 50 05      [ 1]  128 	bres	0x5005, #5
                                    129 ;	main.c: 51: }
      008052 81               [ 4]  130 	ret
                                    131 ;	main.c: 53: static void led_off(void)
                                    132 ;	-----------------------------------------
                                    133 ;	 function led_off
                                    134 ;	-----------------------------------------
      008053                        135 _led_off:
                                    136 ;	main.c: 55: PB_ODR |= (1 << 5);
      008053 72 1A 50 05      [ 1]  137 	bset	0x5005, #5
                                    138 ;	main.c: 56: }
      008057 81               [ 4]  139 	ret
                                    140 ;	main.c: 58: int main(void)
                                    141 ;	-----------------------------------------
                                    142 ;	 function main
                                    143 ;	-----------------------------------------
      008058                        144 _main:
                                    145 ;	main.c: 61: CLK_CKDIVR = 0x00;
      008058 35 00 50 C6      [ 1]  146 	mov	0x50c6+0, #0x00
                                    147 ;	main.c: 64: led_off();
      00805C CD 80 53         [ 4]  148 	call	_led_off
                                    149 ;	main.c: 67: PB_DDR |= (1 << 5);
      00805F 72 1A 50 07      [ 1]  150 	bset	0x5007, #5
                                    151 ;	main.c: 68: PB_CR1 |= (1 << 5);
      008063 72 1A 50 08      [ 1]  152 	bset	0x5008, #5
                                    153 ;	main.c: 69: PB_CR2 &= ~(1 << 5);
      008067 72 1B 50 09      [ 1]  154 	bres	0x5009, #5
                                    155 ;	main.c: 72: tim4_init();
      00806B CD 80 2D         [ 4]  156 	call	_tim4_init
                                    157 ;	main.c: 74: while(1)
      00806E                        158 00102$:
                                    159 ;	main.c: 78: led_on();
      00806E CD 80 4E         [ 4]  160 	call	_led_on
                                    161 ;	main.c: 79: delay_ms(50);
      008071 AE 00 32         [ 2]  162 	ldw	x, #0x0032
      008074 CD 80 3A         [ 4]  163 	call	_delay_ms
                                    164 ;	main.c: 81: led_off();
      008077 CD 80 53         [ 4]  165 	call	_led_off
                                    166 ;	main.c: 82: delay_ms(60);
      00807A AE 00 3C         [ 2]  167 	ldw	x, #0x003c
      00807D CD 80 3A         [ 4]  168 	call	_delay_ms
                                    169 ;	main.c: 84: led_on();
      008080 CD 80 4E         [ 4]  170 	call	_led_on
                                    171 ;	main.c: 85: delay_ms(50);
      008083 AE 00 32         [ 2]  172 	ldw	x, #0x0032
      008086 CD 80 3A         [ 4]  173 	call	_delay_ms
                                    174 ;	main.c: 87: led_off();
      008089 CD 80 53         [ 4]  175 	call	_led_off
                                    176 ;	main.c: 88: delay_ms(840);
      00808C AE 03 48         [ 2]  177 	ldw	x, #0x0348
      00808F CD 80 3A         [ 4]  178 	call	_delay_ms
      008092 20 DA            [ 2]  179 	jra	00102$
                                    180 ;	main.c: 90: }
      008094 81               [ 4]  181 	ret
                                    182 	.area CODE
                                    183 	.area CONST
                                    184 	.area INITIALIZER
                                    185 	.area CABS (ABS)
