/**
 * @file spi.h
 * @brief STM8S103F3 SPI driver.
 *
 * @details Implements the complete STM8S103F3 Serial Peripheral Interface (SPI).
 */

#ifndef SPI_H
#define SPI_H

#include <stdint.h>

/* SPI Register Definitions */
typedef struct {
  volatile uint8_t CR1;     // SPI control register 1
  volatile uint8_t CR2;     // SPI control register 2
  volatile uint8_t ICR;     // SPI interrupt control register
  volatile uint8_t SR;      // SPI status register
  volatile uint8_t DR;      // SPI data register
  volatile uint8_t CRCPR;   // SPI CRC polynomial register
  volatile uint8_t RXCRCR;  // SPI Rx CRC register
  volatile uint8_t TXCRCR;  // SPI Tx CRC register
} SPI_REG;

#define SPI ((SPI_REG *)0x5200) // Base address binding of SPI registers

/* SPI control register 1 (CR1) */
typedef enum {
  SPI_FIRST_CLK_DATA_CAPTURE = 0,
  SPI_SECOND_CLK_DATA_CAPTURE = 1
} SPI_CLK_PHASE;

inline void spi_clk_phase_set(SPI_CLK_PHASE phase) {
  SPI->CR1 = (SPI->CR1 & ~(1U << 0)) | phase;
}

inline SPI_CLK_PHASE spi_clk_phase_read(void) {
  return (SPI_CLK_PHASE)((SPI->CR1 >> 0) & 1);
}


typedef enum {
  SPI_POLARITY_LOW_WHEN_IDLE = 0,
  SPI_POLARITY_HIGH_WHEN_IDLE = 1
} SPI_CLK_POLARITY;

inline void spi_clk_polarity_set(SPI_CLK_POLARITY polarity) {
  SPI->CR1 = (SPI->CR1 & ~(1U << 1)) | (polarity << 1);
}

inline SPI_CLK_POLARITY spi_clk_polarity_read(void) {
  return (SPI_CLK_POLARITY)((SPI->CR1 >> 1) & 1);
}


typedef enum {
  SPI_SLAVE_CONFIGURATION = 0,
  SPI_MASTER_CONFIGURATION = 1
} SPI_MASTER_MODE;

inline void spi_master_mode_set(SPI_MASTER_MODE mode) {
  SPI->CR1 = (SPI->CR1 & ~(1U << 2)) | (mode << 2);
}

inline SPI_MASTER_MODE spi_master_mode_read(void) {
  return (SPI_MASTER_MODE)((SPI->CR1 >> 2) & 1);
}


typedef enum {
  SPI_BAUD_RATE_PSC_2 = 0,
  SPI_BAUD_RATE_PSC_4 = 1,
  SPI_BAUD_RATE_PSC_8 = 2,
  SPI_BAUD_RATE_PSC_16 = 3,
  SPI_BAUD_RATE_PSC_32 = 4,
  SPI_BAUD_RATE_PSC_64 = 5,
  SPI_BAUD_RATE_PSC_128 = 6,
  SPI_BAUD_RATE_PSC_256 = 7
} SPI_BAUD_RATE_PRESCALER;

#define SPI_BAUD_RATE_PSC_MASK 0x38

inline void spi_baud_rate_prescaler_set(SPI_BAUD_RATE_PRESCALER prescaler) {
  SPI->CR1 = (SPI->CR1 & ~(SPI_BAUD_RATE_PSC_MASK)) | ((uint8_t)prescaler << 3);
}

inline SPI_BAUD_RATE_PRESCALER spi_baud_rate_prescaler_read(void) {
  return (SPI_BAUD_RATE_PRESCALER)((SPI->CR1 >> 3) & 0x07);
}


inline void spi_enable(void) {
  SPI->CR1 |= (1U << 6);
}

inline void spi_disable(void) {
  SPI->CR1 &= ~(1U << 6);
}


