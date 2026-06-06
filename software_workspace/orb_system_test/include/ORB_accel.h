// ORB Accelerator Control 
#ifndef ORB_ACCELERATOR_H
#define ORB_ACCELERATOR_H

#include <stdint.h>
#include "xaxidma.h"

int run_orb_accel(uint32_t img_addr, uint32_t img_len, uint32_t res_addr, uint32_t res_max_len);

#endif