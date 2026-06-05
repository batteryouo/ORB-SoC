-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat Jun  6 01:49:58 2026
-- Host        : battery running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               e:/resources/Course/FPGA/ORB-SLAM3/vivado_prj/orb_system_test/orb_system_test.srcs/sources_1/bd/system_bd/ip/system_bd_orb_dummy_ip_0_0/system_bd_orb_dummy_ip_0_0_sim_netlist.vhdl
-- Design      : system_bd_orb_dummy_ip_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_bd_orb_dummy_ip_0_0_orb_dummy_ip is
  port (
    m_axis_result_tlast : out STD_LOGIC;
    m_axis_result_tdata : out STD_LOGIC_VECTOR ( 16 downto 0 );
    irq_done : out STD_LOGIC;
    s_axis_image_tready : out STD_LOGIC;
    clk : in STD_LOGIC;
    resetn : in STD_LOGIC;
    m_axis_result_tready : in STD_LOGIC;
    axi_lite_start : in STD_LOGIC;
    s_axis_image_tlast : in STD_LOGIC;
    s_axis_image_tvalid : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_bd_orb_dummy_ip_0_0_orb_dummy_ip : entity is "orb_dummy_ip";
end system_bd_orb_dummy_ip_0_0_orb_dummy_ip;

architecture STRUCTURE of system_bd_orb_dummy_ip_0_0_orb_dummy_ip is
  signal \FSM_sequential_current_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_current_state[1]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_current_state[1]_i_4_n_0\ : STD_LOGIC;
  signal current_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m_axis_result_tlast_INST_0_i_1_n_0 : STD_LOGIC;
  signal m_axis_result_tlast_INST_0_i_2_n_0 : STD_LOGIC;
  signal m_axis_result_tlast_INST_0_i_3_n_0 : STD_LOGIC;
  signal m_axis_result_tlast_INST_0_i_4_n_0 : STD_LOGIC;
  signal m_axis_result_tlast_INST_0_i_5_n_0 : STD_LOGIC;
  signal next_state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal result_word_count1 : STD_LOGIC;
  signal \result_word_count[0]_i_1_n_0\ : STD_LOGIC;
  signal \result_word_count[0]_i_4_n_0\ : STD_LOGIC;
  signal \result_word_count[0]_i_5_n_0\ : STD_LOGIC;
  signal \result_word_count[0]_i_6_n_0\ : STD_LOGIC;
  signal \result_word_count[0]_i_7_n_0\ : STD_LOGIC;
  signal \result_word_count[12]_i_2_n_0\ : STD_LOGIC;
  signal \result_word_count[12]_i_3_n_0\ : STD_LOGIC;
  signal \result_word_count[12]_i_4_n_0\ : STD_LOGIC;
  signal \result_word_count[12]_i_5_n_0\ : STD_LOGIC;
  signal \result_word_count[4]_i_2_n_0\ : STD_LOGIC;
  signal \result_word_count[4]_i_3_n_0\ : STD_LOGIC;
  signal \result_word_count[4]_i_4_n_0\ : STD_LOGIC;
  signal \result_word_count[4]_i_5_n_0\ : STD_LOGIC;
  signal \result_word_count[8]_i_2_n_0\ : STD_LOGIC;
  signal \result_word_count[8]_i_3_n_0\ : STD_LOGIC;
  signal \result_word_count[8]_i_4_n_0\ : STD_LOGIC;
  signal \result_word_count[8]_i_5_n_0\ : STD_LOGIC;
  signal result_word_count_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \result_word_count_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \result_word_count_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \result_word_count_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \result_word_count_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \result_word_count_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \result_word_count_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \result_word_count_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \result_word_count_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \result_word_count_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \result_word_count_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \result_word_count_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \result_word_count_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \result_word_count_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \result_word_count_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \result_word_count_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \result_word_count_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \result_word_count_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \result_word_count_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \result_word_count_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \result_word_count_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \result_word_count_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \result_word_count_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \result_word_count_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \result_word_count_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \result_word_count_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \result_word_count_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \result_word_count_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \result_word_count_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \result_word_count_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \result_word_count_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \result_word_count_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \NLW_result_word_count_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_current_state[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \FSM_sequential_current_state[1]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \FSM_sequential_current_state[1]_i_4\ : label is "soft_lutpair10";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_current_state_reg[0]\ : label is "DRAIN_IMAGE:01,SEND_RESULT:10,IDLE:00,DONE:11";
  attribute FSM_ENCODED_STATES of \FSM_sequential_current_state_reg[1]\ : label is "DRAIN_IMAGE:01,SEND_RESULT:10,IDLE:00,DONE:11";
  attribute SOFT_HLUTNM of irq_done_INST_0 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[0]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[10]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[11]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[12]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[13]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[14]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[15]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[1]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[2]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[3]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[4]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[5]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[6]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[7]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[8]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \m_axis_result_tdata[9]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of m_axis_result_tlast_INST_0 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of m_axis_result_tvalid_INST_0 : label is "soft_lutpair9";
begin
\FSM_sequential_current_state[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00D5"
    )
        port map (
      I0 => current_state(1),
      I1 => m_axis_result_tlast_INST_0_i_1_n_0,
      I2 => m_axis_result_tready,
      I3 => current_state(0),
      O => next_state(0)
    );
\FSM_sequential_current_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFAEBEAEBEAEBEA"
    )
        port map (
      I0 => \FSM_sequential_current_state[1]_i_4_n_0\,
      I1 => current_state(0),
      I2 => current_state(1),
      I3 => axi_lite_start,
      I4 => m_axis_result_tlast_INST_0_i_1_n_0,
      I5 => m_axis_result_tready,
      O => \FSM_sequential_current_state[1]_i_1_n_0\
    );
\FSM_sequential_current_state[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6222"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => m_axis_result_tready,
      I3 => m_axis_result_tlast_INST_0_i_1_n_0,
      O => next_state(1)
    );
\FSM_sequential_current_state[1]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => resetn,
      O => \FSM_sequential_current_state[1]_i_3_n_0\
    );
