package my_package;

  class Transaction;
    bit [31:0] addr, csm;
    bit [31:0] data[8];
  endclass

endpackage : my_package




program automatic test;
  import my_package::*;  // define class Transaction
  
  // Declare an array of 5 transaction handles
  Transaction trans_array[5];

  
  initial begin
    generator();  // Call the generator task
  end

  // Task to create objects and transmit them
  task generator();
    foreach (trans_array[i]) begin
      trans_array[i] = new();  // create a new Transaction object
      transmit(trans_array[i]);  // transmit the object
    end
  endtask

  // Transmit task: displays or processes the transaction
  task transmit(Transaction tr);
    $display("Transmitting transaction: %p", tr);
  endtask: transmit

endprogram: test
