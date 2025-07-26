/*
Create a class for a graphics image that is 10x 10 pixels. The value for each pixel can be randomized to black or white.
Randomly generate an image that is, on average 20% white. Print the image and report the numbber of pixels of each type
*/


`define SV_RAND_CHECK(r) \
 do begin \
   if (!(r)) begin \
     $display("%s:%0d: Randomization failed \"%s\"",\
              `__FILE__,`__LINE__,`"r`"); \
     $finish; \
   end\
 end while (0)

class Graphics;

  static int countwhite, countblack = 0;
  rand bit[100] pixels ;
  
  constraint imagegen{foreach (pixels[i]) pixels[i] dist{1:/2,0:/8};};
  
  function void display();
    for(int i = 0;i<10;i++)
      begin
        for(int j = 0; j<10;j++)
          begin
            if(pixels[j]==0)
              begin
              countblack++;
              end
            else
              begin
              countwhite++;
              end
            $write("%b ",pixels[j]);
          	
          end
        $display;
      end
    
    $display("No of white pixels(1):%0d",countwhite);
    $display("No of black pixels(0):%0d",countblack);
  endfunction
  
  
  
endclass: Graphics


module test;
  Graphics graph1;
  initial begin
    graph1 = new();
    
    `SV_RAND_CHECK(graph1.randomize());
    graph1.display();
    end
    

endmodule : test

/*
# 1 0 0 0 1 0 0 0 0 1 
# 1 0 0 0 1 0 0 0 0 1 
# 1 0 0 0 1 0 0 0 0 1 
# 1 0 0 0 1 0 0 0 0 1 
# 1 0 0 0 1 0 0 0 0 1 
# 1 0 0 0 1 0 0 0 0 1 
# 1 0 0 0 1 0 0 0 0 1 
# 1 0 0 0 1 0 0 0 0 1 
# 1 0 0 0 1 0 0 0 0 1 
# 1 0 0 0 1 0 0 0 0 1 
# No of white pixels(1):30
# No of black pixels(0):70
*/
