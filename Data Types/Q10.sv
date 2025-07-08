`timescale 1ps/1ps

module test;

  typedef bit [3:0] nibble;           //Create a user-defined type, nibble of 4bits
  
  real r;                             //Create a real variable r and initialize to 4.33
  
  shortint i_pack;                    //Create a shortint variable i_pack
  
  nibble k[3:0];                      // Create ann unpacked array k containing 4 elements of your user defined type nibble 
  
  
  
initial begin    
	  r = 4.33;                         // Initializing r value
  k = '{4'h0,4'hF,4'hE, 4'hD};        // Initializing value for k 
  
  $displayh("%p",k);                  // display out k
  
  //bit wise streaming
  
  i_pack = {>>{k}};
  
  $displayh("Bit wise streaming:%p",i_pack);
 
// Nibble wise streaming
  i_pack = {>>nibble_t{k}};
  
  $displayh("Nibble wise streaming:%p",i_pack);

  // Type convert real r into a nibble assign it to k[0] and print out k
  k[0] = nibble_t'(r);
  
  $displayh("Real type conversion:%p",k);
end
endmodule
