class Exercise2;
  rand bit[7:0] data;
  rand bit[3:0] address;
  constraint checkgen { 	data == 5;
                       address dist {0:/ 10, [1:14]:/80, 15:/ 10};
                      }	; //data always 5
//Probability of address ==0 is 10%
//Probability of address being between [1:14] is 80%
//Probability of address ==15 is 10%

endclass: Exercise2

module top_module;
  Exercise2 ex2;
  initial begin
  	
    ex2 = new();
    repeat(20) begin  	//Generate 20 new data and address values 
    if(!ex2.randomize())
      $display("Randomization failed!");
    else
      $display("Data: %d, Address: %d ", ex2.data, ex2.address);
    end
   
  end
endmodule:top_module
