// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  6 01:49:58 2026
// Host        : battery running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/resources/Course/FPGA/ORB-SLAM3/vivado_prj/orb_system_test/orb_system_test.srcs/sources_1/bd/system_bd/ip/system_bd_orb_dummy_ip_0_0/system_bd_orb_dummy_ip_0_0_stub.v
// Design      : system_bd_orb_dummy_ip_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "orb_dummy_ip,Vivado 2019.1" *)
module system_bd_orb_dummy_ip_0_0(clk, resetn, axi_lite_start, 
  s_axis_image_tdata, s_axis_image_tvalid, s_axis_image_tready, s_axis_image_tlast, 
  m_axis_result_tdata, m_axis_result_tvalid, m_axis_result_tready, m_axis_result_tlast, 
  irq_done)
/* synthesis syn_black_box black_box_pad_pin="clk,resetn,axi_lite_start,s_axis_image_tdata[7:0],s_axis_image_tvalid,s_axis_image_tready,s_axis_image_tlast,m_axis_result_tdata[31:0],m_axis_result_tvalid,m_axis_result_tready,m_axis_result_tlast,irq_done" */;
  input clk;
  input resetn;
  input axi_lite_start;
  input [7:0]s_axis_image_tdata;
  input s_axis_image_tvalid;
  output s_axis_image_tready;
  input s_axis_image_tlast;
  output [31:0]m_axis_result_tdata;
  output m_axis_result_tvalid;
  input m_axis_result_tready;
  output m_axis_result_tlast;
  output irq_done;
endmodule