\FSM_sequential_current_state[1]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => current_state(0),
      I1 => s_axis_image_tlast,
      I2 => s_axis_image_tvalid,
      O => \FSM_sequential_current_state[1]_i_4_n_0\
    );
\FSM_sequential_current_state_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_sequential_current_state[1]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => next_state(0),
      Q => current_state(0)
    );
\FSM_sequential_current_state_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \FSM_sequential_current_state[1]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => next_state(1),
      Q => current_state(1)
    );
irq_done_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      O => irq_done
    );
\m_axis_result_tdata[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(0),
      O => m_axis_result_tdata(0)
    );
\m_axis_result_tdata[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(10),
      O => m_axis_result_tdata(10)
    );
\m_axis_result_tdata[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(11),
      O => m_axis_result_tdata(11)
    );
\m_axis_result_tdata[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(12),
      O => m_axis_result_tdata(12)
    );
\m_axis_result_tdata[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(13),
      O => m_axis_result_tdata(13)
    );
\m_axis_result_tdata[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(14),
      O => m_axis_result_tdata(14)
    );
\m_axis_result_tdata[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(15),
      O => m_axis_result_tdata(15)
    );
\m_axis_result_tdata[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(1),
      O => m_axis_result_tdata(1)
    );
\m_axis_result_tdata[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(2),
      O => m_axis_result_tdata(2)
    );
\m_axis_result_tdata[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(3),
      O => m_axis_result_tdata(3)
    );
\m_axis_result_tdata[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(4),
      O => m_axis_result_tdata(4)
    );
\m_axis_result_tdata[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(5),
      O => m_axis_result_tdata(5)
    );
\m_axis_result_tdata[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(6),
      O => m_axis_result_tdata(6)
    );
\m_axis_result_tdata[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(7),
      O => m_axis_result_tdata(7)
    );
\m_axis_result_tdata[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(8),
      O => m_axis_result_tdata(8)
    );
\m_axis_result_tdata[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => result_word_count_reg(9),
      O => m_axis_result_tdata(9)
    );
m_axis_result_tlast_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => m_axis_result_tlast_INST_0_i_1_n_0,
      I1 => current_state(0),
      I2 => current_state(1),
      O => m_axis_result_tlast
    );
