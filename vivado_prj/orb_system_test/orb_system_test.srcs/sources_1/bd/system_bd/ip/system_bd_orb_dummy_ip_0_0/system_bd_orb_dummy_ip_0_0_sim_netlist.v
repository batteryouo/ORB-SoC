// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Jun  6 01:49:58 2026
// Host        : battery running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               e:/resources/Course/FPGA/ORB-SLAM3/vivado_prj/orb_system_test/orb_system_test.srcs/sources_1/bd/system_bd/ip/system_bd_orb_dummy_ip_0_0/system_bd_orb_dummy_ip_0_0_sim_netlist.v
// Design      : system_bd_orb_dummy_ip_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_bd_orb_dummy_ip_0_0,orb_dummy_ip,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "package_project" *) 
(* X_CORE_INFO = "orb_dummy_ip,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module system_bd_orb_dummy_ip_0_0
   (clk,
    resetn,
    axi_lite_start,
    s_axis_image_tdata,
    s_axis_image_tvalid,
    s_axis_image_tready,
    s_axis_image_tlast,
    m_axis_result_tdata,
    m_axis_result_tvalid,
    m_axis_result_tready,
    m_axis_result_tlast,
    irq_done);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axis_result:s_axis_image, ASSOCIATED_RESET resetn, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_bd_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 resetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input resetn;
  input axi_lite_start;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_image TDATA" *) input [7:0]s_axis_image_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_image TVALID" *) input s_axis_image_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_image TREADY" *) output s_axis_image_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis_image TLAST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axis_image, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_bd_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_image_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_result TDATA" *) output [31:0]m_axis_result_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_result TVALID" *) output m_axis_result_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_result TREADY" *) input m_axis_result_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_result TLAST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis_result, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_bd_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_result_tlast;
  output irq_done;

  wire \<const0> ;
  wire axi_lite_start;
  wire clk;
  wire irq_done;
  wire [31:0]\^m_axis_result_tdata ;
  wire m_axis_result_tlast;
  wire m_axis_result_tready;
  wire resetn;
  wire s_axis_image_tlast;
  wire s_axis_image_tready;
  wire s_axis_image_tvalid;

  assign m_axis_result_tdata[31] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[30] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[29] = \<const0> ;
  assign m_axis_result_tdata[28] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[27] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[26] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[25] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[24] = \<const0> ;
  assign m_axis_result_tdata[23] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[22] = \<const0> ;
  assign m_axis_result_tdata[21] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[20] = \<const0> ;
  assign m_axis_result_tdata[19] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[18] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[17] = \<const0> ;
  assign m_axis_result_tdata[16] = \^m_axis_result_tdata [31];
  assign m_axis_result_tdata[15:0] = \^m_axis_result_tdata [15:0];
  assign m_axis_result_tvalid = \^m_axis_result_tdata [31];
  GND GND
       (.G(\<const0> ));
  system_bd_orb_dummy_ip_0_0_orb_dummy_ip inst
       (.axi_lite_start(axi_lite_start),
        .clk(clk),
        .irq_done(irq_done),
        .m_axis_result_tdata({\^m_axis_result_tdata [31],\^m_axis_result_tdata [15:0]}),
        .m_axis_result_tlast(m_axis_result_tlast),
        .m_axis_result_tready(m_axis_result_tready),
        .resetn(resetn),
        .s_axis_image_tlast(s_axis_image_tlast),
        .s_axis_image_tready(s_axis_image_tready),
        .s_axis_image_tvalid(s_axis_image_tvalid));
endmodule

