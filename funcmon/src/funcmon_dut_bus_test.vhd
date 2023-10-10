library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;

-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.vcomponents.all;


entity funcmon_dut_bus_test is
  port(
    rst                      : in  std_logic;

    test_clk                 : in  std_logic; -- test clock

    count_enable             : in  std_logic;
                               
    fm_mode                  : in  std_logic_vector(   1 downto 0);
    fm_cmd                   : in  std_logic_vector(   3 downto 0);
    fm_pattern               : in  std_logic_vector(   1 downto 0);
                               
    counter                  : out std_logic_vector(4095 downto 0);

    iob_in                   : out std_logic_vector(  41 downto 0); -- respect to DUT
    iob_out                  : in  std_logic_vector( 125 downto 0)  -- respect to DUT
);
end funcmon_dut_bus_test;


architecture behavioral of funcmon_dut_bus_test is
                                       
  signal common_output                 : std_logic;
                                       
  signal common_input_compare          : std_logic;
                                       
  signal data_gen                      : unsigned(2 downto 0);

  constant input_signals_max_index     : integer := 125;
  constant output_signals_max_index    : integer :=  41;
  constant error_count_max_index       : integer := 127;

  subtype error_count_typ is unsigned(31 downto 0);

  type error_count_typ_array is array (error_count_max_index downto 0) of error_count_typ;

  signal error_count                       : error_count_typ_array;
                                           
  signal start_count                       : unsigned(7 downto 0);
                                           
  signal clk_div4                          : std_logic;
  signal clk_div8                          : std_logic;
  signal clk_div32                         : std_logic;
  signal clk_div64                         : std_logic;
                                           
--signal clk_out                           : std_logic;
--signal clkdiv_out                        : std_logic;

  signal div_cnt                           : std_logic_vector(12 downto 0):=(others=>'0');

  constant data_shift_register_max_index   : integer := 25;

  signal common_input_compare_dly          : std_logic_vector(data_shift_register_max_index downto 1);
                                           
--signal compare_select                    : std_logic_vector(1 downto 0);
                                           
  signal repeat_every_8                    : std_logic;

  signal common_input_compare_pipelined    : std_logic;
                                           
  signal common_input_compare_dly1         : std_logic;
  signal common_input_compare_dly2         : std_logic;
                                           
  -- ^^ enough for nonregistered           
                                           
  signal common_input_compare_dly3         : std_logic;
  signal common_input_compare_dly4         : std_logic;
                                           
  -- ^^ now enough for registered          
                                           
  signal common_input_compare_dly5         : std_logic;
                                           
  signal expected_inverse                  : std_logic;
                                           
  shared variable  fm_cmd_integer          : integer range   1 to 25;
                                           
  shared variable  fm_cmd_offset           : integer range   0 to  7;
                                           
  signal FM_cmd_unsigned                   : unsigned(3 downto 0);

  signal select_four_screens               : std_logic;
  signal select_two_screens                : std_logic;
  signal select_screen_1                   : std_logic;
                                           
  signal screen_select                     : std_logic_vector(1 downto 0);
                                           
  signal dut_is_registered                 : std_logic;
                                           
  signal compare_pipeline_sel              : std_logic_vector(1 downto 0);

begin


    select_four_screens      <= fm_mode(1);
    select_two_screens       <= fm_mode(0);

