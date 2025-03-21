class adder_mon extends uvm_monitor;
  virtual intf vif;
  adder_txn txn;
  uvm_analysis_port #(adder_txn) ap_port;

  `uvm_component_utils(adder_mon)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual intf)::get(this,"","pif",vif);
    ap_port = new("ap_port",this);
    txn = adder_txn::type_id::create("txn");
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      txn.a   = vif.a;
      txn.b   = vif.b;
      txn.c   = vif.c;
      txn.sum = vif.sum;
      txn.rst = vif.rst;
      //txn.print();
      ap_port.write(txn);
    end
  endtask
endclass