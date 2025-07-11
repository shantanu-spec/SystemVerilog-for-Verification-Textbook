/*
_____________                    _______________
|            |__________________|               |
| Testbench |_____Interface______ | Arbiter     |
|            |        ^         |               |
|____________|        clk       |_______________|
*/
module top_module();
bit clk;
   always #50 clk = ~clk;

  arb_if arbif(clk);
  arb_with_ifc a1(arbif);
  test_with_ifc t1(arbif);
  
endmodule

//Interface for arbiter
interface arb_if(input bit clk);
  logic[1:0] request,grant;
  bit rst;
endinterface



//Arbiter using interface
module arb_with_ifc (arb_if arbif);

  always@(posedge arbif.clk or posedge arbif.rst)
    begin
      if(arbif.rst)
        arbif.grant  <= 2'b00;
      else if (arbif.request[0])
        arbif.grant <= 2'b01;
      else if(arbif.request[1])
        arbif.grant <= 2'b10;
      else 
        arbif.grant <= '0;
    
    end
endmodule


//Testbench module using interface

module test_with_ifc (arb_if arbif);

	initial begin
      @(posedge arbif.clk);
      arbif.request<= 2'b01;
      $display("@%0t:  Drove req = 01",$time);
      repeat (2) @(posedge arbif.clk);
      if(arbif.grant == 2'b01)
          $display("@%0t: Success: grant == 2'b01",$time);
      else
        $display("@%0t: Error: grant != 2'b01",$time);
$finish;        
	end
endmodule
/*
# run 500ns
# @50:  Drove req = 01
# @250: Success: grant == 2'b01
# ** Note: $finish    : testbench.sv(51)
*/
