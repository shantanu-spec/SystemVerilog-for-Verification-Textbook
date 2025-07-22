/*
Crate a static method called print_last_address that prints out the value of the static variable last_address. 
After allocating objects of class MemTrans, Call the method print_last_address to print out the value of last_address.
*/



module top_module;
	class MemTrans;
      logic [7:0] data_in;
      logic [3:0] address;
      //static variable
      static logic[3:0] last_address = 4'b0;
      
      function new(input logic [7:0] data_in = 8'b0, input logic [3:0] address = 4'b0);
        this.data_in = data_in;
        this.address = address;
        last_address = address;  // update static variable
      endfunction
    
      //Static method to method to print last_address
    // since not returning any value set this to void function or while calling this function- static void cast it
      static function void print_last_address;
        $display("Last set address value: %h", last_address);
      endfunction

      
      function void print;
        $display("Value of data in : %h, address: %h ", data_in,address);
      endfunction
      
	endclass:MemTrans
  
  
  initial begin
  MemTrans mem1,mem2;
    mem1 = new(.address(4'hF));
    mem1.print();
    
    MemTrans::print_last_address(); //Scope resolultion for accessing static methods
    
    mem2 = new(.data_in(8'd3),.address(4'h4));
    mem2.print();
	
    MemTrans::print_last_address();
    
    mem2 = null;//deallocate
    
    MemTrans::print_last_address();

  end
endmodule:top_module

//# Value of data in : 00, address: f 
//# Last set address value: f
//# Value of data in : 03, address: 4 
//# Last set address value: 4
//# Last set address value: 4
