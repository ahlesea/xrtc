-------------------------------------------------------------------------------
-- License    : MIT
-- Copyright (c) 2021, P H Park and Gary Swift (for the Xilinx Radiation Test Consortium - XRTC)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the �Software�), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED �AS IS�, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
------------------------------------------------------------------------------
--
-- File Name   : iob_lvds_dut_noreg.vhd
-- Description : LVDS IOB radiation test build - IOB unregistered
--
-- Author      : P H Park for the XRTC
-- Date        : 3/18/2021
--
-------------------------------------------------------------------------------
-- Revision History
-------------------------------------------------------------------------------
--
-- $Log$
--
-------------------------------------------------------------------------------
-- Pass each IOB input to multiple IOB outputs (3 or 4, typically).
-- This allows distinguishing SEUs at input vs. output.

-- This version places a register in both the input and output IOBs. 
-- Nothing used in fabric except routing and clocking.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

library XILINXCORELIB;

entity iob_lvds_dut_noreg is
  port (
      --diff_bus_in_n             : in    std_logic_vector(20 downto 0);
      --diff_bus_in_p             : in    std_logic_vector(20 downto 0);
      --diff_bus_out_n            : out   std_logic_vector(20 downto 0);
      --diff_bus_out_p            : out   std_logic_vector(20 downto 0);

        -- clocks

        diff_clka_n               : in    std_logic; -- KU060 Bank 44
        diff_clka_p               : in    std_logic; -- KU060 Bank 44
        diff_clkb_n               : out    std_logic; -- KU060 Bank 44
        diff_clkb_p               : out    std_logic; -- KU060 Bank 44

      --diff_bus_out_n_49         : in    std_logic; -- KU060 Bank 48
      --diff_bus_out_p_49         : in    std_logic; -- KU060 Bank 48
        
      --dut_gen_clk_ina           : in    std_logic; -- KU060 Bank 48
      --dut_gen_clk_inb           : in    std_logic; -- KU060 Bank 48 (can't use it as single ended clock)
      --dut_gen_clk_inc           : in    std_logic; -- KU060 Bank 48
      --dut_gen_clk_ind           : in    std_logic; -- KU060 Bank 48 (can't use it as single ended clock)

      --dut_gen_clk_outa          : in    std_logic; -- KU060 Bank 48
      --dut_gen_clk_outb          : in    std_logic; -- KU060 Bank 48
      --dut_gen_clk_outc          : in    std_logic; -- KU060 Bank 48
      --dut_gen_clk_outd          : in    std_logic; -- KU060 Bank 48



        -- KU060 Bank 24 (49 IOs)
        df_i_n_20                 : in    std_logic; -- KU060 Bank 24  (diff_bus_in_n[20])
        df_i_p_20                 : in    std_logic; -- KU060 Bank 24  (diff_bus_in_p[20])

        df_o_n_1                  : out   std_logic; -- KU060 Bank 24  (diff_bus_out_n[1])
        df_o_p_1                  : out   std_logic; -- KU060 Bank 24  (diff_bus_out_p[1])
        df_o_n_9                  : out   std_logic; -- KU060 Bank 24  (diff_bus_out_n[9])
        df_o_p_9                  : out   std_logic; -- KU060 Bank 24  (diff_bus_out_p[9])
        df_o_n_14                 : out   std_logic; -- KU060 Bank 24  (diff_bus_out_n[14])
        df_o_p_14                 : out   std_logic; -- KU060 Bank 24  (diff_bus_out_p[14])
        df_o_n_19                 : out   std_logic; -- KU060 Bank 24  (diff_bus_out_n[19])
        df_o_p_19                 : out   std_logic; -- KU060 Bank 24  (diff_bus_out_p[19])

        df_0051_n                 : in    std_logic; -- KU060 Bank 24
        df_0051_p                 : in    std_logic; -- KU060 Bank 24
        df_0052_n                 : out   std_logic; -- KU060 Bank 24
        df_0052_p                 : out   std_logic; -- KU060 Bank 24
        df_0053_n                 : out   std_logic; -- KU060 Bank 24
        df_0053_p                 : out   std_logic; -- KU060 Bank 24
        df_0056_n                 : in    std_logic; -- KU060 Bank 24
        df_0056_p                 : in    std_logic; -- KU060 Bank 24
        df_0057_n                 : out   std_logic; -- KU060 Bank 24
        df_0057_p                 : out   std_logic; -- KU060 Bank 24
        df_0059_n                 : out   std_logic; -- KU060 Bank 24
        df_0059_p                 : out   std_logic; -- KU060 Bank 24
        df_0092_n                 : out   std_logic; -- KU060 Bank 24
        df_0092_p                 : out   std_logic; -- KU060 Bank 24
        --df_0095_n                 : in    std_logic; -- KU060 Bank 24
        --df_0095_p                 : in    std_logic; -- KU060 Bank 24
        --df_0099_n                 : in    std_logic; -- KU060 Bank 24 (df_0099_n) 
        --df_0099_p                 : in    std_logic; -- KU060 Bank 24 (df_0099_p) 

        -- KU060 Bank 25 (52 IOs)
        --df_i_n_21                 : in   std_logic; -- KU060 Bank 25 (diff_bus_in_cc_n[21])
        --df_i_p_21                 : in   std_logic; -- KU060 Bank 25 (diff_bus_in_cc_p[21])



        -- KU060 Bank 44 (47 IOs)
        df_i_n_5                  : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[5])
        df_i_p_5                  : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[5])
        df_i_n_10                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[10])
        df_i_p_10                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[10])
        df_i_n_12                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[12])
        df_i_p_12                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[12])
        df_i_n_15                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[15])
        df_i_p_15                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[15])
        --df_i_n_16                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[16])
        --df_i_p_16                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[16])
        --df_i_n_17                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[17])
        --df_i_p_17                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_p[17])

        df_o_n_5                  : out   std_logic; -- KU060 Bank 44 (diff_bus_out_n[5])
        df_o_p_5                  : out   std_logic; -- KU060 Bank 44 (diff_bus_out_p[5])

        df_0000_n                 : out   std_logic; -- KU060 Bank 44
        df_0000_p                 : out   std_logic; -- KU060 Bank 44
        df_0001_n                 : out   std_logic; -- KU060 Bank 44
        df_0001_p                 : out   std_logic; -- KU060 Bank 44
        df_0005_n                 : out   std_logic; -- KU060 Bank 44
        df_0005_p                 : out   std_logic; -- KU060 Bank 44
        df_0008_n                 : out   std_logic; -- KU060 Bank 44
        df_0008_p                 : out   std_logic; -- KU060 Bank 44
        df_0011_n                 : out   std_logic; -- KU060 Bank 44
        df_0011_p                 : out   std_logic; -- KU060 Bank 44
        df_0012_n                 : out   std_logic; -- KU060 Bank 44
        df_0012_p                 : out   std_logic; -- KU060 Bank 44
        df_0013_n                 : out   std_logic; -- KU060 Bank 44
        df_0013_p                 : out   std_logic; -- KU060 Bank 44
        df_0017_n                 : out   std_logic; -- KU060 Bank 44
        df_0017_p                 : out   std_logic; -- KU060 Bank 44
        df_0023_n                 : out   std_logic; -- KU060 Bank 44
        df_0023_p                 : out   std_logic; -- KU060 Bank 44
        df_0028_n                 : out   std_logic; -- KU060 Bank 44
        df_0028_p                 : out   std_logic; -- KU060 Bank 44
        --df_0046_n                 : out   std_logic; -- KU060 Bank 44
        --df_0046_p                 : in    std_logic; -- KU060 Bank 44
                        


        -- KU060 Bank 45 (51 IOs)
        df_o_n_2                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[2])
        df_o_p_2                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[2])
        df_o_n_6                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[6])
        df_o_p_6                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[6])
        df_o_n_7                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[7])
        df_o_p_7                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[7])
        df_o_n_10                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[10])
        df_o_p_10                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[10])
        df_o_n_11                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[11])
        df_o_p_11                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[11])
        df_o_n_12                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[12])
        df_o_p_12                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[12])
        df_o_n_15                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[15])
        df_o_p_15                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[15])
        df_o_n_16                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[16])
        df_o_p_16                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[16])
        df_o_n_17                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[17])
        df_o_p_17                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[17])
        df_o_n_20                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[20])
        df_o_p_20                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[20])

        df_0002_n                 : in    std_logic; -- KU060 Bank 45 (df_0002_n)
        df_0002_p                 : in    std_logic; -- KU060 Bank 45 (df_0002_p)
        df_0004_n                 : in    std_logic; -- KU060 Bank 45 (df_0004_cc_n)
        df_0004_p                 : in    std_logic; -- KU060 Bank 45 (df_0004_cc_p)
        df_0007_n                 : in    std_logic; -- KU060 Bank 45 (df_0007_n)
        df_0007_p                 : in    std_logic; -- KU060 Bank 45 (df_0007_p)
        df_0010_n                 : in    std_logic; -- KU060 Bank 45 (df_0010_cc_n)
        df_0010_p                 : in    std_logic; -- KU060 Bank 45 (df_0010_cc_p)
        df_0014_n                 : out   std_logic; -- KU060 Bank 45 (df_0014_n)
        df_0014_p                 : out   std_logic; -- KU060 Bank 45 (df_0014_p)
        df_0016_n                 : out   std_logic; -- KU060 Bank 45 (df_cc_0016_n)
        df_0016_p                 : out   std_logic; -- KU060 Bank 45 (df_cc_0016_p)
        df_0018_n                 : in    std_logic; -- KU060 Bank 45 (df_0018_n)
        df_0018_p                 : in    std_logic; -- KU060 Bank 45 (df_0018_p)
        df_0022_n                 : out   std_logic; -- KU060 Bank 45 (df_0022_n)
        df_0022_p                 : out   std_logic; -- KU060 Bank 45 (df_0022_p)
        df_0029_n                 : out   std_logic; -- KU060 Bank 45 (df_0029_n)
        df_0029_p                 : out   std_logic; -- KU060 Bank 45 (df_0029_p)
        df_0048_n                 : out   std_logic; -- KU060 Bank 45 (df_0048_n)
        df_0048_p                 : out   std_logic -- KU060 Bank 45 (df_0048_p)
        --df_0049_n                 : in    std_logic; -- KU060 Bank 45 (df_0049_n)
        --df_0049_p                 : in    std_logic; -- KU060 Bank 45 (df_0049_p)
        --df_0050_n                 : in    std_logic; -- KU060 Bank 45 (df_0050_n)
        --df_0050_p                 : in    std_logic; -- KU060 Bank 45 (df_0050_p)

        -- KU060 Bank 46 (52 IOs)
        --df_i_n_54                 : in    std_logic; -- KU060 Bank 46 (diff_bus_in_n[54])
        --df_i_p_54                 : in    std_logic; -- KU060 Bank 46 (diff_bus_in_p[54])

        --df_o_n_57                 : in    std_logic; -- KU060 Bank 46 (diff_bus_out_n[57])
        --df_o_p_57                 : in    std_logic; -- KU060 Bank 46 (diff_bus_out_p[57])

        -- KU060 Bank 47 (52 IOs)                                


        -- KU060 Bank 48 (not used. not availabel for V7 485)

        -- KU060 Bank 64 (bank with limited IO to FuncMon FPGA, close to bank 44 or 65)




        --df_0019_n                 : out   std_logic; -- KU060 Bank 66
        --df_0019_p                 : out   std_logic; -- KU060 Bank 66
        --df_0020_n                 : out   std_logic; -- KU060 Bank 66
        --df_0020_p                 : out   std_logic -- KU060 Bank 66
        --df_0021_n                 : out   std_logic; -- KU060 Bank 66
        --df_0021_p                 : out   std_logic  -- KU060 Bank 66

        -- KU060 Bank 67 (not used. bank with limited IO to FuncMon FPGA)
        -- KU060 Bank 68 (not used. bank with limited IO to FuncMon FPGA)
    );
