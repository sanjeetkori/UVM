class adder_env extends uvm_env;
  adder_agt agt;
  adder_sbd sbd;

  `uvm_component_utils(adder_env)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction 

  function void build_phase(uvm_phase phase);
    agt = adder_agt::type_id::create("agt",this);
    sbd = adder_sbd::type_id::create("sbd",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.ap_port.connect(sbd.ap_imp);
  endfunction
endclass