# Constraints file set to:
#  - Scope: Used in Implementation (only)
#


# IDELAYCTRL primitive
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp [get_cells -hier -filter {name =~ *tri_mode_ethernet_mac_idelayctrl_common_i}]
#
# IDELAY/ODELAY primitives
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp [get_cells -hier -filter {name =~ *delay_rgmii_rxd* }]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp [get_cells -hier -filter {name =~ *delay_rgmii_rx_ctl }]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp [get_cells -hier -filter {name =~ *delay_rgmii_txd* }]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp [get_cells -hier -filter {name =~ *delay_rgmii_tx_ctl}]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp [get_cells -hier -filter {name =~ *delay_rgmii_tx_clk }]


# Adjust ODELAY values
set_property ODELAY_VALUE 0 [get_cells -hier -filter {name =~ *delay_rgmii_tx_clk }]
set_property ODELAY_VALUE 0 [get_cells -hier -filter {name =~ *delay_rgmii_tx_ctl }]
set_property ODELAY_VALUE 0 [get_cells -hier -filter {name =~ *delay_rgmii_txd* }]


# Adjust IDELAY values
#set_property IDELAY_VALUE 0 [get_cells -hier -filter {name =~ *delay_rgmii_rxc }]
#
set_property IDELAY_VALUE 13 [get_cells -hier -filter {name =~ *delay_rgmii_rx_ctl }]
set_property IDELAY_VALUE 16 [get_cells -hier -filter {name =~ *rxdata_bus[0].delay_rgmii_rxd }]
set_property IDELAY_VALUE 16 [get_cells -hier -filter {name =~ *rxdata_bus[1].delay_rgmii_rxd }]
set_property IDELAY_VALUE 17 [get_cells -hier -filter {name =~ *rxdata_bus[2].delay_rgmii_rxd }]
set_property IDELAY_VALUE 17 [get_cells -hier -filter {name =~ *rxdata_bus[3].delay_rgmii_rxd }]



# No timing associated with output
set_false_path -from [get_cells -hier -filter {name =~ */phy_resetn_int_reg}] -to [get_ports phy_reset_n]

