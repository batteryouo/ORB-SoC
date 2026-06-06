// ORB Accelerator Control 
#include "orb_accelerator.h"
#include "xstatus.h"

int run_orb_accel(uint32_t img_addr, uint32_t img_len, uint32_t res_addr, uint32_t res_max_len) {
          
  int status;

  // Start S2MM transfer first (PL to DDR)
  // Setup DMA to be ready to receive the result from your ORB IP.
  status = XAxiDma_SimpleTransfer(&dma_orb, res_addr, res_max_len, XAXIDMA_DEVICE_TO_DMA);
  if (status != XST_SUCCESS) {
    // You can add print("Error S2MM\n") here for debugging
    return -1;
  }

  // Start MM2S transfer (DDR to PL)
  // Send the image data to your ORB IP.
  status = XAxiDma_SimpleTransfer(&dma_orb, img_addr, img_len, XAXIDMA_DMA_TO_DEVICE);
  if (status != XST_SUCCESS) {
    // You can add print("Error MM2S\n") here for debugging
    return -1;
  }

  // Wait for both transfers to complete (Polling mode)
  // Wait for image transmission to finish
  while (XAxiDma_Busy(&dma_orb, XAXIDMA_DMA_TO_DEVICE)) {
    // Idle loop waiting for MM2S done
  }
  
  // Wait for result reception to finish
  // This depends on the tlast signal from your ORB IP
  while (XAxiDma_Busy(&dma_orb, XAXIDMA_DEVICE_TO_DMA)) {
    // Idle loop waiting for S2MM done
  }

  return 0;
}