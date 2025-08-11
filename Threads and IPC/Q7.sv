// Transaction class to hold DUT output samples
class OutputTrans;
  bit [7:0] out1;
  bit [7:0] out2;

  function void display();
    $display("[%0t] OutputTrans: out1=%0h out2=%0h", $time, out1, out2);
  endfunction
endclass


interface my_bus(input bit clk);
  logic [7:0] out1,out2;
  
  clocking cb@(posedge clk);
  input out1 ,out2;
  endclocking

endinterface



class Monitor;
  OutputTrans out;
  virtual my_bus vif;
    
  mailbox #(OutputTrans) mbx;
  
  function new( virtual my_bus vif,   mailbox #(OutputTrans) mbx);
    this.vif = vif;
    this.mbx = mbx;
  endfunction
  
  task run();
	forever begin
      @(vif.cb);
      out = new();
      out.out1 = vif.out1;
      out.out2 = vif.out2;
      mbx.put(out);
      out.display();
    end
  endtask
  
endclass: Monitor

module tb;
  bit clk;
  my_bus bus(clk);

  mailbox #(OutputTrans) mbox = new();
  Monitor mon;

  // Simple DUT example
  // Replace with your actual DUT
  initial begin
    bus.out1 = 8'h00;
    bus.out2 = 8'hFF;
    forever #5 clk = ~clk;
  end

  // Drive outputs for demonstration
  initial begin
    repeat (10) begin
      @(posedge clk);
      bus.out1 <= $random;
      bus.out2 <= $random;
    end
  end

  // Create and run monitor
  initial begin
    mon = new(bus, mbox);
    fork
      mon.run();
    join_none
  end

  // Example consumer: Read from mailbox
  initial begin
    OutputTrans t;
    forever begin
      mbox.get(t);
      // Processing...
    end
  end
endmodule
