-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat Jun  6 01:49:58 2026
-- Host        : battery running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/resources/Course/FPGA/ORB-SLAM3/vivado_prj/orb_system_test/orb_system_test.srcs/sources_1/bd/system_bd/ip/system_bd_orb_dummy_ip_0_0/system_bd_orb_dummy_ip_0_0_stub.vhdl
-- Design      : system_bd_orb_dummy_ip_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_bd_orb_dummy_ip_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    resetn : in STD_LOGIC;
    axi_lite_start : in STD_LOGIC;
    s_axis_image_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_image_tvalid : in STD_LOGIC;
    s_axis_image_tready : out STD_LOGIC;
    s_axis_image_tlast : in STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_result_tvalid : out STD_LOGIC;
    m_axis_result_tready : in STD_LOGIC;
    m_axis_result_tlast : out STD_LOGIC;
    irq_done : out STD_LOGIC
  );

end system_bd_orb_dummy_ip_0_0;

architecture stub of system_bd_orb_dummy_ip_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,resetn,axi_lite_start,s_axis_image_tdata[7:0],s_axis_image_tvalid,s_axis_image_tready,s_axis_image_tlast,m_axis_result_tdata[31:0],m_axis_result_tvalid,m_axis_result_tready,m_axis_result_tlast,irq_done";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "orb_dummy_ip,Vivado 2019.1";
begin
end;
