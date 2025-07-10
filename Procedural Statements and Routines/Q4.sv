/*
Create the SystemVerilog  code to specify that the time should be printed in ps(picoseconds), display 2 digits to the right of the deicmal point and use as few characters as possible
*/

`timescale 1ns/1ps

module testbench();

  initial begin

    $timeformat(-12,2,"ps",9);
    
    #5.33ns $display("%t",$realtime);
  end
  //output: 5330.00ps
  
endmodule
