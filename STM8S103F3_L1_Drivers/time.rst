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
                                     11 	.globl _time_delay_sec
                                     12 	.globl _time_delay_ms
                                     13 	.globl _time_delay_us
                                     14 	.globl _clk_fmaster_freq_khz_get
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; Stack segment in internal ram
                                     25 ;--------------------------------------------------------
                                     26 	.area SSEG
      000003                         27 __start__stack:
      000003                         28 	.ds	1
                                     29 
                                     30 ;--------------------------------------------------------
                                     31 ; absolute external ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area DABS (ABS)
                                     34 
                                     35 ; default segment ordering for linker
                                     36 	.area HOME
                                     37 	.area GSINIT
                                     38 	.area GSFINAL
                                     39 	.area CONST
                                     40 	.area INITIALIZER
                                     41 	.area CODE
                                     42 
                                     43 ;--------------------------------------------------------
                                     44 ; interrupt vector
                                     45 ;--------------------------------------------------------
                                     46 	.area HOME
      008000                         47 __interrupt_vect:
      008000 82 00 80 07             48 	int s_GSINIT ; reset
                                     49 ;--------------------------------------------------------
                                     50 ; global & static initialisations
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area GSINIT
                                     54 	.area GSFINAL
                                     55 	.area GSINIT
      008007 CD 80 F0         [ 4]   56 	call	___sdcc_external_startup
      00800A 4D               [ 1]   57 	tnz	a
      00800B 27 03            [ 1]   58 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   59 	jp	__sdcc_program_startup
      008010                         60 __sdcc_init_data:
                                     61 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   62 	ldw x, #l_DATA
      008013 27 07            [ 1]   63 	jreq	00002$
      008015                         64 00001$:
      008015 72 4F 00 00      [ 1]   65 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   66 	decw x
      00801A 26 F9            [ 1]   67 	jrne	00001$
      00801C                         68 00002$:
      00801C AE 00 02         [ 2]   69 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   70 	jreq	00004$
      008021                         71 00003$:
      008021 D6 80 2C         [ 1]   72 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   73 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   74 	decw	x
      008028 26 F7            [ 1]   75 	jrne	00003$
      00802A                         76 00004$:
                                     77 ; stm8_genXINIT() end
                                     78 	.area GSFINAL
      00802A CC 80 04         [ 2]   79 	jp	__sdcc_program_startup
                                     80 ;--------------------------------------------------------
                                     81 ; Home
                                     82 ;--------------------------------------------------------
                                     83 	.area HOME
                                     84 	.area HOME
      008004                         85 __sdcc_program_startup:
      008004 CC 80 BE         [ 2]   86 	jp	_main
                                     87 ;	return from main will return to caller
                                     88 ;--------------------------------------------------------
                                     89 ; code
                                     90 ;--------------------------------------------------------
                                     91 	.area CODE
                                     92 ;	.\time.c: 6: void time_delay_us(uint16_t us) {
                                     93 ;	-----------------------------------------
                                     94 ;	 function time_delay_us
                                     95 ;	-----------------------------------------
      00802F                         96 _time_delay_us:
      00802F 52 06            [ 2]   97 	sub	sp, #6
      008031 1F 05            [ 2]   98 	ldw	(0x05, sp), x
                                     99 ;	.\time.c: 7: uint16_t fmaster_freq_khz = clk_fmaster_freq_khz_get();
      008033 CD 80 C7         [ 4]  100 	call	_clk_fmaster_freq_khz_get
      008036 1F 01            [ 2]  101 	ldw	(0x01, sp), x
      008038 1F 03            [ 2]  102 	ldw	(0x03, sp), x
                                    103 ;	.\time.c: 9: if(fmaster_freq_khz == 0 || us == 0) {
      00803A 1E 01            [ 2]  104 	ldw	x, (0x01, sp)
      00803C 27 57            [ 1]  105 	jreq	00121$
      00803E 1E 05            [ 2]  106 	ldw	x, (0x05, sp)
                                    107 ;	.\time.c: 10: return;
      008040 27 53            [ 1]  108 	jreq	00121$
                                    109 ;	.\time.c: 13: uint8_t divisor = fmaster_freq_khz / 1000U;  
      008042 1E 03            [ 2]  110 	ldw	x, (0x03, sp)
      008044 90 AE 03 E8      [ 2]  111 	ldw	y, #0x03e8
      008048 65               [ 2]  112 	divw	x, y
                                    113 ;	.\time.c: 16: while(divisor > 1) {
      008049 4F               [ 1]  114 	clr	a
      00804A                        115 00104$:
      00804A 88               [ 1]  116 	push	a
      00804B 9F               [ 1]  117 	ld	a, xl
      00804C A1 01            [ 1]  118 	cp	a, #0x01
      00804E 84               [ 1]  119 	pop	a
      00804F 23 06            [ 2]  120 	jrule	00106$
                                    121 ;	.\time.c: 17: divisor >>= 1;
      008051 41               [ 1]  122 	exg	a, xl
      008052 44               [ 1]  123 	srl	a
      008053 41               [ 1]  124 	exg	a, xl
                                    125 ;	.\time.c: 18: prescaler++;
      008054 4C               [ 1]  126 	inc	a
      008055 20 F3            [ 2]  127 	jra	00104$
      008057                        128 00106$:
                                    129 ;	.\../STM8S103F3_L0_Drivers/timer.h: 213: TIM4->PSCR = value;
      008057 C7 53 47         [ 1]  130 	ld	0x5347, a
                                    131 ;	.\time.c: 23: while(us > 0) {
      00805A                        132 00110$:
      00805A 1E 05            [ 2]  133 	ldw	x, (0x05, sp)
      00805C 27 33            [ 1]  134 	jreq	00112$
                                    135 ;	.\time.c: 24: uint16_t chunk = (us >= 256) ? 256 : us;
      00805E 1E 05            [ 2]  136 	ldw	x, (0x05, sp)
      008060 A3 01 00         [ 2]  137 	cpw	x, #0x0100
      008063 25 04            [ 1]  138 	jrc	00123$
      008065 AE 01 00         [ 2]  139 	ldw	x, #0x0100
      008068 C5                     140 	.byte 0xc5
      008069                        141 00123$:
      008069 1E 05            [ 2]  142 	ldw	x, (0x05, sp)
      00806B                        143 00124$:
      00806B 1F 03            [ 2]  144 	ldw	(0x03, sp), x
                                    145 ;	.\time.c: 25: tim4_auto_reload_set((chunk - 1));
      00806D 7B 04            [ 1]  146 	ld	a, (0x04, sp)
      00806F 4A               [ 1]  147 	dec	a
                                    148 ;	.\../STM8S103F3_L0_Drivers/timer.h: 224: TIM4->ARR = value;
      008070 C7 53 48         [ 1]  149 	ld	0x5348, a
                                    150 ;	.\../STM8S103F3_L0_Drivers/timer.h: 184: TIM4->EGR |= (1U << 0);
      008073 72 10 53 45      [ 1]  151 	bset	0x5345, #0
                                    152 ;	.\../STM8S103F3_L0_Drivers/timer.h: 173: TIM4->SR &= ~(1U << 0);
      008077 72 11 53 44      [ 1]  153 	bres	0x5344, #0
                                    154 ;	.\../STM8S103F3_L0_Drivers/timer.h: 115: TIM4->CR1 |= (1U << 0);
      00807B 72 10 53 40      [ 1]  155 	bset	0x5340, #0
                                    156 ;	.\time.c: 31: while(!tim4_update_irq_flag_read());
      00807F                        157 00107$:
                                    158 ;	.\../STM8S103F3_L0_Drivers/timer.h: 177: return ((TIM4->SR >> 0) & 1);
                                    159 ;	.\time.c: 31: while(!tim4_update_irq_flag_read());
      00807F 72 01 53 44 FB   [ 2]  160 	btjf	0x5344, #0, 00107$
                                    161 ;	.\../STM8S103F3_L0_Drivers/timer.h: 119: TIM4->CR1 &= ~(1U << 0);
      008084 72 11 53 40      [ 1]  162 	bres	0x5340, #0
                                    163 ;	.\time.c: 34: us -= chunk;
      008088 1E 05            [ 2]  164 	ldw	x, (0x05, sp)
      00808A 72 F0 03         [ 2]  165 	subw	x, (0x03, sp)
      00808D 1F 05            [ 2]  166 	ldw	(0x05, sp), x
      00808F 20 C9            [ 2]  167 	jra	00110$
      008091                        168 00112$:
                                    169 ;	.\../STM8S103F3_L0_Drivers/timer.h: 173: TIM4->SR &= ~(1U << 0);
      008091 72 11 53 44      [ 1]  170 	bres	0x5344, #0
                                    171 ;	.\time.c: 37: tim4_update_irq_flag_clear();  
      008095                        172 00121$:
                                    173 ;	.\time.c: 38: }
      008095 5B 06            [ 2]  174 	addw	sp, #6
      008097 81               [ 4]  175 	ret
                                    176 ;	.\time.c: 41: void time_delay_ms(uint16_t ms) {
                                    177 ;	-----------------------------------------
                                    178 ;	 function time_delay_ms
                                    179 ;	-----------------------------------------
      008098                        180 _time_delay_ms:
                                    181 ;	.\time.c: 42: while(ms--) {
      008098                        182 00101$:
      008098 90 93            [ 1]  183 	ldw	y, x
      00809A 5A               [ 2]  184 	decw	x
      00809B 90 5D            [ 2]  185 	tnzw	y
      00809D 26 01            [ 1]  186 	jrne	00121$
      00809F 81               [ 4]  187 	ret
      0080A0                        188 00121$:
                                    189 ;	.\time.c: 43: time_delay_us(1000);
      0080A0 89               [ 2]  190 	pushw	x
      0080A1 AE 03 E8         [ 2]  191 	ldw	x, #0x03e8
      0080A4 CD 80 2F         [ 4]  192 	call	_time_delay_us
      0080A7 85               [ 2]  193 	popw	x
      0080A8 20 EE            [ 2]  194 	jra	00101$
                                    195 ;	.\time.c: 45: }
      0080AA 81               [ 4]  196 	ret
                                    197 ;	.\time.c: 48: void time_delay_sec(uint16_t sec) {
                                    198 ;	-----------------------------------------
                                    199 ;	 function time_delay_sec
                                    200 ;	-----------------------------------------
      0080AB                        201 _time_delay_sec:
                                    202 ;	.\time.c: 49: while(sec--) {
      0080AB                        203 00101$:
      0080AB 90 93            [ 1]  204 	ldw	y, x
      0080AD 5A               [ 2]  205 	decw	x
      0080AE 90 5D            [ 2]  206 	tnzw	y
      0080B0 26 01            [ 1]  207 	jrne	00121$
      0080B2 81               [ 4]  208 	ret
      0080B3                        209 00121$:
                                    210 ;	.\time.c: 50: time_delay_ms(1000);
      0080B3 89               [ 2]  211 	pushw	x
      0080B4 AE 03 E8         [ 2]  212 	ldw	x, #0x03e8
      0080B7 CD 80 98         [ 4]  213 	call	_time_delay_ms
      0080BA 85               [ 2]  214 	popw	x
      0080BB 20 EE            [ 2]  215 	jra	00101$
                                    216 ;	.\time.c: 52: }
      0080BD 81               [ 4]  217 	ret
                                    218 ;	.\time.c: 55: int main(void) {
                                    219 ;	-----------------------------------------
                                    220 ;	 function main
                                    221 ;	-----------------------------------------
      0080BE                        222 _main:
                                    223 ;	.\time.c: 56: time_delay_us(250);
      0080BE AE 00 FA         [ 2]  224 	ldw	x, #0x00fa
      0080C1 CD 80 2F         [ 4]  225 	call	_time_delay_us
                                    226 ;	.\time.c: 58: while(1);
      0080C4                        227 00102$:
      0080C4 20 FE            [ 2]  228 	jra	00102$
                                    229 ;	.\time.c: 59: }
      0080C6 81               [ 4]  230 	ret
                                    231 	.area CODE
                                    232 	.area CONST
                                    233 	.area INITIALIZER
                                    234 	.area CABS (ABS)
