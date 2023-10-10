#------------------------------------------------------------------------------
#-- License    : MIT
#-- Copyright (c) 2021, Sebastian Garcia and Gary Swift (for the Xilinx Radiation Test Consortium - XRTC)
#--
#-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#--
#-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#--
#-- THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#--
#------------------------------------------------------------------------------
# Constraints file set to:
#  - Scope: Used in Implementation (only)
#

# Virtex-7 485T "full" board
#
# - XRTC's Virtex-7 "full" board populated with 485T COTS device, together with mezzanine card plugged in "FMC2_SPARE" FMC connector:
# -- Opsero's "robust" Ethernet card (Ethernet I/F in use: "Port0").
#
# NOTES:
#  - Opsero FMC daughter card requires 3V3 voltage rail as one of the PHY power supplies and for the oscillator chip power supply.
#     As Virtex-7 "full" board doesn't provide 3V3, at this time we use an FMC interposer/break-out board to apply the 3V3 supply.
#
# PART is virtex7 xc7vx485tffg1930


# 50 MHz main external clock
# Oscillator on board (UC3): Silabs 530FC50M0000DG (LVDS, 2V5, 50 MHz, 20 ppm, ).
#  MRCC Clock pins on Bank14, VCCO tied to VCCO_CFG_BJ ( = 1V8 , required for other banks powered from same rail)
#set_property PACKAGE_PIN $VIRTEX7_FULL_BOARD__NET_TO_PIN(CLK_P_50MHZ_FPGA)  [get_ports clk_in_p]
#set_property PACKAGE_PIN $VIRTEX7_FULL_BOARD__NET_TO_PIN(CLK_N_50MHZ_FPGA)  [get_ports clk_in_n]
set_property PACKAGE_PIN AP21 [get_ports clk_in_p]
set_property PACKAGE_PIN AR22 [get_ports clk_in_n]
set_property IOSTANDARD LVDS [get_ports clk_in_p]
set_property IOSTANDARD LVDS [get_ports clk_in_n]
set_property DIFF_TERM TRUE [get_ports clk_in_p]
set_property DIFF_TERM TRUE [get_ports clk_in_n]


# I/F to PHY chip (Marvell 88E1510): RGMII and related signals
#
# - On Virtex-7 "full board", populated with 485T device:
# -- Involved 485T banks with VCCO tied to VCCO_CFG_BJ: Bank15.
# -- Involved 485T banks with VCCO tied to VCCO_G2_BJ:  Bank35, Bank36, Bank37.
# - On Opsero "robust" Ethernet mezzanine card:
# -- Using specific board version for 1V8 signals I/F.
# -- Signals are single-ended, except for the 125 MHz reference clock (mezzanine-to-carrier direction)
#
#    V7-485T ball    FMC2_SPARE                     PHY Ethernet Port0 ("E0") chip
#   ("full board")    FMC_name        FMC_pin       (Opsero mezz. card net labels)
# ------------------------------------------------------------------------------
#   AL43 (Bank15)   LA02_P_FMC2         H7          E0_RXD0
#   AL44 (Bank15)   LA02_N_FMC2         H8          E0_RXD1
#   AN44 (Bank15)   LA03_P_FMC2         G9          E0_RXD2
#   AP44 (Bank15)   LA03_N_FMC2         G10         E0_RXD3
#   AL38 (Bank15)   LA00_N_CC_FMC2      G7          E0_RX_CTRL
#   AK38 (Bank15)   LA00_P_CC_FMC2      G6          E0_RX_CLK
#
#   AL40 (Bank15)   LA04_P_FMC2         H10         E0_TXD0
#   P10  (Bank37)   LA08_P_FMC2         G12         E0_TXD1
#   N10  (Bank37)   LA08_N_FMC2         G13         E0_TXD2
#   M11  (Bank37)   LA07_P_FMC2         H13         E0_TXD3
#   M10  (Bank37)   LA07_N_FMC2         H14         E0_TX_CTRL
#   AM40 (Bank15)   LA04_N_FMC2         H11         E0_TX_CLK
#
#   AL39 (Bank15)   LA05_N_FMC2         D12         E0_RESET_N (PHY chip reset)
#   D21  (Bank35)   LA13_P_FMC2         D17         REF_CLK_OE (Enable for 125 MHz clock on mezzanine)
#
# The following is the diff-pair for the 125 MHz reference clock on mezzanine,
#  Microchip DSC1123CI2 (LVDS, 3V3)
#   G3 (Bank36)     CLK0_M2C_P_FMC2     H4         REF_CLK_P
#   G2 (Bank36)     CLK0_M2C_N_FMC2     H5         REF_CLK_N
#

set_property PACKAGE_PIN AL43 [get_ports {rgmii_rxd[0]}]
set_property PACKAGE_PIN AL44 [get_ports {rgmii_rxd[1]}]
set_property PACKAGE_PIN AN44 [get_ports {rgmii_rxd[2]}]
set_property PACKAGE_PIN AP44 [get_ports {rgmii_rxd[3]}]
set_property PACKAGE_PIN AL38 [get_ports rgmii_rx_ctl]
set_property PACKAGE_PIN AK38 [get_ports rgmii_rxc]
set_property IOSTANDARD HSTL_I_18 [get_ports {rgmii_rxd[0]}]
set_property IOSTANDARD HSTL_I_18 [get_ports {rgmii_rxd[1]}]
set_property IOSTANDARD HSTL_I_18 [get_ports {rgmii_rxd[2]}]
set_property IOSTANDARD HSTL_I_18 [get_ports {rgmii_rxd[3]}]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_rx_ctl]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_rxc]
#
set_property PACKAGE_PIN AL40 [get_ports {rgmii_txd[0]}]
set_property PACKAGE_PIN P10 [get_ports {rgmii_txd[1]}]
set_property PACKAGE_PIN N10 [get_ports {rgmii_txd[2]}]
set_property PACKAGE_PIN M11 [get_ports {rgmii_txd[3]}]
set_property PACKAGE_PIN M10 [get_ports rgmii_tx_ctl]
set_property PACKAGE_PIN AM40 [get_ports rgmii_txc]
set_property IOSTANDARD HSTL_I_18 [get_ports {rgmii_txd[0]}]
set_property IOSTANDARD HSTL_I_18 [get_ports {rgmii_txd[1]}]
set_property IOSTANDARD HSTL_I_18 [get_ports {rgmii_txd[2]}]
set_property IOSTANDARD HSTL_I_18 [get_ports {rgmii_txd[3]}]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_tx_ctl]
set_property IOSTANDARD HSTL_I_18 [get_ports rgmii_txc]
#
set_property PACKAGE_PIN AL39 [get_ports phy_reset_n]
set_property IOSTANDARD HSTL_I_18 [get_ports phy_reset_n]




