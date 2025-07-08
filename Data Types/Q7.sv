/*
Q7: Create memory using an associative array for a processor with a word width of 24 bits and an address space of 2**20 words. Assume the PC starts at address 0 at reset. Profram space starts at 0x400. The ISR is at the maximum address.
Fu=ill the memory with the following instructions:
* 24'hA50400 at location 0x400 for the main code
* 24'h123456; instr 1  located at location 0x400
* 24'h789ABC; instr 2 located at location 0x401
* 24'h0F1E2D; ISR 
and then print the values


*/
`timescale 1ps/1ps

module test;

 
  logic [23:0] memory [logic[19:0]];
  initial begin
	
    memory[20'h00000] = 24'hA50400;
    memory[20'h00400] = 24'h123456; // Instr 1 at 
    memory[20'h00401] = 24'h789ABC; // Instr 2
    memory[20'hFFFFF] = 24'h0F1E2D;
    
    $displayh("%p",memory);
  end
endmodule
