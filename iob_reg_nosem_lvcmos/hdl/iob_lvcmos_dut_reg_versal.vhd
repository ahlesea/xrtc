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
-- File Name   : iob_lvcmos_dut_reg.vhd
-- Description : LVCMOS18 IOB radiation test build - IOB registered
--
-- Author      : P H Park, Boeing for the XRTC
-- Date        : 1/14/2021
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

entity iob_lvcmos_dut_reg is
  port (
      --diff_bus_in_n             : in    std_logic_vector(20 downto 0);
      --diff_bus_in_p             : in    std_logic_vector(20 downto 0);
      --diff_bus_out_n            : out   std_logic_vector(20 downto 0);
      --diff_bus_out_p            : out   std_logic_vector(20 downto 0);

        -- clocks




        -- KU060 Bank 24 (49 IOs)
        df_i_n_20                 : in   std_logic; -- KU060 Bank 24  (diff_bus_in_n[20])
        df_i_p_20                 : out  std_logic; -- KU060 Bank 24  (diff_bus_in_p[20])

        df_o_n_1                  : out  std_logic; -- KU060 Bank 24  (diff_bus_out_n[1])
        df_o_p_1                  : out  std_logic; -- KU060 Bank 24  (diff_bus_out_p[1])
        df_o_n_9                  : in   std_logic; -- KU060 Bank 24  (diff_bus_out_n[9])
        df_o_p_9                  : out  std_logic; -- KU060 Bank 24  (diff_bus_out_p[9])
        df_o_n_14                 : out  std_logic; -- KU060 Bank 24  (diff_bus_out_n[14])
        df_o_p_14                 : out  std_logic; -- KU060 Bank 24  (diff_bus_out_p[14])
        df_o_n_19                 : in   std_logic; -- KU060 Bank 24  (diff_bus_out_n[19])
        df_o_p_19                 : out  std_logic; -- KU060 Bank 24  (diff_bus_out_p[19])

        df_0051_n                 : out  std_logic; -- KU060 Bank 24
        df_0051_p                 : out  std_logic; -- KU060 Bank 24
        df_0052_n                 : in   std_logic; -- KU060 Bank 24
        df_0052_p                 : out  std_logic; -- KU060 Bank 24
        df_0053_n                 : out  std_logic; -- KU060 Bank 24
        df_0053_p                 : out  std_logic; -- KU060 Bank 24
        df_0056_n                 : in   std_logic; -- KU060 Bank 24
        df_0056_p                 : out  std_logic; -- KU060 Bank 24
        df_0057_n                 : out  std_logic; -- KU060 Bank 24
        df_0057_p                 : out  std_logic; -- KU060 Bank 24
        df_0059_n                 : in   std_logic; -- KU060 Bank 24
        df_0059_p                 : out  std_logic; -- KU060 Bank 24
        df_0092_n                 : out  std_logic; -- KU060 Bank 24
        df_0092_p                 : out  std_logic; -- KU060 Bank 24
        df_0095_n                 : in   std_logic; -- KU060 Bank 24
        df_0095_p                 : out  std_logic; -- KU060 Bank 24
        df_0099_n                 : out  std_logic; -- KU060 Bank 24 (df_0099_n) 
        df_0099_p                 : out  std_logic; -- KU060 Bank 24 (df_0099_p) 


        -- KU060 Bank 25 (52 IOs)
        --df_i_n_21                 : in   std_logic; -- KU060 Bank 25 (diff_bus_in_cc_n[21])
        --df_i_p_21                 : out  std_logic; -- KU060 Bank 25 (diff_bus_in_cc_p[21])



        -- KU060 Bank 44 (47 IOs)
        df_i_n_5                  : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[5])
        df_i_p_5                  : out   std_logic; -- KU060 Bank 44 (diff_bus_in_p[5])
        df_i_n_10                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_n[10])
        df_i_p_10                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_p[10])
        df_i_n_12                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[12])
        df_i_p_12                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_p[12])
        df_i_n_15                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_n[15])
        df_i_p_15                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_p[15])
        df_i_n_16                 : in    std_logic; -- KU060 Bank 44 (diff_bus_in_n[16])
        df_i_p_16                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_p[16])
        df_i_n_17                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_n[17])
        df_i_p_17                 : out   std_logic; -- KU060 Bank 44 (diff_bus_in_p[17])

        df_o_n_5                  : in    std_logic; -- KU060 Bank 44 (diff_bus_out_n[5])
        df_o_p_5                  : out   std_logic; -- KU060 Bank 44 (diff_bus_out_p[5])

        df_0000_n                 : out   std_logic; -- KU060 Bank 44
        df_0000_p                 : out   std_logic; -- KU060 Bank 44
        df_0001_n                 : in    std_logic; -- KU060 Bank 44
        df_0001_p                 : out   std_logic; -- KU060 Bank 44
        df_0005_n                 : out   std_logic; -- KU060 Bank 44
        df_0005_p                 : out   std_logic; -- KU060 Bank 44
        df_0008_n                 : in    std_logic; -- KU060 Bank 44
        df_0008_p                 : out   std_logic; -- KU060 Bank 44
        df_0011_n                 : out   std_logic; -- KU060 Bank 44
        df_0011_p                 : out   std_logic; -- KU060 Bank 44
        df_0012_n                 : in    std_logic; -- KU060 Bank 44
        df_0012_p                 : out   std_logic; -- KU060 Bank 44
        df_0013_n                 : out   std_logic; -- KU060 Bank 44
        df_0013_p                 : out   std_logic; -- KU060 Bank 44
        df_0017_n                 : in    std_logic; -- KU060 Bank 44
        df_0017_p                 : out   std_logic; -- KU060 Bank 44
        df_0023_n                 : out   std_logic; -- KU060 Bank 44
        df_0023_p                 : out   std_logic; -- KU060 Bank 44
        df_0028_n                 : in    std_logic; -- KU060 Bank 44
        df_0028_p                 : out   std_logic; -- KU060 Bank 44
        df_0046_n                 : out   std_logic; -- KU060 Bank 44
        df_0046_p                 : out   std_logic; -- KU060 Bank 44

        -- KU060 Bank 45 (51 IOs)
        df_o_n_2                  : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[2])
        df_o_p_2                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[2])
        df_o_n_6                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[6])
        df_o_p_6                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[6])
        df_o_n_7                  : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[7])
        df_o_p_7                  : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[7])
        df_o_n_10                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[10])
        df_o_p_10                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[10])
        df_o_n_11                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[11])
        df_o_p_11                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[11])
        df_o_n_12                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[12])
        df_o_p_12                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[12])
        df_o_n_15                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[15])
        df_o_p_15                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[15])
        df_o_n_16                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[16])
        df_o_p_16                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[16])
        df_o_n_17                 : in    std_logic; -- KU060 Bank 45 (diff_bus_out_n[17])
        df_o_p_17                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[17])
        df_o_n_20                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_n[20])
        df_o_p_20                 : out   std_logic; -- KU060 Bank 45 (diff_bus_out_p[20])

        df_0002_n                 : in    std_logic; -- KU060 Bank 45 (df_0002_n)
        df_0002_p                 : out   std_logic; -- KU060 Bank 45 (df_0002_p)
        df_0004_n                 : out   std_logic; -- KU060 Bank 45 (df_0004_cc_n)
        df_0004_p                 : out   std_logic; -- KU060 Bank 45 (df_0004_cc_p)
        df_0007_n                 : in    std_logic; -- KU060 Bank 45 (df_0007_n)
        df_0007_p                 : out   std_logic; -- KU060 Bank 45 (df_0007_p)
        df_0010_n                 : out   std_logic; -- KU060 Bank 45 (df_0010_cc_n)
        df_0010_p                 : out   std_logic; -- KU060 Bank 45 (df_0010_cc_p)
        df_0014_n                 : in    std_logic; -- KU060 Bank 45 (df_0014_n)
        df_0014_p                 : out   std_logic; -- KU060 Bank 45 (df_0014_p)
        df_0016_n                 : out   std_logic; -- KU060 Bank 45 (df_cc_0016_n)
        df_0016_p                 : out   std_logic; -- KU060 Bank 45 (df_cc_0016_p)
        df_0018_n                 : in    std_logic; -- KU060 Bank 45 (df_0018_n)
        df_0018_p                 : out   std_logic; -- KU060 Bank 45 (df_0018_p)
        df_0022_n                 : out   std_logic; -- KU060 Bank 45 (df_0022_n)
        df_0022_p                 : out   std_logic; -- KU060 Bank 45 (df_0022_p)
        df_0029_n                 : in    std_logic; -- KU060 Bank 45 (df_0029_n)
        df_0029_p                 : out   std_logic; -- KU060 Bank 45 (df_0029_p)
        df_0048_n                 : out   std_logic; -- KU060 Bank 45 (df_0048_n)
        df_0048_p                 : out   std_logic; -- KU060 Bank 45 (df_0048_p)
        df_0049_n                 : in    std_logic; -- KU060 Bank 45 (df_0049_n)
        df_0049_p                 : out   std_logic; -- KU060 Bank 45 (df_0049_p)
        df_0050_n                 : out   std_logic; -- KU060 Bank 45 (df_0050_n)
        df_0050_p                 : out   std_logic; -- KU060 Bank 45 (df_0050_p)

        -- KU060 Bank 46 (52 IOs)
        df_i_n_54                 : in    std_logic; -- KU060 Bank 46 (diff_bus_in_n[54])
        df_i_p_54                 : out   std_logic; -- KU060 Bank 46 (diff_bus_in_p[54])

        df_o_n_57                 : out   std_logic; -- KU060 Bank 46 (diff_bus_out_n[57])
        df_o_p_57                 : out   std_logic; -- KU060 Bank 46 (diff_bus_out_p[57])

        -- KU060 Bank 47 (52 IOs)                                


        -- KU060 Bank 48 (not used. not availabel for V7 485)

        -- KU060 Bank 64 (bank with limited IO to FuncMon FPGA, close to bank 44 or 65)

       df_i_n_80                 : in    std_logic; -- KU060 Bank 66 (diff_bus_in_cc_n[80]) TEST CLOCK
        df_i_p_80                 : in    std_logic; -- KU060 Bank 66 (diff_bus_in_cc_p[80]) TEST CLOCK


        df_0019_n                 : in    std_logic; -- KU060 Bank 66
        df_0019_p                 : out   std_logic; -- KU060 Bank 66
        df_0020_n                 : out   std_logic; -- KU060 Bank 66
        df_0020_p                 : out   std_logic -- KU060 Bank 66
        --df_0021_n                 : out   std_logic; -- KU060 Bank 66
        --df_0021_p                 : out   std_logic  -- KU060 Bank 66

        -- KU060 Bank 67 (not used. bank with limited IO to FuncMon FPGA)
        -- KU060 Bank 68 (not used. bank with limited IO to FuncMon FPGA)
    );
