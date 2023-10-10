module counter #(
    parameter N_cnt = 64 ) (
    //
    input                   clock, 
    input                   reset,
    input                   inc,
    output reg  [N_cnt-1:0] counter_q
);


//-----------------------------------------------------------------------------
// Declarations 


    wire    [N_cnt-1:0]     counter_q_next;


//-----------------------------------------------------------------------------
// Main body 


    always @(posedge clock)
    begin
    if (reset) 
        counter_q <= {N_cnt{1'b0}}; 
      else
        if (inc)
            counter_q <= counter_q_next;
        else
            counter_q <= counter_q;
    end
    //
    assign counter_q_next = counter_q + 1;













endmodule


