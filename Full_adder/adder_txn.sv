class adder_txn extends uvm_sequence_item;
  rand bit [3:0] a,b;
  rand bit       c;
       bit [4:0] sum;
  rand bit       rst;

  `uvm_object_utils_begin(adder_txn)
    `uvm_field_int(a,UVM_ALL_ON)
    `uvm_field_int(b,UVM_ALL_ON)
    `uvm_field_int(c,UVM_ALL_ON)
    `uvm_field_int(sum,UVM_ALL_ON)
    `uvm_field_int(rst,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="adder_txn");
    super.new(name);
  endfunction
endclass