end iob_lvcmos_dut_reg;


architecture behavioral of iob_lvcmos_dut_reg is

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

  --constant IN_IOB_COUNT      : integer := 42;
  constant IN_IOB_COUNT      : integer := 29;

  signal   internal_bus      : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal   iob_in            : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal   iob_out_a         : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal   iob_out_b         : std_logic_vector(IN_IOB_COUNT-1 downto 0);
  signal   iob_out_c         : std_logic_vector(IN_IOB_COUNT-1 downto 0);

  -- Clock signals for clock buffers
  signal clk_ina_int      : std_logic;
--signal diff_clkb_int    : std_logic;
  signal diff_clka        : std_logic;
--signal diff_clkb        : std_logic;
--signal clk_ina          : std_logic;
--signal clk_inb          : std_logic;
--signal clk_inc          : std_logic;
--signal clk_ind          : std_logic;

  signal clk_in           : std_logic;

  -- Must have these attributes to keep the replicated output registers both through synthesis and implementation
  attribute DONT_TOUCH : string;
  attribute DONT_TOUCH of internal_bus : signal is "TRUE";
  attribute DONT_TOUCH of iob_in       : signal is "TRUE";
  attribute DONT_TOUCH of iob_out_a    : signal is "TRUE";
  attribute DONT_TOUCH of iob_out_b    : signal is "TRUE";
  attribute DONT_TOUCH of iob_out_c    : signal is "TRUE";


