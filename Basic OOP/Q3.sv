/*
Create a custom constructor so that data_in and address are both initialized to 0 but can also be initialized through arguments passed into constructor. 
Do the following:
a. Create two new MemTrans objects.
b. Initialize address to 2 in the first object, passing argument by name.
c. Initialize data_in to 3 and address to 4 in the second object, passing arguments by name
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
    mem1 = new(.address(4'd2));
    mem1.print(); //Value of data in : 00, address: 2
    
    mem2 = new(.data_in(8'd3),.address(4'd4));
    mem2.print(); //Value of data in : 03, address: 4
    
  end
endmodule:top_module
