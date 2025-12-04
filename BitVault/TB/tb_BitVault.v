`timescale 1ns/1ps
module tb_BitVault;
  reg clk, we;
  reg [1:0] addr;
  reg [7:0] data_in;
  wire [7:0] data_out;

  BitVault dut(.clk(clk), .addr(addr), .data_in(data_in), .we(we), .data_out(data_out));

  initial begin
    $dumpfile("bitvault.vcd");
    $dumpvars(0, tb_BitVault);
  end

  initial begin clk = 0; forever #5 clk = ~clk; end

  initial begin
    $display("Time  we addr data_in data_out");

    // initial
    we = 0; addr = 0; data_in = 8'h00;

    // write to address 0
    #10; we = 1; data_in = 8'hAA; addr = 2'b00;

    // write to address 2
    #10; data_in = 8'h55; addr = 2'b10;

    // disable write & read back
    #10; we = 0; addr = 2'b00;

    #10; addr = 2'b10;

    // overwrite protection (we=0)
    #10; data_in = 8'hFF; addr = 2'b10;

    #20; $finish;
  end
endmodule
