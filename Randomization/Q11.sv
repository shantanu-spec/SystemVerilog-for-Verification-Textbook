/*
Expand the RandTransaction class below so back-to-back transactions of the same type do not have same address. Test the constraint by generating 20 transactions
*/


`define SV_RAND_CHECK(r) \
 do begin \
   if (!(r)) begin \
     $display("%s:%0d: Randomization failed \"%s\"",\
              `__FILE__,`__LINE__,`"r`"); \
     $finish; \
   end\
 end while (0)

`define TESTS 20


package my_package;
typedef enum {READ, WRITE} rw_e;

class Transaction;
rand rw_e rw;
  rand bit [31:0] addr, data;
  
     function void display();
      $display("rw = %s, addr = %0d, data = %0d",
               (rw == READ) ? "READ" : "WRITE", addr, data);
    endfunction
endclass



class RandomTransaction;
  rand Transaction trans_array[];
  
  constraint rw_c {foreach (trans_array[i])
    if((i>0) && (trans_array[i-1].rw  == trans_array[i-1].rw))
     trans_array[i].addr != trans_array[i-1].addr;}
  
  function new();
    trans_array = new[`TESTS];
    foreach (trans_array[i])
      trans_array[i] = new();
  endfunction
  
endclass
endpackage

module testbench;
  import my_package::*;
  
  RandomTransaction rt;

  initial begin
    rt = new();

    `SV_RAND_CHECK (rt.randomize()) ;

    foreach (rt.trans_array[i]) begin
      $display("[%0d] ", i);
      rt.trans_array[i].display();
    end
  end

endmodule


/*RESULTS
# [0] 
# rw =  READ, addr = 1984262286, data = 2498148953
# [1] 
# rw = WRITE, addr = 2779276140, data = 569059684
# [2] 
# rw = WRITE, addr = 215210916, data = 3418634919
# [3] 
# rw = WRITE, addr = 3121990685, data = 2610559451
# [4] 
# rw =  READ, addr = 858836087, data = 3049853722
# [5] 
# rw =  READ, addr = 1638076667, data = 1497410535
# [6] 
# rw = WRITE, addr = 3088877556, data = 1205577538
# [7] 
# rw =  READ, addr = 2214826659, data = 610770012
# [8] 
# rw =  READ, addr = 904054228, data = 798201675
# [9] 
# rw = WRITE, addr = 805759848, data = 2959391950
# [10] 
# rw = WRITE, addr = 2102096763, data = 2270222167
# [11] 
# rw =  READ, addr = 4128881338, data = 1925750012
# [12] 
# rw =  READ, addr = 3151267704, data = 149515756
# [13] 
# rw = WRITE, addr = 3920927476, data = 4288604333
# [14] 
# rw =  READ, addr = 3428387989, data = 3692465966
# [15] 
# rw =  READ, addr = 2968069159, data = 2957883458
# [16] 
# rw = WRITE, addr = 3371273587, data = 2725755219
# [17] 
# rw =  READ, addr = 862266031, data = 3466967659
# [18] 
# rw =  READ, addr = 1412374185, data = 2755791827
# [19] 
# rw =  READ, addr = 3513586932, data = 4054847789
*/
