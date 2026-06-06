// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Jun  7 03:32:46 2026
// Host        : battery running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/resources/Course/FPGA/ORB-SoC/vivado_prj/orb_system_test/orb_system_test.srcs/sources_1/bd/system_bd/ip/system_bd_orb_accelerator_top_0_0/system_bd_orb_accelerator_top_0_0_stub.v
// Design      : system_bd_orb_accelerator_top_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "orb_accelerator_top,Vivado 2019.1" *)
module system_bd_orb_accelerator_top_0_0(clk, resetn, image_width, threshold, 
  s_axis_tdata, s_axis_tvalid, s_axis_tready, s_axis_tlast, m_axis_tdata, m_axis_tvalid, 
  m_axis_tready, m_axis_tlast, irq_done)
/* synthesis syn_black_box black_box_pad_pin="clk,resetn,image_width[15:0],threshold[7:0],s_axis_tdata[7:0],s_axis_tvalid,s_axis_tready,s_axis_tlast,m_axis_tdata[31:0],m_axis_tvalid,m_axis_tready,m_axis_tlast,irq_done" */;
  input clk;
  input resetn;
  input [15:0]image_width;
  input [7:0]threshold;
  input [7:0]s_axis_tdata;
  input s_axis_tvalid;
  output s_axis_tready;
  input s_axis_tlast;
  output [31:0]m_axis_tdata;
  output m_axis_tvalid;
  input m_axis_tready;
  output m_axis_tlast;
  output irq_done;
endmodule
