

`timescale 1ns/1ps
module tb();

  int new_address1, new_address2;
  bit clk;
  
 initial begin
   //For waveform
    $dumpfile("dump.vcd");
   $dumpvars(1, tb);
 fork
   my_task2(21,new_address1);
   my_task2(20,new_address2);  
 join
   $display("new_address1 = %0d",new_address1);
   $display("new_address2 = %0d",new_address2);
   //if not automatic task, output = 20, 20 (last value), if automatic -> 21,20
 end
  
  initial 
    repeat (10) #10 clk = !clk;
  
  
  // Q2.for automatic ->  task automatic my_task2(input int address, output int new_address);
  //Q3 below:
  task my_task2(input int address, output int new_address);
    @(clk);
    new_address = address;
  endtask
  
endmodule
