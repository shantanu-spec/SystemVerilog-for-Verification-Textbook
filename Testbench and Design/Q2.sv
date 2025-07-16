interface my_if(input bit clk);
  bit write;
  bit [15:0] data_in;
  bit [7:0] address;
  logic[15:0] data_out;

  //A clocking block that is sensitive to negative edge of the clk and all I/O that are synchronous to the clock

  clocking cb @(negedge clk);
    output write, data_in, address;
    input data_out;
  endclocking
  

  //A modport for the testbench called master
  modport master(clocking cb);
    
    //Modport for the DUT called slave
    modport slave(    input write,data_in, address, output data_out);

    

endinterface
