
# -----------------------------------------------------------------------------
# Notes

# For 7-Series devices, ALL I/O pins must have a pin and I/O standard set.

# First, configure the used pins here. That will make them "fixed" in Vivado.

# Second, for unused ports at the top-level: first set the unused pins I/O
# standard to something all I/O Banks support, then make Vivado auto-assign the
# unfixed pins, then fix them. Pulldowns are nice too.

# The auto-assignment will silently fail (appear to not do anything) if you set
# an I/O standard that is incompatible with the available pins.

# -----------------------------------------------------------------------------
# Device configuration
# -----------------------------------------------------------------------------

# Clocks: Bank 24 (VCCO_G3_BJ)
#set_property PACKAGE_PIN AN32 [get_ports clk_n]
#set_property PACKAGE_PIN AM32 [get_ports clk_p]
#set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_p]
#set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_n]


set_property CONFIG_VOLTAGE           1.8           [current_design]
set_property CFGBVS                   GND           [current_design]
# These two keep the config pins after loading the bitstream, rather than reverting to I/O
# This is necessary for partial reconfiguration
set_property BITSTREAM.CONFIG.PERSIST YES           [current_design]
set_property CONFIG_MODE              S_SELECTMAP32 [current_design]

# Bitstream options
set_property BITSTREAM.CONFIG.USERID 12345678       [current_design]
set_property BITSTREAM.CONFIG.USR_ACCESS deadbeef   [current_design]

# To support configuration fault injection
set_property BITSTREAM.CONFIG.CONFIGFALLBACK    ENABLE      [current_design]

# Possible solution for V7 1140 SSIT configuration issue
#set_property BITSTREAM.STARTUP.STARTUPCLK JtagClk [current_design]
# -----------------------------------------------------------------------------
# These apply to the post-synthesis netlist.
# Force registers into IOBs, not general logic.
# This causes a warning since the inout pins get IOB set twice.

#set_property IOB TRUE [all_outputs]
#set_property IOB TRUE [all_inputs]

# -----------------------------------------------------------------------------
# TMV clock-capable pin, replaces dut_gen_clk_inb
# Uses untranslated pin number!!!

#create_clock -period 30.000 -name tmv_5_clk -waveform {0.000 15.000} [get_ports {TMV_bus[5]}]

# -----------------------------------------------------------------------------
# Single-Ended Clocks INPUTS
# -----------------------------------------------------------------------------
# Unusable due to FuncMon mismatch
#create_clock -period 30.000 -name dut_gen_clk_ina -waveform {0.000 15.000} [get_ports dut_gen_clk_ina]
#create_clock -period 30.000 -name dut_gen_clk_inb -waveform {0.000 15.000} [get_ports dut_gen_clk_inb]
#create_clock -period 30.000 -name dut_gen_clk_inc -waveform {0.000 15.000} [get_ports dut_gen_clk_inc]
#create_clock -period 30.000 -name dut_gen_clk_ind -waveform {0.000 15.000} [get_ports dut_gen_clk_ind]

# set_property PACKAGE_PIN AY39 [get_ports dut_gen_clk_ina]
# set_property PACKAGE_PIN BA38 [get_ports dut_gen_clk_inb]
# set_property PACKAGE_PIN BC38 [get_ports dut_gen_clk_inc]
# set_property PACKAGE_PIN BC39 [get_ports dut_gen_clk_ind]

#set_property IOSTANDARD LVCMOS18 [get_ports dut_gen_clk_ina]
#set_property IOSTANDARD LVCMOS18 [get_ports dut_gen_clk_inb]
#set_property IOSTANDARD LVCMOS18 [get_ports dut_gen_clk_inc]
#set_property IOSTANDARD LVCMOS18 [get_ports dut_gen_clk_ind]

# -----------------------------------------------------------------------------
# Single-Ended Clocks OUTPUTS
# -----------------------------------------------------------------------------
#create_clock -period 30.000 -name dut_gen_clk_outa -waveform {0.000 15.000} [get_ports dut_gen_clk_outa]
#create_clock -period 30.000 -name dut_gen_clk_outb -waveform {0.000 15.000} [get_ports dut_gen_clk_outb]
#create_clock -period 30.000 -name dut_gen_clk_outc -waveform {0.000 15.000} [get_ports dut_gen_clk_outc]
#create_clock -period 30.000 -name dut_gen_clk_outd -waveform {0.000 15.000} [get_ports dut_gen_clk_outd]

# set_property PACKAGE_PIN AV29 [get_ports dut_gen_clk_outa]
# set_property PACKAGE_PIN AU30 [get_ports dut_gen_clk_outb]
# set_property PACKAGE_PIN AW30 [get_ports dut_gen_clk_outc]
# set_property PACKAGE_PIN AV32 [get_ports dut_gen_clk_outd]

