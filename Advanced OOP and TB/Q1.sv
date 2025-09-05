//Given the following class, create a method in an extended class ExtBinary that multiplies val1 and val2 and returns an integer.

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
