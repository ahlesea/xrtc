-------------------------------------------------------------------------------
-- License    : MIT
-- Copyright (c) 2003, Sam Minger and Gary Swift (for the Xilinx Radiation Test Consortium - XRTC)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- File : xilinx_ser_top.vhd
-- Author : Sam Minger
-- Created : 07/29/2003
-------------------------------------------------------------------------------
-- virtex7 project
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;


entity funcmon_top is
   port(
        clk                       : in    std_logic;                       -- General Clocks, 125 MHz Clock
        
        command                   : in    std_logic_vector(  31 downto 0); -- FUNCMON to IDE (replaces funcmon_in_a)
        command_load              : in    std_logic;                       -- FUNCMON to IDE
        
        fm_counters               : out   std_logic_vector(4095 downto 0); -- FUNCMON to IDE

        -------------------------------------------------------------------------------
        -- Test IOs
        -------------------------------------------------------------------------------
        -- KU060 Bank 24 (49 IOs)
        df_i_n_20                 : out   std_logic; -- KU060 Bank 24  (diff_bus_in_n[20])
        df_i_p_20                 : in    std_logic; -- KU060 Bank 24  (diff_bus_in_p[20])

        df_o_n_1                  : in    std_logic; -- KU060 Bank 24  (diff_bus_out_n[1])
        df_o_p_1                  : in    std_logic; -- KU060 Bank 24  (diff_bus_out_p[1])
        df_o_n_9                  : out   std_logic; -- KU060 Bank 24  (diff_bus_out_n[9])
        df_o_p_9                  : in    std_logic; -- KU060 Bank 24  (diff_bus_out_p[9])
        df_o_n_14                 : in    std_logic; -- KU060 Bank 24  (diff_bus_out_n[14])
        df_o_p_14                 : in    std_logic; -- KU060 Bank 24  (diff_bus_out_p[14])
        df_o_n_19                 : out   std_logic; -- KU060 Bank 24  (diff_bus_out_n[19])
        df_o_p_19                 : in    std_logic; -- KU060 Bank 24  (diff_bus_out_p[19])

        df_0051_n                 : in    std_logic; -- KU060 Bank 24
        df_0051_p                 : in    std_logic; -- KU060 Bank 24
        df_0052_n                 : out   std_logic; -- KU060 Bank 24
        df_0052_p                 : in    std_logic; -- KU060 Bank 24
        df_0053_n                 : in    std_logic; -- KU060 Bank 24
        df_0053_p                 : in    std_logic; -- KU060 Bank 24
        df_0056_n                 : out   std_logic; -- KU060 Bank 24
        df_0056_p                 : in    std_logic; -- KU060 Bank 24
        df_0057_n                 : in    std_logic; -- KU060 Bank 24
        df_0057_p                 : in    std_logic; -- KU060 Bank 24
        df_0059_n                 : out   std_logic; -- KU060 Bank 24
        df_0059_p                 : in    std_logic; -- KU060 Bank 24
        df_0092_n                 : in    std_logic; -- KU060 Bank 24
        df_0092_p                 : in    std_logic; -- KU060 Bank 24
        df_0095_n                 : out   std_logic; -- KU060 Bank 24
        df_0095_p                 : in    std_logic; -- KU060 Bank 24
        df_0099_n                 : in    std_logic; -- KU060 Bank 24 (df_0099_n) 
        df_0099_p                 : in    std_logic; -- KU060 Bank 24 (df_0099_p) 
        df_0114_n                 : in    std_logic; -- KU060 Bank 24
        df_0114_p                 : in    std_logic; -- KU060 Bank 24

        -- KU060 Bank 25 (52 IOs)
        df_i_n_21                 : out   std_logic; -- KU060 Bank 25 (diff_bus_in_cc_n[21])
        df_i_p_21                 : in    std_logic; -- KU060 Bank 25 (diff_bus_in_cc_p[21])
        df_i_n_22                 : in    std_logic; -- KU060 Bank 25 (diff_bus_in_cc_n[22])
        df_i_p_22                 : in    std_logic; -- KU060 Bank 25 (diff_bus_in_cc_p[22])
        df_i_n_23                 : out   std_logic; -- KU060 Bank 25 (diff_bus_in_n[23])   
        df_i_p_23                 : in    std_logic; -- KU060 Bank 25 (diff_bus_in_p[23])   
        df_i_n_24                 : in    std_logic; -- KU060 Bank 25 (diff_bus_in_n[24])   
        df_i_p_24                 : in    std_logic; -- KU060 Bank 25 (diff_bus_in_p[24])   
        df_i_n_25                 : out   std_logic; -- KU060 Bank 25 (diff_bus_in_n[25])   
        df_i_p_25                 : in    std_logic; -- KU060 Bank 25 (diff_bus_in_p[25])   
        df_i_n_26                 : in    std_logic; -- KU060 Bank 25 (diff_bus_in_n[26])   
        df_i_p_26                 : in    std_logic; -- KU060 Bank 25 (diff_bus_in_p[26])   

        df_o_n_40                 : out   std_logic; -- KU060 Bank 25 (diff_bus_out_cc_n[40])
        df_o_p_40                 : in    std_logic; -- KU060 Bank 25 (diff_bus_out_cc_p[40])
        df_o_n_54                 : in    std_logic; -- KU060 Bank 25 (diff_bus_out_n[54])   
        df_o_p_54                 : in    std_logic; -- KU060 Bank 25 (diff_bus_out_p[54])    
        df_o_n_69                 : out   std_logic; -- KU060 Bank 25 (diff_bus_out_n[69])   
        df_o_p_69                 : in    std_logic; -- KU060 Bank 25 (diff_bus_out_p[69])   
        df_o_n_71                 : in    std_logic; -- KU060 Bank 25 (diff_bus_out_n[71])   
        df_o_p_71                 : in    std_logic; -- KU060 Bank 25 (diff_bus_out_p[71])   

        df_0150_n                 : in    std_logic; -- KU060 Bank 25 (df_cc_0150_n)
        df_0150_p                 : in    std_logic; -- KU060 Bank 25 (df_cc_0150_p)

        -- KU060 Bank 44 (47 IOs)
        df_i_n_5                  : out   std_logic; -- KU060 Bank 44 (diff_bus_in_n[5])
        df_i_p_5                  : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[5])
        df_i_n_10                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[10])
        df_i_p_10                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[10])
        df_i_n_12                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_n[12])
        df_i_p_12                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[12])
        df_i_n_15                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[15])
        df_i_p_15                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[15])
        df_i_n_16                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_n[16])
        df_i_p_16                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[16])
        df_i_n_17                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[17])
        df_i_p_17                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[17])

        df_o_n_5                  : out   std_logic; -- KU060 Bank 44 (diff_bus_out_n[5])
        df_o_p_5                  : in    std_logic; -- KU060 Bank 44 (diff_bus_out_p[5])

        df_0000_n                 : in    std_logic; -- KU060 Bank 44
        df_0000_p                 : in    std_logic; -- KU060 Bank 44
        df_0001_n                 : out   std_logic; -- KU060 Bank 44
        df_0001_p                 : in    std_logic; -- KU060 Bank 44
        df_0005_n                 : in    std_logic; -- KU060 Bank 44
        df_0005_p                 : in    std_logic; -- KU060 Bank 44
        df_0008_n                 : out   std_logic; -- KU060 Bank 44
        df_0008_p                 : in    std_logic; -- KU060 Bank 44
        df_0011_n                 : in    std_logic; -- KU060 Bank 44
        df_0011_p                 : in    std_logic; -- KU060 Bank 44
        df_0012_n                 : out   std_logic; -- KU060 Bank 44
        df_0012_p                 : in    std_logic; -- KU060 Bank 44
        df_0013_n                 : in    std_logic; -- KU060 Bank 44
        df_0013_p                 : in    std_logic; -- KU060 Bank 44
        df_0017_n                 : out   std_logic; -- KU060 Bank 44
        df_0017_p                 : in    std_logic; -- KU060 Bank 44
        df_0023_n                 : in    std_logic; -- KU060 Bank 44
        df_0023_p                 : in    std_logic; -- KU060 Bank 44
        df_0028_n                 : out   std_logic; -- KU060 Bank 44
        df_0028_p                 : in    std_logic; -- KU060 Bank 44
        df_0046_n                 : in    std_logic; -- KU060 Bank 44
        df_0046_p                 : in    std_logic; -- KU060 Bank 44

        -- KU060 Bank 45 (51 IOs)
        df_o_n_2                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[2])
        df_o_p_2                  : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[2])
        df_o_n_6                  : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[6])
        df_o_p_6                  : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[6])
        df_o_n_7                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[7])
        df_o_p_7                  : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[7])
        df_o_n_10                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[10])
        df_o_p_10                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[10])
        df_o_n_11                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[11])
        df_o_p_11                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[11])
        df_o_n_12                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[12])
        df_o_p_12                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[12])
        df_o_n_15                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[15])
        df_o_p_15                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[15])
        df_o_n_16                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[16])
        df_o_p_16                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[16])
        df_o_n_17                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[17])
        df_o_p_17                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[17])
        df_o_n_20                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[20])
        df_o_p_20                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_p[20])

        df_0002_n                 : out   std_logic; -- KU060 Bank 45 (df_0002_n)
        df_0002_p                 : in    std_logic; -- KU060 Bank 45 (df_0002_p)
        df_0004_n                 : in    std_logic; -- KU060 Bank 45 (df_0004_cc_n)
        df_0004_p                 : in    std_logic; -- KU060 Bank 45 (df_0004_cc_p)
        df_0007_n                 : out   std_logic; -- KU060 Bank 45 (df_0007_n)
        df_0007_p                 : in    std_logic; -- KU060 Bank 45 (df_0007_p)
        df_0010_n                 : in    std_logic; -- KU060 Bank 45 (df_0010_cc_n)
        df_0010_p                 : in    std_logic; -- KU060 Bank 45 (df_0010_cc_p)
        df_0014_n                 : out   std_logic; -- KU060 Bank 45 (df_0014_n)
        df_0014_p                 : in    std_logic; -- KU060 Bank 45 (df_0014_p)
        df_0016_n                 : in    std_logic; -- KU060 Bank 45 (df_cc_0016_n)
        df_0016_p                 : in    std_logic; -- KU060 Bank 45 (df_cc_0016_p)
        df_0018_n                 : out   std_logic; -- KU060 Bank 45 (df_0018_n)
        df_0018_p                 : in    std_logic; -- KU060 Bank 45 (df_0018_p)
        df_0022_n                 : in    std_logic; -- KU060 Bank 45 (df_0022_n)
        df_0022_p                 : in    std_logic; -- KU060 Bank 45 (df_0022_p)
        df_0029_n                 : out   std_logic; -- KU060 Bank 45 (df_0029_n)
        df_0029_p                 : in    std_logic; -- KU060 Bank 45 (df_0029_p)
        df_0048_n                 : in    std_logic; -- KU060 Bank 45 (df_0048_n)
        df_0048_p                 : in    std_logic; -- KU060 Bank 45 (df_0048_p)
        df_0049_n                 : out   std_logic; -- KU060 Bank 45 (df_0049_n)
        df_0049_p                 : in    std_logic; -- KU060 Bank 45 (df_0049_p)
        df_0050_n                 : in    std_logic; -- KU060 Bank 45 (df_0050_n)
        df_0050_p                 : in    std_logic; -- KU060 Bank 45 (df_0050_p)
        
        -- KU060 Bank 46 (52 IOs)
        df_i_n_54                 : out   std_logic; -- KU060 Bank 46 (diff_bus_in_n[54])
        df_i_p_54                 : in    std_logic; -- KU060 Bank 46 (diff_bus_in_p[54])
        df_o_n_57                 : in    std_logic; -- KU060 Bank 46 (diff_bus_out_n[57])
        df_o_p_57                 : in    std_logic; -- KU060 Bank 46 (diff_bus_out_p[57])
        df_o_n_77                 : in    std_logic; -- KU060 Bank 46 (diff_bus_out_n[77])
        df_o_p_77                 : in    std_logic; -- KU060 Bank 46 (diff_bus_out_p[77])

        -- KU060 Bank 47 (52 IOs)
        df_o_n_55                 : out   std_logic; -- KU060 Bank 47 (diff_bus_out_cc_n[55])
        df_o_p_55                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_cc_p[55])
        df_o_n_56                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_cc_n[56])
        df_o_p_56                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_cc_p[56])
        df_o_n_59                 : out   std_logic; -- KU060 Bank 47 (diff_bus_out_n[59]) 
        df_o_p_59                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_p[59]) 
        df_o_n_60                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_n[60]) 
        df_o_p_60                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_p[60]) 
        df_o_n_61                 : out   std_logic; -- KU060 Bank 47 (diff_bus_out_n[61]) 
        df_o_p_61                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_p[61]) 
        df_o_n_64                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_n[64]) 
        df_o_p_64                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_p[64]) 
        df_o_n_73                 : out   std_logic; -- KU060 Bank 47 (diff_bus_out_n[73]) 
        df_o_p_73                 : in    std_logic; -- KU060 Bank 47 (diff_bus_out_p[73]) 

        df_0068_n                 : in    std_logic; -- KU060 Bank 47 (df_0068_cc_n)
        df_0068_p                 : in    std_logic; -- KU060 Bank 47 (df_0068_cc_p)

        -- KU060 Bank 48 (not used. not availabel for V7 485)

        -- KU060 Bank 64 (bank with limited IO to FuncMon FPGA, close to bank 44 or 65)
        df_o_n_80                 : out   std_logic; -- KU060 Bank 64 (diff_bus_out_n[80])
        df_o_p_80                 : in    std_logic; -- KU060 Bank 64 (diff_bus_out_p[80])

        se_096                    : in    std_logic; -- KU060 Bank 64
        df_0143_p                 : in    std_logic; -- KU060 Bank 64
        se_084                    : in    std_logic; -- KU060 Bank 64

        -- KU060 Bank 66 (46 IOs)
        df_i_n_1                  : in    std_logic; -- KU060 Bank 66 (diff_bus_in_n[1]) 
        df_i_p_1                  : in    std_logic; -- KU060 Bank 66 (diff_bus_in_p[1]) 
        df_i_n_47                 : in    std_logic; -- KU060 Bank 66 (diff_bus_in_n[47]) 
        df_i_p_47                 : in    std_logic; -- KU060 Bank 66 (diff_bus_in_p[47]) 
        df_i_n_48                 : in    std_logic; -- KU060 Bank 66 (diff_bus_in_n[48]) 
        df_i_p_48                 : in    std_logic; -- KU060 Bank 66 (diff_bus_in_p[48]) 
        df_i_n_49                 : in    std_logic; -- KU060 Bank 66 (diff_bus_in_n[49]) 
        df_i_p_49                 : in    std_logic; -- KU060 Bank 66 (diff_bus_in_p[49]) 
        df_i_n_50                 : out   std_logic; -- KU060 Bank 66 (diff_bus_in_n[50]) 
        df_i_p_50                 : in    std_logic; -- KU060 Bank 66 (diff_bus_in_p[50]) 
        df_i_n_80                 : out   std_logic; -- KU060 Bank 66 (diff_bus_in_cc_n[80]) Test Clock output
        df_i_p_80                 : out   std_logic; -- KU060 Bank 66 (diff_bus_in_cc_p[80]) Test Clock output

        df_o_n_21                 : out   std_logic; -- KU060 Bank 66 (diff_bus_out_n[21])
        df_o_p_21                 : in    std_logic; -- KU060 Bank 66 (diff_bus_out_p[21])
        df_o_n_23                 : in    std_logic; -- KU060 Bank 66 (diff_bus_out_n[23])
        df_o_p_23                 : in    std_logic; -- KU060 Bank 66 (diff_bus_out_p[23])
        df_o_n_25                 : out   std_logic; -- KU060 Bank 66 (diff_bus_out_n[25])
        df_o_p_25                 : in    std_logic; -- KU060 Bank 66 (diff_bus_out_p[25])
        df_o_n_26                 : in    std_logic; -- KU060 Bank 66 (diff_bus_out_n[26])
        df_o_p_26                 : in    std_logic; -- KU060 Bank 66 (diff_bus_out_p[26])

        df_0019_n                 : out   std_logic; -- KU060 Bank 66
        df_0019_p                 : in    std_logic; -- KU060 Bank 66
        df_0020_n                 : in    std_logic; -- KU060 Bank 66
        df_0020_p                 : in    std_logic; -- KU060 Bank 66
        df_0021_n                 : in    std_logic; -- KU060 Bank 66
        df_0021_p                 : in    std_logic; -- KU060 Bank 66

        led_status                : out   std_logic); -- LED Pin
