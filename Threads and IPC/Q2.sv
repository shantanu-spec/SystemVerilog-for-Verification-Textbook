`timescale 1 ns/1 ps;

module test;
initial begin
  fork 
    transmit(1);
    transmit(2);
  join_none
  
  
  fork: receive_fork
    receive(1);
    receive(2);
  join_none
  
  //to check with and without wait fork
//   wait fork;
  #15 disable receive_fork;
  $display("%0t: Done",$time);
 
end

task transmit(int index);
  #10;
  $display("%0t: Transmit is done for index = %0d", $time, index);
endtask:transmit

task receive(int index);
  #(index * 10);
  $display("%0t: Receive is done for index = %0d",$time,index);
endtask:receive
endmodule
/*
Without wait fork there is no way to sync the two parallel task receive threads and test can finish even before all packets are received.
10000: Receive is done for index = 2
10000: Transmit is done for index = 2
10000: Transmit is done for index = 2
15000: Done
20000: Receive is done for index = 2

with Wait fork
10000: Receive is done for index = 2
10000: Transmit is done for index = 2
10000: Transmit is done for index = 2
20000: Receive is done for index = 2
35000: Done


*/