begin

-------------------------------------------------------------------------------
-- Clocks
-------------------------------------------------------------------------------
--  clk_c_bufg : bufg
--  port map(
--      I => dut_gen_clk_inc,
--      O => clk_inc  
--  );

--  clk_d_bufg : bufg
--  port map(
--      I => dut_gen_clk_ind,
--      O => clk_ind  
--  );

    -- Pass-through
--  dut_gen_clk_outa <= clk_ina;
--  dut_gen_clk_outb <= clk_inc;            -- Note C-to-B transfer due to missing ports.
--  dut_gen_clk_outc <= dut_gen_clk_inc;
--  dut_gen_clk_outd <= dut_gen_clk_ind;    -- plain pass-through


-- Differential clocks
-- IBUFGDS must be present even if clock unused, else Vivado
-- can't tell they are differential signals, and bitgen fails
-- Comment out BUFG if clock unused.

    ibufds_clk_i : IBUFDS
      generic map (
        DIFF_TERM  => TRUE,
        IOSTANDARD => "LVDS15")
      port map (
        I   => df_i_p_80,
        IB  => df_i_n_80,
        O   => clk_ina_int);


    bufg_clk_in : bufg
    port map(
        I => clk_ina_int,
        O => clk_in
    );

-----------------------------------------------------------------------

