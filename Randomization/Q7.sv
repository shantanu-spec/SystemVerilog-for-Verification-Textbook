/*
For the following class, create:
a. A constraint that limites the read transaction address to the range 0 to 7, inclusive;
b. Write behavioral code to turn off the above constraint. Construct and randomize a MemTrans object with an in-line constraint that limits rad transaction addresses to the range 0 to 8, inclusive. Test that the in-line constraint is working
*/

//Macro to check the randomization
`define SV_RAND_CHECK(r) \
 do begin \
   if (!(r)) begin \
     $display("%s:%0d: Randomization failed \"%s\"",\
              `__FILE__,`__LINE__,`"r`"); \
     $finish; \
   end\
 end while (0)


class MemTrans;
  rand bit rw;
  rand bit [7:0] data_in;
  rand bit [3:0] address;
  
  //Constraint to set the address range to 0 to 7 for read transaction
  constraint addresscheck{
    if(rw == 0)
    address inside {[0:7]};
      }
  
endclass: MemTrans
//Top module
module test;
  MemTrans mem1; //Handle to MemTrans clas
  initial begin
    mem1 = new();  //Initialize the object
    mem1.constraint_mode(0); //set off the constraint in the class MemTrans
   
    repeat(10)begin
      `SV_RAND_CHECK(mem1.randomize() with { if(rw == 0) mem1.address inside {[0:8]};});  //In line constraint to change the range to 0:8 for read transactions
      $display(mem1.rw,mem1.address);
    end
    
  end
endmodule : test

/*Results
  rw address 
# 1   0
# 0   4
# 1   2
# 1  10
# 0   3
# 0   8    -> one of the case where the original constraint is overriden by inline constraint
# 0   5
# 0   1
# 1  12
# 1  15

*/
