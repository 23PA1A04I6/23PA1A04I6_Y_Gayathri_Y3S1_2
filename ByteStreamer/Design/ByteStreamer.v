// ByteStreamer.v : serial-to-parallel converter (8-bit)
module ByteStreamer(
  input clk,
  input shift_enable,
  input serial_in,
  output reg [7:0] parallel_out,
  output reg byte_ready
);
  reg [7:0] shift_reg;
  reg [3:0] count;

  always @(posedge clk) begin
    byte_ready <= 0;

    if(shift_enable) begin
      shift_reg <= {shift_reg[6:0], serial_in};
      count <= count + 1;

      if(count == 7) begin
        parallel_out <= {shift_reg[6:0], serial_in};
        byte_ready <= 1; // byte completed
        count <= 0;
      end
    end
  end
endmodule
