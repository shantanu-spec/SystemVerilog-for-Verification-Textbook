//we are testing a slave design 
//test done using program automatic and the correct modport with clocking block - could also be done by normal modules but programs run at reactive region
program automatic test(AHB_if.TB ahb);

  initial begin
    $display("Starting AHB test...");
       
//     // LEGAL transactions (should not trigger assertion)
 #5 ahb.cb.HTRANS <= 2'b01;  // BUSY
    #5 ahb.cb.HTRANS <= 2'b11;  // SEQ  

    // ILLEGAL transactions (should trigger assertion)
    #5 ahb.cb.HTRANS <= 2'b00;  // IDLE
    #5 ahb.cb.HTRANS <= 2'b10;  // NONSEQ
    $display("End AHB test...");
    #20 $finish;
  end
      endprogram
