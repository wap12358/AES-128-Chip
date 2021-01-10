-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Jan 10 14:07:49 2021
-- Host        : MSI running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               f:/OneDrive/Study/IC2/AES-128-with-an-Instruction-Set/verifyPlatform/vivado/vivado.srcs/sources_1/bd/platform/ip/platform_aes_top_0_2/platform_aes_top_0_2_stub.vhdl
-- Design      : platform_aes_top_0_2
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity platform_aes_top_0_2 is
  Port ( 
    clk : in STD_LOGIC;
    config_pin : in STD_LOGIC_VECTOR ( 2 downto 0 );
    rx : in STD_LOGIC_VECTOR ( 8 downto 0 );
    tx : out STD_LOGIC_VECTOR ( 8 downto 0 )
  );

end platform_aes_top_0_2;

architecture stub of platform_aes_top_0_2 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,config_pin[2:0],rx[8:0],tx[8:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "aes_top,Vivado 2018.3";
begin
end;