#set_property IOSTANDARD LVCMOS18 [get_ports dut_gen_clk_outa]
#set_property IOSTANDARD LVCMOS18 [get_ports dut_gen_clk_outb]
#set_property IOSTANDARD LVCMOS18 [get_ports dut_gen_clk_outc]
#set_property IOSTANDARD LVCMOS18 [get_ports dut_gen_clk_outd]


# -----------------------------------------------------------------------------
# Differential Clocks INPUTS
# We only need to constrain the positive pin for timing.
# The constraint propagates to the IBUFGDS and to the negative pin.
# -----------------------------------------------------------------------------
#create_clock -period 30.000 -name diff_clka_p -waveform {0.000 15.000} [get_ports diff_clka_p]
#create_clock -period 30.000 -name diff_clkb_p -waveform {0.000 15.000} [get_ports diff_clkb_p]

#set_property PACKAGE_PIN  E7 [get_ports diff_clka_n]
#set_property PACKAGE_PIN  F8 [get_ports diff_clka_p]
#set_property PACKAGE_PIN J14 [get_ports diff_clkb_n]
#set_property PACKAGE_PIN J15 [get_ports diff_clkb_p]

#set_property IOSTANDARD LVCMOS18 [get_ports diff_clka_n]
#set_property IOSTANDARD LVCMOS18 [get_ports diff_clka_p]
#set_property IOSTANDARD LVCMOS18 [get_ports diff_clkb_n]
#set_property IOSTANDARD LVCMOS18 [get_ports diff_clkb_p]


##-----------------------------------------------------------------------------
## IO Pin Assignment
##-----------------------------------------------------------------------------
 set_property PACKAGE_PIN AN32 [get_ports {clk_mstr_50_fpga_n}];
 set_property PACKAGE_PIN AM32 [get_ports {clk_mstr_50_fpga_p}];
#set_property PACKAGE_PIN AL32 [get_ports {df_0032_n}];               
#set_property PACKAGE_PIN AK32 [get_ports {df_0032_p}];               
#set_property PACKAGE_PIN AF30 [get_ports {df_0035_n}];               
#set_property PACKAGE_PIN AE30 [get_ports {df_0035_p}];               
#set_property PACKAGE_PIN AH32 [get_ports {df_0037_n}];               
#set_property PACKAGE_PIN AH31 [get_ports {df_0037_p}];               
#set_property PACKAGE_PIN AU30 [get_ports {df_0038_n}];               
#set_property PACKAGE_PIN AU29 [get_ports {df_0038_p}];               
 set_property PACKAGE_PIN AR30 [get_ports {df_0051_n}];               
 set_property PACKAGE_PIN AP29 [get_ports {df_0051_p}];               
 set_property PACKAGE_PIN AK30 [get_ports {df_0052_n}];               
 set_property PACKAGE_PIN AJ30 [get_ports {df_0052_p}];               
 set_property PACKAGE_PIN AK31 [get_ports {df_0053_n}];               
 set_property PACKAGE_PIN AJ31 [get_ports {df_0053_p}];               
 set_property PACKAGE_PIN AW29 [get_ports {df_0056_n}];               
 set_property PACKAGE_PIN AV29 [get_ports {df_0056_p}];               
 set_property PACKAGE_PIN AW31 [get_ports {df_0057_n}];               
 set_property PACKAGE_PIN AW30 [get_ports {df_0057_p}];               
 set_property PACKAGE_PIN AV32 [get_ports {df_0059_n}];               
 set_property PACKAGE_PIN AU32 [get_ports {df_0059_p}];               
 set_property PACKAGE_PIN AM30 [get_ports {df_0092_n}];               
 set_property PACKAGE_PIN AL30 [get_ports {df_0092_p}];               
 set_property PACKAGE_PIN AV31 [get_ports {df_0095_n}];               
 set_property PACKAGE_PIN AU31 [get_ports {df_0095_p}];               
 set_property PACKAGE_PIN AJ29 [get_ports {df_0114_n}];               
 set_property PACKAGE_PIN AH29 [get_ports {df_0114_p}];               
 set_property PACKAGE_PIN AM29 [get_ports {df_0099_n}];            
 set_property PACKAGE_PIN AL29 [get_ports {df_0099_p}];            
#set_property PACKAGE_PIN AF28 [get_ports {df_i_n_14}];        
#set_property PACKAGE_PIN AE28 [get_ports {df_i_p_14}];        
#set_property PACKAGE_PIN AG29 [get_ports {df_i_n_19}];        
#set_property PACKAGE_PIN AF29 [get_ports {df_i_p_19}];        
 set_property PACKAGE_PIN AJ28 [get_ports {df_i_n_20}];        
 set_property PACKAGE_PIN AH28 [get_ports {df_i_p_20}];        
