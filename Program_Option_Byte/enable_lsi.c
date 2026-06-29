#include <stdint.h>

/* FLASH registers */
#define FLASH_CR2      (*(volatile uint8_t *)0x505B)
#define FLASH_NCR2     (*(volatile uint8_t *)0x505C)
#define FLASH_IAPSR    (*(volatile uint8_t *)0x505F)
#define FLASH_DUKR     (*(volatile uint8_t *)0x5064)

/* Option bytes memory locations */
#define OPT3           (*(volatile uint8_t *)0x4805)
#define NOPT3          (*(volatile uint8_t *)0x4806)

/* Register Bit Definitions */
#define FLASH_IAPSR_DUL   (1 << 3)
#define FLASH_CR2_WPRG    (1 << 7)
#define FLASH_NCR2_NWPRG  (1 << 7)

/**
  * @brief  Unlocks data/option memory, enables WPRG mode, and activates the LSI clock.
  * @note   Modifying option bytes incorrectly can trigger a system reset.
  */
void option_enable_lsi(void)
{
    /* 1. Unlock Data EEPROM and Option Bytes memory access */
    FLASH_DUKR = 0xAE;
    FLASH_DUKR = 0x56;

    /* Wait until Data EEPROM / Option Bytes area is fully unlocked */
    while (!(FLASH_IAPSR & FLASH_IAPSR_DUL));

    /* 2. Enable Option Byte Programming Mode (WPRG) */
    /* CR2 and NCR2 must be complements of each other */
    FLASH_CR2 |= FLASH_CR2_WPRG;
    FLASH_NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);

    /* 3. Modify and write the Option Byte pair */
    uint8_t value = OPT3;
    value |= (1 << 3);  /* Set Bit 3 (LSI_EN) to 1 */

    OPT3 = value;       /* Write original value */
    NOPT3 = (uint8_t)(~value); /* Write complemented value immediately after */

    /* 4. Disable Option Byte Programming Mode (WPRG) */
    FLASH_CR2 &= (uint8_t)(~FLASH_CR2_WPRG);
    FLASH_NCR2 |= FLASH_NCR2_NWPRG;

    /* 5. Lock Data EEPROM and Option Bytes area again */
    FLASH_IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
}

int main(void)
{
    /* Call the configuration function */
    option_enable_lsi();

    while (1)
    {
        /* Your application code here */
    }
}