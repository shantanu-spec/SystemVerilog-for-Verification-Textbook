/*
Define a user defined 7 bit type and encapsulate the fields of the following packet in a structure using your new type. Lastly, assign the header to 7'h5A

|<-27  header 21->| <-20  cmd 14->|<-13 data 7->|<-6  crc 0->|    
*/

`timescale 1ps/1ps

parameter crc = 0, data = 1, cmd = 2, header = 3;

module test;
  
  bit [3:0] [6:0] fields;


initial begin    
  fields[header] = 7'h5A;
  $displayh("%p",fields);
    
  end
endmodule
