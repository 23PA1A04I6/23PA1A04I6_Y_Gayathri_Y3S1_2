`timescale 1ns/1ps
module tb_ByteStreamer;
  reg clk, shift_enable, serial_in;
  wire [7:0] parallel_out;
  wire byte_ready;

  ByteStreamer dut(.clk(clk), .shift_enable(shift_enable),
                   .serial_in(serial_in), .parallel_out(parallel_out), .byte_ready(byte_ready));

  initial begin
    $dumpfile("bytestreamer.vcd");
    $dumpvars(0, tb_ByteStreamer);
  end

  initial begin clk = 0; forever #5 clk = ~clk; end

  task send_byte(input [7:0] data);
    integer i;
    begin
      for(i=7;i>=0;i=i-1) begin
        serial_in = data[i];
        shift_enable = 1;
        #10;
      end
      shift_enable = 0;
      #10;
    end
  endtask

  initial begin
    serial_in = 0; shift_enable = 0;

    #10; send_byte(8'hA5);
    #20; send_byte(8'h3C);

    #50; $finish;
  end
endmodule
