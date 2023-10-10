
`timescale 1 ps/1 ps

module clocks_generation (
    //
    // Clock
    input           clkin1,
    input           clkin1_bufg,
    // Asynchronous resets/status
    input           glbl_rst,
    output          dcm_locked,
    //
    // clock outputs
    output          gtx_clk_bufg,
    output          refclk_iodelay_bufg
);

    wire           mmcm_rst;
//     wire           clkin1_bufg;
    wire           dcm_locked_int;
    wire           dcm_locked_sync;
    reg            dcm_locked_reg = 1;
    reg            dcm_locked_edge = 1;


//     // Route clkin1 through a BUFGCE for the MMCM reset generation logic
//     BUFGCE #(  
//         .SIM_DEVICE("7SERIES") 
//     )
//     bufg_clkin1 (
//         .I  (clkin1), 
//         .CE (1'b1), 
//         .O  (clkin1_bufg)
//     );  

    // Detect a falling edge on dcm_locked (after resyncing to this domain)
    sync_block lock_sync (
        .clk            (clkin1_bufg),
        .data_in        (dcm_locked_int),
        .data_out       (dcm_locked_sync)
    );

    // For the falling edge detect we want to force this at power on so init the flops to 1
    always @(posedge clkin1_bufg)
    begin
        dcm_locked_reg     <= dcm_locked_sync;
        dcm_locked_edge    <= dcm_locked_reg & !dcm_locked_sync;
    end

    // MMCM reset pulse width should be at least 5 ns  
    reset_sync reset_sync__mmcm_inst (
        .clk            (clkin1_bufg),
        .enable         (1'b1),
        .reset_in       (glbl_rst | dcm_locked_edge),
        .reset_out      (mmcm_rst)
    );


    // -----
    // Generate clocks
    clk_wiz clk_wiz__inst (
        //
        // Clock in ports
        .CLK_IN1        (clkin1),
        //
        // Clock out ports
        .CLK_OUT0       (gtx_clk_bufg),
        .CLK_OUT1       (refclk_iodelay_bufg),
        //
        // Status and control signals
        .RESET          (mmcm_rst),
        .LOCKED         (dcm_locked_int)
    );

    assign dcm_locked = dcm_locked_int;

  

endmodule






