--  select_screen_1          <= fm_cmd(3);
    select_screen_1          <= '0';

    compare_pipeline_sel     <= dut_is_registered & fm_cmd(1);
    dut_is_registered        <= fm_cmd(0);


    -- lvcmos18; define common_input_compare_pipelined
    common_input_compare_pipelined <= common_input_compare_dly5 when (compare_pipeline_sel = "11") else
                                      common_input_compare_dly4 when (compare_pipeline_sel = "10") else
                                      common_input_compare_dly3 when (compare_pipeline_sel = "01") else
                                      common_input_compare_dly2;


    process(test_clk)
    begin
      if rising_edge(test_clk) then
        common_input_compare_dly1  <= common_input_compare;
        common_input_compare_dly2  <= common_input_compare_dly1;
        common_input_compare_dly3  <= common_input_compare_dly2;
        common_input_compare_dly4  <= common_input_compare_dly3;
        common_input_compare_dly5  <= common_input_compare_dly4;
      end if;
    end process;


  --compare_select <= fm_pattern;

    screen_select  <= select_two_screens & select_screen_1;


  --counter_map : for i in  0 to 63 generate
    counter_map : for i in  0 to 127 generate
      signal register_32_bits : std_logic_vector( 31 downto 0 );
    begin

      register_32_bits <= std_logic_vector(error_count(i));

      counter( ( i*32 + 31 ) downto i*32 ) <= register_32_bits;

    end generate;


    -- start_count is used in ioserdes; leaving it in here; shouldn't cause any problem
    process(test_clk)
    begin
      if rising_edge(test_clk) then

        if (rst = '1') then
          start_count <= (others => '0');
        elsif ( start_count =  "11111111" ) then -- maintain the count after initialization period ?
          start_count <= start_count;
        else                                     -- initialization period: increment the count
          start_count <= start_count + 1;
        end if;

      end if;
    end process;


    ----------------------------------------------------------------------
    -- combinatorial, no longer process for output bit pattern sent to the dut
    -- -----------------------------------
    --
    -- Note that Inverse will pass both nonregistered and registered,
    --   even if testing for the other design type.
    --
    -- However, Normal will pass only the design type,
    --   nonregistered or registered, that is being tested for
    --
    -- using '.'s, instead of 0's, in Inverse and Normal columns,
    --   for readability
    --
    -- data_gen   Inverse   Normal  Serdes
    --
    --   000         .        .       .
    --   001         1        .       .
    --   010         .        1       1
    --   011         1        .       1
    --   100         .        1       .
    --   101         1        1       1
    --   110         .        .       .
    --   111         1        1       1
    --
    ----------------------------------------------------------------------

    -- 11.1..1. : repeats every 8 clocks

    common_output        <= '0'            when (fm_pattern = "00") else
                            '1'            when (fm_pattern = "01") else
                            data_gen( 0 )  when (fm_pattern = "10") else
                            repeat_every_8 when (fm_pattern = "11") else
                            '0';

    common_input_compare <= '0'            when (fm_pattern = "00") else
                            '1'            when (fm_pattern = "01") else
                            data_gen( 0 )  when (fm_pattern = "10") else
                            repeat_every_8 when (fm_pattern = "11") else
                            '0';


    -- lvcmos18 definition of repeat_every_8
    repeat_every_8 <= (data_gen(2) xor (data_gen(1) and (not data_gen(0))));


    ----------------------------------------------------------------------
    -- process for the 3-bit data generator data_gen
    ----------------------------------------------------------------------
    process(test_clk)
    begin
      if rising_edge(test_clk) then

        if (rst = '1') then
          data_gen                  <= (others => '0');
        else
          data_gen                  <= data_gen + 1;
        end if;
      end if;
    end process;


    ----------------------------------------------------------------------

    gen_data_output_instance : for n in 0 to output_signals_max_index generate
    --data_output(n) <= common_output;
      iob_in(n)      <= common_output;
    end generate;

    ----------------------------------------------------------------------

    -- ioserdes info

    -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    -- fm_cmd buttons for new Funcmon
    --
    -- If all buttons are off, expecting old non-FIFO design to pass "Inverse" pattern
    -- If all buttons are off, expecting new     FIFO design to FAIL "Inverse" pattern
    --
    -- If only button FM5 ( 0 ) is ON, expecting old non-FIFO design to FAIL "Inverse" pattern
    -- If only button FM5 ( 0 ) is ON, expecting new     FIFO design to pass "Inverse" pattern
    --
    --
    -- fm_cmd( 0 ) -- FM5 -- Add 1      cycle  to the delayed comparison signal,
    --                       which targets a passing "Inverse" pattern for the old design
    --
    --                    -- Also selects New FIFO design
    --
    -- fm_cmd( 1 ) -- FM6 -- Add      2 cycles to the delayed comparison signal,
    -- fm_cmd( 2 ) -- FM7 -- Add      4 cycles to the delayed comparison signal,
    -- fm_cmd( 3 ) -- FM8 -- Subtract 4 cycles to the delayed comparison signal,
    --
    -- The delayed comparison signal can be from -4 to +7, in steps of 1, from the target
    --
    -- The default (0 add/0 subtract) delayed comparison signal targets the old non-FIFO design.
    --
    -- If fm_cmd( 0 ) / FM5, is (only) on, the new FIFO design is targeted.
    -- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


    gen_IOB_error_i : for n in 0 to error_count_max_index generate
      process(test_clk)
      begin

        if rising_edge(test_clk) then

          if (rst = '1') then
            error_count(n) <= (others => '0');
          else

            if ((count_enable = '1') and (n <= input_signals_max_index) and (start_count = "11111111")) then

            --if (data_input(n) = common_input_compare_pipelined) then
              if (iob_out(n) = common_input_compare_pipelined) then
                  error_count(n) <= error_count(n);
              else
                  error_count(n) <= error_count(n) + 1;
              end if;

            end if;
          end if;
        end if;
      end process;
    end generate;


    --Divider-stages for the output of the DLL-oscillator
    process(test_clk)
    begin
      if rising_edge(test_clk) then
        div_cnt <= std_logic_vector(unsigned(div_cnt) + 1);
      end if;
    end process;


  end behavioral;