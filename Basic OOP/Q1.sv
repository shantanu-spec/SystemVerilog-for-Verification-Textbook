//Create a class called MemTrans that contains the follwoing members, then construct an object in an initial block
/*
a. An 8-bit data_in of logic type
b. A 4-bit address of logic type
c. A void function called print that prints out the value of data_in and address
*/

module top_module;
	class MemTrans;
      logic [7:0] data_in;
      logic [3:0] address;
      
      function void print();
        $display("Value of data in : %h, address: %h", data_in,address);
      endfunction
      
	endclass:MemTrans
  
  
  initial begin
  MemTrans mem1;
    mem1 = new();
  end
endmodule:top_module
