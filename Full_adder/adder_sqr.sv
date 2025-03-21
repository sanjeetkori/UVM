class adder_sqr extends uvm_sequencer#(adder_txn);
  `uvm_component_utils(adder_sqr)
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
endclass