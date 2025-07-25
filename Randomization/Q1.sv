/*
Weite a SV code for the following item:
a. Create a class Exercise1 containing two random variables, 8-bit data and 4-bit address. Create a constraint block that keeps address 3 to 4.
b. In an initial block, construct an Exercise1 object and randomize it. Check the status from randomization.
*/

class Exercise1;
  rand bit[7:0] data;
  rand bit[3:0] address;
  constraint addresscheck{ address>2;
                          address<5;};  //Keeps address to 3 and 4
endclass: Exercise1

module top_module;
  Exercise1 ex1;
  initial begin
  	
    ex1 = new();
    
    if(!ex1.randomize())
      $display("Randomization failed!");
    else
      $display("Data: %d, Address: %d ", ex1.data, ex1.address);
    
    if(!ex1.randomize())
      $display("Randomization failed!");
    else
      $display("Data: %d, Address: %d ", ex1.data, ex1.address);
  end
endmodule:top_module
