
//provided a bus master as VIP initiate AHB txns -dummy used
 
module dummy_slave(AHB_if.slave ahb);
  always_ff @(posedge ahb.HCLK) begin
    if (ahb.HTRANS == 2'b01 || ahb.HTRANS == 2'b11) begin // BUSY or SEQ -double safeguard along with assertions
      ahb.HRDATA <= ahb.HADDR[7:0] + ahb.HWDATA; // Dummy read response
    end
  end
endmodule

//dummy master vip
module bus_master_vip(AHB_if.master ahb);

  task automatic drive_txn(logic [20:0] addr, logic write, logic [1:0] trans, logic [7:0] wdata);
    ahb.cb.HADDR  <= addr;
    ahb.cb.HWRITE <= write;
    ahb.cb.HTRANS <= trans;
    ahb.cb.HWDATA <= wdata;
//     ##1; // wait one clock cycle
  endtask

endmodule
