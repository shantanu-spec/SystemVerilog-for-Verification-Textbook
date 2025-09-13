/*Expand the solution to Exercise 4 to collect coverage on the test plan requirement,
“The opcode shall take on the values ADD or SUB when operand1 is maximum
negative or maximum positive value.” Weight the cross coverage by 5.
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
  
  covergroup opcg @(posedge clk);
    // Operand1 coverpoint
    operand1_cp: coverpoint tr.operand1 {
      bins maxneg = { -128 };
      bins zero   = { 0 };
      bins maxpos = { 127 };
      bins others = default; 
    }
    
    // Opcode coverpoint
    opcode_cp: coverpoint tr.opcode {
      bins add_or_sub   = { ADD, SUB };
      bins add_then_sub = (ADD => SUB);
    }

    // Example of illegal bin
    illeg_cp: coverpoint tr.opcode {
      illegal_bins nodiv = { DIV };
    }

    // Cross coverage for ADD/SUB with maxneg/maxpos values
    checkcross_cp: cross opcode_cp, operand1_cp {
      bins crisscross =
        binsof(opcode_cp) intersect { ADD, SUB } &&
        binsof(operand1_cp) intersect { -128, 127 };
      type_option.weight = 5;
    }
  endgroup
  
  opcg cg_main;
  
  initial begin
    cg_main = new();
    repeat (100) begin
      tr = new();
      if (!tr.randomize())
        $display("Randomization Error!");
      @(posedge clk);
      cg_main.sample();
    end
  end

  initial begin
    #500;
    $display ("Coverage(opcg) = %0.2f %%", cg_main.get_inst_coverage());
    $finish;
  end

endmodule
