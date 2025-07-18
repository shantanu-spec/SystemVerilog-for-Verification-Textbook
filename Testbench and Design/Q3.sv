`timescale 1ns/1ps



interface my_if(input bit clk);
  bit write;
  bit [15:0] data_in;
  bit [7:0] address;
  logic[15:0] data_out;

  //A clocking block that is sensitive to negative edge of the clk and all I/O that are synchronous to the clock

  clocking cb @(negedge clk);
    output write, data_in, address;
    input data_out;
  endclocking
  

  //A modport for the testbench called master
  modport master(clocking cb);
    
    //Modport for the DUT called slave
    modport slave(    input clk, write,data_in, address, output data_out);

    

endinterface


module test;

  bit clk = 1'b1;
  initial forever #5 clk = ~clk; 
  my_if reg_bus(clk);

  initial begin
    $display("%t: Start Test: ",$time);
    reg_bus.cb.data_in <= 16'h0000; #7;
    reg_bus.cb.data_in <= 16'h0001; #17;
    reg_bus.cb.data_in <= 16'h0002; #17;
    reg_bus.cb.data_in <= 16'h0003; #17;
    $display("%t: End Test: ",$time);
    $finish;
  end

 

endmodule
