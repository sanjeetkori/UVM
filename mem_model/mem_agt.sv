class mem_agt extends uvm_agent;
  mem_drv drv;
  mem_sqr sqr;
  mem_mon mon;

  `uvm_component_utils(mem_agt)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = mem_mon::type_id::create("mon",this);
    if(get_is_active == UVM_ACTIVE) begin
      drv = mem_drv::type_id::create("drv",this);
      sqr = mem_sqr::type_id::create("sqr",this);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    if(get_is_active == UVM_ACTIVE)
      drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass