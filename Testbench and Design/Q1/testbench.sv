
    `timescale 1ns/1ps

//TB instantiates interface,slave and master
	`include "interface.v"
	`include "test.sv"
	`include "masterslave.sv"

//TB instantiates interface,slave and master


module tb_top;

  bit clk = 0;
  always #5 clk = ~clk;  

  // Instantiate interface
  AHB_if ahb(clk);

  // Instantiate DUT and master VIP
  dummy_slave       u_slave(.ahb(ahb));
  bus_master_vip    u_master(.ahb(ahb));

  // Run test program
  test u_test(ahb);

endmodule