end funcmon_top;


architecture behavioral of funcmon_top is
   
   -- General Counter for LED HeartBeat
   signal led_counter : std_logic_vector(22 downto 0); -- Counter for the light Local Clock Division.

   signal clk_in_lo               : std_logic;
   signal clk_in_md               : std_logic;
   signal clk_in_hi               : std_logic;

   signal start                   : std_logic;
   signal counter                 : std_logic_vector(4095 downto 0); 

   signal muxed_clk               : std_logic;
   signal test_clk                : std_logic;

   signal clk_fb                  : std_logic;

   component funcmon_dut_bus_test is
     port(
      rst                       : in    std_logic;

      test_clk                  : in    std_logic; -- DUT test clock

      count_enable              : in    std_logic;

      fm_mode                   : in    std_logic_vector(   1 downto 0);
      fm_cmd                    : in    std_logic_vector(   3 downto 0);
      fm_pattern                : in    std_logic_vector(   1 downto 0);

      counter                   : out   std_logic_vector(4095 downto 0);

      iob_in                    : out   std_logic_vector(  41 downto 0); -- respect to DUT
      iob_out                   : in    std_logic_vector( 125 downto 0)  -- respect to DUT
      );
  end component;


   component clkmac is
      port ( clkfb_in           : in    std_logic; 
             CLKIN1_IN          : in    std_logic; 
             CLKOUT0_OUT        : out   std_logic; 
             CLKOUT1_OUT        : out   std_logic; 
             CLKOUT2_OUT        : out   std_logic; 
             clkfb_out          : out   std_logic;
             LOCKED_OUT         : out   std_logic);
   end component;


  -- Functional Monitor Interface
  signal rst                 : std_logic;