end iob_lvds_dut_noreg;


architecture behavioral of iob_lvds_dut_noreg is


  component IBUFDS
    generic(
      CAPACITANCE       : string  := "DONT_CARE";
      DIFF_TERM         : boolean :=  FALSE;
      DQS_BIAS          : string  :=  "FALSE";
      IBUF_DELAY_VALUE  : string  := "0";
      IBUF_LOW_PWR      : boolean :=  TRUE;
      IFD_DELAY_VALUE   : string  := "AUTO";
      IOSTANDARD        : string  := "DEFAULT");
    port(
      O                 : out std_ulogic;
      I                 : in  std_ulogic;
      IB                : in  std_ulogic);
  end component;

  component OBUFDS
    generic(
      CAPACITANCE       : string := "DONT_CARE";
      IOSTANDARD        : string := "DEFAULT";
      SLEW              : string := "SLOW");
    port(               
      O                 : out std_ulogic;
      OB                : out std_ulogic;
      I                 : in  std_ulogic);
  end component;


--constant IN_IOB_COUNT      : integer := 35; -- 35x8 = 280
  --constant IN_IOB_COUNT      : integer := 19; -- 19x8 = 152
  constant IN_IOB_COUNT      : integer := 12; -- 19x8 = 152

  signal internal_bus        : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal iob_in              : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal iob_out_a           : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal iob_out_b           : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal iob_out_c           : std_logic_vector(IN_IOB_COUNT-1 downto 0);

  signal diff_in_p           : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal diff_in_n           : std_logic_vector(IN_IOB_COUNT-1 downto 0);

  signal diff_out_a_p        : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal diff_out_a_n        : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal diff_out_b_p        : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal diff_out_b_n        : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal diff_out_c_p        : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal diff_out_c_n        : std_logic_vector(IN_IOB_COUNT-1 downto 0);


  -- Clock signals for clock buffers
  signal diff_clka_int    : std_logic;
