

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "aes_verify_platform_data" "NUM_INSTANCES" "DEVICE_ID"  "C_S00_AXI_BASEADDR" "C_S00_AXI_HIGHADDR"
}