--signal fm_data_strobe      : std_logic;
  signal fm_mode             : std_logic_vector ( 1 downto 0);
  signal fm_cmd              : std_logic_vector ( 3 downto 0);
  signal fm_pattern          : std_logic_vector ( 1 downto 0);

  signal rst_check_s         : std_logic;

  signal clk_freq_sel        : std_logic_vector(1 downto 0);

  constant IN_IOB_COUNT      : integer := 42;

  signal internal_bus        : std_logic_vector(IN_IOB_COUNT-1 downto 0);   -- respect to DUT
  signal iob_in              : std_logic_vector(IN_IOB_COUNT-1 downto 0);   -- respect to DUT
  signal iob_out             : std_logic_vector(IN_IOB_COUNT*3-1 downto 0); -- respect to DUT
  signal iob_out_a           : std_logic_vector(IN_IOB_COUNT-1 downto 0);   -- respect to DUT
  signal iob_out_b           : std_logic_vector(IN_IOB_COUNT-1 downto 0);   -- respect to DUT
  signal iob_out_c           : std_logic_vector(IN_IOB_COUNT-1 downto 0);   -- respect to DUT
                                                                            
  signal diff_in_p           : std_logic_vector(IN_IOB_COUNT-1 downto 0);   -- respect to DUT
  signal diff_in_n           : std_logic_vector(IN_IOB_COUNT-1 downto 0);   -- respect to DUT
                                                                            
  signal test_clk_out        : std_logic;

