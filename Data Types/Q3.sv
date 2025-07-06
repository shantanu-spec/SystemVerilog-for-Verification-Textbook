
module top_module();

  bit [11:0] my_array[4];
  
initial begin
  my_array[0] =  12'h012;
  my_array[1] =  12'h345;
  my_array[2] =  12'h678;
  my_array[3] =  12'h9AB;

//   $display("%P",my_array);
  
  for(int i = 0;i<4;i++)
    begin
      $display("array %d:%h",i,my_array[i][5:4]);
    end
// end
  
  foreach(my_array[j])
    begin
      $display(" foreacharray %d:%h",j,my_array[j][5:4]);
    end
end
endmodule