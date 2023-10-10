
`timescale 1 ps/1 ps

module fm_resets_generation (
    //
    // Clocks
    input           clock_fm,
    //
    // Asynchronous reset and MMCM status inputs
    input           reset_global,
    input           dcm_locked,
    //
    // Synchronous reset outputs
    output reg      reset_fm = 1
);

    wire            dcm_locked_sync;
    wire            reset_global_bridged_fm;
    reg             reset_fm_pre = 1;


    // -----
    // Synchronise the async dcm_locked signal into FuncMon clock domain
    sync_block sync_block__dcm_locked_inst (
        .clk              (clock_fm),
        .data_in          (dcm_locked),
        .data_out         (dcm_locked_sync)
    );

    // -----
    // Reset bridge on FuncMon clock domain
    reset_sync reset_sync__fm_inst (
        .clk              (clock_fm),
        .enable           (dcm_locked_sync),
        .reset_in         (reset_global),
        .reset_out        (reset_global_bridged_fm)
    );

    // Fully synchronous reset on FuncMon clock domain
    always @(posedge clock_fm)
    begin
    if (reset_global_bridged_fm) 
        begin
        reset_fm_pre <= 1;
        reset_fm <= 1;
        end
      else 
        begin
        reset_fm_pre <= 0;
        reset_fm     <= reset_fm_pre;
        end
    end

    
    





endmodule

























