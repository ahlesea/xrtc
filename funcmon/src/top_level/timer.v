module timer #(
    parameter       TIME_us = 200, 
    parameter       F_CLOCK_MHz = 125 ) (
    //
    input           clock, 
    input           reset,
    output reg      tick,
    output reg      toggle_duty50
);


//-----------------------------------------------------------------------------
// Declarations 
    
    // Counter bits number (overflow time for N_cnt bits:  T_ov = 2^N_cnt * T_clock )
    parameter    counts_req = TIME_us * F_CLOCK_MHz;
    parameter    N_cnt = $clog2(counts_req);  

    reg     [N_cnt-1:0]    counter_q;
    wire    [N_cnt-1:0]    counter_q_next;


//-----------------------------------------------------------------------------
// Main body 




    // Counter implemented as a small FSM
    //
    // 1. State update 
    always @(posedge clock)
    if ( (reset)||(counter_q_next == counts_req) ) 
        counter_q <= {N_cnt{1'b0}}; 
      else
        counter_q <= counter_q_next;
    //
    // 2. Next-state logic
    assign counter_q_next = counter_q + 1;
    //
    // 3. Registered output 'tick'  (width: one clock period)
    always @(posedge clock)
    if (reset) 
        tick <= 1'b0; 
      else
        begin
        tick <= (counter_q_next == counts_req) ? 1'b1 : 1'b0;
        toggle_duty50 <= counter_q_next[N_cnt-1];
        end








endmodule




























