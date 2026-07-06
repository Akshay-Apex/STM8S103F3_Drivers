#include <stdint.h>

#include "../STM8S103F3_L0_Drivers/clk.h"
#include "../STM8S103F3_L0_Drivers/gpio.h"

#include "../STM8S103F3_L1_Drivers/time.h"
#include "../STM8S103F3_L1_Drivers/ws2812_spi.h"

#define NUM_LEDS 16
#define BUF_SIZE (NUM_LEDS * 3)

// Global buffer: Uses exactly 48 bytes of RAM
uint8_t led_buffer[BUF_SIZE];

int main(void) {
  // Initialization code 
  gpio_out_push_pull_fast_mode(GPIO_D, 4);  
  gpio_out_push_pull(GPIO_B, 5);
  
  clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_LSI);  
  
  clk_cpu_div_prescalar_set(CLK_CPU_DIV_1);
  gpio_output_set(GPIO_B, 5);
  
  time_init();  
  ws2812_spi_init();
  
  // 16-bit counter variable (ranges from 0 to 65535)
  uint16_t binary_counter = 0;

  while(1) {
    // Process all 16 bits of the counter
    for(uint8_t bit = 0; bit < NUM_LEDS; bit++) {
      // Check if the specific bit is set to 1
      if((binary_counter >> bit) & 0x01) {
        led_buffer[bit * 3]     = 0xFF; // G (Green ON)
        led_buffer[bit * 3 + 1] = 0x00; // R
        led_buffer[bit * 3 + 2] = 0x00; // B
      } else {
        led_buffer[bit * 3]     = 0x00; // G (OFF)
        led_buffer[bit * 3 + 1] = 0x00; // R
        led_buffer[bit * 3 + 2] = 0x00; // B
      }
    }

    // Push the 16-bit state to the WS2812 strip
    gpio_output_toggle(GPIO_B, 5);
    ws2812_send_frame(led_buffer, BUF_SIZE);

    // Increment the counter (automatically rolls over to 0 after 65535)
    binary_counter++;

    // Precise centisecond pause (10 milliseconds) using your native driver
    time_delay_lsi_ms(10);
  }
}
















// #include <stdint.h>

// #include "../STM8S103F3_L0_Drivers/clk.h"
// #include "../STM8S103F3_L0_Drivers/gpio.h"

// #include "../STM8S103F3_L1_Drivers/time.h"
// #include "../STM8S103F3_L1_Drivers/ws2812_spi.h"

// #define NUM_LEDS 16
// #define BUF_SIZE (NUM_LEDS * 3)

// // Global buffer: Uses exactly 48 bytes of your 1024-byte RAM
// uint8_t led_buffer[BUF_SIZE];

// // Lightweight software delay for smooth sub-second frame transitions
// // Uses zero flash storage compared to pulling in heavy hardware timer libraries
// void nop_delay(uint16_t count) {
//   volatile uint16_t i;
//   for (i = 0; i < count; i++) {
//     __asm__("nop"); // Inline assembly NOP to prevent compiler optimization bypassing
//   }
// }

// // Ultra-lean HSV to RGB converter
// void hue_to_rgb(uint8_t hue, uint8_t *r, uint8_t *g, uint8_t *b) {
//   uint8_t region = hue / 43;
//   uint8_t remainder = (hue % 43) * 6;

//   switch (region) {
//     case 0:  *r = 255;             *g = remainder;       *b = 0;             break;
//     case 1:  *r = 255 - remainder; *g = 255;             *b = 0;             break;
//     case 2:  *r = 0;               *g = 255;             *b = remainder;       break;
//     case 3:  *r = 0;               *g = 255 - remainder; *b = 255;             break;
//     case 4:  *r = remainder;       *g = 0;               *b = 255;             break;
//     default: *r = 255;             *g = 0;               *b = 255 - remainder; break;
//   }
// }

// void clear_buffer(void) {
//   for (uint8_t i = 0; i < BUF_SIZE; i++) {
//     led_buffer[i] = 0x00;
//   }
// }

// int main(void) {
//   // Initialization code 
//   gpio_out_push_pull_fast_mode(GPIO_D, 4);  
//   gpio_out_push_pull(GPIO_B, 5);
//   time_init();  

//   clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_LSI);  
//   clk_cpu_div_prescalar_set(CLK_CPU_DIV_1);

//   uint8_t select = 0; 
//   gpio_output_set(GPIO_B, 5);
//   ws2812_spi_init();
  
