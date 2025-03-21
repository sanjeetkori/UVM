class adder_sbd extends uvm_scoreboard;
  adder_txn txn;
  uvm_analysis_imp #(adder_txn,adder_sbd) ap_imp;
  bit [7:0] sum;

  `uvm_component_utils(adder_sbd)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_imp = new("ap_imp",this);
    txn = adder_txn::type_id::create("txn");
  endfunction

  function void write(adder_txn txn1);
    this.txn = txn1;

    if(!txn.rst)
      sum = txn.a + txn.b + txn.c;
    else
      sum = 0;
    
    if(sum !== txn.sum)
      $display("%0t sbd_mismatch :: exp act = %0d %0d rst = %0d , abc = %0d %0d %0d", $time, sum, txn.sum, txn.rst,  txn.a, txn.b, txn.c);
    else
      $display("%0t sbd_match    :: exp act = %0d %0d rst = %0d", $time, sum, txn.sum, txn.rst);

  endfunction
endclass