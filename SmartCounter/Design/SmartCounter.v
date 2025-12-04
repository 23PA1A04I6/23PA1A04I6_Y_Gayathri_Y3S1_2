// smart_counter.v
module SmartCounter (
    input  wire        clk,
    input  wire        arst_n,    // active-low async reset
    input  wire        load,      // synchronous load when high
    input  wire        enable,    // increment when high (on rising clock)
    input  wire [7:0]  load_val,
    output reg  [7:0]  q
);

always @(posedge clk or negedge arst_n) begin
    if (!arst_n)
        q <= 8'b0;
    else if (load)
        q <= load_val;
    else if (enable)
        q <= q + 1'b1;
end

endmodule