//   while(1) {
//     // Blink sequence at the start of each animation loop
//     for(uint8_t i = 0; i < 6; i++) {
//       gpio_output_toggle(GPIO_B, 5);
//       time_delay_lsi_sec(1);
//     }

//     if(select == 0) {
//       // --- ANIMATION 1: SUPER SMOOTH ROLLING RAINBOW ---
//       uint8_t start_hue = 0;
//       // 150 high-speed fluid steps
//       for(uint16_t frame = 0; frame < 150; frame++) {
//         uint8_t current_hue = start_hue;
//         for(uint8_t led = 0; led < NUM_LEDS; led++) {
//           uint8_t r, g, b;
//           hue_to_rgb(current_hue, &r, &g, &b);
          
//           led_buffer[led * 3]     = g; 
//           led_buffer[led * 3 + 1] = r; 
//           led_buffer[led * 3 + 2] = b; 
          
//           current_hue += 12; 
//         }
//         ws2812_send_frame(led_buffer, BUF_SIZE);
//         start_hue += 2; // Tiny increment per frame for ultra-smooth scrolling
//         nop_delay(800); 
//       }
//       select = 1;

//     } else if(select == 1) {
//       // --- ANIMATION 2: SMOOTH THEATER CHASE ---
//       for(uint16_t frame = 0; frame < 90; frame++) {
//         uint8_t step = (frame / 3) % 3; // Slow down the shifting slightly while keeping updates frequent
//         for(uint8_t led = 0; led < NUM_LEDS; led++) {
//           if((led + step) % 3 == 0) {
//             led_buffer[led * 3]     = 0x00; 
//             led_buffer[led * 3 + 1] = 0xFF; // Red
//             led_buffer[led * 3 + 2] = 0x00; 
//           } else {
//             led_buffer[led * 3]     = 0x00;
//             led_buffer[led * 3 + 1] = 0x00;
//             led_buffer[led * 3 + 2] = 0x00;
//           }
//         }
//         ws2812_send_frame(led_buffer, BUF_SIZE);
//         nop_delay(1200); 
//       }
//       select = 2;

//     } else if(select == 2) {
//       // --- ANIMATION 3: SMOOTH BREATHING FADE ---
//       uint8_t brightness = 0;
//       int8_t fade_direction = 2; // Small step sizing for a creamy gradient look
      
//       for(uint16_t frame = 0; frame < 250; frame++) {
//         for(uint8_t led = 0; led < NUM_LEDS; led++) {
//           led_buffer[led * 3]     = 0x00;
//           led_buffer[led * 3 + 1] = 0x00;
//           led_buffer[led * 3 + 2] = brightness; // Blue
//         }
//         ws2812_send_frame(led_buffer, BUF_SIZE);
        
//         // Bounce brightness boundary targets safely
//         if (brightness >= 252) fade_direction = -2;
//         if (brightness <= 2)   fade_direction = 2;
//         brightness += fade_direction;
        
//         nop_delay(500);
//       }
//       select = 3;

//     } else if(select == 3) {
//       // --- ANIMATION 4: SMOOTH COLOR WIPE ---
//       // Increments across all 16 pixels smoothly, then holds and clears
//       for(uint8_t current_led = 0; current_led <= NUM_LEDS; current_led++) {
//         clear_buffer();
//         for(uint8_t led = 0; led < current_led; led++) {
//           led_buffer[led * 3] = 0xFF; // Green
//         }
//         ws2812_send_frame(led_buffer, BUF_SIZE);
        
//         // Creates a smooth trailing wipe feel per pixel step
//         nop_delay(6000); 
//       }
//       // Brief black hold phase before cycling
//       clear_buffer();
//       ws2812_send_frame(led_buffer, BUF_SIZE);
//       time_delay_lsi_sec(1);
//       select = 4;

//     } else {
//       // --- ANIMATION 5: FAST FLASH STROBE ---
//       for(uint16_t frame = 0; frame < 40; frame++) {
//         if(frame % 2 == 0) {
//           for(uint8_t led = 0; led < NUM_LEDS; led++) {
//             led_buffer[led * 3]     = 0xFF; 
//             led_buffer[led * 3 + 1] = 0xFF; 
//             led_buffer[led * 3 + 2] = 0xFF; // White
//           }
//         } else {
//           clear_buffer();
//         }
//         ws2812_send_frame(led_buffer, BUF_SIZE);
//         nop_delay(3500);
//       }
//       select = 0;
//     }
//   }
// }















// #include <stdint.h>

