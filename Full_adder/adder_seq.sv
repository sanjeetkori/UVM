class adder_seq extends uvm_sequence#(adder_txn);
  `uvm_object_utils(adder_seq)
  function new(string name="adder_seq");
    super.new(name);
  endfunction

  virtual task body();
    repeat(20) begin
      `uvm_do(req);
    end
  endtask
endclass