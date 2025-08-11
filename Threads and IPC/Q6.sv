//Mailbox exercise
program automatic test;
  mailbox #(int) mbx;
  int value;
  
  initial begin
    mbx = new(1);
    $display("mbx.num() = %0d",mbx.num()); 				//->0[0]
    $display("mbx.try_get = %0d",mbx.try_get(value));	//->0[0]
    
    mbx.put(2);										    // [2]
    $display("mbx.try_put = %0d",mbx.try_put(value));   //->0 -not successful since mbx is full
    $display("mbx.num() = %0d",mbx.num());  			//->1 ->[2]
    mbx.peek(value);									// copies value [2]
    $display("value=%0d",value);						//2 is output
  end
  
endprogram: test
