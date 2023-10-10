
`timescale 1ps/1ps

module clk_wiz (
    // Clock in ports
    input         CLK_IN1,
    // Clock out ports
    output        CLK_OUT0,
    output        CLK_OUT1,
    // Status and control signals
    input         RESET,
    output        LOCKED
);

    // Clocking primitive
    //------------------------------------
    // Instantiation of the MMCM primitive
    //    * Unused inputs are tied off
    //    * Unused outputs are labeled unused
    wire [15:0] do_unused;
    wire        drdy_unused;
    wire        psdone_unused;
    wire        clkfbout;
    wire        clkfboutb_unused;
    wire        clkout0b_unused;
    wire        clkout1b_unused;
    wire        clkout2_unused;
    wire        clkout2b_unused;
    wire        clkout3_unused;
    wire        clkout3b_unused;
    wire        clkout4_unused;
    wire        clkout5_unused;
    wire        clkout6_unused;
    wire        clkfbstopped_unused;
    wire        clkinstopped_unused;
  
    // -----
    // MMCM instantiation
    MMCME2_ADV #(
        .BANDWIDTH            ("OPTIMIZED"),
        .COMPENSATION         ("ZHOLD"),
        .DIVCLK_DIVIDE        (1),
        .CLKFBOUT_MULT_F      (20.000),
        .CLKFBOUT_PHASE       (0.000),
        //
        .CLKOUT0_DIVIDE_F     (8.000),
        .CLKOUT0_PHASE        (0.000),
        .CLKOUT0_DUTY_CYCLE   (0.500),
        //
        .CLKOUT1_DIVIDE       (5),
        .CLKOUT1_PHASE        (0.000),
        .CLKOUT1_DUTY_CYCLE   (0.500),
        //
        .CLKIN1_PERIOD        (5.000),
        .REF_JITTER1          (0.010) )
    mmcm_adv__inst (
        // Output clocks
        .CLKFBOUT            (clkfbout),
        .CLKOUT0             (clkout0),
        .CLKOUT1             (clkout1),
        .CLKOUT2             (clkout2_unused),
        .CLKOUT3             (clkout3_unused),
        .CLKOUT4             (clkout4_unused),
        .CLKOUT5             (clkout5_unused),
        .CLKOUT6             (clkout6_unused),
        //
        .CLKFBOUTB           (clkfboutb_unused),
        .CLKOUT0B            (clkout0b_unused),
        .CLKOUT1B            (clkout1b_unused),
        .CLKOUT2B            (clkout2b_unused),
        .CLKOUT3B            (clkout3b_unused),
        //
        // Input clock control
        .CLKFBIN             (clkfbout),
        .CLKIN1              (CLK_IN1),
        .CLKIN2              (1'b0),
        // Tied to always select the primary input clock
        .CLKINSEL            (1'b1),
        // Ports for dynamic reconfiguration
        .DADDR               (7'h0),
        .DCLK                (1'b0),
        .DEN                 (1'b0),
        .DI                  (16'h0),
        .DO                  (do_unused),
        .DRDY                (drdy_unused),
        .DWE                 (1'b0),
        // Ports for dynamic phase shift
        .PSCLK               (1'b0),
        .PSEN                (1'b0),
        .PSINCDEC            (1'b0),
        .PSDONE              (psdone_unused),
        //
        // Other control and status signals
        .LOCKED              (LOCKED),
        .CLKINSTOPPED        (clkinstopped_unused),
        .CLKFBSTOPPED        (clkfbstopped_unused),
        .PWRDWN              (1'b0),
        .RST                 (RESET)
    );

    // -----
    // Output buffering
    
    BUFGCE #(  
    .SIM_DEVICE("7SERIES") 
    ) 
    clkout0_bufgce (
        .O   (CLK_OUT0),
        .CE  (1'b1),
        .I   (clkout0)
    );
    
    BUFGCE #(  
    .SIM_DEVICE("7SERIES") 
    ) 
    clkout1_bufgce (
        .O   (CLK_OUT1),
        .CE  (1'b1),
        .I   (clkout1)
    );

    
    
endmodule




















