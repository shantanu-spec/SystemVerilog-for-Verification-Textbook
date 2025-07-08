
`timescale 1ps/1ps

module test;
byte value[$] = {2, -1, 127};
 int w;
  int tq[$];
  byte tq1[$];
  initial begin

    
//     foreach(value[i])
//     $display(value[i]);
  
  //Print out the sum of queue in decimal radix
    w = 0;
    foreach (value[i]) 
      w += value[i];

      $display("Sum = %0d", w);
  
   // Print out the min and max values in queue %p because it is an unpacked array when using min and max method
    
    $display("Min = %p", value.min());
    $display("Max = %p", value.max());
    
    //Sort the queue
 value.sort();
    
    foreach(value[i])
      $display("Sorted queue:%d",value[i]);
    
    
    
   // Print out the index of any negative values in queue
    tq = value.find_index with (item<0);
    $display("Indexes less than 0: %p", tq);
    
    //Print out the positive values in the queue
    
    tq1 = value.find with (item>0);
    $display("Positive Items: %p", tq1);
    
    //Reverse sort 
     value.rsort();
    
    foreach(value[i])
      $display("Reverse Sorted queue:%d",value[i]);
    
    
    
  end
endmodule
