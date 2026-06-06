//==============================================================================
// main.c - Phase 3 DMA + Dummy ORB IP Integration Test
//
// Test Flow:
//   1. Prepare a dummy image in DDR
//      (pattern: 0, 1, 2, ..., 255, 0, 1, ...)
//   2. Start DMA to send the image into the dummy ORB IP
//   3. DMA receives the dummy IP result back to DDR
//   4. Verify the result is:
//      {0xDEAD0000, 0xDEAD0001, ..., 0xDEAD002B}
//==============================================================================

#include <stdio.h>

#include "xparameters.h"
#include "xil_io.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "sleep.h"

#include "orb_accelerator.h"

// ── DDR memory map ───────────────────────────────────────────────────

#define IMAGE_BUF_ADDR    0x10000000U
#define IMAGE_BUF_SIZE    0x00100000U   // 1 MB

#define RESULT_BUF_ADDR   0x10100000U
#define RESULT_BUF_SIZE   0x00100000U   // 1 MB

// ── Test image parameters ────────────────────────────────────────────

#define IMAGE_WIDTH       160
#define IMAGE_HEIGHT      120
#define IMAGE_BYTES       (IMAGE_WIDTH * IMAGE_HEIGHT)

// ── Expected result ──────────────────────────────────────────────────

#define EXPECTED_WORDS    44
#define EXPECTED_PATTERN  0xDEAD0000

// ── Convenient pointers ──────────────────────────────────────────────

volatile uint8_t *img_buf = (volatile uint8_t *)IMAGE_BUF_ADDR;
volatile uint32_t *res_buf = (volatile uint32_t *)RESULT_BUF_ADDR;

//=============================================================================
// Prepare test image
//=============================================================================

static void prepare_test_image(void) {
  xil_printf( "Preparing test image (%d bytes)...\r\n", IMAGE_BYTES );

  for (int i = 0; i < IMAGE_BYTES; i++) {
    img_buf[i] = (uint8_t)(i & 0xFF);
  }

  // Flush cache to DDR so DMA can access updated data
  Xil_DCacheFlushRange( (INTPTR)IMAGE_BUF_ADDR, IMAGE_BYTES );

  xil_printf("Image prepared. First bytes: %02X %02X %02X %02X ...\r\n",
             img_buf[0], img_buf[1], img_buf[2], img_buf[3]);
}

//=============================================================================
// Clear result buffer
//=============================================================================

static void clear_result_buffer(void) {
  for (int i = 0; i < EXPECTED_WORDS; i++) {
    res_buf[i] = 0xFFFFFFFFU;
  }

  Xil_DCacheFlushRange((INTPTR)RESULT_BUF_ADDR, EXPECTED_WORDS * 4);
}

//=============================================================================
// Verify result
//=============================================================================

static int verify_result(void) {

  // Invalidate cache before reading DDR
  // to ensure DMA-written data is visible
  Xil_DCacheInvalidateRange((INTPTR)RESULT_BUF_ADDR, EXPECTED_WORDS * 4);

  xil_printf(
    "\r\n=== Result Verification ===\r\n"
  );

  int errors = 0;

  for (int i = 0; i < EXPECTED_WORDS; i++) {

    uint32_t expected =
      EXPECTED_PATTERN | (uint32_t)i;

    uint32_t actual =
      res_buf[i];

    if (actual == expected) {
      xil_printf("  [%2d] 0x%08X  OK\r\n", i, actual);
    } 
    else {

      xil_printf("  [%2d] 0x%08X  EXPECTED 0x%08X  *** MISMATCH ***\r\n",
                 i, actual, expected);
      errors++;
    }
  }

  return errors;
}

//=============================================================================
// Main
//=============================================================================

int main(void) {

  xil_printf("\r\n");
  xil_printf("=================================================\r\n");
  xil_printf("  Phase 3: DMA + Dummy ORB IP Integration Test  \r\n");
  xil_printf("=================================================\r\n");
    

  // Step 1: Initialize AXI DMA
  xil_printf("\r\n[1] Initializing AXI DMA...\r\n");

  if (init_orb_dma() != 0) {
    xil_printf("    DMA init FAILED, halt.\r\n");
    return -1;
  }

  xil_printf("    DMA init OK\r\n");

  // Step 2: Prepare test image
  xil_printf("\r\n[2] Preparing test image...\r\n");
  prepare_test_image();

  // Step 3: Clear result buffer
  xil_printf("\r\n[3] Clearing result buffer...\r\n");
  clear_result_buffer();

  // Step 4: Start DMA transfer
  xil_printf("\r\n[4] Starting DMA transfer (image -> IP -> result)...\r\n");

  int ret = run_orb_accel(IMAGE_BUF_ADDR, IMAGE_BYTES,
                          RESULT_BUF_ADDR, RESULT_BUF_SIZE);

  if (ret != 0) {
    xil_printf( "    DMA transfer failed, halt.\r\n" );
    return -1;
  }

  xil_printf( "    DMA transfer completed\r\n" );

  // Verification
  int errors = verify_result();
  xil_printf( "\r\n=================================================\r\n" );

  if (errors == 0) {
    xil_printf("  ALL %d WORDS MATCHED. TEST PASSED.\r\n", EXPECTED_WORDS );
  }
  else {
    xil_printf( "  %d / %d WORDS MISMATCHED. TEST FAILED.\r\n", errors, EXPECTED_WORDS );
  }
  xil_printf("=================================================\r\n");

  while (1) {
    sleep(1);
  }

  return 0;
}