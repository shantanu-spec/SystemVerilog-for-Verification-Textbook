/*
Cteate a testbench that randomizes the Exercise 1000 times.
a. Count the number of times each address value occurs and print the results in a histogram. -> Values seen on Questa 0-> 10.4%, 1:14 -> 79.3%, 15 ->10.3%
b. Run the simulkation with 3 different random seeds,
Results:
On Synopysy VCS(2023.03):      to run: simv +ntb_random_seed=42 -> 9.1%,81%,9.9%

On Cadence Xcelium(23.09):     to run: -sv_seed=42              -> 10.5%,79.5%,10%

On Siemens Questa(2024.3):     to run: -sv_seed=42              -> 10.8%,83.9%,9.2%
*/
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
    repeat(1000) begin  	//Generate 1000 new data and address values 
    if(!ex2.randomize())
      $display("Randomization failed!");
    else
      $display( ex2.address);
    end
   
  end
endmodule:top_module
