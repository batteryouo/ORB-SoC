// main.c
#include <stdio.h>
#include "xparameters.h"
#include "xaxidma.h"
#include "xil_cache.h"
#include "xil_printf.h"

typedef struct __attribute__((packed)) {
  uint16_t frame_id;
  uint16_t keypoint_count;
  uint32_t reserved;
} result_header_t;

typedef struct __attribute__((packed)) {
  int16_t x;
  int16_t y;
  uint16_t angle;
  uint8_t  octave;
  uint8_t  padding;
  uint32_t response;
  uint8_t  descriptor[32];
} keypoint_t;

#define IMAGE_BUF_ADDR  0x10000000
#define RESULT_BUF_ADDR 0x10100000
#define IMAGE_WIDTH   80
#define IMAGE_HEIGHT  60
#define IMAGE_BYTES   (IMAGE_WIDTH * IMAGE_HEIGHT)

XAxiDma AxiDma;

int main() {
  xil_printf("--- ORB-SLAM3 FPGA Hardware Test Start ---\r\n");

  XAxiDma_Config *CfgPtr = XAxiDma_LookupConfig(XPAR_AXI_DMA_0_DEVICE_ID);
  if (XAxiDma_CfgInitialize(&AxiDma, CfgPtr) != XST_SUCCESS) {
    xil_printf("DMA Init Failed!\r\n");
    return -1;
  }
  XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
  XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

  uint8_t *img_ptr = (uint8_t *)IMAGE_BUF_ADDR;
  for (int i = 0; i < IMAGE_BYTES; i++) {
    int x = i % IMAGE_WIDTH;
    int y = i / IMAGE_WIDTH;
    if (x >= 20 && x < 30 && y >= 20 && y < 30) {
      img_ptr[i] = 255; // White square
    } else {
      img_ptr[i] = 0;   // Black background
    }
  }
  memset((void*)RESULT_BUF_ADDR, 0, 1024 * 1024);

  // CRITICAL FIX: Flush both buffers to physical memory BEFORE DMA starts
  Xil_DCacheFlushRange((UINTPTR)RESULT_BUF_ADDR, 1024 * 1024);
  Xil_DCacheFlushRange((UINTPTR)IMAGE_BUF_ADDR, IMAGE_BYTES);

  xil_printf("Starting S2MM (Receive)...\r\n");
  XAxiDma_SimpleTransfer(&AxiDma, RESULT_BUF_ADDR, 1024 * 1024, XAXIDMA_DEVICE_TO_DMA);

  xil_printf("Starting MM2S (Send Image)...\r\n");
  XAxiDma_SimpleTransfer(&AxiDma, IMAGE_BUF_ADDR, IMAGE_BYTES, XAXIDMA_DMA_TO_DEVICE);

  while (XAxiDma_Busy(&AxiDma, XAXIDMA_DMA_TO_DEVICE)) { /* Wait */ }
  xil_printf("Image Send Complete.\r\n");

  while (XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA)) { /* Wait */ }
  xil_printf("Result Receive Complete.\r\n");

  Xil_DCacheInvalidateRange((UINTPTR)RESULT_BUF_ADDR, 1024 * 1024);

  xil_printf("\r\n=== Detection Results ===\r\n");
  uint32_t *raw_ptr = (uint32_t *)RESULT_BUF_ADDR;
  keypoint_t *kp;
  int kp_count = 0;
  
  while (*raw_ptr != 0xFFFFFFFF) {
    kp = (keypoint_t *)raw_ptr;
//    xil_printf("KP[%d]: X=%d, Y=%d, Score=%ld\r\n", kp_count, kp->x, kp->y, kp->response);
    xil_printf("KP[%d]: X=%d, Y=%d, AngleField=0x%04X, Score=%lu\r\n", kp_count, kp->x, kp->y, kp->angle, kp->response);

    kp_count++;
    raw_ptr += 11; // Skip 11 words (44 bytes) to next keypoint

    if (kp_count > 1000) {
      xil_printf("Error: Too many keypoints or missing EOF!\r\n");
      break;
    }
  }

  xil_printf("Total Keypoints Detected: %d\r\n", kp_count);
  xil_printf("------------------------------------------\r\n");

  return 0;
}
