#ifndef RST_H
#define RST_H

#include <stdint.h>

/* Reset Status Register */
#define RST_SR (*(volatile uint8_t *)0x50B3) 

/* Reset Flags */
#define RST_WWDG_FLAG_MASK  (1U << 0)
#define RST_IWDG_FLAG_MASK  (1U << 1)
#define RST_ILLOP_FLAG_MASK (1U << 2)
#define RST_SWIM_FLAG_MASK  (1U << 3)
#define RST_EMC_FLAG_MASK   (1U << 4)


/* Clears the specified reset flags */
inline void rst_flags_clear(uint8_t flag_mask) {
  RST_SR = flag_mask;
}

/* Reads the reset status register */
inline uint8_t rst_flags_read(void) {
  return RST_SR;
}

#endif