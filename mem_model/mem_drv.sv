`define drv_if vif.drv_cb
class mem_drv extends uvm_driver #(mem_txn);
  virtual intf vif;
  `uvm_component_utils(mem_drv)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this,"","pif",vif))
      `uvm_fatal("NO_VIF","drv_if");
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever @(posedge vif.clk) begin
      if(vif.rst) begin
        drive_idle();
      end
      else begin
        seq_item_port.try_next_item(req);
        if(req == null)
          drive_idle();
        else begin
          drive_txn(req);
          seq_item_port.item_done();
        end
      end
    end
  endtask

  virtual task drive_idle();
    `drv_if.wr_en <= 0;
    `drv_if.rd_en <= 0;
  endtask

  virtual task drive_txn(mem_txn req);
    `drv_if.addr <= req.addr;
    if(req.wr_en) begin
      `drv_if.wr_en <= req.wr_en;
      `drv_if.wdata <= req.wdata;
      @(posedge vif.clk);
      `drv_if.wr_en <= 0;
      @(posedge vif.clk);
    end
    else if(req.rd_en) begin
      `drv_if.rd_en <= req.rd_en;
      @(posedge vif.clk);
      `drv_if.rd_en <= 0;
      @(posedge vif.clk);
      req.rdata = `drv_if.rdata;
    end
  endtask
endclass