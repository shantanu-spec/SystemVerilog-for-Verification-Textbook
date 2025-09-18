//Q1

//DUT
interface DUT_if(input bit clk);
  logic [7:0] b_data;
  logic [7:0] b_address;
endinterface: DUT_if

//Instruction - Transaction
class Instruction;
  bit [3:0] opcode;
  bit [7:0] operand; 
endclass: Instruction

//Mailbox
typedef mailbox#(Instruction) inst_mbox;

//Driver class
class Driver;
   	inst_mbox agt2drv;
  virtual DUT_if vif;
  
  //Declare a virtual interface for the DUT
  function new(input inst_mbox agt2drv, input virtual DUT_if vif);
    this.agt2drv = agt2drv;
    this.vif = vif;
  endfunction
  
    task run();
    Instruction instr;
    forever begin
      agt2drv.get(instr);          // get transaction
      $display("[Driver] Got opcode=%0d operand=%0d",
                instr.opcode, instr.operand);
      vif.b_data = instr.operand;    // drive DUT interface
      @(posedge vif.clk);
    end
  endtask
endclass: Driver

class Environment;
	Driver drv;
  inst_mbox agt2drv;
  virtual DUT_if vif;
  
  function new(input virtual DUT_if vif);
    this.vif = vif;
    agt2drv  = new();
 	drv = new(agt2drv,vif);
  endfunction
endclass:Environment


//Q2
program automatic test(DUT_if dut_vif);
// 	import my_package::*;
  Environment env;
  initial begin
    env = new(dut_vif);
  //Create object reference by env handle
    fork
      env.drv.run();
    join_none
  end
endprogram

module tb;
  bit clk = 0;
  always #5 clk = ~clk;   
  // Instantiate the interface
  DUT_if dut_if(clk);
  // Instantiate the program, pass the interface
  test t0(dut_if);

endmodule
