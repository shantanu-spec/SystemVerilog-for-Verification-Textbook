//Using code Sample 8.26 to Sample 8.28 in Section 8.7.1 and 8.7.2 of the text, add the ability to randomly delay a transaction between 0 and 100ns.

//Sample 8.26 Base callback class
virtual class Driver_cbs;
  virtual task pre_tx(ref Transaction tr, ref bit drop); //nothhing by def
  endtask
  
  virtual task post_tx(ref Transaction tr);// do nothing by def
  endtask

endclass: Driver_cbs

//Sample 8.27 Driver class with callbacks
class Driver;
  Driver_cbs cbs[$];
  
  task run();
    bit drop;
    Transaction tr;
    
    forever begin
    drop = 0;
      agt2drv.get(tr); //Agent to driver mbx
      foreach (cbs[i]) cbs[i].pre_tx(tx,drop);
      if(done) continue;
      transmit(tr);
      foreach (cbs[i]) cbs[i].post_tx(tx);
    end
  endtask: run
endclass: Driver

// TASK: add the ability to randomly delay a transaction between 0 and 100ns.
//Sample 8.28 Test using callback for error injection

class Driver_cbs_drop extends Driver_cbs;
  virtual task pre_tx(ref Transaction tr, ref bit drop);
   // Randomly drop 1 out  of every 100 transactions
    drop = ($urandom_range(0,99)==0);
  endtask
endclass

class Driver_cbs_delay extends Driver_cbs;
    virtual task pre_tx(ref Transaction tr, ref bit drop);
  		int delay_ns;
      delay_ns = $urandom_range(0,100);
      #(delay_ns * 1ns);
    endtask
endclass

program automatic test;
 Environment env;
  
  initial begin
    env = new();
    env.gen_cfg();
    env.build();
    
    begin
    	Driver_cbs_drop dcd = new();
    	Driver_cbs_delay dcl = new();
  		env.drv.cbs.push_back(dcd);
    	env.drv.cbs.push_back(dcl);
    end
    
    env.run();
    env.wrap_up();
  end
endprogram