#set_property PACKAGE_PIN AN31 [get_ports {df_o_n_0}];        
#set_property PACKAGE_PIN AM31 [get_ports {df_o_p_0}];        
 set_property PACKAGE_PIN AP31 [get_ports {df_o_n_14}];       
 set_property PACKAGE_PIN AP30 [get_ports {df_o_p_14}];       
 set_property PACKAGE_PIN AR32 [get_ports {df_o_n_19}];       
 set_property PACKAGE_PIN AR31 [get_ports {df_o_p_19}];       
 set_property PACKAGE_PIN AK33 [get_ports {df_o_n_1}];        
 set_property PACKAGE_PIN AJ33 [get_ports {df_o_p_1}];        
 set_property PACKAGE_PIN AP33 [get_ports {df_o_n_9}];        
 set_property PACKAGE_PIN AN33 [get_ports {df_o_p_9}];        
#set_property PACKAGE_PIN AG30 [get_ports {se_008}];                  
#set_property PACKAGE_PIN AL33 [get_ports {se_009}];                  
#set_property PACKAGE_PIN AT29 [get_ports {se_015}];                  
#set_property PACKAGE_PIN AT32 [get_ports {se_053}];             
#set_property PACKAGE_PIN AT30 [get_ports {se_060}];                  
 set_property PACKAGE_PIN AT37 [get_ports {df_0150_n}];            
 set_property PACKAGE_PIN AR37 [get_ports {df_0150_p}];            
 set_property PACKAGE_PIN AK36 [get_ports {df_i_n_23}];        
 set_property PACKAGE_PIN AK35 [get_ports {df_i_p_23}];        
 set_property PACKAGE_PIN AM39 [get_ports {df_i_n_24}];        
 set_property PACKAGE_PIN AL39 [get_ports {df_i_p_24}];        
 set_property PACKAGE_PIN AL35 [get_ports {df_i_n_25}];        
 set_property PACKAGE_PIN AL34 [get_ports {df_i_p_25}];        
 set_property PACKAGE_PIN AL38 [get_ports {df_i_n_26}];        
 set_property PACKAGE_PIN AL37 [get_ports {df_i_p_26}];        
#set_property PACKAGE_PIN AP34 [get_ports {df_i_n_38}];        
#set_property PACKAGE_PIN AN34 [get_ports {df_i_p_38}];        
#set_property PACKAGE_PIN AU39 [get_ports {df_i_n_40}];        
#set_property PACKAGE_PIN AT39 [get_ports {df_i_p_40}];        
#set_property PACKAGE_PIN AV37 [get_ports {df_i_n_41}];        
#set_property PACKAGE_PIN AU37 [get_ports {df_i_p_41}];        
#set_property PACKAGE_PIN AU35 [get_ports {df_i_n_42}];        
#set_property PACKAGE_PIN AT35 [get_ports {df_i_p_42}];        
#set_property PACKAGE_PIN AW36 [get_ports {df_i_n_43}];        
#set_property PACKAGE_PIN AW35 [get_ports {df_i_p_43}];        
#set_property PACKAGE_PIN AU34 [get_ports {df_i_n_45}];        
#set_property PACKAGE_PIN AT34 [get_ports {df_i_p_45}];        
#set_property PACKAGE_PIN AW34 [get_ports {df_i_n_46}];        
#set_property PACKAGE_PIN AW33 [get_ports {df_i_p_46}];        
 set_property PACKAGE_PIN AR36 [get_ports {df_i_n_21}];     
 set_property PACKAGE_PIN AP36 [get_ports {df_i_p_21}];     
 set_property PACKAGE_PIN AT38 [get_ports {df_i_n_22}];     
 set_property PACKAGE_PIN AR38 [get_ports {df_i_p_22}];     
 set_property PACKAGE_PIN AN37 [get_ports {df_o_n_40}];    
 set_property PACKAGE_PIN AN36 [get_ports {df_o_p_40}];    
 set_property PACKAGE_PIN AK38 [get_ports {df_o_n_54}];       
 set_property PACKAGE_PIN AK37 [get_ports {df_o_p_54}];       
#set_property PACKAGE_PIN AM37 [get_ports {df_o_n_66}];       
#set_property PACKAGE_PIN AM36 [get_ports {df_o_p_66}];       
#set_property PACKAGE_PIN AP39 [get_ports {df_o_n_67}];       
#set_property PACKAGE_PIN AN39 [get_ports {df_o_p_67}];       
 set_property PACKAGE_PIN AM35 [get_ports {df_o_n_69}];       
 set_property PACKAGE_PIN AM34 [get_ports {df_o_p_69}];       
 set_property PACKAGE_PIN AV39 [get_ports {df_o_n_71}];       
 set_property PACKAGE_PIN AV38 [get_ports {df_o_p_71}];       
