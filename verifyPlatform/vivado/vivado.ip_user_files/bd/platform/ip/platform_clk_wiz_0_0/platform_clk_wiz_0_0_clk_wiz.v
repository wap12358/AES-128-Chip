
// file: platform_clk_wiz_0_0.v
// 
// (c) Copyright 2008 - 2013 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
//----------------------------------------------------------------------------
// User entered comments
//----------------------------------------------------------------------------
// None
//
//----------------------------------------------------------------------------
//  Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
//   Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
//----------------------------------------------------------------------------
// clk_aes_tx____10.000______0.000______50.0______302.332____155.540
// clk_aes_chip____50.000______0.000______50.0______213.504____155.540
//
//----------------------------------------------------------------------------
// Input Clock   Freq (MHz)    Input Jitter (UI)
//----------------------------------------------------------------------------
// __primary__________50.000____________0.010

`timescale 1ps/1ps

module platform_clk_wiz_0_0_clk_wiz 

 (// Clock in ports
  // Clock out ports
  output        clk_aes_tx,
  output        clk_aes_chip,
  // Dynamic reconfiguration ports
  input   [6:0] daddr,
  input         dclk,
  input         den,
  input  [15:0] din,
  output [15:0] dout,
  output        drdy,
  input         dwe,
  // Status and control signals
  input         reset,
  output        locked,
  input         clk_in1
 );
  // Input buffering
  //------------------------------------
wire clk_in1_platform_clk_wiz_0_0;
wire clk_in2_platform_clk_wiz_0_0;
  IBUF clkin1_ibufg
   (.O (clk_in1_platform_clk_wiz_0_0),
    .I (clk_in1));




  // Clocking PRIMITIVE
  //------------------------------------

  // Instantiation of the MMCM PRIMITIVE
  //    * Unused inputs are tied off
  //    * Unused outputs are labeled unused

  wire        clk_aes_tx_platform_clk_wiz_0_0;
  wire        clk_aes_chip_platform_clk_wiz_0_0;
  wire        clk_out3_platform_clk_wiz_0_0;
  wire        clk_out4_platform_clk_wiz_0_0;
  wire        clk_out5_platform_clk_wiz_0_0;
  wire        clk_out6_platform_clk_wiz_0_0;
  wire        clk_out7_platform_clk_wiz_0_0;

  wire        psdone_unused;
  wire        locked_int;
  wire        clkfbout_platform_clk_wiz_0_0;
  wire        clkfbout_buf_platform_clk_wiz_0_0;
  wire        clkfboutb_unused;
   wire clkout2_unused;
   wire clkout3_unused;
   wire clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;
  wire        reset_high;

  PLLE2_ADV
  #(.BANDWIDTH            ("OPTIMIZED"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT        (17),
    .CLKFBOUT_PHASE       (0.000),
    .CLKOUT0_DIVIDE       (85),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT1_DIVIDE       (17),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKIN1_PERIOD        (20.000))
  plle2_adv_inst
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_platform_clk_wiz_0_0),
    .CLKOUT0             (clk_aes_tx_platform_clk_wiz_0_0),
    .CLKOUT1             (clk_aes_chip_platform_clk_wiz_0_0),
    .CLKOUT2             (clkout2_unused),
    .CLKOUT3             (clkout3_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_platform_clk_wiz_0_0),
    .CLKIN1              (clk_in1_platform_clk_wiz_0_0),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (daddr),
    .DCLK                (dclk),
    .DEN                 (den),
    .DI                  (din),
    .DO                  (dout),
    .DRDY                (drdy),
    .DWE                 (dwe),
    // Other control and status signals
    .LOCKED              (locked_int),
    .PWRDWN              (1'b0),
    .RST                 (reset_high));
  assign reset_high = reset; 

  assign locked = locked_int;
// Clock Monitor clock assigning
//--------------------------------------
 // Output buffering
  //-----------------------------------

  BUFG clkf_buf
   (.O (clkfbout_buf_platform_clk_wiz_0_0),
    .I (clkfbout_platform_clk_wiz_0_0));






  BUFG clkout1_buf
   (.O   (clk_aes_tx),
    .I   (clk_aes_tx_platform_clk_wiz_0_0));


  BUFG clkout2_buf
   (.O   (clk_aes_chip),
    .I   (clk_aes_chip_platform_clk_wiz_0_0));



endmodule
