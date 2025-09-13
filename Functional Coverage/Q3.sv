/*
Expand the solution to Exercise 2 to cover the following test plan requirements:
a. “The opcode shall take on the values ADD or SUB” (hint: this is 1 coverage
bin).
b. “The opcode shall take on the values ADD followed by SUB” (hint: this is a
second coverage bin).
Label the coverpoint opcode_cp
*/

typedef enum {ADD, SUB, MULT, DIV} opcode_e;


class Transaction;
  rand opcode_e opcode;
  rand byte operand1;
  rand byte operand2;
endclass: Transaction


module test;
  bit clk = 0;
  always #10 clk = ~clk;
  
  Transaction tr;
  
  covergroup opcg;
    operand1_cp: coverpoint tr.operand1{
      bins maxneg = {-128};
      bins zero = {0};
      bins maxpos = {127};
      bins others = default; 
    }
    
    opcode_cp: coverpoint tr.opcode{ //here
      bins add_or_sub  = {ADD,SUB};
      bins add_then_sub  = (ADD=>SUB);
    }
  endgroup
  
  covergroup cg @(posedge clk);
    coverpoint tr.opcode{
      bins add = {ADD};
      bins sub = {SUB};
      bins mult = {MULT};
      bins div = {DIV};
    }
  endgroup
  
  
  cg cg_alu;
  opcg cg_operand1;
  
  initial begin
    cg_alu = new();
    cg_operand1 = new();
    repeat(100)
      begin
        
        tr = new();
        
        if(!tr.randomize())
          $display("Randomization Error!");
        $display ("val= %d",tr.opcode);
        $display ("valop= %d",tr.operand1);
        cg_operand1.sample();
        @(posedge clk);
        
      end
  end

  initial begin
    #500;
    $display ("val= %d",tr.opcode);
    $display ("Coverage = %0.2f %%", cg_alu.get_inst_coverage());
    $display ("Coverageop = %0.2f %%", cg_operand1.get_inst_coverage());
    $finish;
  end

endmodule
