module funcmon_v7_full_board #(
    parameter       COUNTERS_REG_WORDS = 128,
    parameter       COUNTERS_REG_BITS_PER_WORD = 32,
    parameter       EXTRA_WORDS = 8,
    parameter       BITS_FUNCMON_STATUS = 32,
    parameter       BITS_COMMIF_RX_CMD = 32)
    (
    input           clk_in_p,    // Main clock: 50 MHz from on-board oscillator
    input           clk_in_n,

    // RGMII I/F
    output  [3:0]   rgmii_txd,
    output          rgmii_tx_ctl,
    output          rgmii_txc,
    input   [3:0]   rgmii_rxd,
    input           rgmii_rx_ctl,
    input           rgmii_rxc,

    output          phy_reset_n, // Reset input of the PHY chip

    //-----------------------------------------------------------------------------
    // Test IOs
    //-----------------------------------------------------------------------------

    // KU060 Bank 24 (49 IOs)
    output  df_i_n_20, // KU060 Bank 24  (diff_bus_in_n[20])
    input   df_i_p_20, // KU060 Bank 24  (diff_bus_in_p[20])

    input   df_o_n_1,  // KU060 Bank 24  (diff_bus_out_n[1])
    input   df_o_p_1,  // KU060 Bank 24  (diff_bus_out_p[1])
    output  df_o_n_9,  // KU060 Bank 24  (diff_bus_out_n[9])
    input   df_o_p_9,  // KU060 Bank 24  (diff_bus_out_p[9])
    input   df_o_n_14, // KU060 Bank 24  (diff_bus_out_n[14])
    input   df_o_p_14, // KU060 Bank 24  (diff_bus_out_p[14])
    output  df_o_n_19, // KU060 Bank 24  (diff_bus_out_n[19])
    input   df_o_p_19, // KU060 Bank 24  (diff_bus_out_p[19])

    input   df_0051_n, // KU060 Bank 24
    input   df_0051_p, // KU060 Bank 24
    output  df_0052_n, // KU060 Bank 24
    input   df_0052_p, // KU060 Bank 24
    input   df_0053_n, // KU060 Bank 24
    input   df_0053_p, // KU060 Bank 24
    output  df_0056_n, // KU060 Bank 24
    input   df_0056_p, // KU060 Bank 24
    input   df_0057_n, // KU060 Bank 24
    input   df_0057_p, // KU060 Bank 24
    output  df_0059_n, // KU060 Bank 24
    input   df_0059_p, // KU060 Bank 24
    input   df_0092_n, // KU060 Bank 24
    input   df_0092_p, // KU060 Bank 24
    output  df_0095_n, // KU060 Bank 24
    input   df_0095_p, // KU060 Bank 24
    input   df_0099_n, // KU060 Bank 24 (df_0099_n) 
    input   df_0099_p, // KU060 Bank 24 (df_0099_p) 
    input   df_0114_n, // KU060 Bank 24
    input   df_0114_p, // KU060 Bank 24

    // KU060 Bank 25 (52 IOs)
    output  df_i_n_21, // KU060 Bank 25 (diff_bus_in_cc_n[21])
    input   df_i_p_21, // KU060 Bank 25 (diff_bus_in_cc_p[21])
    input   df_i_n_22, // KU060 Bank 25 (diff_bus_in_cc_n[22])
    input   df_i_p_22, // KU060 Bank 25 (diff_bus_in_cc_p[22])
    output  df_i_n_23, // KU060 Bank 25 (diff_bus_in_n[23])   
    input   df_i_p_23, // KU060 Bank 25 (diff_bus_in_p[23])   
    input   df_i_n_24, // KU060 Bank 25 (diff_bus_in_n[24])   
    input   df_i_p_24, // KU060 Bank 25 (diff_bus_in_p[24])   
    output  df_i_n_25, // KU060 Bank 25 (diff_bus_in_n[25])   
    input   df_i_p_25, // KU060 Bank 25 (diff_bus_in_p[25])   
    input   df_i_n_26, // KU060 Bank 25 (diff_bus_in_n[26])   
    input   df_i_p_26, // KU060 Bank 25 (diff_bus_in_p[26])   

    output  df_o_n_40, // KU060 Bank 25 (diff_bus_out_cc_n[40])
    input   df_o_p_40, // KU060 Bank 25 (diff_bus_out_cc_p[40])
    input   df_o_n_54, // KU060 Bank 25 (diff_bus_out_n[54])   
    input   df_o_p_54, // KU060 Bank 25 (diff_bus_out_p[54])    
    output  df_o_n_69, // KU060 Bank 25 (diff_bus_out_n[69])   
    input   df_o_p_69, // KU060 Bank 25 (diff_bus_out_p[69])   
    input   df_o_n_71, // KU060 Bank 25 (diff_bus_out_n[71])   
    input   df_o_p_71, // KU060 Bank 25 (diff_bus_out_p[71])   

    input   df_0150_n, // KU060 Bank 25 (df_cc_0150_n)
    input   df_0150_p, // KU060 Bank 25 (df_cc_0150_p)
  
    // KU060 Bank 44 (47 IOs)
    output  df_i_n_5,  // KU060 Bank 44 (diff_bus_in_n[5])
    input   df_i_p_5,  // KU060 Bank 44 (diff_bus_in_p[5])
    input   df_i_n_10, // KU060 Bank 44 (diff_bus_in_n[10])
    input   df_i_p_10, // KU060 Bank 44 (diff_bus_in_p[10])
    output  df_i_n_12, // KU060 Bank 44 (diff_bus_in_n[12])
    input   df_i_p_12, // KU060 Bank 44 (diff_bus_in_p[12])
    input   df_i_n_15, // KU060 Bank 44 (diff_bus_in_n[15])
    input   df_i_p_15, // KU060 Bank 44 (diff_bus_in_p[15])
    output  df_i_n_16, // KU060 Bank 44 (diff_bus_in_n[16])
    input   df_i_p_16, // KU060 Bank 44 (diff_bus_in_p[16])
    input   df_i_n_17, // KU060 Bank 44 (diff_bus_in_n[17])
    input   df_i_p_17, // KU060 Bank 44 (diff_bus_in_p[17])

    output  df_o_n_5,  // KU060 Bank 44 (diff_bus_out_n[5])
    input   df_o_p_5,  // KU060 Bank 44 (diff_bus_out_p[5])

    input   df_0000_n, // KU060 Bank 44
    input   df_0000_p, // KU060 Bank 44
    output  df_0001_n, // KU060 Bank 44
    input   df_0001_p, // KU060 Bank 44
    input   df_0005_n, // KU060 Bank 44
    input   df_0005_p, // KU060 Bank 44
    output  df_0008_n, // KU060 Bank 44
    input   df_0008_p, // KU060 Bank 44
    input   df_0011_n, // KU060 Bank 44
    input   df_0011_p, // KU060 Bank 44
    output  df_0012_n, // KU060 Bank 44
    input   df_0012_p, // KU060 Bank 44
    input   df_0013_n, // KU060 Bank 44
    input   df_0013_p, // KU060 Bank 44
    output  df_0017_n, // KU060 Bank 44
    input   df_0017_p, // KU060 Bank 44
    input   df_0023_n, // KU060 Bank 44
    input   df_0023_p, // KU060 Bank 44
    output  df_0028_n, // KU060 Bank 44
    input   df_0028_p, // KU060 Bank 44
    input   df_0046_n, // KU060 Bank 44
    input   df_0046_p, // KU060 Bank 44

    // KU060 Bank 45 (51 IOs)
    output  df_o_n_2,  // KU060 Bank 45 (diff_bus_out_n[2])
    input   df_o_p_2,  // KU060 Bank 45 (diff_bus_out_p[2])
    input   df_o_n_6,  // KU060 Bank 45 (diff_bus_out_n[6])
    input   df_o_p_6,  // KU060 Bank 45 (diff_bus_out_p[6])
    output  df_o_n_7,  // KU060 Bank 45 (diff_bus_out_n[7])
    input   df_o_p_7,  // KU060 Bank 45 (diff_bus_out_p[7])
    input   df_o_n_10, // KU060 Bank 45 (diff_bus_out_n[10])
    input   df_o_p_10, // KU060 Bank 45 (diff_bus_out_p[10])
    output  df_o_n_11, // KU060 Bank 45 (diff_bus_out_n[11])
    input   df_o_p_11, // KU060 Bank 45 (diff_bus_out_p[11])
    input   df_o_n_12, // KU060 Bank 45 (diff_bus_out_n[12])
    input   df_o_p_12, // KU060 Bank 45 (diff_bus_out_p[12])
    output  df_o_n_15, // KU060 Bank 45 (diff_bus_out_n[15])
    input   df_o_p_15, // KU060 Bank 45 (diff_bus_out_p[15])
    input   df_o_n_16, // KU060 Bank 45 (diff_bus_out_n[16])
    input   df_o_p_16, // KU060 Bank 45 (diff_bus_out_p[16])
    output  df_o_n_17, // KU060 Bank 45 (diff_bus_out_n[17])
    input   df_o_p_17, // KU060 Bank 45 (diff_bus_out_p[17])
    input   df_o_n_20, // KU060 Bank 45 (diff_bus_out_n[20])
    input   df_o_p_20, // KU060 Bank 45 (diff_bus_out_p[20])
     
    output  df_0002_n, // KU060 Bank 45 (df_0002_n)
    input   df_0002_p, // KU060 Bank 45 (df_0002_p)
    input   df_0004_n, // KU060 Bank 45 (df_0004_cc_n)
    input   df_0004_p, // KU060 Bank 45 (df_0004_cc_p)
    output  df_0007_n, // KU060 Bank 45 (df_0007_n)
    input   df_0007_p, // KU060 Bank 45 (df_0007_p)
    input   df_0010_n, // KU060 Bank 45 (df_0010_cc_n)
    input   df_0010_p, // KU060 Bank 45 (df_0010_cc_p)
    output  df_0014_n, // KU060 Bank 45 (df_0014_n)
    input   df_0014_p, // KU060 Bank 45 (df_0014_p)
    input   df_0016_n, // KU060 Bank 45 (df_cc_0016_n)
    input   df_0016_p, // KU060 Bank 45 (df_cc_0016_p)
    output  df_0018_n, // KU060 Bank 45 (df_0018_n)
    input   df_0018_p, // KU060 Bank 45 (df_0018_p)
    input   df_0022_n, // KU060 Bank 45 (df_0022_n)
    input   df_0022_p, // KU060 Bank 45 (df_0022_p)
    output  df_0029_n, // KU060 Bank 45 (df_0029_n)
    input   df_0029_p, // KU060 Bank 45 (df_0029_p)
    input   df_0048_n, // KU060 Bank 45 (df_0048_n)
    input   df_0048_p, // KU060 Bank 45 (df_0048_p)
    output  df_0049_n, // KU060 Bank 45 (df_0049_n)
    input   df_0049_p, // KU060 Bank 45 (df_0049_p)
    input   df_0050_n, // KU060 Bank 45 (df_0050_n)
    input   df_0050_p, // KU060 Bank 45 (df_0050_p)

    // KU060 Bank 46 (52 IOs)
    output  df_i_n_54, // KU060 Bank 46 (diff_bus_in_n[54])
    input   df_i_p_54, // KU060 Bank 46 (diff_bus_in_p[54])

    input   df_o_n_57, // KU060 Bank 46 (diff_bus_out_n[57])
    input   df_o_p_57, // KU060 Bank 46 (diff_bus_out_p[57])
    input   df_o_n_77, // KU060 Bank 46 (diff_bus_out_n[77])
    input   df_o_p_77, // KU060 Bank 46 (diff_bus_out_p[77])
    
    // KU060 Bank 47 (52 IOs)
    output  df_o_n_55, // KU060 Bank 47 (diff_bus_out_cc_n[55])
    input   df_o_p_55, // KU060 Bank 47 (diff_bus_out_cc_p[55])
    input   df_o_n_56, // KU060 Bank 47 (diff_bus_out_cc_n[56])
    input   df_o_p_56, // KU060 Bank 47 (diff_bus_out_cc_p[56])
    output  df_o_n_59, // KU060 Bank 47 (diff_bus_out_n[59]) 
    input   df_o_p_59, // KU060 Bank 47 (diff_bus_out_p[59]) 
    input   df_o_n_60, // KU060 Bank 47 (diff_bus_out_n[60]) 
    input   df_o_p_60, // KU060 Bank 47 (diff_bus_out_p[60]) 
    output  df_o_n_61, // KU060 Bank 47 (diff_bus_out_n[61]) 
    input   df_o_p_61, // KU060 Bank 47 (diff_bus_out_p[61]) 
    input   df_o_n_64, // KU060 Bank 47 (diff_bus_out_n[64]) 
    input   df_o_p_64, // KU060 Bank 47 (diff_bus_out_p[64]) 
    output  df_o_n_73, // KU060 Bank 47 (diff_bus_out_n[73]) 
    input   df_o_p_73, // KU060 Bank 47 (diff_bus_out_p[73]) 

    input   df_0068_n, // KU060 Bank 47 (df_0068_cc_n)
    input   df_0068_p, // KU060 Bank 47 (df_0068_cc_p)

    // KU060 Bank 48 (not used. not availabel for V7 485)
    
    // KU060 Bank 64 (bank with limited IO to FuncMon FPGA, close to bank 44 or 65)
    output   df_o_n_80, // KU060 Bank 64 (diff_bus_out_n[80])
    input    df_o_p_80, // KU060 Bank 64 (diff_bus_out_p[80])
    
    input    se_096,    // KU060 Bank 64
    input    df_0143_p, // KU060 Bank 64
    input    se_084,    // KU060 Bank 64
    
    // KU060 Bank 66 (46 IOs)
    input    df_i_n_1,  // KU060 Bank 66 (diff_bus_in_n[1]) 
    input    df_i_p_1,  // KU060 Bank 66 (diff_bus_in_p[1]) 
    input    df_i_n_47, // KU060 Bank 66 (diff_bus_in_n[47]) 
    input    df_i_p_47, // KU060 Bank 66 (diff_bus_in_p[47]) 
    input    df_i_n_48, // KU060 Bank 66 (diff_bus_in_n[48]) 
    input    df_i_p_48, // KU060 Bank 66 (diff_bus_in_p[48]) 
    input    df_i_n_49, // KU060 Bank 66 (diff_bus_in_n[49]) 
    input    df_i_p_49, // KU060 Bank 66 (diff_bus_in_p[49]) 
    output   df_i_n_50, // KU060 Bank 66 (diff_bus_in_n[50]) 
    input    df_i_p_50, // KU060 Bank 66 (diff_bus_in_p[50]) 
    output   df_i_n_80, // KU060 Bank 66 (diff_bus_in_cc_n[80])
    output   df_i_p_80, // KU060 Bank 66 (diff_bus_in_cc_p[80])

    output   df_o_n_21, // KU060 Bank 66 (diff_bus_out_n[21])
    input    df_o_p_21, // KU060 Bank 66 (diff_bus_out_p[21])
    input    df_o_n_23, // KU060 Bank 66 (diff_bus_out_n[23])
    input    df_o_p_23, // KU060 Bank 66 (diff_bus_out_p[23])
    output   df_o_n_25, // KU060 Bank 66 (diff_bus_out_n[25])
    input    df_o_p_25, // KU060 Bank 66 (diff_bus_out_p[25])
    input    df_o_n_26, // KU060 Bank 66 (diff_bus_out_n[26])
    input    df_o_p_26, // KU060 Bank 66 (diff_bus_out_p[26])

    output   df_0019_n, // KU060 Bank 66
    input    df_0019_p, // KU060 Bank 66
    input    df_0020_n, // KU060 Bank 66
    input    df_0020_p, // KU060 Bank 66
    input    df_0021_n, // KU060 Bank 66
    input    df_0021_p  // KU060 Bank 66
);


