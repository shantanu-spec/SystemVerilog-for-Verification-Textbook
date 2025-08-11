//What would happen with the following initial begin code that calls wait10 task

`timescale 1ns/1ns


module test;
  semaphore sem;

  initial begin
	fork 
  		begin 
          sem = new(1);
          sem.get(1);
          #45;
          sem.put(2);
        end 
      wait10(sem);
	join
  end
endmodule: test


task wait10(input semaphore sem1);
  
  repeat(10) begin
  #10;
    sem1.get(1);
    break;    
  end
  $display("@%0t ns: Key received!",$time);
endtask :wait10
// @45ns: Key received!
