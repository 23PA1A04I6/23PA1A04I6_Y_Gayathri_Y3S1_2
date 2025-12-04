// BitVault.v : 4x8 register file with write enable and 2-bit address
module BitVault (
  input clk,
  input [1:0] addr,      // address for read/write
  input [7:0] data_in,   // data to write
  input we,              // write enable
  output [7:0] data_out  // data read at addr
);
  reg [7:0] mem[3:0];

  // write operation
  always @(posedge clk) begin
    if(we)
      mem[addr] <= data_in;
  end

  // continuous read
  assign data_out = mem[addr];
endmodule