--signal diff_clkb_int    : std_logic;
--signal diff_clka        : std_logic;
--signal diff_clkb        : std_logic;
  signal clk_ina          : std_logic;
  signal clk_inb          : std_logic;
  signal clk_inc          : std_logic;
  signal clk_ind          : std_logic;

  -- Must have these attributes to keep the replicated output registers both through synthesis and implementation
  attribute DONT_TOUCH : string;
  attribute DONT_TOUCH of internal_bus : signal is "TRUE";
--attribute DONT_TOUCH of iob_in       : signal is "TRUE";
--attribute DONT_TOUCH of iob_out_a    : signal is "TRUE";
--attribute DONT_TOUCH of iob_out_b    : signal is "TRUE";
--attribute DONT_TOUCH of iob_out_c    : signal is "TRUE";


begin

-------------------------------------------------------------------------------
-- Clocks
-------------------------------------------------------------------------------

--  clk_a_bufg : bufg
--  port map(
--      I => dut_gen_clk_ina,
--      O => clk_ina  
--  );
-- 
--  clk_c_bufg : bufg
--  port map(
--      I => dut_gen_clk_inc,
--      O => clk_inc
--  );

    -- Pass-through
--  dut_gen_clk_outa <= clk_ina;
--  dut_gen_clk_outb <= clk_inb;            -- Note C-to-B transfer due to missing ports.
--  dut_gen_clk_outc <= clk_inc;
--  dut_gen_clk_outd <= clk_ind;


