/*
An ALU has the opcodes shown in the table 2.1
ALU opcodes:
Opcode                      Encoding
Add: A+B                    2'b00
Sub: A-B                    2'b01
Bit-wise invert: A          2'b10
Reduction Or: B             2'b11


Write a testbench which performs the following tasks.
*/
  `timescale 1ns/1ps

  module test;
    

//a. Create an enumerated type of the opcodes: opcode_e
    typedef enum bit[1:0] {add,sub,invert, reduct} opcode_e;
    
    //b. Create a variable opcode of the type opcode_e
    opcode_e opcode;

  //Instantiate an ALU with 2 bit input opcode
    ALU alucheck(.opcode(opcode));

    
  initial begin    
//Loop thorugh all the values of variable opcode every 10 ns
    opcode = opcode.first;
    
    $display("OPcode = %d, %s",opcode,opcode.name());
    
    do 
      begin
      #10;
      opcode = opcode.next;
        $display("OPcode = %d, %s",opcode,opcode.name());
      end
    while(opcode != opcode.first);
    
    
        
  end
  endmodule

    
    // Simple ALU placeholder
module ALU(input logic [1:0] opcode);
  always@(opcode)
    begin
    case (opcode)
      2'b00: $display("ALU: Performing ADD");
      2'b01: $display("ALU: Performing SUB");
      2'b10: $display("ALU: Performing INVERT");
      2'b11: $display("ALU: Performing REDUCT");
      default: $display("ALU: Invalid opcode");
    endcase
    end

  endmodule