begin


   clk_freq_sel    <= fm_cmd(3 downto 2);

   fm_counters     <= counter;

   -------------------------------------------
   -- Functional Monitor User Input Signals --
   -------------------------------------------
-- fm_mode         <= funcmon_in_a(17) & funcmon_in_a(16);
   fm_mode         <= "00";
                   
-- fm_cmd          <= funcmon_in_a(15) & funcmon_in_a(14) & funcmon_in_a(13) & funcmon_in_a(12);
-- fm_cmd          <= command(27 downto 24);
   fm_cmd          <= command( 3 downto  0);
                   
-- fm_pattern      <= funcmon_in_a(11) & funcmon_in_a(10);
-- fm_pattern      <= command(29 downto 28);
   fm_pattern      <= command( 5 downto  4);
                   
-- fm_data_strobe  <= funcmon_in_a(7);
-- fm_data_strobe  <= command_load;

   rst             <= command(7);
   start           <= command(6);

   -------------------------------------------
   -- Function Monitor Interface Signals --
   -------------------------------------------
   -- Input Signals to funcmon_if
-- regsel          <= funcmon_in_a(18) & funcmon_in_a(5) & funcmon_in_a(4) &
--                    funcmon_in_a(3)  & funcmon_in_a(2) & funcmon_in_a(1);

