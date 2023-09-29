proc getPresetInfo {} {
  return [dict create name {XRTC_CIPS_w_Sem} description {XRTC_CIPS_w_Sem}  vlnv xilinx.com:ip:versal_cips:3.2 display_name {XRTC_CIPS_w_Sem} ]
}

proc validate_preset {IPINST} { return true }


proc apply_preset {} {
  return [dict create \
    CONFIG.PS_PMC_CONFIG {BOOT_MODE Custom DEBUG_MODE Custom IO_CONFIG_MODE Custom PMC_BANK_0_IO_STANDARD LVCMOS3.3 PMC_BANK_1_IO_STANDARD LVCMOS3.3 PMC_QSPI_PERIPHERAL_ENABLE 0 PMC_QSPI_PERIPHERAL_MODE Single PMC_REF_CLK_FREQMHZ 50 PMC_SMAP_PERIPHERAL {{ENABLE 1} {IO {32 Bit}}} PS_BANK_2_IO_STANDARD LVCMOS3.3 PS_BANK_3_IO_STANDARD LVCMOS3.3 PS_HSDP_INGRESS_TRAFFIC JTAG PS_HSDP_MODE NONE PS_UART0_BAUD_RATE 115200 PS_UART0_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 26 .. 27}}} PS_UART1_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 4 .. 5}}} SEM_MEM_ENABLE_SCAN_AFTER 1 SEM_MEM_SCAN 1 SMON_ALARMS Set_Alarms_On SMON_ENABLE_TEMP_AVERAGING 0 SMON_TEMP_AVERAGING_SAMPLES 0 }  \
    CONFIG.PS_PMC_CONFIG_APPLIED {0}  \
    CONFIG.BOOT_MODE {Custom}  \
    CONFIG.DEBUG_MODE {Custom}  \
    CONFIG.IO_CONFIG_MODE {Custom}  \
  ]
}

proc addCIPS {} {
  create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips:3.2 XRTC_CIPS_w_Sem
}
  
addCIPS
set cips [get_bd_cells {XRTC_CIPS_w_Sem}]
set cfg [apply_preset]
set_property -dict $cfg $cips


