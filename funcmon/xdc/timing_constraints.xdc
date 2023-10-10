#------------------------------------------------------------------------------
#-- License    : MIT
#-- Copyright (c) 2021, Sebastian Garcia and Gary Swift (for the Xilinx Radiation Test Consortium - XRTC)
#--
#-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the â€œSoftwareâ€?), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#--
#-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#--
#-- THE SOFTWARE IS PROVIDED â€œAS ISâ€?, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#--
#------------------------------------------------------------------------------
# Constraints file set to:
#  - Scope: Used both in Synthesis and Implementation 
#


set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]

# Primary clock
create_clock -period 20.000 -name clk_in_p [get_ports clk_in_p]
set_input_jitter clk_in_p 0.050

# Rx clock from PHY
# NOTE: It comes pre-defined in .xdc file of black-box (in udp_with_temac_rgmii.dcp), so Synthesis will give a couple of warnings about this
#       Still needed for Implementation constraints
create_clock -period 8.000 -name rgmii_rxc [get_ports rgmii_rxc]

# Define virtual clock 
create_clock -period 8.000 -name rgmii_rxc_virtual


# Ignore paths to resync flops
#
set_false_path -to [get_pins -filter {REF_PIN_NAME =~ PRE} -of [get_cells -hier -filter {name =~ */reset_sync_flop*}]]
set_false_path -to [get_pins -filter {REF_PIN_NAME =~ D}   -of [get_cells -hier -filter {name =~ */reset_sync_flop*}]]


# FIFO Clock crossing constraints
#
# Control signal is synched separately so this is a false path
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *rx_fifo_i/rd_addr_reg[*]}] -to [get_cells -hier -filter {name =~ *fifo*wr_rd_addr_reg[*]}] 3.200
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *rx_fifo_i/wr_store_frame_tog_reg}] -to [get_cells -hier -filter {name =~ *fifo_i/resync_wr_store_frame_tog/data_sync_reg0}] 3.200
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *rx_fifo_i/update_addr_tog_reg}] -to [get_cells -hier -filter {name =~ *rx_fifo_i/sync_rd_addr_tog/data_sync_reg0}] 3.200
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *tx_fifo_i/rd_addr_txfer_reg[*]}] -to [get_cells -hier -filter {name =~ *fifo*wr_rd_addr_reg[*]}] 3.200
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *tx_fifo_i/wr_frame_in_fifo_reg}] -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_wr_frame_in_fifo/data_sync_reg0}] 3.200
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *tx_fifo_i/wr_frames_in_fifo_reg}] -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_wr_frames_in_fifo/data_sync_reg0}] 3.200
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *tx_fifo_i/frame_in_fifo_valid_tog_reg}] -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_fif_valid_tog/data_sync_reg0}] 3.200
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *tx_fifo_i/rd_txfer_tog_reg}] -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_rd_txfer_tog/data_sync_reg0}] 3.200
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *tx_fifo_i/rd_tran_frame_tog_reg}] -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_rd_tran_frame_tog/data_sync_reg0}] 3.200
#
set_power_opt -exclude_cells [get_cells -hierarchical -filter { PRIMITIVE_TYPE =~ *.bram.* }]


# CDC
#
create_waiver -type CDC -id {CDC-10} -user "tri_mode_ethernet_mac" -desc "Part of reset synchronizer. Safe to ignore" -tags "11999" -from [get_pins */resets_generation_0/glbl_reset_gen/reset_sync_flop_4/C] -to [get_pins -of [get_cells -hier -filter {name =~ */idelayctrl_reset_gen/reset_sync_flop_0*}] -filter {name =~ *PRE}] -timestamp "Sat Feb 27 05:55:54 GMT 2021"
#
create_waiver -type CDC -id {CDC-11} -user "tri_mode_ethernet_mac" -desc "Part of reset synchronizer. Safe to ignore" -tags "11999" -from [get_pins */resets_generation_0/glbl_reset_gen/reset_sync_flop_4/C] -to [list [get_pins -of [get_cells -hier -filter {name =~ */sync_glbl_rstn_tx_clk/async_rst0_reg*}] -filter {name =~ *CLR}] [get_pins -of [get_cells -hier -filter {name =~ */sync_stats_reset/async_rst0_reg*}] -filter {name =~ *PRE}]] -timestamp "Sat Feb 27 05:55:54 GMT 2021"

# CDC from clk_temac domain to clk_fm domain
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *rx_cmd_tmp_reg*}] -to [get_cells -hier -filter {name =~ *commif_rx_command__clk_fm_domain_reg*}] 5.000

# CDC from clk_fm domain to clk_temac domain
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *udp_with_temac_rgmii__inst/snapshot_reg_bank_0/snapshot_reg*}] -to [get_cells -hier -filter {name =~ *udp_with_temac_rgmii__inst/udp_tx_ctrl_fsm_0/transmit_data_input_bus_reg*}] 5.000

# CDC from clk_temac domain to clk_fm domain AND from clk_fm domain to clk_temac domain  (toggle flop to first sync flop)
set_max_delay -datapath_only -from [get_cells -hier -filter {name =~ *event_toggle_reg*}] -to [get_cells -hier -filter {name =~ *sync_reg0*}] 5.000


