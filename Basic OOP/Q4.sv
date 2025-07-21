/*
Modify the Q3.sv solution to the following things:
a. After onstuction, set the address of the first object to 4'hf
b. use print function to print out the values of the data_in and address for the two objects
c. Explicitly deallocate the 2nd object
*/


module top_module;
	class MemTrans;
      logic [7:0] data_in;
      logic [3:0] address;
      
      function new(input logic [7:0] data_in = 8'b0, input logic [3:0] address = 4'b0);
        this.data_in = data_in;
        this.address = address;
        
      endfunction
      
      function void print();
        $display("Value of data in : %h, address: %h", data_in,address);
      endfunction
      
	endclass:MemTrans
  
  
  initial begin
  MemTrans mem1,mem2;
    mem1 = new(.address(4'hF));
    mem1.print();
    
    mem2 = new(.data_in(8'd3),.address(4'd4));
    mem2.print();
    mem2 = null;// Explicitly deallocate the 2nd object, if try to print mem2, will cause fatal error- bad handle

  end
endmodule:top_module
