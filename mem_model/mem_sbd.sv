class mem_sbd extends uvm_scoreboard;

  virtual intf vif;
  mem_txn txn_q[$];
  bit [7:0] sbd_mem[4];
  uvm_analysis_imp#(mem_txn,mem_sbd) ap_imp;
  
  `uvm_component_utils(mem_sbd)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_imp = new("ap_imp",this);
    foreach (sbd_mem[i]) sbd_mem[i] = 8'hFF;
  endfunction

  virtual function void write(mem_txn txn);
    txn_q.push_back(txn);
  endfunction

  virtual task run_phase(uvm_phase phase);
    mem_txn txn;

    forever begin
      wait(txn_q.size() > 0);
      txn = txn_q.pop_front();

      if(txn.wr_en) begin
        sbd_mem[txn.addr] = txn.wdata;
        `uvm_info(get_type_name(),$sformatf("\t WDATA : Addr = %0d Data = %0d", txn.addr, txn.wdata),UVM_LOW);
      end
      else if(txn.rd_en) begin
        if(sbd_mem[txn.addr] == txn.rdata) begin
          `uvm_info(get_type_name(),$sformatf("Match \t RDATA : Addr = %0d Data = %0d", txn.addr, txn.rdata),UVM_LOW);
        end
        else
          `uvm_error(get_type_name(),$sformatf("Addr = %0d , exp act = %0d %0d", txn.addr, sbd_mem[txn.addr], txn.rdata));
      end
    end
  endtask

endclass