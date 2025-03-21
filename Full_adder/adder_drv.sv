//`define drv_if vif.drv_mp.drv_cb
class adder_drv extends uvm_driver #(adder_txn);
  virtual intf vif;
  `uvm_component_utils(adder_drv)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this,"","pif",vif))
      `uvm_fatal("NO_VIF","drv_if");
  endfunction

  virtual task run_phase(uvm_phase phase);
    @(negedge vif.rst)
    forever begin
      seq_item_port.get_next_item(req);
        vif.a   <= req.a;
        vif.b   <= req.b;
        vif.c   <= req.c;
          vif.rst   <= req.rst;
      @(negedge vif.clk);
      seq_item_port.item_done();
    end
  endtask
endclass