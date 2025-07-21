// Using the MemTrans class from Exercise 1, create a custom constructor, the new function, so that data_in and address are both initialized to 0

module top_module;
	class MemTrans;
      logic [7:0] data_in;
      logic [3:0] address;
      
      function new();
        data_in = 8'b0;
        address = 4'b0;
        
      endfunction
      
      function void print();
        $display("Value of data in : %h, address: %h", data_in,address);
      endfunction
      
	endclass:MemTrans
  
  
  initial begin
  MemTrans mem1;
    mem1 = new();
    // mem1.print();
  end
endmodule:top_module