-- update          <= funcmon_in_a(6);


    count_led : process (clk_in_lo, rst)
    begin
      if (rst = '1') then
        led_counter    <= (others => '0');
      elsif(clk_in_lo'EVENT and clk_in_lo = '1') then
        led_counter    <= unsigned(led_counter)  + '1';
      end if;
    end process;

    led_status <= led_counter(led_counter'high); -- Output LED value "Heart Beat"


    -- Function Monitor
    funcmon_dut_bus_test_i : funcmon_dut_bus_test
      port map (
        -- configmon reset signal
        rst                     => rst,                 -- (i)

        test_clk                => test_clk,            -- (i)

        count_enable            => start,               -- (i)

        fm_mode                 => fm_mode,             -- (i)
        fm_cmd                  => fm_cmd,              -- (i)
        fm_pattern              => fm_pattern,          -- (i)

        counter                 => counter,             -- (o)

        iob_in                  => iob_in,              -- respect to DUT
        iob_out                 => iob_out              -- respect to DUT
        );



------------------------------------------------------------------------------
--  Clock         Output      Phase      Duty Cycle   Pk-to-Pk     Phase
--                Freq (MHz)  (degrees)    (%)       Jitter (ps)  Error (ps)
------------------------------------------------------------------------------
-- CLKIN1*M/D should be 400 to 1,200 MHz
-- M=4, D=1 currently used >> 500 MHz
-- M=16, D=5 will give 400 MHz
------------------------------------------------------------------------------
-- clk_in          125.000

-- CLKOUT0_OUT     125.000  (125 x 4) / 4
-- CLKOUT1_OUT      15.625  (125 x 4) / 32
-- CLKOUT2_OUT       3.906  (125 x 4) / 128
------------------------------------------------------------------------------
   clkmac_i : clkmac
      port map(
         clkfb_in       => clk_fb,
         CLKIN1_IN      => clk,

         CLKOUT0_OUT    => clk_in_hi,
         CLKOUT1_OUT    => clk_in_md,
         CLKOUT2_OUT    => clk_in_lo,
         clkfb_out      => clk_fb,
         LOCKED_OUT     => open);


   -- BUFGMUX: Global Clock Buffer 2-to-1 MUX
   -- Virtex-II/II-Pro/4/5, Spartan-3/3E/3A, KU
   BUFGMUX_clk_mux_i0 : BUFGMUX
     port map (
       O      => muxed_clk,           -- Clock MUX output

       I0     => clk_in_lo,           -- low freq clock in 
       I1     => clk_in_md,           -- middle freq clock in
       S      => clk_freq_sel(0));    -- Clock select input


   BUFGMUX_clk_mux_i1 : BUFGMUX
     port map (
       O      => test_clk,            -- Test clock output

       I0     => muxed_clk,           -- muxed clock
       I1     => clk_in_hi,           -- high freq clock in 
       S      => clk_freq_sel(1));    -- Clock select input


-------------------------------------------------------------------------------
-- Input to Output routing
-------------------------------------------------------------------------------

  gen_data_i : for i in 0 to (IN_IOB_COUNT-1) generate

    iob_out(i*3)   <= iob_out_a(i);
    iob_out(i*3+1) <= iob_out_b(i);
    iob_out(i*3+2) <= iob_out_c(i);

  end generate;


-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 24 (49 IOs)
-------------------------------------------------------------------------------
  df_i_n_20        <= iob_in(0);
  iob_out_a(0)     <= df_i_p_20;
  iob_out_b(0)     <= df_o_n_1;
  iob_out_c(0)     <= df_o_p_1;
 
  df_o_n_9         <= iob_in(1);           
  iob_out_a(1)     <= df_o_p_9;           
  iob_out_b(1)     <= df_o_n_14;           
  iob_out_c(1)     <= df_o_p_14;           

  df_o_n_19        <= iob_in(2);           
  iob_out_a(2)     <= df_o_p_19;           
  iob_out_b(2)     <= df_0051_n;           
  iob_out_c(2)     <= df_0051_p;           

  df_0052_n        <= iob_in(3);           
  iob_out_a(3)     <= df_0052_p;           
  iob_out_b(3)     <= df_0053_n;           
  iob_out_c(3)     <= df_0053_p;           

  df_0056_n        <= iob_in(4);           
  iob_out_a(4)     <= df_0056_p;           
  iob_out_b(4)     <= df_0057_n;           
  iob_out_c(4)     <= df_0057_p;           

  df_0059_n        <= iob_in(5);           
  iob_out_a(5)     <= df_0059_p;           
  iob_out_b(5)     <= df_0092_n;           
  iob_out_c(5)     <= df_0092_p;              

  df_0095_n        <= iob_in(6);           
  iob_out_a(6)     <= df_0095_p;           
  iob_out_b(6)     <= df_0099_n;           
  iob_out_c(6)     <= df_0099_p;           
             
-- UNUSED
--df_0114_n    
--df_0114_p

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 25 (52 IOs)
-------------------------------------------------------------------------------
  df_i_n_21     <= iob_in(7);
  iob_out_a(7)  <= df_i_p_21;
  iob_out_b(7)  <= df_i_n_22;
  iob_out_c(7)  <= df_i_p_22;
                                        
  df_i_n_23     <= iob_in(8);
  iob_out_a(8)  <= df_i_p_23;
  iob_out_b(8)  <= df_i_n_24;
  iob_out_c(8)  <= df_i_p_24;
                                        
  df_i_n_25     <= iob_in(9);
  iob_out_a(9)  <= df_i_p_25;
  iob_out_b(9)  <= df_i_n_26;
  iob_out_c(9)  <= df_i_p_26;
                                        
  df_o_n_40     <= iob_in(10);
  iob_out_a(10) <= df_o_p_40;
  iob_out_b(10) <= df_o_n_54;
  iob_out_c(10) <= df_o_p_54;
                                        
  df_o_n_69     <= iob_in(11);
  iob_out_a(11) <= df_o_p_69;
  iob_out_b(11) <= df_o_n_71;
  iob_out_c(11) <= df_o_p_71;

-- UNUSED
--df_0150_n
--df_0150_p

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 44 (47 IOs)
-------------------------------------------------------------------------------
  df_i_n_5      <= iob_in(12);
  iob_out_a(12) <= df_i_p_5;
  iob_out_b(12) <= df_i_n_10;
  iob_out_c(12) <= df_i_p_10;
                                        
  df_i_n_12     <= iob_in(13);
  iob_out_a(13) <= df_i_p_12;
  iob_out_b(13) <= df_i_n_15;
  iob_out_c(13) <= df_i_p_15;
                                        
  df_i_n_16     <= iob_in(14);
  iob_out_a(14) <= df_i_p_16;
  iob_out_b(14) <= df_i_n_17;
  iob_out_c(14) <= df_i_p_17;
                                        
  df_o_n_5      <= iob_in(15);
  iob_out_a(15) <= df_o_p_5;
  iob_out_b(15) <= df_0000_n;
  iob_out_c(15) <= df_0000_p;
                                        
  df_0001_n     <= iob_in(16);
  iob_out_a(16) <= df_0001_p;
  iob_out_b(16) <= df_0005_n;
  iob_out_c(16) <= df_0005_p;
                                        
  df_0008_n     <= iob_in(17);
  iob_out_a(17) <= df_0008_p;
  iob_out_b(17) <= df_0011_n;
  iob_out_c(17) <= df_0011_p;
                                        
  df_0012_n     <= iob_in(18);
  iob_out_a(18) <= df_0012_p;
  iob_out_b(18) <= df_0013_n;
  iob_out_c(18) <= df_0013_p;
                                        
  df_0017_n     <= iob_in(19);
  iob_out_a(19) <= df_0017_p;
  iob_out_b(19) <= df_0023_n;
  iob_out_c(19) <= df_0023_p;
                                        
  df_0028_n     <= iob_in(20);
  iob_out_a(20) <= df_0028_p;
  iob_out_b(20) <= df_0046_n;
  iob_out_c(20) <= df_0046_p;

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 45 (51 IOs)
-------------------------------------------------------------------------------
  df_o_n_2      <= iob_in(21);
  iob_out_a(21) <= df_o_p_2;
  iob_out_b(21) <= df_o_n_6;
  iob_out_c(21) <= df_o_p_6;
                                        
  df_o_n_7      <= iob_in(22);
  iob_out_a(22) <= df_o_p_7;
  iob_out_b(22) <= df_o_n_10;
  iob_out_c(22) <= df_o_p_10;
                                        
  df_o_n_11     <= iob_in(23);
  iob_out_a(23) <= df_o_p_11;
  iob_out_b(23) <= df_o_n_12;
  iob_out_c(23) <= df_o_p_12;
                                        
  df_o_n_15     <= iob_in(24);
  iob_out_a(24) <= df_o_p_15;
  iob_out_b(24) <= df_o_n_16;
  iob_out_c(24) <= df_o_p_16;
                                        
  df_o_n_17     <= iob_in(25);
  iob_out_a(25) <= df_o_p_17;
  iob_out_b(25) <= df_o_n_20;
  iob_out_c(25) <= df_o_p_20;
                                        
  df_0002_n     <= iob_in(26);
  iob_out_a(26) <= df_0002_p;
  iob_out_b(26) <= df_0004_n;
  iob_out_c(26) <= df_0004_p;
                                        
  df_0007_n     <= iob_in(27);
  iob_out_a(27) <= df_0007_p;
  iob_out_b(27) <= df_0010_n;
  iob_out_c(27) <= df_0010_p;
                                        
  df_0014_n     <= iob_in(28);
  iob_out_a(28) <= df_0014_p;
  iob_out_b(28) <= df_0016_n;
  iob_out_c(28) <= df_0016_p;
                                        
  df_0018_n     <= iob_in(29);
  iob_out_a(29) <= df_0018_p;
  iob_out_b(29) <= df_0022_n;
  iob_out_c(29) <= df_0022_p;

  df_0029_n     <= iob_in(30);
  iob_out_a(30) <= df_0029_p;
  iob_out_b(30) <= df_0048_n;
  iob_out_c(30) <= df_0048_p;
                                       
  df_0049_n     <= iob_in(31);
  iob_out_a(31) <= df_0049_p;
  iob_out_b(31) <= df_0050_n;
  iob_out_c(31) <= df_0050_p;

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 46 (52 IOs)
-------------------------------------------------------------------------------
  df_i_n_54     <= iob_in(32);
  iob_out_a(32) <= df_i_p_54;
  iob_out_b(32) <= df_o_n_57;
  iob_out_c(32) <= df_o_p_57;

-- UNUSED
--df_o_n_77
--df_o_p_77

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 47 (52 IOs)
-------------------------------------------------------------------------------
  df_o_n_55     <= iob_in(33);
  iob_out_a(33) <= df_o_p_55;
  iob_out_b(33) <= df_o_n_56;
  iob_out_c(33) <= df_o_p_56;
                                        
  df_o_n_59     <= iob_in(34);
  iob_out_a(34) <= df_o_p_59;
  iob_out_b(34) <= df_o_n_60;
  iob_out_c(34) <= df_o_p_60;
                                        
  df_o_n_61     <= iob_in(35);
  iob_out_a(35) <= df_o_p_61;
  iob_out_b(35) <= df_o_n_64;
  iob_out_c(35) <= df_o_p_64;
                                        
  df_o_n_73     <= iob_in(36);
  iob_out_a(36) <= df_o_p_73;
  iob_out_b(36) <= df_0068_n;
  iob_out_c(36) <= df_0068_p;

-------------------------------------------------------------------------------
-- KU060 Bank 48 (not used. not availabel for V7 680)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- KU060 Bank 64 (bank with limited IO to FuncMon FPGA, close to bank 44 or 65)
-------------------------------------------------------------------------------
  df_o_n_80     <= iob_in(37);
  iob_out_a(37) <= df_o_p_80;
  iob_out_b(37) <= se_096;
  iob_out_c(37) <= se_084;

-- UNUSED
--df_0143_p

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 66 (46 IOs)
-------------------------------------------------------------------------------
  df_i_n_50     <= iob_in(38);
  iob_out_a(38) <= df_i_p_50;
  iob_out_b(38) <= df_0021_n;
  iob_out_c(38) <= df_0021_p;
                                        
  df_o_n_21     <= iob_in(39);
  iob_out_a(39) <= df_o_p_21;
  iob_out_b(39) <= df_o_n_23;
  iob_out_c(39) <= df_o_p_23;
                                        
  df_o_n_25     <= iob_in(40);
  iob_out_a(40) <= df_o_p_25;
  iob_out_b(40) <= df_o_n_26;
  iob_out_c(40) <= df_o_p_26;
                                        
  df_0019_n     <= iob_in(41);
  iob_out_a(41) <= df_0019_p;
  iob_out_b(41) <= df_0020_n;
  iob_out_c(41) <= df_0020_p;

-- Unused
--df_i_n_1
--df_i_p_1;
--df_i_n_47;
--df_i_p_47;
--df_i_n_48
--df_i_p_48;
--df_i_n_49;
--df_i_p_49;

-- Test Clock output
--df_i_n_80
--df_i_p_80

  dut_gen_clk_oddr : ODDR
    port map (
      Q                 => test_clk_out, -- DDR output
  
      C                 => test_clk,   -- clock input
      CE                => '1',        -- clock enable input
      D1                => '1',        -- data input (positive edge)
      D2                => '0',        -- data input (negative edge)
      R                 => '0',        -- reset input
      S                 => '0');       -- set input

  obufds_i : OBUFDS
    generic map (
      IOSTANDARD => "LVDS")
    port map (
      O   => df_i_p_80,
      OB  => df_i_n_80,
      I   => test_clk_out);

end behavioral;
