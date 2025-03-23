class write_seq extends uvm_sequence #(mem_txn);
  `uvm_object_utils(write_seq)

  function new(string name="write_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_do_with(req,{req.wr_en==1;});
  endtask
endclass

class read_seq extends uvm_sequence #(mem_txn);
  `uvm_object_utils(read_seq)

  function new(string name="read_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_do_with(req,{req.rd_en==1;});
  endtask
endclass

class mem_seq extends uvm_sequence #(mem_txn);

  write_seq wr_seq;
  read_seq  rd_seq;

  `uvm_object_utils(mem_seq)

  function new(string name="mem_seq");
    super.new(name);
  endfunction

  virtual task body();
    repeat(10) begin
    `uvm_do(wr_seq);
    `uvm_do(rd_seq);
    end
  endtask

endclass