typedef enum {
  SPI_FRAME_FORMAT_MSB_FIRST = 0,
  SPI_FRAME_FORMAT_LSB_FIRST = 1
} SPI_FRAME_FORMAT;

inline void spi_tx_frame_format_set(SPI_FRAME_FORMAT format) {
  SPI->CR1 = (SPI->CR1 & ~(1U << 7)) | (format << 7);
}

inline SPI_FRAME_FORMAT spi_tx_frame_format_read(void) {
  return (SPI_FRAME_FORMAT)((SPI->CR1 >> 7) & 1);
}



/* SPI control register 2 (CR2) */
typedef enum {
  SPI_SLAVE_SELECT_SLAVE_MODE = 0,
  SPI_SLAVE_SELECT_MASTER_MODE = 1
} SPI_INTERNAL_SLAVE_SELECT_MODE;

inline void spi_internal_slave_select_mode_set(SPI_INTERNAL_SLAVE_SELECT_MODE mode) {
  SPI->CR2 = (SPI->CR2 & ~(1U << 0)) | mode;
}

inline SPI_INTERNAL_SLAVE_SELECT_MODE spi_internal_slave_select_mode_read(void) {
  return (SPI_INTERNAL_SLAVE_SELECT_MODE)((SPI->CR2 >> 0) & 1);
}


inline void spi_software_slave_enable(void) {
  SPI->CR2 |= (1U << 1);
}

inline void spi_software_slave_disable(void) {
  SPI->CR2 &= ~(1U << 1);
}


typedef enum {
  SPI_TRANSFER_MODE_FULL_DUPLEX = 0,
  SPI_TRANSFER_MODE_RECEIVE_ONLY = 1
} SPI_TRANSFER_MODE;

inline void spi_transfer_mode_set(SPI_TRANSFER_MODE mode) {
  SPI->CR2 = (SPI->CR2 & ~(1U << 2)) | ((uint8_t)mode << 2);
}

inline SPI_TRANSFER_MODE spi_transfer_mode_read(void) {
  return (SPI_TRANSFER_MODE)((SPI->CR2 >> 2) & 1);
}


typedef enum {
  SPI_TX_BUFFER = 0,
  SPI_TX_CRC_REGISTER = 1
} SPI_TX_CRC_BUFFER_SELECT;

inline void spi_tx_crc_buffer_select_set(SPI_TX_CRC_BUFFER_SELECT select) {
  SPI->CR2 = (SPI->CR2 & ~(1U << 4)) | ((uint8_t)select << 4);
}

inline SPI_TX_CRC_BUFFER_SELECT spi_tx_crc_buffer_select_read(void) {
  return (SPI_TX_CRC_BUFFER_SELECT)((SPI->CR2 >> 4) & 1);
}


inline void spi_hw_crc_calculation_enable(void) {
  SPI->CR2 |= (1U << 5);
}

inline void spi_hw_crc_calculation_disable(void) {
  SPI->CR2 &= ~(1U << 5);
}


typedef enum {
  SPI_INPUT_ENABLE = 0,
  SPI_OUTPUT_ENABLE = 1
} SPI_BIDIRECTIONAL_IO_MODE;

inline void spi_bidirectional_io_mode_set(SPI_BIDIRECTIONAL_IO_MODE mode) {
  SPI->CR2 = (SPI->CR2 & ~(1U << 6)) | ((uint8_t)mode << 6);
}

inline SPI_BIDIRECTIONAL_IO_MODE spi_bidirectional_io_mode_read(void) {
  return (SPI_BIDIRECTIONAL_IO_MODE)((SPI->CR2 >> 6) & 1);
}


typedef enum {
  SPI_2_LINE_UNIDIRECTIONAL_DATA_MODE = 0,
  SPI_1_LINE_BIDIRECTIONAL_DATA_MODE = 1
} SPI_BIDIRECTIONAL_DATA_MODE;

