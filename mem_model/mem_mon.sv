class mem_mon extends uvm_monitor;
  virtual intf vif;
  uvm_analysis_port #(mem_txn) ap_port;
  mem_txn txn;

  `uvm_component_utils(mem_mon)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this,"","pif",vif))
      `uvm_fatal("NO_VIF","mem_mon")
    ap_port = new("ap_port",this);
    txn = new();
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever @(posedge vif.clk) begin
      wait(vif.mon_cb.wr_en || vif.mon_cb.rd_en);
      txn.addr = vif.mon_cb.addr;
      if(vif.mon_cb.wr_en) begin
        txn.wr_en = 1;
        txn.rd_en = 0;
        txn.wdata = vif.mon_cb.wdata;
      end
      if(vif.mon_cb.rd_en) begin
        txn.rd_en = 1;
        txn.wr_en = 0;
        @(posedge vif.clk)
        @(posedge vif.clk)
        txn.rdata = vif.mon_cb.rdata;
      end
      //`uvm_info(get_type_name(),$sformatf("txn = %0p",txn),UVM_LOW);
      //txn.print();
      ap_port.write(txn);
    end
  endtask
endclass