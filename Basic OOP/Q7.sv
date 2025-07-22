/*
Complete the function print_all in class MemTrans to print out data_in and address using class PrintUtilities. Demonstrate using the function print_all
*/

module top_module;

class PrintUtilities;
  
  function void print_4 (input string name, input [3:0] val_4bits);
    $display("%t: %s = %h",$time, name, val_4bits);
  endfunction:print_4
  
  function void print_8 (input string name, input [7:0] val_8bits);
    $display("%t: %s = %h",$time, name, val_8bits);
  endfunction:print_8  
endclass : PrintUtilities

class MemTrans;
  bit[7:0] data_in;
  bit[3:0] address;
  PrintUtilities print;
  
  function new();
    print = new();
  endfunction:new
  
  function void print_all;
    print.print_4("Address", address);
    print.print_8("Data", data_in);
  endfunction: print_all
  
endclass: MemTrans

  
  initial begin
  MemTrans mem1;
    mem1 = new();
    mem1.address = 4'hf;
    mem1.data_in = 8'h21;
    
    mem1.print_all;
  end
endmodule: top_module

//#                    0: Address = f
//#                    0: Data = 21