m_axis_result_tlast_INST_0_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => m_axis_result_tlast_INST_0_i_2_n_0,
      I1 => m_axis_result_tlast_INST_0_i_3_n_0,
      I2 => m_axis_result_tlast_INST_0_i_4_n_0,
      I3 => m_axis_result_tlast_INST_0_i_5_n_0,
      O => m_axis_result_tlast_INST_0_i_1_n_0
    );
m_axis_result_tlast_INST_0_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => result_word_count_reg(15),
      I1 => result_word_count_reg(14),
      I2 => result_word_count_reg(13),
      I3 => result_word_count_reg(12),
      O => m_axis_result_tlast_INST_0_i_2_n_0
    );
m_axis_result_tlast_INST_0_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => result_word_count_reg(11),
      I1 => result_word_count_reg(10),
      I2 => result_word_count_reg(9),
      I3 => result_word_count_reg(8),
      O => m_axis_result_tlast_INST_0_i_3_n_0
    );
m_axis_result_tlast_INST_0_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => result_word_count_reg(7),
      I1 => result_word_count_reg(6),
      I2 => result_word_count_reg(4),
      I3 => result_word_count_reg(5),
      O => m_axis_result_tlast_INST_0_i_4_n_0
    );
m_axis_result_tlast_INST_0_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => result_word_count_reg(2),
      I1 => result_word_count_reg(3),
      I2 => result_word_count_reg(1),
      I3 => result_word_count_reg(0),
      O => m_axis_result_tlast_INST_0_i_5_n_0
    );
m_axis_result_tvalid_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => current_state(1),
      I1 => current_state(0),
      O => m_axis_result_tdata(16)
    );
\result_word_count[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"31"
    )
        port map (
      I0 => current_state(1),
      I1 => current_state(0),
      I2 => m_axis_result_tready,
      O => \result_word_count[0]_i_1_n_0\
    );
\result_word_count[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      I2 => m_axis_result_tready,
      O => result_word_count1
    );
\result_word_count[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(3),
      O => \result_word_count[0]_i_4_n_0\
    );
\result_word_count[0]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(2),
      O => \result_word_count[0]_i_5_n_0\
    );
\result_word_count[0]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(1),
      O => \result_word_count[0]_i_6_n_0\
    );
\result_word_count[0]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => result_word_count_reg(0),
      I1 => m_axis_result_tready,
      I2 => current_state(1),
      I3 => current_state(0),
      O => \result_word_count[0]_i_7_n_0\
    );
\result_word_count[12]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(15),
      O => \result_word_count[12]_i_2_n_0\
    );
\result_word_count[12]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(14),
      O => \result_word_count[12]_i_3_n_0\
    );
\result_word_count[12]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(13),
      O => \result_word_count[12]_i_4_n_0\
    );
\result_word_count[12]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(12),
      O => \result_word_count[12]_i_5_n_0\
    );
\result_word_count[4]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(7),
      O => \result_word_count[4]_i_2_n_0\
    );
\result_word_count[4]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(6),
      O => \result_word_count[4]_i_3_n_0\
    );
\result_word_count[4]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(5),
      O => \result_word_count[4]_i_4_n_0\
    );
\result_word_count[4]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(4),
      O => \result_word_count[4]_i_5_n_0\
    );
\result_word_count[8]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(11),
      O => \result_word_count[8]_i_2_n_0\
    );
\result_word_count[8]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(10),
      O => \result_word_count[8]_i_3_n_0\
    );
\result_word_count[8]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(9),
      O => \result_word_count[8]_i_4_n_0\
    );
\result_word_count[8]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => m_axis_result_tready,
      I1 => current_state(1),
      I2 => current_state(0),
      I3 => result_word_count_reg(8),
      O => \result_word_count[8]_i_5_n_0\
    );
\result_word_count_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[0]_i_2_n_7\,
      Q => result_word_count_reg(0)
    );
