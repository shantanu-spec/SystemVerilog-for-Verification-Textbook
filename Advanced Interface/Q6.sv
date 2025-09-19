//Q6-Modify the following interface to use a parameter, ADDRESS_WIDTH . By default the addressing space supports 256 words.

//DUT
interface DUT_if #(ADDRESS_WIDTH = 256)(input bit clk);
  bit rst;
  bit [7:0] data_out;
  
  
  logic [ADDRESS_WIDTH-1:0] address;
  logic [7:0] data_in;
  logic write;
  modport DUT(input clk, data_out, output address, data_in, write);
endinterface: DUT_if

//Instruction - Transaction
class Instruction;
  bit [3:0] opcode;
  bit [7:0] operand; 
endclass: Instruction

//Mailbox
typedef mailbox#(Instruction) inst_mbox;
typedef virtual DUT_if vx_if;

//Driver class
class Driver;
   	inst_mbox agt2drv;
  	vx_if vif;
  
  //Declare a virtual interface for the DUT
  function new(input inst_mbox agt2drv, input vx_if vif);
    this.agt2drv = agt2drv;
    this.vif = vif;
  endfunction
  
    task run();
    Instruction instr;
    forever begin
      agt2drv.get(instr);          // get transaction
      $display("[Driver] Got opcode=%0d operand=%0d",
                instr.opcode, instr.operand);
      vif.data_in = instr.operand;    // drive DUT interface
      @(posedge vif.clk);
    end
  endtask
endclass: Driver

class Environment;
	Driver drv;
  inst_mbox agt2drv;
 	vx_if vif;
  
  function new(input vx_if vif);
    this.vif = vif;
    agt2drv  = new();
 	drv = new(agt2drv,vif);
  endfunction
endclass:Environment


//Q3- Change to cross module reference 
program automatic test;
// 	import my_package::*;
  Environment env[];//dynamic queue
   initial begin
     for (int i = 0; i < top.NUM_RISC_BUS;i ++)begin
       env[i] = new(top.dut_if[i]);     
       //      Create object reference by env handle
    fork
      
      env[i].drv.run();
    join_none
     end
  end
endprogram

module top;
  parameter int NUM_RISC_BUS = 5;
  bit clk = 0;
  always #5 clk = ~clk;   // clock generator

  // Instantiate the interface
  DUT_if dut_if[NUM_RISC_BUS](clk);

  // Instantiate the program, pass the interface
  test t0();

endmodule
