-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat Jun  6 23:24:57 2026
-- Host        : battery running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/resources/Course/FPGA/ORB-SoC/rtl/ip/line_buffer_dynamic/line_buffer_dynamic_stub.vhdl
-- Design      : line_buffer_dynamic
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity line_buffer_dynamic is
  Port ( 
    A : in STD_LOGIC_VECTOR ( 9 downto 0 );
    D : in STD_LOGIC_VECTOR ( 7 downto 0 );
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end line_buffer_dynamic;

architecture stub of line_buffer_dynamic is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "A[9:0],D[7:0],CLK,CE,Q[7:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "c_shift_ram_v12_0_13,Vivado 2019.1";
begin
end;
