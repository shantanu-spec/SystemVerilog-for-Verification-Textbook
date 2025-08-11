/*
Create a task wait10 that for 10 tries will wait for 10 ns and then check for 1 semphore key to be available- if found get out of the loop and print time
*/


`timescale 1ns/1ns


module test;
  semaphore sem;
  
  initial begin
    sem = new(1);

    #50; 
    sem.put(1);
    wait10(sem);
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

//# @60 ns: Key received!
