class adder_agt extends uvm_agent;
  adder_sqr sqr;
  adder_drv drv;
  adder_mon mon;

  `uvm_component_utils(adder_agt)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sqr = adder_sqr::type_id::create("sqr",this);
    drv = adder_drv::type_id::create("drv",this);
    mon = adder_mon::type_id::create("mon",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass