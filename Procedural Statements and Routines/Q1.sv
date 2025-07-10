module testbench;

  //a. Create a 512 element integer array
  integer array[511:0];
  //b. Create a 9-bit address varaible to index into array
  typedef bit [8:0] index_t;
  index_t address;
  
  //Call a task, my_task( and pass the array and the address), takes two inouts array by reference and address
  task automatic my_task(ref index_t address, const ref integer array[511:0]);
  	//predecrement address
    --address;
    
    //call function print_int pass address and array 
      print_int(address,array);
  endtask

  //Create function that prints out simulation time and the value of the input, has no return value
  function automatic void print_int(index_t addr, const ref integer array[511:0]);
    $display("Time : %t\ value: %d",$time, array[addr]);
  endfunction
  
  initial begin
  //Initialize the last location in the array to 5
    array [511] = 5;
  
    
//     address = 512;
    //call the task
    my_task(address,array);
  end

  
  
endmodule