(* ORIG_REF_NAME = "orb_dummy_ip" *) 
module system_bd_orb_dummy_ip_0_0_orb_dummy_ip
   (m_axis_result_tlast,
    m_axis_result_tdata,
    irq_done,
    s_axis_image_tready,
    clk,
    resetn,
    m_axis_result_tready,
    axi_lite_start,
    s_axis_image_tlast,
    s_axis_image_tvalid);
  output m_axis_result_tlast;
  output [16:0]m_axis_result_tdata;
  output irq_done;
  output s_axis_image_tready;
  input clk;
  input resetn;
  input m_axis_result_tready;
  input axi_lite_start;
  input s_axis_image_tlast;
  input s_axis_image_tvalid;

  wire \FSM_sequential_current_state[1]_i_1_n_0 ;
  wire \FSM_sequential_current_state[1]_i_3_n_0 ;
  wire \FSM_sequential_current_state[1]_i_4_n_0 ;
  wire axi_lite_start;
  wire clk;
  wire [1:0]current_state;
  wire irq_done;
  wire [16:0]m_axis_result_tdata;
  wire m_axis_result_tlast;
  wire m_axis_result_tlast_INST_0_i_1_n_0;
  wire m_axis_result_tlast_INST_0_i_2_n_0;
  wire m_axis_result_tlast_INST_0_i_3_n_0;
  wire m_axis_result_tlast_INST_0_i_4_n_0;
  wire m_axis_result_tlast_INST_0_i_5_n_0;
  wire m_axis_result_tready;
  wire [1:0]next_state;
  wire resetn;
  wire result_word_count1;
  wire \result_word_count[0]_i_1_n_0 ;
  wire \result_word_count[0]_i_4_n_0 ;
  wire \result_word_count[0]_i_5_n_0 ;
  wire \result_word_count[0]_i_6_n_0 ;
  wire \result_word_count[0]_i_7_n_0 ;
  wire \result_word_count[12]_i_2_n_0 ;
  wire \result_word_count[12]_i_3_n_0 ;
  wire \result_word_count[12]_i_4_n_0 ;
  wire \result_word_count[12]_i_5_n_0 ;
  wire \result_word_count[4]_i_2_n_0 ;
  wire \result_word_count[4]_i_3_n_0 ;
  wire \result_word_count[4]_i_4_n_0 ;
  wire \result_word_count[4]_i_5_n_0 ;
  wire \result_word_count[8]_i_2_n_0 ;
  wire \result_word_count[8]_i_3_n_0 ;
  wire \result_word_count[8]_i_4_n_0 ;
  wire \result_word_count[8]_i_5_n_0 ;
  wire [15:0]result_word_count_reg;
  wire \result_word_count_reg[0]_i_2_n_0 ;
  wire \result_word_count_reg[0]_i_2_n_1 ;
  wire \result_word_count_reg[0]_i_2_n_2 ;
  wire \result_word_count_reg[0]_i_2_n_3 ;
  wire \result_word_count_reg[0]_i_2_n_4 ;
  wire \result_word_count_reg[0]_i_2_n_5 ;
  wire \result_word_count_reg[0]_i_2_n_6 ;
  wire \result_word_count_reg[0]_i_2_n_7 ;
  wire \result_word_count_reg[12]_i_1_n_1 ;
  wire \result_word_count_reg[12]_i_1_n_2 ;
  wire \result_word_count_reg[12]_i_1_n_3 ;
  wire \result_word_count_reg[12]_i_1_n_4 ;
  wire \result_word_count_reg[12]_i_1_n_5 ;
  wire \result_word_count_reg[12]_i_1_n_6 ;
  wire \result_word_count_reg[12]_i_1_n_7 ;
  wire \result_word_count_reg[4]_i_1_n_0 ;
  wire \result_word_count_reg[4]_i_1_n_1 ;
  wire \result_word_count_reg[4]_i_1_n_2 ;
  wire \result_word_count_reg[4]_i_1_n_3 ;
  wire \result_word_count_reg[4]_i_1_n_4 ;
  wire \result_word_count_reg[4]_i_1_n_5 ;
  wire \result_word_count_reg[4]_i_1_n_6 ;
  wire \result_word_count_reg[4]_i_1_n_7 ;
  wire \result_word_count_reg[8]_i_1_n_0 ;
  wire \result_word_count_reg[8]_i_1_n_1 ;
  wire \result_word_count_reg[8]_i_1_n_2 ;
  wire \result_word_count_reg[8]_i_1_n_3 ;
  wire \result_word_count_reg[8]_i_1_n_4 ;
  wire \result_word_count_reg[8]_i_1_n_5 ;
  wire \result_word_count_reg[8]_i_1_n_6 ;
  wire \result_word_count_reg[8]_i_1_n_7 ;
  wire s_axis_image_tlast;
  wire s_axis_image_tready;
  wire s_axis_image_tvalid;
  wire [3:3]\NLW_result_word_count_reg[12]_i_1_CO_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h00D5)) 
    \FSM_sequential_current_state[0]_i_1 
       (.I0(current_state[1]),
        .I1(m_axis_result_tlast_INST_0_i_1_n_0),
        .I2(m_axis_result_tready),
        .I3(current_state[0]),
        .O(next_state[0]));
  LUT6 #(
    .INIT(64'hFBFAEBEAEBEAEBEA)) 
    \FSM_sequential_current_state[1]_i_1 
       (.I0(\FSM_sequential_current_state[1]_i_4_n_0 ),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .I3(axi_lite_start),
        .I4(m_axis_result_tlast_INST_0_i_1_n_0),
        .I5(m_axis_result_tready),
        .O(\FSM_sequential_current_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h6222)) 
    \FSM_sequential_current_state[1]_i_2 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(m_axis_result_tready),
        .I3(m_axis_result_tlast_INST_0_i_1_n_0),
        .O(next_state[1]));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_sequential_current_state[1]_i_3 
       (.I0(resetn),
        .O(\FSM_sequential_current_state[1]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \FSM_sequential_current_state[1]_i_4 
       (.I0(current_state[0]),
        .I1(s_axis_image_tlast),
        .I2(s_axis_image_tvalid),
        .O(\FSM_sequential_current_state[1]_i_4_n_0 ));
  (* FSM_ENCODED_STATES = "DRAIN_IMAGE:01,SEND_RESULT:10,IDLE:00,DONE:11" *) 
  FDCE \FSM_sequential_current_state_reg[0] 
       (.C(clk),
        .CE(\FSM_sequential_current_state[1]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(next_state[0]),
        .Q(current_state[0]));
  (* FSM_ENCODED_STATES = "DRAIN_IMAGE:01,SEND_RESULT:10,IDLE:00,DONE:11" *) 
  FDCE \FSM_sequential_current_state_reg[1] 
       (.C(clk),
        .CE(\FSM_sequential_current_state[1]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(next_state[1]),
        .Q(current_state[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h8)) 
    irq_done_INST_0
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .O(irq_done));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[0]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[0]),
        .O(m_axis_result_tdata[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[10]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[10]),
        .O(m_axis_result_tdata[10]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[11]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[11]),
        .O(m_axis_result_tdata[11]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[12]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[12]),
        .O(m_axis_result_tdata[12]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[13]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[13]),
        .O(m_axis_result_tdata[13]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[14]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[14]),
        .O(m_axis_result_tdata[14]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[15]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[15]),
        .O(m_axis_result_tdata[15]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[1]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[1]),
        .O(m_axis_result_tdata[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[2]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[2]),
        .O(m_axis_result_tdata[2]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[3]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[3]),
        .O(m_axis_result_tdata[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[4]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[4]),
        .O(m_axis_result_tdata[4]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[5]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[5]),
        .O(m_axis_result_tdata[5]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[6]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[6]),
        .O(m_axis_result_tdata[6]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[7]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[7]),
        .O(m_axis_result_tdata[7]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[8]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[8]),
        .O(m_axis_result_tdata[8]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \m_axis_result_tdata[9]_INST_0 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(result_word_count_reg[9]),
        .O(m_axis_result_tdata[9]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h20)) 
    m_axis_result_tlast_INST_0
       (.I0(m_axis_result_tlast_INST_0_i_1_n_0),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .O(m_axis_result_tlast));
  LUT4 #(
    .INIT(16'h8000)) 
    m_axis_result_tlast_INST_0_i_1
       (.I0(m_axis_result_tlast_INST_0_i_2_n_0),
        .I1(m_axis_result_tlast_INST_0_i_3_n_0),
        .I2(m_axis_result_tlast_INST_0_i_4_n_0),
        .I3(m_axis_result_tlast_INST_0_i_5_n_0),
        .O(m_axis_result_tlast_INST_0_i_1_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    m_axis_result_tlast_INST_0_i_2
       (.I0(result_word_count_reg[15]),
        .I1(result_word_count_reg[14]),
        .I2(result_word_count_reg[13]),
        .I3(result_word_count_reg[12]),
        .O(m_axis_result_tlast_INST_0_i_2_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    m_axis_result_tlast_INST_0_i_3
       (.I0(result_word_count_reg[11]),
        .I1(result_word_count_reg[10]),
        .I2(result_word_count_reg[9]),
        .I3(result_word_count_reg[8]),
        .O(m_axis_result_tlast_INST_0_i_3_n_0));
  LUT4 #(
    .INIT(16'h0100)) 
    m_axis_result_tlast_INST_0_i_4
       (.I0(result_word_count_reg[7]),
        .I1(result_word_count_reg[6]),
        .I2(result_word_count_reg[4]),
        .I3(result_word_count_reg[5]),
        .O(m_axis_result_tlast_INST_0_i_4_n_0));
  LUT4 #(
    .INIT(16'h4000)) 
    m_axis_result_tlast_INST_0_i_5
       (.I0(result_word_count_reg[2]),
        .I1(result_word_count_reg[3]),
        .I2(result_word_count_reg[1]),
        .I3(result_word_count_reg[0]),
        .O(m_axis_result_tlast_INST_0_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    m_axis_result_tvalid_INST_0
       (.I0(current_state[1]),
        .I1(current_state[0]),
        .O(m_axis_result_tdata[16]));
  LUT3 #(
    .INIT(8'h31)) 
    \result_word_count[0]_i_1 
       (.I0(current_state[1]),
        .I1(current_state[0]),
        .I2(m_axis_result_tready),
        .O(\result_word_count[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h40)) 
    \result_word_count[0]_i_3 
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .I2(m_axis_result_tready),
        .O(result_word_count1));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[0]_i_4 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[3]),
        .O(\result_word_count[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[0]_i_5 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[2]),
        .O(\result_word_count[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[0]_i_6 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[1]),
        .O(\result_word_count[0]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h0040)) 
    \result_word_count[0]_i_7 
       (.I0(result_word_count_reg[0]),
        .I1(m_axis_result_tready),
        .I2(current_state[1]),
        .I3(current_state[0]),
        .O(\result_word_count[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[12]_i_2 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[15]),
        .O(\result_word_count[12]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[12]_i_3 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[14]),
        .O(\result_word_count[12]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[12]_i_4 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[13]),
        .O(\result_word_count[12]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[12]_i_5 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[12]),
        .O(\result_word_count[12]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[4]_i_2 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[7]),
        .O(\result_word_count[4]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[4]_i_3 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[6]),
        .O(\result_word_count[4]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[4]_i_4 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[5]),
        .O(\result_word_count[4]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[4]_i_5 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[4]),
        .O(\result_word_count[4]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[8]_i_2 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[11]),
        .O(\result_word_count[8]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[8]_i_3 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[10]),
        .O(\result_word_count[8]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[8]_i_4 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[9]),
        .O(\result_word_count[8]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \result_word_count[8]_i_5 
       (.I0(m_axis_result_tready),
        .I1(current_state[1]),
        .I2(current_state[0]),
        .I3(result_word_count_reg[8]),
        .O(\result_word_count[8]_i_5_n_0 ));
  FDCE \result_word_count_reg[0] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[0]_i_2_n_7 ),
        .Q(result_word_count_reg[0]));
  CARRY4 \result_word_count_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\result_word_count_reg[0]_i_2_n_0 ,\result_word_count_reg[0]_i_2_n_1 ,\result_word_count_reg[0]_i_2_n_2 ,\result_word_count_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,result_word_count1}),
        .O({\result_word_count_reg[0]_i_2_n_4 ,\result_word_count_reg[0]_i_2_n_5 ,\result_word_count_reg[0]_i_2_n_6 ,\result_word_count_reg[0]_i_2_n_7 }),
        .S({\result_word_count[0]_i_4_n_0 ,\result_word_count[0]_i_5_n_0 ,\result_word_count[0]_i_6_n_0 ,\result_word_count[0]_i_7_n_0 }));
  FDCE \result_word_count_reg[10] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[8]_i_1_n_5 ),
        .Q(result_word_count_reg[10]));
  FDCE \result_word_count_reg[11] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[8]_i_1_n_4 ),
        .Q(result_word_count_reg[11]));
  FDCE \result_word_count_reg[12] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[12]_i_1_n_7 ),
        .Q(result_word_count_reg[12]));
  CARRY4 \result_word_count_reg[12]_i_1 
       (.CI(\result_word_count_reg[8]_i_1_n_0 ),
        .CO({\NLW_result_word_count_reg[12]_i_1_CO_UNCONNECTED [3],\result_word_count_reg[12]_i_1_n_1 ,\result_word_count_reg[12]_i_1_n_2 ,\result_word_count_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\result_word_count_reg[12]_i_1_n_4 ,\result_word_count_reg[12]_i_1_n_5 ,\result_word_count_reg[12]_i_1_n_6 ,\result_word_count_reg[12]_i_1_n_7 }),
        .S({\result_word_count[12]_i_2_n_0 ,\result_word_count[12]_i_3_n_0 ,\result_word_count[12]_i_4_n_0 ,\result_word_count[12]_i_5_n_0 }));
  FDCE \result_word_count_reg[13] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[12]_i_1_n_6 ),
        .Q(result_word_count_reg[13]));
  FDCE \result_word_count_reg[14] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[12]_i_1_n_5 ),
        .Q(result_word_count_reg[14]));
  FDCE \result_word_count_reg[15] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[12]_i_1_n_4 ),
        .Q(result_word_count_reg[15]));
  FDCE \result_word_count_reg[1] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[0]_i_2_n_6 ),
        .Q(result_word_count_reg[1]));
  FDCE \result_word_count_reg[2] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[0]_i_2_n_5 ),
        .Q(result_word_count_reg[2]));
  FDCE \result_word_count_reg[3] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[0]_i_2_n_4 ),
        .Q(result_word_count_reg[3]));
  FDCE \result_word_count_reg[4] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[4]_i_1_n_7 ),
        .Q(result_word_count_reg[4]));
  CARRY4 \result_word_count_reg[4]_i_1 
       (.CI(\result_word_count_reg[0]_i_2_n_0 ),
        .CO({\result_word_count_reg[4]_i_1_n_0 ,\result_word_count_reg[4]_i_1_n_1 ,\result_word_count_reg[4]_i_1_n_2 ,\result_word_count_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\result_word_count_reg[4]_i_1_n_4 ,\result_word_count_reg[4]_i_1_n_5 ,\result_word_count_reg[4]_i_1_n_6 ,\result_word_count_reg[4]_i_1_n_7 }),
        .S({\result_word_count[4]_i_2_n_0 ,\result_word_count[4]_i_3_n_0 ,\result_word_count[4]_i_4_n_0 ,\result_word_count[4]_i_5_n_0 }));
  FDCE \result_word_count_reg[5] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[4]_i_1_n_6 ),
        .Q(result_word_count_reg[5]));
  FDCE \result_word_count_reg[6] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[4]_i_1_n_5 ),
        .Q(result_word_count_reg[6]));
  FDCE \result_word_count_reg[7] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[4]_i_1_n_4 ),
        .Q(result_word_count_reg[7]));
  FDCE \result_word_count_reg[8] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[8]_i_1_n_7 ),
        .Q(result_word_count_reg[8]));
  CARRY4 \result_word_count_reg[8]_i_1 
       (.CI(\result_word_count_reg[4]_i_1_n_0 ),
        .CO({\result_word_count_reg[8]_i_1_n_0 ,\result_word_count_reg[8]_i_1_n_1 ,\result_word_count_reg[8]_i_1_n_2 ,\result_word_count_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\result_word_count_reg[8]_i_1_n_4 ,\result_word_count_reg[8]_i_1_n_5 ,\result_word_count_reg[8]_i_1_n_6 ,\result_word_count_reg[8]_i_1_n_7 }),
        .S({\result_word_count[8]_i_2_n_0 ,\result_word_count[8]_i_3_n_0 ,\result_word_count[8]_i_4_n_0 ,\result_word_count[8]_i_5_n_0 }));
  FDCE \result_word_count_reg[9] 
       (.C(clk),
        .CE(\result_word_count[0]_i_1_n_0 ),
        .CLR(\FSM_sequential_current_state[1]_i_3_n_0 ),
        .D(\result_word_count_reg[8]_i_1_n_6 ),
        .Q(result_word_count_reg[9]));
  LUT2 #(
    .INIT(4'h2)) 
    s_axis_image_tready_INST_0
       (.I0(current_state[0]),
        .I1(current_state[1]),
        .O(s_axis_image_tready));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
