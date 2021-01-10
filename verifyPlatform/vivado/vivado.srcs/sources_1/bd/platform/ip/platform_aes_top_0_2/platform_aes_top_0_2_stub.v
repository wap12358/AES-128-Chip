// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Jan 10 14:07:49 2021
// Host        : MSI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               f:/OneDrive/Study/IC2/AES-128-with-an-Instruction-Set/verifyPlatform/vivado/vivado.srcs/sources_1/bd/platform/ip/platform_aes_top_0_2/platform_aes_top_0_2_stub.v
// Design      : platform_aes_top_0_2
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "aes_top,Vivado 2018.3" *)
module platform_aes_top_0_2(clk, config_pin, rx, tx)
/* synthesis syn_black_box black_box_pad_pin="clk,config_pin[2:0],rx[8:0],tx[8:0]" */;
  input clk;
  input [2:0]config_pin;
  input [8:0]rx;
  output [8:0]tx;
endmodule
