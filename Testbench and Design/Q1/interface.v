//interface for ARM  Advanced High Performance Bus (AHB)

interface AHB_if(input bit clk);
  bit HCLK;				        //Clock
  logic [20:0] HADDR;	    //Address 21 width
  bit HWRITE;			        //Write flag: 1= write, 0 = read 	
  logic[1:0] HTRANS;		//Txn Type: 00= IDLE; 10 = NONSEQ
  logic[7:0] HWDATA;		//Write Data
  logic[7:0] HRDATA;		//Read Datat
  


  assign HCLK = clk; //connect clk to HCLK
//CLocking block
  clocking cb @(posedge HCLK);
    output HADDR;
    output HWRITE;
    output HTRANS;
    output HWDATA;
    input  HRDATA;
  endclocking
  
  
//interface will display an error if type is not IDLE or NONSEQ on negedge of HCLK
  property idlenonseq;
    @(negedge HCLK) (HTRANS == 2'b01 || HTRANS == 2'b11);  //this is an acceptable txn
  endproperty
  
  assert_states: assert property (idlenonseq) //allow the acceptable txns
    else $error("HTRANS is of type: %b on negedge of HCLK:%0t", HTRANS, $time); //else this error
  
    
      // Modport for master (writes to interface)
  modport master (
    clocking cb,
    output HADDR, HWRITE, HTRANS, HWDATA,
    input  HRDATA
  );

  // Modport for slave (reads inputs, drives output)
  modport slave (
    input  HCLK, HADDR, HWRITE, HTRANS, HWDATA,
    output HRDATA
  );
      //Modport for the testbench - cb has same direction as the testbench
      modport TB(clocking cb);
      
  // Modport for monitor (observes all)
  modport monitor (
    input HCLK, HADDR, HWRITE, HTRANS, HWDATA, HRDATA
  );
endinterface

