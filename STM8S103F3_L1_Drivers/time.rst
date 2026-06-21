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
                                     14 	.globl _clk_fmaster_freq_get
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
      000001                         27 __start__stack:
      000001                         28 	.ds	1
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
      008007 CD 81 7E         [ 4]   56 	call	___sdcc_external_startup
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
      00801C AE 00 00         [ 2]   69 	ldw	x, #l_INITIALIZER
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
      008004 CC 80 D4         [ 2]   86 	jp	_main
                                     87 ;	return from main will return to caller
                                     88 ;--------------------------------------------------------
                                     89 ; code
                                     90 ;--------------------------------------------------------
                                     91 	.area CODE
                                     92 ;	.\time.c: 6: void time_delay_us(uint16_t us) {
                                     93 ;	-----------------------------------------
                                     94 ;	 function time_delay_us
                                     95 ;	-----------------------------------------
      00802D                         96 _time_delay_us:
      00802D 52 0A            [ 2]   97 	sub	sp, #10
      00802F 1F 09            [ 2]   98 	ldw	(0x09, sp), x
                                     99 ;	.\time.c: 7: uint32_t fmaster_freq = clk_fmaster_freq_get();
      008031 CD 80 DD         [ 4]  100 	call	_clk_fmaster_freq_get
      008034 1F 03            [ 2]  101 	ldw	(0x03, sp), x
      008036 17 01            [ 2]  102 	ldw	(0x01, sp), y
      008038 16 03            [ 2]  103 	ldw	y, (0x03, sp)
      00803A 17 07            [ 2]  104 	ldw	(0x07, sp), y
      00803C 16 01            [ 2]  105 	ldw	y, (0x01, sp)
      00803E 17 05            [ 2]  106 	ldw	(0x05, sp), y
                                    107 ;	.\time.c: 9: if(fmaster_freq == 0 || us == 0) {
      008040 1E 03            [ 2]  108 	ldw	x, (0x03, sp)
      008042 26 04            [ 1]  109 	jrne	00182$
      008044 1E 01            [ 2]  110 	ldw	x, (0x01, sp)
      008046 27 63            [ 1]  111 	jreq	00121$
      008048                        112 00182$:
      008048 1E 09            [ 2]  113 	ldw	x, (0x09, sp)
                                    114 ;	.\time.c: 10: return;
      00804A 27 5F            [ 1]  115 	jreq	00121$
                                    116 ;	.\time.c: 13: uint8_t divisor = fmaster_freq / 1000000UL;
      00804C 4B 40            [ 1]  117 	push	#0x40
      00804E 4B 42            [ 1]  118 	push	#0x42
      008050 4B 0F            [ 1]  119 	push	#0x0f
      008052 4B 00            [ 1]  120 	push	#0x00
      008054 1E 0B            [ 2]  121 	ldw	x, (0x0b, sp)
      008056 89               [ 2]  122 	pushw	x
      008057 1E 0B            [ 2]  123 	ldw	x, (0x0b, sp)
      008059 89               [ 2]  124 	pushw	x
      00805A CD 81 23         [ 4]  125 	call	__divulong
      00805D 5B 08            [ 2]  126 	addw	sp, #8
                                    127 ;	.\time.c: 16: while(divisor > 1) {
      00805F 4F               [ 1]  128 	clr	a
      008060                        129 00104$:
      008060 88               [ 1]  130 	push	a
      008061 9F               [ 1]  131 	ld	a, xl
      008062 A1 01            [ 1]  132 	cp	a, #0x01
      008064 84               [ 1]  133 	pop	a
      008065 23 06            [ 2]  134 	jrule	00106$
                                    135 ;	.\time.c: 17: divisor >>= 1;
      008067 41               [ 1]  136 	exg	a, xl
      008068 44               [ 1]  137 	srl	a
      008069 41               [ 1]  138 	exg	a, xl
                                    139 ;	.\time.c: 18: prescaler++;
      00806A 4C               [ 1]  140 	inc	a
      00806B 20 F3            [ 2]  141 	jra	00104$
      00806D                        142 00106$:
                                    143 ;	.\../STM8S103F3_L0_Drivers/timer.h: 213: TIM4->PSCR = value;
      00806D C7 53 47         [ 1]  144 	ld	0x5347, a
                                    145 ;	.\time.c: 23: while(us > 0) {
      008070                        146 00110$:
      008070 1E 09            [ 2]  147 	ldw	x, (0x09, sp)
      008072 27 33            [ 1]  148 	jreq	00112$
                                    149 ;	.\time.c: 24: uint16_t chunk = (us >= 256) ? 256 : us;
      008074 1E 09            [ 2]  150 	ldw	x, (0x09, sp)
      008076 A3 01 00         [ 2]  151 	cpw	x, #0x0100
      008079 25 04            [ 1]  152 	jrc	00123$
      00807B AE 01 00         [ 2]  153 	ldw	x, #0x0100
      00807E C5                     154 	.byte 0xc5
      00807F                        155 00123$:
      00807F 1E 09            [ 2]  156 	ldw	x, (0x09, sp)
      008081                        157 00124$:
      008081 1F 07            [ 2]  158 	ldw	(0x07, sp), x
                                    159 ;	.\time.c: 25: tim4_auto_reload_set((chunk - 1));
      008083 7B 08            [ 1]  160 	ld	a, (0x08, sp)
      008085 4A               [ 1]  161 	dec	a
                                    162 ;	.\../STM8S103F3_L0_Drivers/timer.h: 224: TIM4->ARR = value;
      008086 C7 53 48         [ 1]  163 	ld	0x5348, a
                                    164 ;	.\../STM8S103F3_L0_Drivers/timer.h: 184: TIM4->EGR |= (1U << 0);
      008089 72 10 53 45      [ 1]  165 	bset	0x5345, #0
                                    166 ;	.\../STM8S103F3_L0_Drivers/timer.h: 173: TIM4->SR &= ~(1U << 0);
      00808D 72 11 53 44      [ 1]  167 	bres	0x5344, #0
                                    168 ;	.\../STM8S103F3_L0_Drivers/timer.h: 115: TIM4->CR1 |= (1U << 0);
      008091 72 10 53 40      [ 1]  169 	bset	0x5340, #0
                                    170 ;	.\time.c: 31: while(!tim4_update_irq_flag_read());
      008095                        171 00107$:
                                    172 ;	.\../STM8S103F3_L0_Drivers/timer.h: 177: return ((TIM4->SR >> 0) & 1);
                                    173 ;	.\time.c: 31: while(!tim4_update_irq_flag_read());
      008095 72 01 53 44 FB   [ 2]  174 	btjf	0x5344, #0, 00107$
                                    175 ;	.\../STM8S103F3_L0_Drivers/timer.h: 119: TIM4->CR1 &= ~(1U << 0);
      00809A 72 11 53 40      [ 1]  176 	bres	0x5340, #0
                                    177 ;	.\time.c: 34: us -= chunk;
      00809E 1E 09            [ 2]  178 	ldw	x, (0x09, sp)
      0080A0 72 F0 07         [ 2]  179 	subw	x, (0x07, sp)
      0080A3 1F 09            [ 2]  180 	ldw	(0x09, sp), x
      0080A5 20 C9            [ 2]  181 	jra	00110$
      0080A7                        182 00112$:
                                    183 ;	.\../STM8S103F3_L0_Drivers/timer.h: 173: TIM4->SR &= ~(1U << 0);
      0080A7 72 11 53 44      [ 1]  184 	bres	0x5344, #0
                                    185 ;	.\time.c: 37: tim4_update_irq_flag_clear();  
      0080AB                        186 00121$:
                                    187 ;	.\time.c: 38: }
      0080AB 5B 0A            [ 2]  188 	addw	sp, #10
      0080AD 81               [ 4]  189 	ret
                                    190 ;	.\time.c: 41: void time_delay_ms(uint16_t ms) {
                                    191 ;	-----------------------------------------
                                    192 ;	 function time_delay_ms
                                    193 ;	-----------------------------------------
      0080AE                        194 _time_delay_ms:
                                    195 ;	.\time.c: 42: while(ms--) {
      0080AE                        196 00101$:
      0080AE 90 93            [ 1]  197 	ldw	y, x
      0080B0 5A               [ 2]  198 	decw	x
      0080B1 90 5D            [ 2]  199 	tnzw	y
      0080B3 26 01            [ 1]  200 	jrne	00121$
      0080B5 81               [ 4]  201 	ret
      0080B6                        202 00121$:
                                    203 ;	.\time.c: 43: time_delay_us(1000);
      0080B6 89               [ 2]  204 	pushw	x
      0080B7 AE 03 E8         [ 2]  205 	ldw	x, #0x03e8
      0080BA CD 80 2D         [ 4]  206 	call	_time_delay_us
      0080BD 85               [ 2]  207 	popw	x
      0080BE 20 EE            [ 2]  208 	jra	00101$
                                    209 ;	.\time.c: 45: }
      0080C0 81               [ 4]  210 	ret
                                    211 ;	.\time.c: 48: void time_delay_sec(uint16_t sec) {
                                    212 ;	-----------------------------------------
                                    213 ;	 function time_delay_sec
                                    214 ;	-----------------------------------------
      0080C1                        215 _time_delay_sec:
                                    216 ;	.\time.c: 49: while(sec--) {
      0080C1                        217 00101$:
      0080C1 90 93            [ 1]  218 	ldw	y, x
      0080C3 5A               [ 2]  219 	decw	x
      0080C4 90 5D            [ 2]  220 	tnzw	y
      0080C6 26 01            [ 1]  221 	jrne	00121$
      0080C8 81               [ 4]  222 	ret
      0080C9                        223 00121$:
                                    224 ;	.\time.c: 50: time_delay_ms(1000);
      0080C9 89               [ 2]  225 	pushw	x
      0080CA AE 03 E8         [ 2]  226 	ldw	x, #0x03e8
      0080CD CD 80 AE         [ 4]  227 	call	_time_delay_ms
      0080D0 85               [ 2]  228 	popw	x
      0080D1 20 EE            [ 2]  229 	jra	00101$
                                    230 ;	.\time.c: 52: }
      0080D3 81               [ 4]  231 	ret
                                    232 ;	.\time.c: 55: int main(void) {
                                    233 ;	-----------------------------------------
                                    234 ;	 function main
                                    235 ;	-----------------------------------------
      0080D4                        236 _main:
                                    237 ;	.\time.c: 56: time_delay_ms(250);
      0080D4 AE 00 FA         [ 2]  238 	ldw	x, #0x00fa
      0080D7 CD 80 AE         [ 4]  239 	call	_time_delay_ms
                                    240 ;	.\time.c: 58: while(1);
      0080DA                        241 00102$:
      0080DA 20 FE            [ 2]  242 	jra	00102$
                                    243 ;	.\time.c: 59: }
      0080DC 81               [ 4]  244 	ret
                                    245 	.area CODE
                                    246 	.area CONST
                                    247 	.area INITIALIZER
                                    248 	.area CABS (ABS)
