//Given Binary::copy function create ExtBinary copy
//From the solution to Exercise 6, use the copy function to ocopy the object pointed to by the extended class handle mc to the extended class handle mc2
class Binary;
  rand bit [3:0] val1, val2;
  
  function new(input bit [3:0] val1,val2);
		this.val1 = val1;
    	this.val2 = val2;
  endfunction: new
  
  virtual function void print_int(input int val);
    $display("val=0d%0d",val);
  endfunction: print_int
  
  virtual function Binary copy();
    copy = new(15,8);
    copy.val1 = val1;
  	copy.val2 = val2;
  endfunction: copy
  
endclass: Binary

class ExtBinary extends Binary;
  
  function new(input bit [3:0] val1,val2);
    super.new(val1,val2);
  endfunction: new
  
  virtual function int mult_val();
    return val1*val2;
  endfunction:mult_val
  
  virtual function ExtBinary copy();
  
  	copy = new(this.val1, this.val2); 
    super.copy();
    return copy;
  endfunction: copy
  
endclass: ExtBinary

class Exercise3 extends ExtBinary;
  
  function new(input bit [3:0] val1,val2);
    super.new(val1,val2);
  endfunction: new
  
  constraint val1set {val1 < 10;}
  constraint val2set {val2 < 10;}
endclass: Exercise3
