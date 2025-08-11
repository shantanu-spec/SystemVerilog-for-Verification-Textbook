`timescale 1 ns/1 ns

module test;

event e1, e2;

task trigger(event local_event, input time wait_time);
  #wait_time;
  ->local_event;

endtask:trigger

initial begin
fork
  trigger(e1,10);
  begin
    wait(e1.triggered());
    $display("%0t: e1 triggered", $time);
  end
	join
end

initial begin
  fork
    trigger(e2,20);
    begin
      wait(e2.triggered());
      $display("%0t: e2 triggered", $time);
    end
  join
  end
endmodule

//Output: #10: e2 triggered
//when e1 is triggered at 10 ns, it evaluates all the wait events and e2 is trigger is called