-- Differential clocks
-- IBUFGDS must be present even if clock unused, else Vivado
-- can't tell they are differential signals, and bitgen fails
-- Comment out BUFG if clock unused.

--  IBUFGDS_inst_a : IBUFGDS
--      generic map (
--          DIFF_TERM       => TRUE, -- Supposedly has external termination
--          DIFF_TERM       => FALSE    ,
--          IBUF_LOW_PWR    => TRUE,
--          IOSTANDARD      => "DEFAULT"
--      )
--      port map (
--          O   => diff_clka_int,
--          I   => diff_clka_p,
--          IB  => diff_clka_n
--      );
--
--  diff_clka_bufg : bufg
--  port map(
--      I => diff_clka_int,
--      O => diff_clka  
--  );

-----------------------------------------------------------------------

    ibufds_clk_i : IBUFDS
      generic map (
        DIFF_TERM  => TRUE,
        IOSTANDARD => "LVDS15")
      port map (
        I   => diff_clka_p,
        IB  => diff_clka_n,
        O   => diff_clka_int);

    obufds_clk_i : OBUFDS
      generic map (
        IOSTANDARD  => "LVDS15")
      port map (
        O   => diff_clkb_p,
        OB  => diff_clkb_n,
        I   => diff_clka_int);




-------------------------------------------------------------------------------
-- Input to Output routing
-------------------------------------------------------------------------------

  gen_data_i : for i in 0 to (IN_IOB_COUNT-1) generate

    ibufds_i : IBUFDS
      generic map (
        DIFF_TERM  => TRUE,
        IOSTANDARD => "LVDS")
      port map (
        I   => diff_in_p(i),
        IB  => diff_in_n(i),
        O   => iob_in(i));


        internal_bus(i) <= iob_in(i);

        iob_out_a(i)    <= internal_bus(i);
        iob_out_b(i)    <= internal_bus(i);
        iob_out_c(i)    <= internal_bus(i);





    obufds_a_i : OBUFDS
      generic map (
        IOSTANDARD  => "LVDS")
      port map (
        O   => diff_out_a_p(i),
        OB  => diff_out_a_n(i),
        I   => iob_out_a(i));

    obufds_b_i : OBUFDS
      generic map (
        IOSTANDARD  => "LVDS")
      port map (
        O   => diff_out_b_p(i),
        OB  => diff_out_b_n(i),
        I   => iob_out_b(i));

    obufds_c_i : OBUFDS
      generic map (
        IOSTANDARD  => "LVDS")
      port map (
        O   => diff_out_c_p(i),
        OB  => diff_out_c_n(i),
        I   => iob_out_c(i));

  end generate;


