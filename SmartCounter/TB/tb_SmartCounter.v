// tb_smart_counter.v
`timescale 1ns/1ps
module tb_SmartCounter;
  reg clk;
  reg arst_n;
  reg load;
  reg enable;
  reg [7:0] load_val;
  wire [7:0] q;

  SmartCounter dut (
    .clk(clk), .arst_n(arst_n), .load(load), .enable(enable),
    .load_val(load_val), .q(q)
  );

  initial begin
    $display("Time   arst_n load enable load_val q");
    $monitor("%4t   %b      %b    %b      %h      %h", $time, arst_n, load, enable, load_val, q);
  end

  // clock generator
  initial clk = 0;
  always #5 clk = ~clk; // 100 MHz -> 10ns period

  initial begin
    
    $dumpfile("smart_counter.vcd");      // waveform file name
    $dumpvars(0, tb_SmartCounter);       // dump everything in this module

    // initial reset
    arst_n = 0; load = 0; enable = 0; load_val = 8'hAA;
    #12; // while clock toggles
    arst_n = 1; // release reset

    // load a value
    #7; // align to edge
    load = 1; load_val = 8'h3C;
    #10; load = 0;

    // increment 5 times
    #5; enable = 1;
    #50; enable = 0;

    // load again while enable high
    #3; load = 1; load_val = 8'hFE;
    #10; load = 0;

    // show async reset while running
    #8; arst_n = 0; // assert async reset
    #3; arst_n = 1; // release reset

    // check increments after reset
    #5; enable = 1;
    #40; enable = 0;

    #20;
    $finish;
  end
endmodule

