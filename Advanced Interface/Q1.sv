//Q1 -complete the driver and environment

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