//-----------------------------------------------------------------------------
    wire                clk_in;
    wire                clk_in_bufg;
    reg [63:0]          reset_master_shift_reg = 64'hFFFFFFFFFFFFFFFF;
    reg                 reset_master = 1'b1;
    wire                reset_fm;
    wire                dcm_locked;    
    wire                clk_temac_125MHz_bufg;
    wire                clk_idelayctrl_200MHz_bufg;

    wire [(COUNTERS_REG_WORDS * COUNTERS_REG_BITS_PER_WORD - 1) : 0]  fm_counters_block_bits;
    wire                fm_snapshot_request;
    wire [(BITS_FUNCMON_STATUS -1):0]  fm_status_register;
    wire [($clog2(COUNTERS_REG_WORDS) - 1) : 0]  fm_register_select;

    wire                commif_rx_command_flag;
    wire [(BITS_COMMIF_RX_CMD - 1):0]  commif_rx_command;

    wire [15:0]         snapshot_databytes_length;
    wire [7:0]          snapshot_databytes_bus;
    wire [ ($clog2((COUNTERS_REG_BITS_PER_WORD/8)*(COUNTERS_REG_WORDS + EXTRA_WORDS)) - 1) : 0]  snapshot_databytes_index;

    wire [31:0]         test_counter_32;
    wire                cmd_error;
    wire                cmd_ok;
