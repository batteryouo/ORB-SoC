-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Jun  8 03:25:53 2026
-- Host        : battery running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               E:/resources/Course/FPGA/ORB-SoC/vivado_prj/orb_system_test/orb_system_test.srcs/sources_1/bd/system_bd/ip/system_bd_orb_accelerator_top_0_3/system_bd_orb_accelerator_top_0_3_stub.vhdl
-- Design      : system_bd_orb_accelerator_top_0_3
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_bd_orb_accelerator_top_0_3 is
  Port ( 
    clk : in STD_LOGIC;
    resetn : in STD_LOGIC;
    image_width : in STD_LOGIC_VECTOR ( 15 downto 0 );
    image_height : in STD_LOGIC_VECTOR ( 15 downto 0 );
    threshold : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tlast : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tlast : out STD_LOGIC;
    irq_done : out STD_LOGIC
  );

end system_bd_orb_accelerator_top_0_3;

architecture stub of system_bd_orb_accelerator_top_0_3 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,resetn,image_width[15:0],image_height[15:0],threshold[7:0],s_axis_tdata[7:0],s_axis_tvalid,s_axis_tready,s_axis_tlast,m_axis_tdata[31:0],m_axis_tkeep[3:0],m_axis_tvalid,m_axis_tready,m_axis_tlast,irq_done";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "orb_accelerator_top,Vivado 2019.1";
begin
end;
