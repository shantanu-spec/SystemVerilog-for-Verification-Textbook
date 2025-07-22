

package automatic my_package;
class Statistics;
  time startT;
  function Statistics copy();
    copy = new();
    copy.startT = startT;
  endfunction
endclass
class MemTrans;
  bit[7:0] data_in;
  bit[3:0] address;
  Statistics stats;
  
  function new();
   data_in = 3;
   address = 5;
    stats = new();
  endfunction:new
//deep copy function  
  function MemTrans copy();
    copy = new ();
    copy.data_in = data_in;
    copy.address = address;
    copy.stats = stats.copy();
  endfunction:copy
endclass: MemTrans
endpackage

module top_module;
  import my_package::*;
  MemTrans src,dst;
  initial begin
  src = new();
    src.stats.startT = 42;
    $display(src.data_in,src.address,src.stats.startT);
    dst = src.copy();
    
    $display(dst.data_in,dst.address,dst.stats.startT);
    dst.stats.startT = 96;
         $display(dst.data_in,dst.address,dst.stats.startT);
  end
endmodule