--    IBUFGDS_inst_b : IBUFGDS
--        generic map (
--            DIFF_TERM       => TRUE,
--            IBUF_LOW_PWR    => TRUE,
--            IOSTANDARD      => "DEFAULT"
--        )
--        port map (
--            O   => diff_clkb_int,
--        );

--    diff_clkb_bufg : bufg
--    port map(
--        I => diff_clkb_int,
--        O => diff_clkb  
--    );

-------------------------------------------------------------------------------
-- Input to Output routing
-------------------------------------------------------------------------------

  gen_data_i : for i in 0 to (IN_IOB_COUNT-1) generate

    reg_i : process (clk_in)
    begin
      if (clk_in'event and clk_in = '1') then
        internal_bus(i) <= iob_in(i);

        iob_out_a(i)    <= internal_bus(i);
        iob_out_b(i)    <= internal_bus(i);
        iob_out_c(i)    <= internal_bus(i);
      end if;
    end process;

  --iodelay_i : iodelay
  --generic map (
  --  REFCLK_FREQUENCY      => 200.0,                 -- idelayctrl frequency: 175 to 225 MHz
  --  SIGNAL_PATTERN        => "DATA")                -- input signal type, "clock" or "data" 
  --port map (
  --  RST                   => iodelay_rst,                 -- 1-bit active high, synch reset input
  --  T                     => '1'                    -- 1-bit 3-state control input
  --);

  end generate;


-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 24 (49 IOs)
-------------------------------------------------------------------------------
  iob_in(0)             <= df_i_n_20;
  df_i_p_20             <= iob_out_a(0);
  df_o_n_1              <= iob_out_b(0);
  df_o_p_1              <= iob_out_c(0);

  iob_in(1)             <= df_o_n_9;
  df_o_p_9              <= iob_out_a(1);
  df_o_n_14             <= iob_out_b(1);
  df_o_p_14             <= iob_out_c(1);

  iob_in(2)             <= df_o_n_19;
  df_o_p_19             <= iob_out_a(2);
  df_0051_n             <= iob_out_b(2);
  df_0051_p             <= iob_out_c(2);

  iob_in(3)             <= df_0052_n;
  df_0052_p             <= iob_out_a(3);
  df_0053_n             <= iob_out_b(3);
  df_0053_p             <= iob_out_c(3);

  iob_in(4)             <= df_0056_n;
  df_0056_p             <= iob_out_a(4);
  df_0057_n             <= iob_out_b(4);
  df_0057_p             <= iob_out_c(4);

  iob_in(5)             <= df_0059_n;
  df_0059_p             <= iob_out_a(5);
  df_0092_n             <= iob_out_b(5);
  df_0092_p             <= iob_out_c(5);    
            
  iob_in(6)             <= df_0095_n;
  df_0095_p             <= iob_out_a(6);
  df_0099_n             <= iob_out_b(6);
  df_0099_p             <= iob_out_c(6);
             
-- UNUSED
--df_0114_n    
--df_0114_p

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 25 (52 IOs)
-------------------------------------------------------------------------------
  --iob_in(7)             <= df_i_n_21;
  --df_i_p_21             <= iob_out_a(7);





-- UNUSED

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 44 (47 IOs)
-------------------------------------------------------------------------------
  iob_in(7)            <= df_i_n_5;
  df_i_p_5              <= iob_out_a(7);
  df_i_n_10             <= iob_out_b(7);
  df_i_p_10             <= iob_out_c(7);

  iob_in(8)            <= df_i_n_12;
  df_i_p_12             <= iob_out_a(8);
  df_i_n_15             <= iob_out_b(8);
  df_i_p_15             <= iob_out_c(8);

  iob_in(9)            <= df_i_n_16;
  df_i_p_16             <= iob_out_a(9);
  df_i_n_17             <= iob_out_b(9);
  df_i_p_17             <= iob_out_c(9);

  iob_in(10)            <= df_o_n_5;
  df_o_p_5              <= iob_out_a(10);
  df_0000_n             <= iob_out_b(10);
  df_0000_p             <= iob_out_c(10);

  iob_in(11)            <= df_0001_n;
  df_0001_p             <= iob_out_a(11);
  df_0005_n             <= iob_out_b(11);
  df_0005_p             <= iob_out_c(11);

  iob_in(12)            <= df_0008_n;
  df_0008_p             <= iob_out_a(12);
  df_0011_n             <= iob_out_b(12);
  df_0011_p             <= iob_out_c(12);

  iob_in(13)            <= df_0012_n;
  df_0012_p             <= iob_out_a(13);
  df_0013_n             <= iob_out_b(13);
  df_0013_p             <= iob_out_c(13);

  iob_in(14)            <= df_0017_n;
  df_0017_p             <= iob_out_a(14);
  df_0023_n             <= iob_out_b(14);
  df_0023_p             <= iob_out_c(14);

  iob_in(15)            <= df_0028_n;
  df_0028_p             <= iob_out_a(15);
  df_0046_n             <= iob_out_b(15);
  df_0046_p             <= iob_out_c(15);

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 45 (51 IOs)
-------------------------------------------------------------------------------
  iob_in(16)            <= df_o_n_2;
  df_o_p_2              <= iob_out_a(16);
  df_o_n_6              <= iob_out_b(16);
  df_o_p_6              <= iob_out_c(16);

  iob_in(17)            <= df_o_n_7;
  df_o_p_7              <= iob_out_a(17);
  df_o_n_10             <= iob_out_b(17);
  df_o_p_10             <= iob_out_c(17);

  iob_in(18)            <= df_o_n_11;
  df_o_p_11             <= iob_out_a(18);
  df_o_n_12             <= iob_out_b(18);
  df_o_p_12             <= iob_out_c(18);

  iob_in(19)            <= df_o_n_15;
  df_o_p_15             <= iob_out_a(19);
  df_o_n_16             <= iob_out_b(19);
  df_o_p_16             <= iob_out_c(19);

  iob_in(20)            <= df_o_n_17;
  df_o_p_17             <= iob_out_a(20);
  df_o_n_20             <= iob_out_b(20);
  df_o_p_20             <= iob_out_c(20);

  iob_in(21)            <= df_0002_n;
  df_0002_p             <= iob_out_a(21);
  df_0004_n             <= iob_out_b(21);
  df_0004_p             <= iob_out_c(21);

  iob_in(22)            <= df_0007_n;
  df_0007_p             <= iob_out_a(22);
  df_0010_n             <= iob_out_b(22);
  df_0010_p             <= iob_out_c(22);

  iob_in(23)            <= df_0014_n;
  df_0014_p             <= iob_out_a(23);
  df_0016_n             <= iob_out_b(23);
  df_0016_p             <= iob_out_c(23);

  iob_in(24)            <= df_0018_n;
  df_0018_p             <= iob_out_a(24);
  df_0022_n             <= iob_out_b(24);
  df_0022_p             <= iob_out_c(24);

  iob_in(25)            <= df_0029_n;
  df_0029_p             <= iob_out_a(25);
  df_0048_n             <= iob_out_b(25);
  df_0048_p             <= iob_out_c(25);

  iob_in(26)            <= df_0049_n;
  df_0049_p             <= iob_out_a(26);
  df_0050_n             <= iob_out_b(26);
  df_0050_p             <= iob_out_c(26);

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 46 (52 IOs)
-------------------------------------------------------------------------------
  iob_in(27)            <= df_i_n_54;
  df_i_p_54             <= iob_out_a(27);
  df_o_n_57             <= iob_out_b(27);
  df_o_p_57             <= iob_out_c(27);

-- UNUSED

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 47 (52 IOs)
-------------------------------------------------------------------------------




-------------------------------------------------------------------------------
-- KU060 Bank 48 (not used. not availabel for V7 680)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- KU060 Bank 64 (bank with limited IO to FuncMon FPGA, close to bank 44 or 65)
-------------------------------------------------------------------------------

-- UNUSED
--df_0143_p

-------------------------------------------------------------------------------
-- Port mapping: KU060 Bank 66 (46 IOs)
-------------------------------------------------------------------------------
  --df_0021_n             <= iob_out_b(38);
  --df_0021_p             <= iob_out_c(38);



  iob_in(28)            <= df_0019_n;
  df_0019_p             <= iob_out_a(28);
  df_0020_n             <= iob_out_b(28);
  df_0020_p             <= iob_out_c(28);

-- Unused
--df_i_n_1
--df_i_p_1 

-- Used as clock input
--df_i_n_80
--df_i_p_80

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
--              I   => df_i_p(n),
--              IB  => df_i_n(n)
--          );
--  end generate;

end behavioral;