#set_property PACKAGE_PIN AV36 [get_ports {df_o_n_72}];       
#set_property PACKAGE_PIN AU36 [get_ports {df_o_p_72}];       
#set_property PACKAGE_PIN AT33 [get_ports {df_o_n_74}];       
#set_property PACKAGE_PIN AR33 [get_ports {df_o_p_74}];       
#set_property PACKAGE_PIN AV34 [get_ports {df_o_n_76}];       
#set_property PACKAGE_PIN AV33 [get_ports {df_o_p_76}];       
#set_property PACKAGE_PIN AN38 [get_ports {se_072}];                  
#set_property PACKAGE_PIN AP38 [get_ports {se_077}];                  
#set_property PACKAGE_PIN AR35 [get_ports {se_102}];                  
#set_property PACKAGE_PIN AW38 [get_ports {se_103}];                  
#set_property PACKAGE_PIN AP35 [get_ports {se_104}];                  
#set_property PACKAGE_PIN AJ39 [get_ports {se_105}];                  
 set_property PACKAGE_PIN AP24 [get_ports {df_0000_n}];               
 set_property PACKAGE_PIN AN24 [get_ports {df_0000_p}];               
 set_property PACKAGE_PIN AK21 [get_ports {df_0001_n}];               
 set_property PACKAGE_PIN AK20 [get_ports {df_0001_p}];               
 set_property PACKAGE_PIN AR21 [get_ports {df_0005_n}];               
 set_property PACKAGE_PIN AP21 [get_ports {df_0005_p}];               
 set_property PACKAGE_PIN AW23 [get_ports {df_0008_n}];               
 set_property PACKAGE_PIN AV23 [get_ports {df_0008_p}];               
 set_property PACKAGE_PIN AW24 [get_ports {df_0011_n}];               
 set_property PACKAGE_PIN AV24 [get_ports {df_0011_p}];               
 set_property PACKAGE_PIN AU22 [get_ports {df_0012_n}];               
 set_property PACKAGE_PIN AT22 [get_ports {df_0012_p}];               
 set_property PACKAGE_PIN AT24 [get_ports {df_0013_n}];               
 set_property PACKAGE_PIN AT23 [get_ports {df_0013_p}];               
 set_property PACKAGE_PIN AF23 [get_ports {df_0017_n}];               
 set_property PACKAGE_PIN AE23 [get_ports {df_0017_p}];               
 set_property PACKAGE_PIN AR23 [get_ports {df_0023_n}];               
 set_property PACKAGE_PIN AR22 [get_ports {df_0023_p}];               
 set_property PACKAGE_PIN AW21 [get_ports {df_0028_n}];               
 set_property PACKAGE_PIN AV21 [get_ports {df_0028_p}];     
          
 set_property PACKAGE_PIN AP23 [get_ports {df_0046_n}];
 set_property PACKAGE_PIN AN23 [get_ports {df_0046_p}];
          
#set_property PACKAGE_PIN AM20 [get_ports {df_0089_n}];               
#set_property PACKAGE_PIN AL20 [get_ports {df_0089_p}];               
#set_property PACKAGE_PIN AD21 [get_ports {df_0090_n}];               
#set_property PACKAGE_PIN AD20 [get_ports {df_0090_p}];               
 set_property PACKAGE_PIN AG20 [get_ports {df_i_n_10}];        
 set_property PACKAGE_PIN AF20 [get_ports {df_i_p_10}];        
 set_property PACKAGE_PIN AF22 [get_ports {df_i_n_12}];        
 set_property PACKAGE_PIN AE22 [get_ports {df_i_p_12}];        
 set_property PACKAGE_PIN AJ21 [get_ports {df_i_n_15}];        
 set_property PACKAGE_PIN AJ20 [get_ports {df_i_p_15}];        
 set_property PACKAGE_PIN AH23 [get_ports {df_i_n_16}];        
 set_property PACKAGE_PIN AH22 [get_ports {df_i_p_16}];        
 set_property PACKAGE_PIN AG22 [get_ports {df_i_n_17}];        
 set_property PACKAGE_PIN AG21 [get_ports {df_i_p_17}];        
 set_property PACKAGE_PIN AE21 [get_ports {df_i_n_5}];         
 set_property PACKAGE_PIN AE20 [get_ports {df_i_p_5}];         
 set_property PACKAGE_PIN AV22 [get_ports {df_o_n_5}];        
 set_property PACKAGE_PIN AU21 [get_ports {df_o_p_5}];        
 set_property PACKAGE_PIN AN21 [get_ports {diff_clka_n}];             
 set_property PACKAGE_PIN AM21 [get_ports {diff_clka_p}];             
 set_property PACKAGE_PIN AN22 [get_ports {diff_clkb_n}];             
 set_property PACKAGE_PIN AM22 [get_ports {diff_clkb_p}];             