// #include "../STM8S103F3_L0_Drivers/clk.h"
// #include "../STM8S103F3_L0_Drivers/gpio.h"

// #include "../STM8S103F3_L1_Drivers/time.h"
// // #include "../STM8S103F3_L1_Drivers/ws2812_spi.h"
// #include "../STM8S103F3_L1_Drivers/ws2812.h"

// int main(void) {
//   // Initialization code 
//   gpio_out_push_pull_fast_mode(GPIO_D, 4);  
//   gpio_out_push_pull(GPIO_B, 5);
//   time_init();  

//   clk_fmaster_switch_src_auto_mode(CLK_MASTER_SRC_LSI);  
//   clk_cpu_div_prescalar_set(CLK_CPU_DIV_1);

//   uint8_t green_frame[] = {
//     0xFF, 0x00, 0x00,   0xFF, 0x00, 0x00,   0xFF, 0x00, 0x00, 
//     0xFF, 0x00, 0x00,   0xFF, 0x00, 0x00,   0xFF, 0x00, 0x00,
//     0xFF, 0x00, 0x00,   0xFF, 0x00, 0x00,   0xFF, 0x00, 0x00
//   };

//   uint8_t red_frame[] = {
//       0x00, 0xFF, 0x00,   0x00, 0xFF, 0x00,   0x00, 0xFF, 0x00, 
//       0x00, 0xFF, 0x00,   0x00, 0xFF, 0x00,   0x00, 0xFF, 0x00,
//       0x00, 0xFF, 0x00,   0x00, 0xFF, 0x00,   0x00, 0xFF, 0x00
//   };

//   uint8_t blue_frame[] = {
//       0x00, 0x00, 0xFF,   0x00, 0x00, 0xFF,   0x00, 0x00, 0xFF, 
//       0x00, 0x00, 0xFF,   0x00, 0x00, 0xFF,   0x00, 0x00, 0xFF,
//       0x00, 0x00, 0xFF,   0x00, 0x00, 0xFF,   0x00, 0x00, 0xFF
//   };

//   uint8_t black_frame[] = {
//     0x00, 0x00, 0x00,   0x00, 0x00, 0x00,   0x00, 0xFF, 0x00, 
//     0x00, 0x00, 0x00,   0x00, 0x00, 0x00,   0x00, 0xFF, 0x00,
//     0x00, 0x00, 0x00,   0x00, 0x00, 0x00,   0x00, 0xFF, 0x00
// };

// uint8_t white_frame[] = {
//     0xFF, 0xFF, 0xFF,   0xFF, 0xFF, 0xFF,   0xFF, 0xFF, 0xFF,
//     0xFF, 0xFF, 0xFF,   0xFF, 0xFF, 0xFF,   0xFF, 0xFF, 0xFF,
//     0xFF, 0xFF, 0xFF,   0xFF, 0xFF, 0xFF,   0xFF, 0xFF, 0xFF
// };

//   uint8_t select = 1;
//   gpio_output_set(GPIO_B, 5);
//   // ws2812_spi_init();
//   ws2812_init(WS2812_CH1_PD4);
//   while(1) {
//     // Blink at the beginning of each frame for 3 times for 6 sec
//     for(uint8_t i = 0; i < 6; i++) {
//       gpio_output_toggle(GPIO_B, 5);
//       time_delay_lsi_sec(1);
//     }

    
//     if(select == 3) {
//       // Blank but 3
//       // ws2812_send_frame(black_frame, 27);
//       ws2812_write_frame_ch1(black_frame, 27);
//       select = 4;
//       time_delay_lsi_sec(3);
//     } else if(select == 4) {

//       // White
//       // ws2812_send_frame(white_frame, 27);
//       ws2812_write_frame_ch1(white_frame, 27);
//       select = 0;
//       time_delay_lsi_sec(3);
//     } else if(select == 0) {

//       // Green
//       // ws2812_send_frame(green_frame, 27);
//       ws2812_write_frame_ch1(green_frame, 27);
//       select = 1;
//       time_delay_lsi_sec(3);

//     // Red
//     } else if(select == 1) {
//       // ws2812_send_frame(red_frame, 27);
//       ws2812_write_frame_ch1(red_frame, 27);
//       select = 2;
//       time_delay_lsi_sec(3);

//     // Blue
//     } else {
//       // ws2812_send_frame(blue_frame, 27);
//       ws2812_write_frame_ch1(blue_frame, 27);
//       select = 3;
//       time_delay_lsi_sec(3);
//     }
//   }
// }