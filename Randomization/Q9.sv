/*
Create a class StimData, containing an array of integer samples. Randomize the size and contents of the array, constraining the size to be between 1 and 1000. 
Test the constraint by generating 20 transactions and reporting the size 
*/
`define SV_RAND_CHECK(r) \
 do begin \
   if (!(r)) begin \
     $display("%s:%0d: Randomization failed \"%s\"",\
              `__FILE__,`__LINE__,`"r`"); \
     $finish; \
   end\
 end while (0)

class StimData;
  rand int array [];
  constraint arraylen{array.size() > 1;
                      array.size() < 1000;
                     };

  function void display();
    $display("Transaction size: %d", array.size());
  endfunction: display
  
endclass: StimData

module test;
  StimData stim1;
  initial begin
    stim1 = new();
    repeat(20) begin
      `SV_RAND_CHECK(stim1.randomize());
      stim1.display();
    end
  end
endmodule: test

/*
# Transaction size:         943
# Transaction size:         904
# Transaction size:          83
# Transaction size:         309
# Transaction size:         333
# Transaction size:         943
# Transaction size:         277
# Transaction size:         599
# Transaction size:          30
# Transaction size:         440
# Transaction size:         818
# Transaction size:         340
# Transaction size:         788
# Transaction size:         511
# Transaction size:         616
# Transaction size:         675
# Transaction size:         596
# Transaction size:         194
# Transaction size:         853
# Transaction size:         746
*/
