/* Using the Q4.sv, create a static variable last_variable that holds the initial value of the address variable form the most recently created object, as set in the constructor. 
After callocating objects of class MemTrans, print out the current value of last_address.
 
*/

module top_module;
	class MemTrans;
      logic [7:0] data_in;
      logic [3:0] address;
      //static variable
    static logic[3:0] last_address = 4'b0;//initialize the static variable
      
      function new(input logic [7:0] data_in = 8'b0, input logic [3:0] address = 4'b0);
        this.data_in = data_in;
        this.address = address;
        last_address = address;  // update static variable
      endfunction
       

      
      function void print();
        $display("Value of data in : %h, address: %h ", data_in,address);
      endfunction
      
	endclass:MemTrans
  
  
  initial begin
  MemTrans mem1,mem2;
    mem1 = new(.address(4'hF));
    mem1.print();  ///Value of data in : 00, address: f 
    
    $display("last address:%h",mem1.last_address); // last address:f
    
    mem2 = new(.data_in(8'd3),.address(4'h4)); 
    mem2.print(); //Value of data in : 03, address: 4 

    $display("last address:%h",mem2.last_address); //last address:4
    mem2 = null;//deallocate
    
    $display("last address:%h",mem1.last_address); //even if mem2 is deallocated, this gives last address:4 (any obj can access the static variable since its global scope in class)


  end
endmodule:top_module
