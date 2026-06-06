// ORB Accelerator Control 
#include "orb_accelerator.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xil_printf.h"

XAxiDma dma_orb;  // global DMA instance

int init_orb_dma(void){
  XAxiDma_Config *cfg;
  int status;
  
  // Find XPAR_AXI_DMA_0_DEVICE_ID in xparameters.h
  cfg = XAxiDma_LookupConfig(XPAR_AXI_DMA_0_DEVICE_ID);
  if (!cfg) {
    xil_printf("[ERR] XAxiDma_LookupConfig failed\r\n");
    return XST_FAILURE;
  }
  
  status = XAxiDma_CfgInitialize(&dma_orb, cfg);
  if (status != XST_SUCCESS) {
    xil_printf("[ERR] XAxiDma_CfgInitialize failed (%d)\r\n", status);
    return XST_FAILURE;
  }
  
  // check if not Scatter-Gather mode
  if (XAxiDma_HasSg(&dma_orb)) {
    xil_printf("[ERR] DMA is in SG mode, expected simple mode\r\n");
    return XST_FAILURE;
  }
  
  // Trun off Interrupt (Testing for polling mode)
  XAxiDma_IntrDisable(&dma_orb, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
  XAxiDma_IntrDisable(&dma_orb, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);
  
  return XST_SUCCESS;
}
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