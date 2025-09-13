/*Assuming that your covergroup is called Covcode and the instantiation name of
the covergroup is ck , expand Exercise 4 to:
a. Display the coverage of coverpoint operand1_cp referenced by the instantiation
name.
b. Display the coverage of coverpoint opcode_cp referenced by the covergroup
name.*/

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
  
  covergroup Covcode @(posedge clk);
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

    // Illegal bin example
    illeg_cp: coverpoint tr.opcode {
      illegal_bins nodiv = { DIV };
    }

    // Cross coverage for ADD/SUB with maxneg/maxpos
    checkcross_cp: cross opcode_cp, operand1_cp {
      bins crisscross =
        binsof(opcode_cp) intersect { ADD, SUB } &&
        binsof(operand1_cp) intersect { -128, 127 };
      type_option.weight = 5;
    }
  endgroup
  
  Covcode ck;
  
  initial begin
    ck = new();
    repeat (100) begin
      tr = new();
      if (!tr.randomize())
        $display("Randomization Error!");
      @(posedge clk);
      ck.sample();
    end
  end

  initial begin
    #500;
    // a. Coverage of operand1_cp via instantiation name (ck)
    $display("Coverage(operand1_cp via ck) = %0.2f %%", ck.operand1_cp.get_inst_coverage());

    // b. Coverage of opcode_cp via covergroup type (Covcode)
    $display("Coverage(opcode_cp via Covcode) = %0.2f %%", Covcode::opcode_cp.get_coverage());

    // Whole group instance coverage
    $display("Total Coverage (ck) = %0.2f %%", ck.get_inst_coverage());

    $finish;
  end

endmodule