-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 24 (49 IOs)
-------------------------------------------------------------------------------
  diff_in_n(0)          <= df_i_n_20;
  diff_in_p(0)          <= df_i_p_20;
  df_o_n_1              <= diff_out_a_n(0);
  df_o_p_1              <= diff_out_a_p(0);
  df_o_n_9              <= diff_out_b_n(0);
  df_o_p_9              <= diff_out_b_p(0);
  df_o_n_14             <= diff_out_c_n(0);
  df_o_p_14             <= diff_out_c_p(0);

  diff_in_n(1)          <= df_0051_n;
  diff_in_p(1)          <= df_0051_p;
  df_o_n_19             <= diff_out_a_n(1);
  df_o_p_19             <= diff_out_a_p(1);
  df_0052_n             <= diff_out_b_n(1);
  df_0052_p             <= diff_out_b_p(1);
  df_0053_n             <= diff_out_c_n(1);
  df_0053_p             <= diff_out_c_p(1);

  diff_in_n(2)          <= df_0056_n;
  diff_in_p(2)          <= df_0056_p;
  df_0057_n             <= diff_out_a_n(2);
  df_0057_p             <= diff_out_a_p(2);
  df_0059_n             <= diff_out_b_n(2);
  df_0059_p             <= diff_out_b_p(2);
  df_0092_n             <= diff_out_c_n(2);
  df_0092_p             <= diff_out_c_p(2);


-- not used
--df_0095_n             <= diff_out_c_n(4);
--df_0095_p             <= diff_out_c_p(4);
--df_0099_n             <= std_logic; -- KU060 Bank 24
--df_0099_p             <= std_logic; -- KU060 Bank 24






-- unused


-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 44 (47 IOs)
-------------------------------------------------------------------------------
  diff_in_n(3)          <= df_i_n_5;
  diff_in_p(3)          <= df_i_p_5;
  df_o_n_5              <= diff_out_a_n(3);
  df_o_p_5              <= diff_out_a_p(3);
  df_0000_n             <= diff_out_b_n(3);
  df_0000_p             <= diff_out_b_p(3);
  df_0001_n             <= diff_out_c_n(3);
  df_0001_p             <= diff_out_c_p(3);

  diff_in_n(4)          <= df_i_n_10;
  diff_in_p(4)          <= df_i_p_10;
  df_0005_n             <= diff_out_a_n(4);
  df_0005_p             <= diff_out_a_p(4);
  df_0008_n             <= diff_out_b_n(4);
  df_0008_p             <= diff_out_b_p(4);
  df_0011_n             <= diff_out_c_n(4);
  df_0011_p             <= diff_out_c_p(4);

  diff_in_n(5)          <= df_i_n_12;
  diff_in_p(5)          <= df_i_p_12;
  df_0012_n             <= diff_out_a_n(5);
  df_0012_p             <= diff_out_a_p(5);
  df_0013_n             <= diff_out_b_n(5);
  df_0013_p             <= diff_out_b_p(5);
  df_0017_n             <= diff_out_c_n(5);
  df_0017_p             <= diff_out_c_p(5);

  diff_in_n(6)          <= df_i_n_15;
  diff_in_p(6)          <= df_i_p_15;
  df_0023_n             <= diff_out_a_n(6);
  df_0023_p             <= diff_out_a_p(6);
  df_0028_n             <= diff_out_b_n(6);
  df_0028_p             <= diff_out_b_p(6);
  -- last output in the bank 64

