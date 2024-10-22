vlib work
vlib activehdl

vlib activehdl/xilinx_vip
vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_vip_v1_1_4
vlib activehdl/processing_system7_vip_v1_0_6
vlib activehdl/axi_lite_ipif_v3_0_4
vlib activehdl/lib_cdc_v1_0_2
vlib activehdl/interrupt_control_v3_1_4
vlib activehdl/axi_gpio_v2_0_20
vlib activehdl/generic_baseblocks_v2_1_0
vlib activehdl/axi_register_slice_v2_1_18
vlib activehdl/fifo_generator_v13_2_3
vlib activehdl/axi_data_fifo_v2_1_17
vlib activehdl/axi_crossbar_v2_1_19
vlib activehdl/axi_protocol_converter_v2_1_18
vlib activehdl/proc_sys_reset_v5_0_13

vmap xilinx_vip activehdl/xilinx_vip
vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap axi_infrastructure_v1_1_0 activehdl/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_4 activehdl/axi_vip_v1_1_4
vmap processing_system7_vip_v1_0_6 activehdl/processing_system7_vip_v1_0_6
vmap axi_lite_ipif_v3_0_4 activehdl/axi_lite_ipif_v3_0_4
vmap lib_cdc_v1_0_2 activehdl/lib_cdc_v1_0_2
vmap interrupt_control_v3_1_4 activehdl/interrupt_control_v3_1_4
vmap axi_gpio_v2_0_20 activehdl/axi_gpio_v2_0_20
vmap generic_baseblocks_v2_1_0 activehdl/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_18 activehdl/axi_register_slice_v2_1_18
vmap fifo_generator_v13_2_3 activehdl/fifo_generator_v13_2_3
vmap axi_data_fifo_v2_1_17 activehdl/axi_data_fifo_v2_1_17
vmap axi_crossbar_v2_1_19 activehdl/axi_crossbar_v2_1_19
vmap axi_protocol_converter_v2_1_18 activehdl/axi_protocol_converter_v2_1_18
vmap proc_sys_reset_v5_0_13 activehdl/proc_sys_reset_v5_0_13

vlog -work xilinx_vip  -sv2k12 "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/Xilinx/Vivado/2018.3/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_4  -sv2k12 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/98af/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_6  -sv2k12 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/platform/ip/platform_processing_system7_0_0/sim/platform_processing_system7_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work interrupt_control_v3_1_4 -93 \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/a040/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_20 -93 \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/a7c9/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/platform/ip/platform_axi_gpio_0_0/sim/platform_axi_gpio_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/platform_clk_wiz_0_0_mmcm_pll_drp.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/platform/ip/platform_clk_wiz_0_0/proc_common_v3_00_a/hdl/src/vhdl/platform_clk_wiz_0_0_conv_funs_pkg.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/proc_common_v3_00_a/hdl/src/vhdl/platform_clk_wiz_0_0_proc_common_pkg.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/proc_common_v3_00_a/hdl/src/vhdl/platform_clk_wiz_0_0_ipif_pkg.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/proc_common_v3_00_a/hdl/src/vhdl/platform_clk_wiz_0_0_family_support.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/proc_common_v3_00_a/hdl/src/vhdl/platform_clk_wiz_0_0_family.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/proc_common_v3_00_a/hdl/src/vhdl/platform_clk_wiz_0_0_soft_reset.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/proc_common_v3_00_a/hdl/src/vhdl/platform_clk_wiz_0_0_pselect_f.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/axi_lite_ipif_v1_01_a/hdl/src/vhdl/platform_clk_wiz_0_0_address_decoder.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/axi_lite_ipif_v1_01_a/hdl/src/vhdl/platform_clk_wiz_0_0_slave_attachment.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/axi_lite_ipif_v1_01_a/hdl/src/vhdl/platform_clk_wiz_0_0_axi_lite_ipif.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/platform_clk_wiz_0_0_clk_wiz_drp.vhd" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/platform_clk_wiz_0_0_axi_clk_config.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/platform_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/platform/ip/platform_clk_wiz_0_0/platform_clk_wiz_0_0.v" \
"../../../bd/platform/sim/platform.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/datagenerator/FIFO128.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/datagenerator/aes_core/aes_core.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/datagenerator/aes_core/aes_decipher_block.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/datagenerator/aes_core/aes_encipher_block.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/datagenerator/aes_core/aes_inv_sbox.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/datagenerator/aes_core/aes_key_mem.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/port/aes_rx.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/datagenerator/aes_core/aes_sbox.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/port/aes_tx.v" \
"../../../bd/platform/ipshared/6263/hdl/aes_verify_platform_data_v1_0_S00_AXI.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/controller/rtl/asyfifo.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/controller/rtl/bin2gray.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/datagenerator/datagenerator.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/controller/rtl/dualport_ram.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/controller/rtl/gray2bin.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/datagenerator/lfsr.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/controller/mux.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/controller/rtl/rlogic.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/controller/scoreboard.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/top.v" \
"../../../../vivado.srcs/sources_1/bd/rtl/controller/rtl/wlogic.v" \
"../../../bd/platform/ipshared/6263/hdl/aes_verify_platform_data_v1_0.v" \
"../../../bd/platform/ip/platform_aesVerifyPlatformData_0_1/sim/platform_aesVerifyPlatformData_0_1.v" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_18  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/cc23/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_3  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/64f4/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_3 -93 \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_3  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/64f4/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_17  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/c4fd/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_19  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/6c9d/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/platform/ip/platform_xbar_0/sim/platform_xbar_0.v" \

vlog -work axi_protocol_converter_v2_1_18  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/7a04/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/ec67/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/70cf/hdl" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ipshared/85a3" "+incdir+../../../../vivado.srcs/sources_1/bd/platform/ip/platform_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2018.3/data/xilinx_vip/include" \
"../../../bd/platform/ip/platform_auto_pc_1/sim/platform_auto_pc_1.v" \

vcom -work proc_sys_reset_v5_0_13 -93 \
"../../../../vivado.srcs/sources_1/bd/platform/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/platform/ip/platform_rst_ps7_0_50M_0/sim/platform_rst_ps7_0_50M_0.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

