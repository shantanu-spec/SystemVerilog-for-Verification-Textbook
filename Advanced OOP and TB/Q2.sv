//Starting with the solution to Exercise 1, use the ExtBinary class to initialize val1=15, val2=8 , and print out the multiplied value.
class Binary;
  rand bit [3:0] val1, val2;
  
  function new(input bit [3:0] val1,val2);
		this.val1 = val1;
    	this.val2 = val2;
  endfunction: new
  
  virtual function void print_int(input int val);
    $display("val=0d%0d",val);
  endfunction: print_int
  
endclass: Binary

class ExtBinary extends Binary;
  
  function new(input bit [3:0] val1,val2);
    super.new(val1,val2);
  endfunction: new
  
  function int mult_val();
    return val1*val2;
	
  endfunction
endclass: ExtBinary

module ex2;
  initial begin
  ExtBinary extb;
    extb = new(15,8);
    $display("Multiplied value is = %0d",extb.mult_val());
  
  end
endmodule