inline void spi_bidirectional_data_mode_set(SPI_BIDIRECTIONAL_DATA_MODE mode) {
  SPI->CR2 = (SPI->CR2 & ~(1U << 7)) | ((uint8_t)mode << 7);
}

inline SPI_BIDIRECTIONAL_DATA_MODE spi_bidirectional_data_mode_read(void) {
  return (SPI_BIDIRECTIONAL_DATA_MODE)((SPI->CR2 >> 7) & 1);
}



/* SPI interrupt control register (ICR) */
inline void spi_wakeup_irq_enable(void) {
  SPI->ICR |= (1U << 4);
}

inline void spi_wakeup_irq_disable(void) {
  SPI->ICR &= ~(1U << 4);
}


inline void spi_error_irq_enable(void) {
  SPI->ICR |= (1U << 5);
}

inline void spi_error_irq_disable(void) {
  SPI->ICR &= ~(1U << 5);
}


inline void spi_rx_buffer_not_empty_irq_enable(void) {
  SPI->ICR |= (1U << 6);
}

inline void spi_rx_buffer_not_empty_irq_disable(void) {
  SPI->ICR &= ~(1U << 6);
}


inline void spi_tx_buffer_empty_irq_enable(void) {
  SPI->ICR |= (1U << 7);
}

inline void spi_tx_buffer_empty_irq_disable(void) {
  SPI->ICR &= ~(1U << 7);
}



/* SPI status register (SR) */
typedef enum {
  SPI_RX_BUFFER_EMPTY = 0,
  SPI_RX_BUFFER_NOT_EMPTY = 1
} SPI_RX_BUFFER_STATUS;

inline SPI_RX_BUFFER_STATUS spi_rx_buffer_status_read(void) {
  return (SPI_RX_BUFFER_STATUS)((SPI->SR >> 0) & 1);
}


typedef enum {
  SPI_TX_BUFFER_NOT_EMPTY = 0,
  SPI_TX_BUFFER_EMPTY = 1
} SPI_TX_BUFFER_STATUS;

inline SPI_TX_BUFFER_STATUS spi_tx_buffer_status_read(void) {
  return (SPI_TX_BUFFER_STATUS)((SPI->SR >> 1) & 1);
}


inline uint8_t spi_wakeup_event_status_read(void) {
  return (uint8_t)((SPI->SR >> 3) & 1);
}


inline uint8_t spi_crc_error_status_read(void) {
  return (uint8_t)((SPI->SR >> 4) & 1);
}


inline uint8_t spi_mode_fault_status_read(void) {
  return (uint8_t)((SPI->SR >> 5) & 1);
}


inline uint8_t spi_overrun_status_read(void) {
  return (uint8_t)((SPI->SR >> 6) & 1);
}


inline uint8_t spi_busy_status_read(void) {
  return (uint8_t)((SPI->SR >> 7) & 1);
}



/* SPI data register (DR) */
inline void spi_tx_data_write(uint8_t data) {
  SPI->DR = data;
}

inline uint8_t spi_rx_data_read(void) {
  return SPI->DR;
}



/* SPI CRC polynomial register (CRCPR) */
inline void spi_crc_polynomial_write(uint8_t polynomial) {
  SPI->CRCPR = polynomial;
}

inline uint8_t spi_crc_polynomial_read(void) {
  return SPI->CRCPR;
}



/* SPI Rx CRC register (RXCRCR) */
inline void spi_rx_crc_write(uint8_t crc) {
  SPI->RXCRCR = crc;
}

inline uint8_t spi_rx_crc_read(void) {
  return SPI->RXCRCR;
}



/* SPI Tx CRC register (TXCRCR) */
inline void spi_tx_crc_write(uint8_t crc) {
  SPI->TXCRCR = crc;
}

inline uint8_t spi_tx_crc_read(void) {
  return SPI->TXCRCR;
}


#endif