-- unused
--df_i_n_16;
--df_i_p_16;
--df_i_n_17
--df_i_p_17
--df_0046_n
--df_0046_p


-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 64 (bank with limited IO to FuncMon FPGA, close to bank 44)
-------------------------------------------------------------------------------

-- unused

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 45 (51 IOs)
-------------------------------------------------------------------------------
  diff_in_n(7)         <= df_0002_n;
  diff_in_p(7)         <= df_0002_p;
  df_o_n_2              <= diff_out_a_n(7);
  df_o_p_2              <= diff_out_a_p(7);
  df_o_n_6              <= diff_out_b_n(7);
  df_o_p_6              <= diff_out_b_p(7);
  df_o_n_7              <= diff_out_c_n(7);
  df_o_p_7              <= diff_out_c_p(7);

  diff_in_n(8)         <= df_0004_n;
  diff_in_p(8)         <= df_0004_p;
  df_o_n_10             <= diff_out_a_n(8);
  df_o_p_10             <= diff_out_a_p(8);
  df_o_n_11             <= diff_out_b_n(8);
  df_o_p_11             <= diff_out_b_p(8);
  df_o_n_12             <= diff_out_c_n(8);
  df_o_p_12             <= diff_out_c_p(8);

  diff_in_n(9)         <= df_0007_n;
  diff_in_p(9)         <= df_0007_p;
  df_o_n_15             <= diff_out_a_n(9);
  df_o_p_15             <= diff_out_a_p(9);
  df_o_n_16             <= diff_out_b_n(9);
  df_o_p_16             <= diff_out_b_p(9);
  df_o_n_17             <= diff_out_c_n(9);
  df_o_p_17             <= diff_out_c_p(9);

  diff_in_n(10)         <= df_0010_n;
  diff_in_p(10)         <= df_0010_p;
  df_o_n_20             <= diff_out_a_n(10);
  df_o_p_20             <= diff_out_a_p(10);
  df_0014_n             <= diff_out_b_n(10);
  df_0014_p             <= diff_out_b_p(10);
  df_0016_n             <= diff_out_c_n(10);
  df_0016_p             <= diff_out_c_p(10);

  diff_in_n(11)         <= df_0018_n;
  diff_in_p(11)         <= df_0018_p;
  df_0022_n             <= diff_out_a_n(11);
  df_0022_p             <= diff_out_a_p(11);
  df_0029_n             <= diff_out_b_n(11);
  df_0029_p             <= diff_out_b_p(11);
  df_0048_n             <= diff_out_c_n(11);
  df_0048_p             <= diff_out_c_p(11);

-- Not used
--df_0049_n                 : in    std_logic; -- KU060 Bank 45
--df_0049_p                 : out   std_logic; -- KU060 Bank 45
--df_0050_n                 : out   std_logic; -- KU060 Bank 45
--df_0050_p                 : out   std_logic; -- KU060 Bank 45


-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 46 (52 IOs)
-------------------------------------------------------------------------------
-- Not used
--df_i_n_54
--df_i_p_54
--df_o_n_57
--df_o_p_57


-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 47 (52 IOs)
-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
-- KU060 Bank 48 (not used. not availabel for V7 680)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- KU060 Bank 64 (not used. bank with limited IO to FuncMon FPGA)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 66 (46 IOs)
-------------------------------------------------------------------------------


-- Not used
--df_i_n_80             : in    std_logic;
--df_i_p_80             : in    std_logic;


-------------------------------------------------------------------------------
-- For each differential input
-- Necessary for DRC since LVDS (cannot be used as singl-ended, unlike DIFF output)
-------------------------------------------------------------------------------
--  ibufds_gen : for n in 0 to DIFF_IN_COUNT-1 generate
--      diff_input_buf : IBUFDS
--          generic map (
--              DIFF_TERM       => TRUE,
--              IBUF_LOW_PWR    => TRUE,
--              IOSTANDARD      => "DEFAULT"
--          )
--          port map (
--              O   => open,
--              I   => diff_bus_in_p(n),
--              IB  => diff_bus_in_n(n)
--          );
--  end generate;

end behavioral;