\result_word_count_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \result_word_count_reg[0]_i_2_n_0\,
      CO(2) => \result_word_count_reg[0]_i_2_n_1\,
      CO(1) => \result_word_count_reg[0]_i_2_n_2\,
      CO(0) => \result_word_count_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => result_word_count1,
      O(3) => \result_word_count_reg[0]_i_2_n_4\,
      O(2) => \result_word_count_reg[0]_i_2_n_5\,
      O(1) => \result_word_count_reg[0]_i_2_n_6\,
      O(0) => \result_word_count_reg[0]_i_2_n_7\,
      S(3) => \result_word_count[0]_i_4_n_0\,
      S(2) => \result_word_count[0]_i_5_n_0\,
      S(1) => \result_word_count[0]_i_6_n_0\,
      S(0) => \result_word_count[0]_i_7_n_0\
    );
\result_word_count_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[8]_i_1_n_5\,
      Q => result_word_count_reg(10)
    );
\result_word_count_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[8]_i_1_n_4\,
      Q => result_word_count_reg(11)
    );
\result_word_count_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[12]_i_1_n_7\,
      Q => result_word_count_reg(12)
    );
\result_word_count_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \result_word_count_reg[8]_i_1_n_0\,
      CO(3) => \NLW_result_word_count_reg[12]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \result_word_count_reg[12]_i_1_n_1\,
      CO(1) => \result_word_count_reg[12]_i_1_n_2\,
      CO(0) => \result_word_count_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \result_word_count_reg[12]_i_1_n_4\,
      O(2) => \result_word_count_reg[12]_i_1_n_5\,
      O(1) => \result_word_count_reg[12]_i_1_n_6\,
      O(0) => \result_word_count_reg[12]_i_1_n_7\,
      S(3) => \result_word_count[12]_i_2_n_0\,
      S(2) => \result_word_count[12]_i_3_n_0\,
      S(1) => \result_word_count[12]_i_4_n_0\,
      S(0) => \result_word_count[12]_i_5_n_0\
    );
\result_word_count_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[12]_i_1_n_6\,
      Q => result_word_count_reg(13)
    );
\result_word_count_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[12]_i_1_n_5\,
      Q => result_word_count_reg(14)
    );
\result_word_count_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[12]_i_1_n_4\,
      Q => result_word_count_reg(15)
    );
\result_word_count_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[0]_i_2_n_6\,
      Q => result_word_count_reg(1)
    );
\result_word_count_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[0]_i_2_n_5\,
      Q => result_word_count_reg(2)
    );
\result_word_count_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[0]_i_2_n_4\,
      Q => result_word_count_reg(3)
    );
\result_word_count_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[4]_i_1_n_7\,
      Q => result_word_count_reg(4)
    );
\result_word_count_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \result_word_count_reg[0]_i_2_n_0\,
      CO(3) => \result_word_count_reg[4]_i_1_n_0\,
      CO(2) => \result_word_count_reg[4]_i_1_n_1\,
      CO(1) => \result_word_count_reg[4]_i_1_n_2\,
      CO(0) => \result_word_count_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \result_word_count_reg[4]_i_1_n_4\,
      O(2) => \result_word_count_reg[4]_i_1_n_5\,
      O(1) => \result_word_count_reg[4]_i_1_n_6\,
      O(0) => \result_word_count_reg[4]_i_1_n_7\,
      S(3) => \result_word_count[4]_i_2_n_0\,
      S(2) => \result_word_count[4]_i_3_n_0\,
      S(1) => \result_word_count[4]_i_4_n_0\,
      S(0) => \result_word_count[4]_i_5_n_0\
    );
\result_word_count_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[4]_i_1_n_6\,
      Q => result_word_count_reg(5)
    );
\result_word_count_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[4]_i_1_n_5\,
      Q => result_word_count_reg(6)
    );
\result_word_count_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[4]_i_1_n_4\,
      Q => result_word_count_reg(7)
    );
\result_word_count_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[8]_i_1_n_7\,
      Q => result_word_count_reg(8)
    );
\result_word_count_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \result_word_count_reg[4]_i_1_n_0\,
      CO(3) => \result_word_count_reg[8]_i_1_n_0\,
      CO(2) => \result_word_count_reg[8]_i_1_n_1\,
      CO(1) => \result_word_count_reg[8]_i_1_n_2\,
      CO(0) => \result_word_count_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \result_word_count_reg[8]_i_1_n_4\,
      O(2) => \result_word_count_reg[8]_i_1_n_5\,
      O(1) => \result_word_count_reg[8]_i_1_n_6\,
      O(0) => \result_word_count_reg[8]_i_1_n_7\,
      S(3) => \result_word_count[8]_i_2_n_0\,
      S(2) => \result_word_count[8]_i_3_n_0\,
      S(1) => \result_word_count[8]_i_4_n_0\,
      S(0) => \result_word_count[8]_i_5_n_0\
    );
