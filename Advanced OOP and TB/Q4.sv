//Starting with the solution to Exercise 3, use the Exercise3 class to randomize val1 and val2 , and print out the multiplied value.
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

class Exercise3 extends ExtBinary;
  
  function new(input bit [3:0] val1,val2);
    super.new(val1,val2);
  endfunction: new
  
  constraint val1set {val1 < 10;}
  constraint val2set {val2 < 10;}
endclass: Exercise3



module ex3;
  Exercise3 ex3;
  initial begin
    
    ex3 = new(0,0);
    if(!ex3.randomize())
      $display("Randomization ERROR!");
    else
      ex3.print_int(ex3.val1);
      ex3.print_int(ex3.val2);
      ex3.print_int(ex3.mult_val());
    
  end
endmodule
