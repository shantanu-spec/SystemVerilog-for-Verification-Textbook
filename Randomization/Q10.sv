/*
Expand Transaxtion class below so back-to-back transactions of the same type do not havw the same address. Test the constraint by generating 20 transactions.
*/

`define SV_RAND_CHECK(r) \
 do begin \
   if (!(r)) begin \
     $display("%s:%0d: Randomization failed \"%s\"",\
              `__FILE__,`__LINE__,`"r`"); \
     $finish; \
   end\
 end while (0)

package my_package;

typedef enum {READ,WRITE} rw_e;

class Transaction;
  rw_e old_rw;
  rand rw_e rw;
  rand bit [31:0] addr,data;
  bit [31:0] old_addr;  //create a non-random address space to store generated address
  constraint rw_c{if (old_rw == WRITE) rw != WRITE;};
  constraint address_c { addr  != old_addr; }; //new addr should not be same as the just generate prev addr value
  
  function void post_randomize;
    old_rw = rw;
  	old_addr = addr;	//store generated address after randomization
  endfunction
  
  function void print_all;
    $display("addr = %d, data = %d, rw = %s",addr,data,rw);
  endfunction
endclass: Transaction

endpackage: my_package

module test;
  import my_package::*;
Transaction trans1;
  initial begin
    trans1 = new();
    repeat(20) begin
    `SV_RAND_CHECK(trans1.randomize());
    trans1.print_all();
    end
  end
endmodule: test