\result_word_count_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \result_word_count[0]_i_1_n_0\,
      CLR => \FSM_sequential_current_state[1]_i_3_n_0\,
      D => \result_word_count_reg[8]_i_1_n_6\,
      Q => result_word_count_reg(9)
    );
s_axis_image_tready_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => current_state(0),
      I1 => current_state(1),
      O => s_axis_image_tready
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_bd_orb_dummy_ip_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of system_bd_orb_dummy_ip_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of system_bd_orb_dummy_ip_0_0 : entity is "system_bd_orb_dummy_ip_0_0,orb_dummy_ip,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of system_bd_orb_dummy_ip_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of system_bd_orb_dummy_ip_0_0 : entity is "package_project";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of system_bd_orb_dummy_ip_0_0 : entity is "orb_dummy_ip,Vivado 2019.1";
end system_bd_orb_dummy_ip_0_0;

architecture STRUCTURE of system_bd_orb_dummy_ip_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^m_axis_result_tdata\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axis_result:s_axis_image, ASSOCIATED_RESET resetn, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_bd_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_result_tlast : signal is "xilinx.com:interface:axis:1.0 m_axis_result TLAST";
  attribute X_INTERFACE_PARAMETER of m_axis_result_tlast : signal is "XIL_INTERFACENAME m_axis_result, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_bd_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_result_tready : signal is "xilinx.com:interface:axis:1.0 m_axis_result TREADY";
  attribute X_INTERFACE_INFO of m_axis_result_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis_result TVALID";
  attribute X_INTERFACE_INFO of resetn : signal is "xilinx.com:signal:reset:1.0 resetn RST";
  attribute X_INTERFACE_PARAMETER of resetn : signal is "XIL_INTERFACENAME resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_image_tlast : signal is "xilinx.com:interface:axis:1.0 s_axis_image TLAST";
  attribute X_INTERFACE_PARAMETER of s_axis_image_tlast : signal is "XIL_INTERFACENAME s_axis_image, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_bd_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axis_image_tready : signal is "xilinx.com:interface:axis:1.0 s_axis_image TREADY";
  attribute X_INTERFACE_INFO of s_axis_image_tvalid : signal is "xilinx.com:interface:axis:1.0 s_axis_image TVALID";
  attribute X_INTERFACE_INFO of m_axis_result_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis_result TDATA";
  attribute X_INTERFACE_INFO of s_axis_image_tdata : signal is "xilinx.com:interface:axis:1.0 s_axis_image TDATA";
begin
  m_axis_result_tdata(31) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(30) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(29) <= \<const0>\;
  m_axis_result_tdata(28) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(27) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(26) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(25) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(24) <= \<const0>\;
  m_axis_result_tdata(23) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(22) <= \<const0>\;
  m_axis_result_tdata(21) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(20) <= \<const0>\;
  m_axis_result_tdata(19) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(18) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(17) <= \<const0>\;
  m_axis_result_tdata(16) <= \^m_axis_result_tdata\(31);
  m_axis_result_tdata(15 downto 0) <= \^m_axis_result_tdata\(15 downto 0);
  m_axis_result_tvalid <= \^m_axis_result_tdata\(31);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.system_bd_orb_dummy_ip_0_0_orb_dummy_ip
     port map (
      axi_lite_start => axi_lite_start,
      clk => clk,
      irq_done => irq_done,
      m_axis_result_tdata(16) => \^m_axis_result_tdata\(31),
      m_axis_result_tdata(15 downto 0) => \^m_axis_result_tdata\(15 downto 0),
      m_axis_result_tlast => m_axis_result_tlast,
      m_axis_result_tready => m_axis_result_tready,
      resetn => resetn,
      s_axis_image_tlast => s_axis_image_tlast,
      s_axis_image_tready => s_axis_image_tready,
      s_axis_image_tvalid => s_axis_image_tvalid
    );
end STRUCTURE;
