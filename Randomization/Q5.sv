class Stim;
  const bit[31:0] CONGEST_ADDR =42;
  typedef enum{READ,WRITE,CONTROL} stim_e;
  randc stim_e kind; //Enum var
  rand bit [31:0] len,src,dst;
  rand bit congestion_test;

  constraint c_stim{
    len<1000;
    len>0;			//Length len should be between 0 to 1000
    if(congestion_test){ // If the random test is 1
      dst inside {[CONGEST_ADDR-10:CONGEST_ADDR+10]}; //destination should be between 32 and 52
      src == CONGEST_ADDR;  //source should be 42
    }
      else   // if it is not test , then src can be in these values and dst be random 32 bit values
        src inside {0, [2:10], [100:107]};
  }
endclass:Stim

module test;
  Stim stim1;
  initial begin
  stim1 = new;
  if(!stim1.randomize())
    $display("Randomization failed");
    else
      $display("Length:%d, SRC:%d, DST:%d, TEST?= %d",stim1.len,stim1.src,stim1.dst,stim1.congestion_test);
      if(!stim1.randomize())
    $display("Randomization failed");
    else
      $display("Length:%d, SRC:%d, DST:%d, TEST?= %d",stim1.len,stim1.src,stim1.dst,stim1.congestion_test);
  end
endmodule


//Results to check:
//# Length:       358, SRC:         7, DST:4051028113, TEST?= 0
//# Length:       657, SRC:        42, DST:        46, TEST?= 1
