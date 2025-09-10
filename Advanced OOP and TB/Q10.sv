/*9. Create a class that can compare any data type using the case equality operators,
=== and !== . It contains a compare function that returns a 1 if the two values
match, 0 otherwise. By default it compares two 4-bit data types.
10. Using the solution from Exercise 9, use the comparator class to compare two
4-bit values, expected_4bit and actual_4bit . Next, compare two values
of type color_t, expected_color and actual_color . Increment an error
counter if an error occurs.
*/


typedef enum logic [1:0] {RED, GREEN, BLUE} color_t;

class DataComp#(type T = logic[3:0]);
  // static generic function
  function bit compare (T a, T b);
    return (a === b) ? 1'b1 : 1'b0;
  endfunction
endclass


module test;
  int count = 0;
  logic [3:0] expected_4bit = 4'b1010, actual_4bit = 4'b1011;
  
  color_t expected_color = RED, actual_color = BLUE;
  	DataComp #(logic[3:0]) comp_4bit;
	DataComp #(color_t) comp_color;

  initial begin
    // Comparator for 4-bit values
  		comp_4bit = new();
    if (!comp_4bit.compare(expected_4bit, actual_4bit))
      count++;

    // Comparator for color_t
     comp_color = new();
    if (!comp_color.compare(expected_color, actual_color))
      count++;

    $display("Total mismatches: %0d", count);
  end
endmodule