//-----------------------------------------------------------------------------


    // 50 MHz main clock
    IBUFDS clk_in_buf (
        .O  (clk_in),
        .I  (clk_in_p),
        .IB (clk_in_n));

    BUFGCE #(  
        .SIM_DEVICE("7SERIES"))
    bufg_clkin1 (
        .I  (clk_in), 
        .CE (1'b1), 
        .O  (clk_in_bufg));      
    
    
    // Internal initial 'master/global reset' 
    // NOTE: reset_master_shift_reg and reset_master are initialized filled with ones.
    always @(posedge clk_in_bufg)    
    begin    
       reset_master_shift_reg[0]    <= 1'b0;
       reset_master_shift_reg[63:1] <= reset_master_shift_reg[62:0];
       reset_master                 <= reset_master_shift_reg[63];
    end 

        
    // -----
    // Clocks generation module 
    clocks_generation clocks_generation__inst (
        //
        // Clock input
        .clkin1                 (clk_in),    
        .clkin1_bufg            (clk_in_bufg),
        //
        // Asynchronous reset input
        .glbl_rst               (reset_master),
        //
        // Asynchronous status from MCCM
        .dcm_locked             (dcm_locked),
        //
        // Clock outputs
        .gtx_clk_bufg           (clk_temac_125MHz_bufg),
        .refclk_iodelay_bufg    (clk_idelayctrl_200MHz_bufg)
    );   

    assign clk_fm = clk_idelayctrl_200MHz_bufg;
    
    
    // -----
    //
    fm_resets_generation fm_resets_generation__inst (
        //
        // Clocks
        .clock_fm               (clk_fm),
        //
        // Asynchronous reset and MMCM status inputs
        .reset_global           (reset_master),
        .dcm_locked             (dcm_locked),
        //
        // Synchronous reset outputs
        .reset_fm               (reset_fm)
    );
   

    // -----
    // Wrapper for communication I/F (UDP/IP using TEMAC with RGMII I/F) 
    udp_with_temac_rgmii udp_with_temac_rgmii__inst (
        //
        .clk_temac_125MHz_bufg                  (clk_temac_125MHz_bufg),      // Clock (125 MHz) for TEMAC Tx side, FIFOs and other modules of the GbE communication interface
        .clk_idelayctrl_200MHz_bufg             (clk_idelayctrl_200MHz_bufg), // Clock (200 MHz) for IODELAYs (IDELAYCTRL primitive) used in RGMII I/F

        .dcm_locked                             (dcm_locked),                 // 'LOCKED' signal from top module's MMCM (generating the clocks)
                                                                              
        .global_rst                             (reset_master),               // Master reset input (asynchronous, in general)
        .phy_reset_n                            (phy_reset_n),

        // RGMII I/F 
        .rgmii_txd                              (rgmii_txd),
        .rgmii_tx_ctl                           (rgmii_tx_ctl),
        .rgmii_txc                              (rgmii_txc),
        .rgmii_rxd                              (rgmii_rxd),
        .rgmii_rx_ctl                           (rgmii_rx_ctl),
        .rgmii_rxc                              (rgmii_rxc),

        // Ports connecting to FuncMon exerciser side
        .clk_fm                                 (clk_fm), 
        .reset_fm                               (reset_fm), 
        .fm_counters_block_bits                 (fm_counters_block_bits),  
        .fm_register_select                     (fm_register_select),
        .fm_snapshot_request                    (fm_snapshot_request),
        .fm_status_register                     (fm_status_register),
        .commif_rx_command_flag__clk_fm_domain  (commif_rx_command_flag),
        .commif_rx_command__clk_fm_domain       (commif_rx_command)
    );    


    //
    // NOTE: 'regsel' index is used in beam test designs that update the counters sequentially (e.g., BRAM tests)
    //       For consistency, the snapshot is only taken when 'regsel' equals zero.       
    assign fm_register_select = 0;
    assign fm_status_register = 32'b10101010101010101010101010101010;


    // Timer for periodic transmission of registers via UDP/IP 
    timer #(
        .TIME_us            (250),    // 4 k packet/s    
        .F_CLOCK_MHz        (200)) 
    timer_i (
        .clock              (clk_fm), 
        .reset              (reset_fm),
        .tick               (fm_snapshot_request),
        .toggle_duty50      ());


    //-----------------------------------------------------------------------------
    //  // Instantiate FuncMon Exerciser
    //  // Inputs: clk_fm, reset_i, commif_rx_command bus, commif_rx_command_flag, exerciser's (IOB, RAM, stc.) inputs from DUT outputs, etc.
    //  // Outputs: "error counter" registers, exerciser's (IOB, RAM, stc.) outputs to DUT inputs, etc.
    //-----------------------------------------------------------------------------
    funcmon_top funcmon_top_i (
        // to DUT
        .clk                      (clk_temac_125MHz_bufg),  // (i)
                                                            
        .command                  (commif_rx_command),      // (i) [31:0]
        .command_load             (commif_rx_command_flag), // (i)
                                                             
        .fm_counters              (fm_counters_block_bits), // FUNCMON to IDE

        //-----------------------------------------------------------------------------
        // Test IOs
        //-----------------------------------------------------------------------------

        // KU060 Bank 24 (49 IOs)
        .df_i_n_20                (df_i_n_20), // out KU060 Bank 24  (diff_bus_in_n[20])
        .df_i_p_20                (df_i_p_20), // out KU060 Bank 24  (diff_bus_in_p[20])
                                   
        .df_o_n_1                 (df_o_n_1),  // in  KU060 Bank 24  (diff_bus_out_n[1])
        .df_o_p_1                 (df_o_p_1),  // in  KU060 Bank 24  (diff_bus_out_p[1])
        .df_o_n_9                 (df_o_n_9),  // in  KU060 Bank 24  (diff_bus_out_n[9])
        .df_o_p_9                 (df_o_p_9),  // in  KU060 Bank 24  (diff_bus_out_p[9])
        .df_o_n_14                (df_o_n_14), // in  KU060 Bank 24  (diff_bus_out_n[14])
        .df_o_p_14                (df_o_p_14), // in  KU060 Bank 24  (diff_bus_out_p[14])
        .df_o_n_19                (df_o_n_19), // in  KU060 Bank 24  (diff_bus_out_n[19])
        .df_o_p_19                (df_o_p_19), // in  KU060 Bank 24  (diff_bus_out_p[19])
                                   
        .df_0051_n                (df_0051_n), // out KU060 Bank 24
        .df_0051_p                (df_0051_p), // out KU060 Bank 24
        .df_0052_n                (df_0052_n), // in  KU060 Bank 24
        .df_0052_p                (df_0052_p), // in  KU060 Bank 24
        .df_0053_n                (df_0053_n), // in  KU060 Bank 24
        .df_0053_p                (df_0053_p), // in  KU060 Bank 24
        .df_0056_n                (df_0056_n), // out KU060 Bank 24
        .df_0056_p                (df_0056_p), // out KU060 Bank 24
        .df_0057_n                (df_0057_n), // in  KU060 Bank 24
        .df_0057_p                (df_0057_p), // in  KU060 Bank 24
        .df_0059_n                (df_0059_n), // in  KU060 Bank 24
        .df_0059_p                (df_0059_p), // in  KU060 Bank 24
        .df_0092_n                (df_0092_n), // in  KU060 Bank 24
        .df_0092_p                (df_0092_p), // in  KU060 Bank 24
        .df_0095_n                (df_0095_n), // in  KU060 Bank 24
        .df_0095_p                (df_0095_p), // in  KU060 Bank 24
        .df_0099_n                (df_0099_n), // in  KU060 Bank 24 (df_0099_n) 
        .df_0099_p                (df_0099_p), // in  KU060 Bank 24 (df_0099_p) 
        .df_0114_n                (df_0114_n), // in  KU060 Bank 24
        .df_0114_p                (df_0114_p), // in  KU060 Bank 24

        // KU060 Bank 25 (52 IOs)
        .df_i_n_21                (df_i_n_21), // out KU060 Bank 25 (diff_bus_in_cc_n[21])
        .df_i_p_21                (df_i_p_21), // out KU060 Bank 25 (diff_bus_in_cc_p[21])
        .df_i_n_22                (df_i_n_22), // out KU060 Bank 25 (diff_bus_in_cc_n[22])
        .df_i_p_22                (df_i_p_22), // out KU060 Bank 25 (diff_bus_in_cc_p[22])
        .df_i_n_23                (df_i_n_23), // in  KU060 Bank 25 (diff_bus_in_n[23])   
        .df_i_p_23                (df_i_p_23), // in  KU060 Bank 25 (diff_bus_in_p[23])   
        .df_i_n_24                (df_i_n_24), // in  KU060 Bank 25 (diff_bus_in_n[24])   
        .df_i_p_24                (df_i_p_24), // in  KU060 Bank 25 (diff_bus_in_p[24])   
        .df_i_n_25                (df_i_n_25), // in  KU060 Bank 25 (diff_bus_in_n[25])   
        .df_i_p_25                (df_i_p_25), // in  KU060 Bank 25 (diff_bus_in_p[25])   
        .df_i_n_26                (df_i_n_26), // in  KU060 Bank 25 (diff_bus_in_n[26])   
        .df_i_p_26                (df_i_p_26), // in  KU060 Bank 25 (diff_bus_in_p[26])   
                                   
        .df_o_n_40                (df_o_n_40), // in  KU060 Bank 25 (diff_bus_out_cc_n[40])
        .df_o_p_40                (df_o_p_40), // in  KU060 Bank 25 (diff_bus_out_cc_p[40])
        .df_o_n_54                (df_o_n_54), // in  KU060 Bank 25 (diff_bus_out_n[54])   
        .df_o_p_54                (df_o_p_54), // in  KU060 Bank 25 (diff_bus_out_p[54])    
        .df_o_n_69                (df_o_n_69), // in  KU060 Bank 25 (diff_bus_out_n[69])   
        .df_o_p_69                (df_o_p_69), // in  KU060 Bank 25 (diff_bus_out_p[69])   
        .df_o_n_71                (df_o_n_71), // in  KU060 Bank 25 (diff_bus_out_n[71])   
        .df_o_p_71                (df_o_p_71), // in  KU060 Bank 25 (diff_bus_out_p[71])   
                                   
        .df_0150_n                (df_0150_n), // in  KU060 Bank 25 (df_cc_0150_n)
        .df_0150_p                (df_0150_p), // in  KU060 Bank 25 (df_cc_0150_p)

        // KU060 Bank 44 (47 IOs)
        .df_i_n_5                 (df_i_n_5),  // out KU060 Bank 44 (diff_bus_in_n[5])
        .df_i_p_5                 (df_i_p_5),  // out KU060 Bank 44 (diff_bus_in_p[5])
        .df_i_n_10                (df_i_n_10), // out KU060 Bank 44 (diff_bus_in_n[10])
        .df_i_p_10                (df_i_p_10), // out KU060 Bank 44 (diff_bus_in_p[10])
        .df_i_n_12                (df_i_n_12), // out KU060 Bank 44 (diff_bus_in_n[12])
        .df_i_p_12                (df_i_p_12), // out KU060 Bank 44 (diff_bus_in_p[12])
        .df_i_n_15                (df_i_n_15), // out KU060 Bank 44 (diff_bus_in_n[15])
        .df_i_p_15                (df_i_p_15), // out KU060 Bank 44 (diff_bus_in_p[15])
        .df_i_n_16                (df_i_n_16), // out KU060 Bank 44 (diff_bus_in_n[16])
        .df_i_p_16                (df_i_p_16), // out KU060 Bank 44 (diff_bus_in_p[16])
        .df_i_n_17                (df_i_n_17), // in  KU060 Bank 44 (diff_bus_in_n[17])
        .df_i_p_17                (df_i_p_17), // in  KU060 Bank 44 (diff_bus_in_p[17])
                                   
        .df_o_n_5                 (df_o_n_5 ), // in  KU060 Bank 44 (diff_bus_out_n[5])
        .df_o_p_5                 (df_o_p_5 ), // in  KU060 Bank 44 (diff_bus_out_p[5])
                                   
        .df_0000_n                (df_0000_n), // in  KU060 Bank 44
        .df_0000_p                (df_0000_p), // in  KU060 Bank 44
        .df_0001_n                (df_0001_n), // in  KU060 Bank 44
        .df_0001_p                (df_0001_p), // in  KU060 Bank 44
        .df_0005_n                (df_0005_n), // in  KU060 Bank 44
        .df_0005_p                (df_0005_p), // in  KU060 Bank 44
        .df_0008_n                (df_0008_n), // in  KU060 Bank 44
        .df_0008_p                (df_0008_p), // in  KU060 Bank 44
        .df_0011_n                (df_0011_n), // in  KU060 Bank 44
        .df_0011_p                (df_0011_p), // in  KU060 Bank 44
        .df_0012_n                (df_0012_n), // in  KU060 Bank 44
        .df_0012_p                (df_0012_p), // in  KU060 Bank 44
        .df_0013_n                (df_0013_n), // in  KU060 Bank 44
        .df_0013_p                (df_0013_p), // in  KU060 Bank 44
        .df_0017_n                (df_0017_n), // in  KU060 Bank 44
        .df_0017_p                (df_0017_p), // in  KU060 Bank 44
        .df_0023_n                (df_0023_n), // in  KU060 Bank 44
        .df_0023_p                (df_0023_p), // in  KU060 Bank 44
        .df_0028_n                (df_0028_n), // in  KU060 Bank 44
        .df_0028_p                (df_0028_p), // in  KU060 Bank 44
        .df_0046_n                (df_0046_n), // in  KU060 Bank 44
        .df_0046_p                (df_0046_p), // in  KU060 Bank 44

        // KU060 Bank 45 (51 IOs)
        .df_o_n_2                 (df_o_n_2),  // in  KU060 Bank 45 (diff_bus_out_n[2])
        .df_o_p_2                 (df_o_p_2),  // in  KU060 Bank 45 (diff_bus_out_p[2])
        .df_o_n_6                 (df_o_n_6),  // in  KU060 Bank 45 (diff_bus_out_n[6])
        .df_o_p_6                 (df_o_p_6),  // in  KU060 Bank 45 (diff_bus_out_p[6])
        .df_o_n_7                 (df_o_n_7),  // in  KU060 Bank 45 (diff_bus_out_n[7])
        .df_o_p_7                 (df_o_p_7),  // in  KU060 Bank 45 (diff_bus_out_p[7])
        .df_o_n_10                (df_o_n_10), // in  KU060 Bank 45 (diff_bus_out_n[10])
        .df_o_p_10                (df_o_p_10), // in  KU060 Bank 45 (diff_bus_out_p[10])
        .df_o_n_11                (df_o_n_11), // in  KU060 Bank 45 (diff_bus_out_n[11])
        .df_o_p_11                (df_o_p_11), // in  KU060 Bank 45 (diff_bus_out_p[11])
        .df_o_n_12                (df_o_n_12), // in  KU060 Bank 45 (diff_bus_out_n[12])
        .df_o_p_12                (df_o_p_12), // in  KU060 Bank 45 (diff_bus_out_p[12])
        .df_o_n_15                (df_o_n_15), // in  KU060 Bank 45 (diff_bus_out_n[15])
        .df_o_p_15                (df_o_p_15), // in  KU060 Bank 45 (diff_bus_out_p[15])
        .df_o_n_16                (df_o_n_16), // in  KU060 Bank 45 (diff_bus_out_n[16])
        .df_o_p_16                (df_o_p_16), // in  KU060 Bank 45 (diff_bus_out_p[16])
        .df_o_n_17                (df_o_n_17), // in  KU060 Bank 45 (diff_bus_out_n[17])
        .df_o_p_17                (df_o_p_17), // in  KU060 Bank 45 (diff_bus_out_p[17])
        .df_o_n_20                (df_o_n_20), // in  KU060 Bank 45 (diff_bus_out_n[20])
        .df_o_p_20                (df_o_p_20), // in  KU060 Bank 45 (diff_bus_out_p[20])
                                   
        .df_0002_n                (df_0002_n), // out KU060 Bank 45 (df_0002_n)
        .df_0002_p                (df_0002_p), // out KU060 Bank 45 (df_0002_p)
        .df_0004_n                (df_0004_n), // out KU060 Bank 45 (df_0004_cc_n)
        .df_0004_p                (df_0004_p), // out KU060 Bank 45 (df_0004_cc_p)
        .df_0007_n                (df_0007_n), // out KU060 Bank 45 (df_0007_n)
        .df_0007_p                (df_0007_p), // out KU060 Bank 45 (df_0007_p)
        .df_0010_n                (df_0010_n), // out KU060 Bank 45 (df_0010_cc_n)
        .df_0010_p                (df_0010_p), // out KU060 Bank 45 (df_0010_cc_p)
        .df_0014_n                (df_0014_n), // in  KU060 Bank 45 (df_0014_n)
        .df_0014_p                (df_0014_p), // in  KU060 Bank 45 (df_0014_p)
        .df_0016_n                (df_0016_n), // in  KU060 Bank 45 (df_cc_0016_n)
        .df_0016_p                (df_0016_p), // in  KU060 Bank 45 (df_cc_0016_p)
        .df_0018_n                (df_0018_n), // out KU060 Bank 45 (df_0018_n)
        .df_0018_p                (df_0018_p), // out KU060 Bank 45 (df_0018_p)
        .df_0022_n                (df_0022_n), // in  KU060 Bank 45 (df_0022_n)
        .df_0022_p                (df_0022_p), // in  KU060 Bank 45 (df_0022_p)
        .df_0029_n                (df_0029_n), // in  KU060 Bank 45 (df_0029_n)
        .df_0029_p                (df_0029_p), // in  KU060 Bank 45 (df_0029_p)
        .df_0048_n                (df_0048_n), // in  KU060 Bank 45 (df_0048_n)
        .df_0048_p                (df_0048_p), // in  KU060 Bank 45 (df_0048_p)
        .df_0049_n                (df_0049_n), // in  KU060 Bank 45 (df_0049_n)
        .df_0049_p                (df_0049_p), // in  KU060 Bank 45 (df_0049_p)
        .df_0050_n                (df_0050_n), // in  KU060 Bank 45 (df_0050_n)
        .df_0050_p                (df_0050_p), // in  KU060 Bank 45 (df_0050_p)
        
        // KU060 Bank 46 (52 IOs)
        .df_i_n_54                (df_i_n_54), // in  KU060 Bank 46 (diff_bus_in_n[54])
        .df_i_p_54                (df_i_p_54), // in  KU060 Bank 46 (diff_bus_in_p[54])

        .df_o_n_57                (df_o_n_57), // in  KU060 Bank 46 (diff_bus_out_n[57])
        .df_o_p_57                (df_o_p_57), // in  KU060 Bank 46 (diff_bus_out_p[57])
        .df_o_n_77                (df_o_n_77), // in  KU060 Bank 46 (diff_bus_out_n[77])
        .df_o_p_77                (df_o_p_77), // in  KU060 Bank 46 (diff_bus_out_p[77])

        // KU060 Bank 47 (52 IOs)
        .df_o_n_55                (df_o_n_55), // in  KU060 Bank 47 (diff_bus_out_cc_n[55])
        .df_o_p_55                (df_o_p_55), // in  KU060 Bank 47 (diff_bus_out_cc_p[55])
        .df_o_n_56                (df_o_n_56), // in  KU060 Bank 47 (diff_bus_out_cc_n[56])
        .df_o_p_56                (df_o_p_56), // in  KU060 Bank 47 (diff_bus_out_cc_p[56])
        .df_o_n_59                (df_o_n_59), // in  KU060 Bank 47 (diff_bus_out_n[59]) 
        .df_o_p_59                (df_o_p_59), // in  KU060 Bank 47 (diff_bus_out_p[59]) 
        .df_o_n_60                (df_o_n_60), // out KU060 Bank 47 (diff_bus_out_n[60]) 
        .df_o_p_60                (df_o_p_60), // out KU060 Bank 47 (diff_bus_out_p[60]) 
        .df_o_n_61                (df_o_n_61), // in  KU060 Bank 47 (diff_bus_out_n[61]) 
        .df_o_p_61                (df_o_p_61), // in  KU060 Bank 47 (diff_bus_out_p[61]) 
        .df_o_n_64                (df_o_n_64), // in  KU060 Bank 47 (diff_bus_out_n[64]) 
        .df_o_p_64                (df_o_p_64), // in  KU060 Bank 47 (diff_bus_out_p[64]) 
        .df_o_n_73                (df_o_n_73), // in  KU060 Bank 47 (diff_bus_out_n[73]) 
        .df_o_p_73                (df_o_p_73), // in  KU060 Bank 47 (diff_bus_out_p[73]) 
                                   
        .df_0068_n                (df_0068_n), // out KU060 Bank 47 (df_0068_cc_n)
        .df_0068_p                (df_0068_p), // out KU060 Bank 47 (df_0068_cc_p)

        // KU060 Bank 48 (not used. not availabel for V7 485)

        // KU060 Bank 64 (bank with limited IO to FuncMon FPGA, close to bank 44 or 65)
        .df_o_n_80                (df_o_n_80), // in  KU060 Bank 64 (diff_bus_out_n[80])
        .df_o_p_80                (df_o_p_80), // in  KU060 Bank 64 (diff_bus_out_p[80])

        .se_096                   (se_096   ), // in  KU060 Bank 64
        .df_0143_p                (df_0143_p), // in  KU060 Bank 64
        .se_084                   (se_084   ), // in  KU060 Bank 64
        
        // KU060 Bank 66 (46 IOs)
        .df_i_n_1                 (df_i_n_1),  // out KU060 Bank 66 (diff_bus_in_n[1]) 
        .df_i_p_1                 (df_i_p_1),  // out KU060 Bank 66 (diff_bus_in_p[1]) 
        .df_i_n_47                (df_i_n_47), // out KU060 Bank 66 (diff_bus_in_n[47]) 
        .df_i_p_47                (df_i_p_47), // out KU060 Bank 66 (diff_bus_in_p[47]) 
        .df_i_n_48                (df_i_n_48), // out KU060 Bank 66 (diff_bus_in_n[48]) 
        .df_i_p_48                (df_i_p_48), // out KU060 Bank 66 (diff_bus_in_p[48]) 
        .df_i_n_49                (df_i_n_49), // in  KU060 Bank 66 (diff_bus_in_n[49]) 
        .df_i_p_49                (df_i_p_49), // in  KU060 Bank 66 (diff_bus_in_p[49]) 
        .df_i_n_50                (df_i_n_50), // in  KU060 Bank 66 (diff_bus_in_n[50]) 
        .df_i_p_50                (df_i_p_50), // in  KU060 Bank 66 (diff_bus_in_p[50]) 
        .df_i_n_80                (df_i_n_80), // in  KU060 Bank 66 (diff_bus_in_cc_n[80])
        .df_i_p_80                (df_i_p_80), // in  KU060 Bank 66 (diff_bus_in_cc_p[80])
                                   
        .df_o_n_21                (df_o_n_21), // in  KU060 Bank 66 (diff_bus_out_n[21])
        .df_o_p_21                (df_o_p_21), // in  KU060 Bank 66 (diff_bus_out_p[21])
        .df_o_n_23                (df_o_n_23), // in  KU060 Bank 66 (diff_bus_out_n[23])
        .df_o_p_23                (df_o_p_23), // in  KU060 Bank 66 (diff_bus_out_p[23])
        .df_o_n_25                (df_o_n_25), // in  KU060 Bank 66 (diff_bus_out_n[25])
        .df_o_p_25                (df_o_p_25), // in  KU060 Bank 66 (diff_bus_out_p[25])
        .df_o_n_26                (df_o_n_26), // in  KU060 Bank 66 (diff_bus_out_n[26])
        .df_o_p_26                (df_o_p_26), // in  KU060 Bank 66 (diff_bus_out_p[26])
                                   
        .df_0019_n                (df_0019_n), // in  KU060 Bank 66
        .df_0019_p                (df_0019_p), // in  KU060 Bank 66
        .df_0020_n                (df_0020_n), // in  KU060 Bank 66
        .df_0020_p                (df_0020_p), // in  KU060 Bank 66
        .df_0021_n                (df_0021_n), // in  KU060 Bank 66
        .df_0021_p                (df_0021_p), // in  KU060 Bank 66

        .led_status               ()); 

endmodule