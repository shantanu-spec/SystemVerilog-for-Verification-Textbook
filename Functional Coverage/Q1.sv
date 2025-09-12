//For the class below, write a covergroup to collect coverage on the test plan requirement, “All ALU opcodes must be tested.” Assume the opcodes are valid on the positive edge of signal clk .
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
  
  covergroup cg @(posedge clk);
    coverpoint tr.opcode{
      bins add = {ADD};
      bins sub = {SUB};
      bins mult = {MULT};
      bins div = {DIV};
    }
  endgroup
  
  
  cg cg_alu;
  
  initial begin
    cg_alu = new();
    repeat(10)
      begin
        tr = new();
        if(!tr.randomize())
          $display("Randomization Error!");
        @(posedge clk);   /// Important
      end
  end

  initial begin
    #500 $display ("Coverage = %0.2f %%", cg_alu.get_inst_coverage());
    $finish;
  end

endmodule