#set_property PACKAGE_PIN AH21 [get_ports {se_003}];                  
#set_property PACKAGE_PIN AJ23 [get_ports {se_025}];                  
#set_property PACKAGE_PIN AP20 [get_ports {se_062}];                  
 set_property PACKAGE_PIN AG24 [get_ports {df_0002_n}];               
 set_property PACKAGE_PIN AF24 [get_ports {df_0002_p}];               
 set_property PACKAGE_PIN AN27 [get_ports {df_0004_n}];            
 set_property PACKAGE_PIN AM27 [get_ports {df_0004_p}];            
 set_property PACKAGE_PIN AP28 [get_ports {df_0007_n}];               
 set_property PACKAGE_PIN AN28 [get_ports {df_0007_p}];               
 set_property PACKAGE_PIN AL28 [get_ports {df_0010_n}];            
 set_property PACKAGE_PIN AL27 [get_ports {df_0010_p}];            
 set_property PACKAGE_PIN AG25 [get_ports {df_0014_n}];               
 set_property PACKAGE_PIN AF25 [get_ports {df_0014_p}];               
 set_property PACKAGE_PIN AE26 [get_ports {df_0018_n}];               
 set_property PACKAGE_PIN AD26 [get_ports {df_0018_p}];               
 set_property PACKAGE_PIN AM25 [get_ports {df_0022_n}];               
 set_property PACKAGE_PIN AM24 [get_ports {df_0022_p}];               
 set_property PACKAGE_PIN AW26 [get_ports {df_0029_n}];               
 set_property PACKAGE_PIN AW25 [get_ports {df_0029_p}];               
 set_property PACKAGE_PIN AJ24 [get_ports {df_0048_n}];               
 set_property PACKAGE_PIN AH24 [get_ports {df_0048_p}];               
 set_property PACKAGE_PIN AR25 [get_ports {df_0049_n}];               
 set_property PACKAGE_PIN AP25 [get_ports {df_0049_p}];               
 set_property PACKAGE_PIN AE25 [get_ports {df_0050_n}];               
 set_property PACKAGE_PIN AD25 [get_ports {df_0050_p}];               
 set_property PACKAGE_PIN AK28 [get_ports {df_0016_n}];            
 set_property PACKAGE_PIN AK27 [get_ports {df_0016_p}];            
 set_property PACKAGE_PIN AK25 [get_ports {df_o_n_10}];       
 set_property PACKAGE_PIN AJ25 [get_ports {df_o_p_10}];       
 set_property PACKAGE_PIN AF27 [get_ports {df_o_n_11}];       
 set_property PACKAGE_PIN AE27 [get_ports {df_o_p_11}];       
 set_property PACKAGE_PIN AU27 [get_ports {df_o_n_12}];       
 set_property PACKAGE_PIN AT27 [get_ports {df_o_p_12}];       
 set_property PACKAGE_PIN AJ26 [get_ports {df_o_n_15}];       
 set_property PACKAGE_PIN AH26 [get_ports {df_o_p_15}];       
 set_property PACKAGE_PIN AL25 [get_ports {df_o_n_16}];       
 set_property PACKAGE_PIN AL24 [get_ports {df_o_p_16}];       
 set_property PACKAGE_PIN AU26 [get_ports {df_o_n_17}];       
 set_property PACKAGE_PIN AU25 [get_ports {df_o_p_17}];       
 set_property PACKAGE_PIN AG27 [get_ports {df_o_n_20}];       
 set_property PACKAGE_PIN AG26 [get_ports {df_o_p_20}];       
 set_property PACKAGE_PIN AT28 [get_ports {df_o_n_2}];        
 set_property PACKAGE_PIN AR28 [get_ports {df_o_p_2}];        
 set_property PACKAGE_PIN AR27 [get_ports {df_o_n_6}];        
 set_property PACKAGE_PIN AR26 [get_ports {df_o_p_6}];        
 set_property PACKAGE_PIN AW28 [get_ports {df_o_n_7}];        
 set_property PACKAGE_PIN AV28 [get_ports {df_o_p_7}];        
 set_property PACKAGE_PIN AN26 [get_ports {fst_clkn_fpga}];           
 set_property PACKAGE_PIN AM26 [get_ports {fst_clkp_fpga}];           
#set_property PACKAGE_PIN AP26 [get_ports {se_000}];                  
#set_property PACKAGE_PIN AV27 [get_ports {se_024}];                  
#set_property PACKAGE_PIN AK26 [get_ports {se_029}];                  
#set_property PACKAGE_PIN AV26 [get_ports {se_032}];                  
#set_property PACKAGE_PIN AH27 [get_ports {se_061}];                  
#set_property PACKAGE_PIN G39 [get_ports {df_i_n_18}];         
#set_property PACKAGE_PIN H39 [get_ports {df_i_p_18}];         
 set_property PACKAGE_PIN D36 [get_ports {df_i_n_54}];         
 set_property PACKAGE_PIN E36 [get_ports {df_i_p_54}];         