set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins funcmon_top_i/clkmac_i/inst/mmcm_adv_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins clocks_generation__inst/clk_wiz__inst/mmcm_adv__inst/CLKOUT1]] 5.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clocks_generation__inst/clk_wiz__inst/mmcm_adv__inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins funcmon_top_i/clkmac_i/inst/mmcm_adv_inst/CLKOUT1]] 5.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins funcmon_top_i/clkmac_i/inst/mmcm_adv_inst/CLKOUT2]] -to [get_clocks -of_objects [get_pins clocks_generation__inst/clk_wiz__inst/mmcm_adv__inst/CLKOUT1]] 5.0
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins clocks_generation__inst/clk_wiz__inst/mmcm_adv__inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins funcmon_top_i/clkmac_i/inst/mmcm_adv_inst/CLKOUT2]] 5.0
set_max_delay -from [get_clocks -of_objects [get_pins funcmon_top_i/clkmac_i/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins clocks_generation__inst/clk_wiz__inst/mmcm_adv__inst/CLKOUT1]] 5.0
set_max_delay -from [get_clocks -of_objects [get_pins clocks_generation__inst/clk_wiz__inst/mmcm_adv__inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins funcmon_top_i/clkmac_i/inst/mmcm_adv_inst/CLKOUT0]] 5.0



set trco_max            2.800;          # Maximum clock to output delay from rising edge (external device)
set trco_min            1.200;          # Minimum clock to output delay from rising edge (external device)
set tfco_max            2.800;          # Maximum clock to output delay from falling edge (external device)
set tfco_min            1.200;          # Minimum clock to output delay from falling edge (external device)
#
set trce_dly_rxctl_max  0.020;          # Maximum board trace delay (rgmii_rx_ctl signal)
set trce_dly_rxd0_max  -0.279;          # Maximum board trace delay (rgmii_rxd[0] signal)
set trce_dly_rxd1_max  -0.279;          # Maximum board trace delay (rgmii_rxd[1] signal)
set trce_dly_rxd2_max  -0.435;          # Maximum board trace delay (rgmii_rxd[2] signal)
set trce_dly_rxd3_max  -0.435;          # Maximum board trace delay (rgmii_rxd[3] signal)
#
set trce_dly_rxctl_min -0.020;          # Minimum board trace delay (rgmii_rx_ctl signal)
set trce_dly_rxd0_min  -0.239;          # Minimum board trace delay (rgmii_rxd[0] signal)
set trce_dly_rxd1_min  -0.239;          # Minimum board trace delay (rgmii_rxd[1] signal)
set trce_dly_rxd2_min  -0.395;          # Minimum board trace delay (rgmii_rxd[2] signal)
set trce_dly_rxd3_min  -0.395;          # Minimum board trace delay (rgmii_rxd[3] signal)
#
#set trce_dly_clk_max    0.000;            # Maximum board trace delay (rgmii_rxc)
#set trce_dly_clk_min    0.000;            # Minimum board trace delay (rgmii_rxc)
#
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $trco_max + $trce_dly_rxctl_max] [get_ports rgmii_rx_ctl];
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $trco_min + $trce_dly_rxctl_min] [get_ports rgmii_rx_ctl];
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $tfco_max + $trce_dly_rxctl_max] [get_ports rgmii_rx_ctl] -clock_fall -add_delay;
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $tfco_min + $trce_dly_rxctl_min] [get_ports rgmii_rx_ctl] -clock_fall -add_delay;
#
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $trco_max + $trce_dly_rxd0_max] [get_ports rgmii_rxd[0]];
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $trco_min + $trce_dly_rxd0_min] [get_ports rgmii_rxd[0]];
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $tfco_max + $trce_dly_rxd0_max] [get_ports rgmii_rxd[0]] -clock_fall -add_delay;
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $tfco_min + $trce_dly_rxd0_min] [get_ports rgmii_rxd[0]] -clock_fall -add_delay;
#
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $trco_max + $trce_dly_rxd1_max] [get_ports rgmii_rxd[1]];
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $trco_min + $trce_dly_rxd1_min] [get_ports rgmii_rxd[1]];
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $tfco_max + $trce_dly_rxd1_max] [get_ports rgmii_rxd[1]] -clock_fall -add_delay;
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $tfco_min + $trce_dly_rxd1_min] [get_ports rgmii_rxd[1]] -clock_fall -add_delay;
#
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $trco_max + $trce_dly_rxd2_max] [get_ports rgmii_rxd[2]];
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $trco_min + $trce_dly_rxd2_min] [get_ports rgmii_rxd[2]];
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $tfco_max + $trce_dly_rxd2_max] [get_ports rgmii_rxd[2]] -clock_fall -add_delay;
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $tfco_min + $trce_dly_rxd2_min] [get_ports rgmii_rxd[2]] -clock_fall -add_delay;
#
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $trco_max + $trce_dly_rxd3_max] [get_ports rgmii_rxd[3]];
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $trco_min + $trce_dly_rxd3_min] [get_ports rgmii_rxd[3]];
set_input_delay -clock [get_clocks rgmii_rxc] -max [expr $tfco_max + $trce_dly_rxd3_max] [get_ports rgmii_rxd[3]] -clock_fall -add_delay;
set_input_delay -clock [get_clocks rgmii_rxc] -min [expr $tfco_min + $trce_dly_rxd3_min] [get_ports rgmii_rxd[3]] -clock_fall -add_delay;



































