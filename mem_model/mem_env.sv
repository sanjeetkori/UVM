class mem_env extends uvm_env;
  mem_agt agt;
  mem_sbd sbd;

  `uvm_component_utils(mem_env)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = mem_agt::type_id::create("agt",this);
    sbd = mem_sbd::type_id::create("sbd",this);
  endfunction

  function void connect_phase (uvm_phase phase);
    agt.mon.ap_port.connect(sbd.ap_imp);
  endfunction 

endclass