#set_property PACKAGE_PIN C34 [get_ports {df_i_n_56}];         
#set_property PACKAGE_PIN D34 [get_ports {df_i_p_56}];         
#set_property PACKAGE_PIN K37 [get_ports {df_i_n_64}];         
#set_property PACKAGE_PIN L37 [get_ports {df_i_p_64}];         
#set_property PACKAGE_PIN J36 [get_ports {df_o_n_27}];        
#set_property PACKAGE_PIN K36 [get_ports {df_o_p_27}];        
#set_property PACKAGE_PIN J39 [get_ports {df_o_n_28}];        
#set_property PACKAGE_PIN J38 [get_ports {df_o_p_28}];        
#set_property PACKAGE_PIN K35 [get_ports {df_o_n_29}];        
#set_property PACKAGE_PIN L35 [get_ports {df_o_p_29}];        
#set_property PACKAGE_PIN K38 [get_ports {df_o_n_30}];        
#set_property PACKAGE_PIN L38 [get_ports {df_o_p_30}];        
#set_property PACKAGE_PIN G34 [get_ports {df_o_n_31}];        
#set_property PACKAGE_PIN H34 [get_ports {df_o_p_31}];        
#set_property PACKAGE_PIN H38 [get_ports {df_o_n_32}];        
#set_property PACKAGE_PIN H37 [get_ports {df_o_p_32}];        
#set_property PACKAGE_PIN G36 [get_ports {df_o_n_33}];     
#set_property PACKAGE_PIN H36 [get_ports {df_o_p_33}];     
#set_property PACKAGE_PIN F37 [get_ports {df_o_n_34}];     
#set_property PACKAGE_PIN G37 [get_ports {df_o_p_34}]; 
#set_property PACKAGE_PIN E38 [get_ports {df_o_n_35}];     
#set_property PACKAGE_PIN F38 [get_ports {df_o_p_35}];     
#set_property PACKAGE_PIN D38 [get_ports {df_o_n_36}];     
#set_property PACKAGE_PIN E37 [get_ports {df_o_p_36}];     
#set_property PACKAGE_PIN B39 [get_ports {df_o_n_37}];        
#set_property PACKAGE_PIN C38 [get_ports {df_o_p_37}];        
#set_property PACKAGE_PIN A38 [get_ports {df_o_n_38}];        
#set_property PACKAGE_PIN A37 [get_ports {df_o_p_38}];        
#set_property PACKAGE_PIN F35 [get_ports {df_o_n_3}];         
#set_property PACKAGE_PIN G35 [get_ports {df_o_p_3}];         
#set_property PACKAGE_PIN A34 [get_ports {df_o_n_47}];        
#set_property PACKAGE_PIN B34 [get_ports {df_o_p_47}];        
#set_property PACKAGE_PIN B37 [get_ports {df_o_n_51}];        
#set_property PACKAGE_PIN C37 [get_ports {df_o_p_51}];        
#set_property PACKAGE_PIN B36 [get_ports {df_o_n_52}];        
#set_property PACKAGE_PIN C36 [get_ports {df_o_p_52}];        
 set_property PACKAGE_PIN D35 [get_ports {df_o_n_57}];        
 set_property PACKAGE_PIN E35 [get_ports {df_o_p_57}];        
 set_property PACKAGE_PIN A35 [get_ports {df_o_n_77}];        
 set_property PACKAGE_PIN B35 [get_ports {df_o_p_77}];        
#set_property PACKAGE_PIN J35 [get_ports {se_071}];                   
#set_property PACKAGE_PIN C39 [get_ports {se_073}];                   
#set_property PACKAGE_PIN F34 [get_ports {se_075}];                   
#set_property PACKAGE_PIN D39 [get_ports {se_076}];                   
#set_property PACKAGE_PIN F39 [get_ports {se_080}];                   
#set_property PACKAGE_PIN L39 [get_ports {se_100}];                   
#set_property PACKAGE_PIN A33 [get_ports {se_101}];                   
#set_property PACKAGE_PIN J34 [get_ports {se_109}];                   
 set_property PACKAGE_PIN G31 [get_ports {df_0068_n}];             
 set_property PACKAGE_PIN H31 [get_ports {df_0068_p}];             
#set_property PACKAGE_PIN G32 [get_ports {df_0085_n}];             
#set_property PACKAGE_PIN H32 [get_ports {df_0085_p}];             
#set_property PACKAGE_PIN L30 [get_ports {df_0154_n}];                
#set_property PACKAGE_PIN M30 [get_ports {df_0154_p}];                
#set_property PACKAGE_PIN D31 [get_ports {df_i_n_58}];         
#set_property PACKAGE_PIN E31 [get_ports {df_i_p_58}];         
#set_property PACKAGE_PIN A30 [get_ports {df_i_n_60}];         
#set_property PACKAGE_PIN B30 [get_ports {df_i_p_60}];         
#set_property PACKAGE_PIN F29 [get_ports {df_i_n_62}];         
#set_property PACKAGE_PIN G29 [get_ports {df_i_p_62}];         
#set_property PACKAGE_PIN J31 [get_ports {df_i_n_66}];         
#set_property PACKAGE_PIN J30 [get_ports {df_i_p_66}];         
#set_property PACKAGE_PIN H29 [get_ports {df_i_n_68}];         
#set_property PACKAGE_PIN J29 [get_ports {df_i_p_68}];         
#set_property PACKAGE_PIN B31 [get_ports {df_i_n_74}];         
#set_property PACKAGE_PIN C31 [get_ports {df_i_p_74}];         
#set_property PACKAGE_PIN M32 [get_ports {df_o_n_39}];        
#set_property PACKAGE_PIN M31 [get_ports {df_o_p_39}];        
#set_property PACKAGE_PIN K32 [get_ports {df_o_n_41}];        
#set_property PACKAGE_PIN K31 [get_ports {df_o_p_41}];        
#set_property PACKAGE_PIN C33 [get_ports {df_o_n_42}];        
#set_property PACKAGE_PIN C32 [get_ports {df_o_p_42}];        
#set_property PACKAGE_PIN L29 [get_ports {df_o_n_43}];        
#set_property PACKAGE_PIN M29 [get_ports {df_o_p_43}];        
#set_property PACKAGE_PIN P30 [get_ports {df_o_n_44}];        
#set_property PACKAGE_PIN R30 [get_ports {df_o_p_44}];        
#set_property PACKAGE_PIN N29 [get_ports {df_o_n_45}];        
#set_property PACKAGE_PIN P29 [get_ports {df_o_p_45}];        
#set_property PACKAGE_PIN A32 [get_ports {df_o_n_46}];        
#set_property PACKAGE_PIN B32 [get_ports {df_o_p_46}];        
#set_property PACKAGE_PIN C29 [get_ports {df_o_n_50}];        
#set_property PACKAGE_PIN D29 [get_ports {df_o_p_50}];        
 set_property PACKAGE_PIN E33 [get_ports {df_o_n_55}];     
 set_property PACKAGE_PIN F33 [get_ports {df_o_p_55}];     
 set_property PACKAGE_PIN E32 [get_ports {df_o_n_56}];     
 set_property PACKAGE_PIN F32 [get_ports {df_o_p_56}];     
 set_property PACKAGE_PIN D30 [get_ports {df_o_n_59}];        
 set_property PACKAGE_PIN E30 [get_ports {df_o_p_59}];        
 set_property PACKAGE_PIN F30 [get_ports {df_o_n_60}];        
 set_property PACKAGE_PIN G30 [get_ports {df_o_p_60}];        
 set_property PACKAGE_PIN H33 [get_ports {df_o_n_61}];        
 set_property PACKAGE_PIN J33 [get_ports {df_o_p_61}];        
 set_property PACKAGE_PIN L33 [get_ports {df_o_n_64}];        
 set_property PACKAGE_PIN L32 [get_ports {df_o_p_64}];        
 set_property PACKAGE_PIN A29 [get_ports {df_o_n_73}];        
 set_property PACKAGE_PIN A28 [get_ports {df_o_p_73}];        
#set_property PACKAGE_PIN B29 [get_ports {se_070}];                   
#set_property PACKAGE_PIN K30 [get_ports {se_081}];                   
#set_property PACKAGE_PIN K33 [get_ports {se_082}];                   
#set_property PACKAGE_PIN D33 [get_ports {se_107}];                   

 set_property PACKAGE_PIN A14 [get_ports {df_0019_n}];                
 set_property PACKAGE_PIN A15 [get_ports {df_0019_p}];                
 set_property PACKAGE_PIN C13 [get_ports {df_0020_n}];                
 set_property PACKAGE_PIN D13 [get_ports {df_0020_p}];                
 set_property PACKAGE_PIN D16 [get_ports {df_0021_n}];                
 set_property PACKAGE_PIN E16 [get_ports {df_0021_p}];                
#set_property PACKAGE_PIN G15 [get_ports {df_0124_n}];             
#set_property PACKAGE_PIN G16 [get_ports {df_0124_p}];             
#set_property PACKAGE_PIN F14 [get_ports {df_0125_n}];             
#set_property PACKAGE_PIN G14 [get_ports {df_0125_p}];             
#set_property PACKAGE_PIN E12 [get_ports {df_0126_n}];                
#set_property PACKAGE_PIN E13 [get_ports {df_0126_p}];                
#set_property PACKAGE_PIN R12 [get_ports {df_0129_n}];                
#set_property PACKAGE_PIN R13 [get_ports {df_0129_p}];                
#set_property PACKAGE_PIN M12 [get_ports {df_0132_n}];                
#set_property PACKAGE_PIN N12 [get_ports {df_0132_p}];                
#set_property PACKAGE_PIN B12 [get_ports {df_0133_n}];                
#set_property PACKAGE_PIN C12 [get_ports {df_0133_p}];                
 set_property PACKAGE_PIN M14 [get_ports {df_i_n_1}];          
 set_property PACKAGE_PIN N14 [get_ports {df_i_p_1}];
 set_property PACKAGE_PIN L13 [get_ports {df_i_p_47}];
 set_property PACKAGE_PIN L12 [get_ports {df_i_n_47}];         
 set_property PACKAGE_PIN L15 [get_ports {df_i_n_48}];         
 set_property PACKAGE_PIN M15 [get_ports {df_i_p_48}];         
 set_property PACKAGE_PIN H13 [get_ports {df_i_n_49}];         
 set_property PACKAGE_PIN J13 [get_ports {df_i_p_49}];         
 set_property PACKAGE_PIN K12 [get_ports {df_i_n_50}];         
 set_property PACKAGE_PIN K13 [get_ports {df_i_p_50}];         
 set_property PACKAGE_PIN E15 [get_ports {df_i_n_80}];      
 set_property PACKAGE_PIN F15 [get_ports {df_i_p_80}];      
 set_property PACKAGE_PIN J15 [get_ports {df_o_n_21}];        
 set_property PACKAGE_PIN K15 [get_ports {df_o_p_21}];        
 set_property PACKAGE_PIN N13 [get_ports {df_o_n_23}];        
 set_property PACKAGE_PIN P13 [get_ports {df_o_p_23}];        
 set_property PACKAGE_PIN F12 [get_ports {df_o_n_25}];        
 set_property PACKAGE_PIN F13 [get_ports {df_o_p_25}];        
 set_property PACKAGE_PIN D14 [get_ports {df_o_n_26}];        
 set_property PACKAGE_PIN D15 [get_ports {df_o_p_26}];        
 set_property PACKAGE_PIN J14 [get_ports {gen_clka_fpga}];            
 set_property PACKAGE_PIN H14 [get_ports {gen_clkb_fpga}];            
#set_property PACKAGE_PIN L14 [get_ports {se_010_fpga}];              
#set_property PACKAGE_PIN H12 [get_ports {se_012}];                   
#set_property PACKAGE_PIN G12 [get_ports {se_016}];                   
#set_property PACKAGE_PIN C16 [get_ports {se_017}];                   
#set_property PACKAGE_PIN P14 [get_ports {se_078}];                   
#set_property PACKAGE_PIN P15 [get_ports {se_097}];

 set_property PACKAGE_PIN AG16 [get_ports {df_o_n_80}]; 
 set_property PACKAGE_PIN AG17 [get_ports {df_o_p_80}]; 

 set_property PACKAGE_PIN AU19 [get_ports {se_096}]; 
 set_property PACKAGE_PIN AD18 [get_ports {se_084}]; 


##-----------------------------------------------------------------------------
## All IO LVCMOS18
##-----------------------------------------------------------------------------
 set_property IOSTANDARD LVCMOS18 [get_ports {se_096}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {se_084}]

 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_80}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_80}]

 set_property IOSTANDARD LVCMOS18 [get_ports {df_0000_n}]
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0000_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0001_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0001_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0002_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0002_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0004_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0004_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0005_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0005_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0007_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0007_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0008_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0008_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0010_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0010_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0011_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0011_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0012_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0012_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0013_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0013_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0014_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0014_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0016_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0016_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0017_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0017_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0018_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0018_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0019_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0019_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0020_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0020_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0021_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0021_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0022_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0022_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0023_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0023_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0028_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0028_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0029_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0029_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0046_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0046_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0048_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0048_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0049_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0049_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0050_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0050_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0051_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0051_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0052_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0052_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0053_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0053_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0056_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0056_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0057_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0057_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0059_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0059_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0068_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0068_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0092_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0092_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0095_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0095_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0099_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0099_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0114_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0114_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0143_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0150_n}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_0150_p}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_1}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_10}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_12}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_15}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_16}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_17}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_20}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_21}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_22}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_23}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_24}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_25}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_26}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_47}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_48}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_49}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_5}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_50}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_n_54}]

 set_property IOSTANDARD LVDS [get_ports {df_i_p_80}]  
 set_property IOSTANDARD LVDS [get_ports {df_i_n_80}]

 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_1}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_10}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_12}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_15}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_16}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_17}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_20}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_21}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_22}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_23}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_24}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_25}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_26}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_47}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_48}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_49}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_5}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_50}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_i_p_54}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_1}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_10}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_11}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_12}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_14}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_15}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_16}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_17}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_19}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_2}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_20}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_21}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_23}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_25}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_26}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_40}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_5}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_54}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_55}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_56}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_57}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_59}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_6}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_60}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_61}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_64}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_69}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_7}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_71}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_73}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_77}]  
 
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_n_9}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_1}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_10}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_11}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_12}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_14}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_15}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_16}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_17}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_19}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_2}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_20}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_21}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_23}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_25}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_26}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_40}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_5}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_54}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_55}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_56}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_57}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_59}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_6}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_60}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_61}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_64}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_69}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_7}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_71}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_73}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_77}]  
 set_property IOSTANDARD LVCMOS18 [get_ports {df_o_p_9}]  