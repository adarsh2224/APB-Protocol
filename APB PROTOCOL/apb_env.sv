class apb_env extends uvm_env;
  apb_agent agent;
  apb_mon   mon;
  apb_cov   cov;
  apb_sbd   sbd;

  `uvm_component_utils(apb_env)
  `NEW_COMP

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = apb_agent::type_id::create("agent", this);
    mon   = apb_mon::type_id::create("mon", this);
    cov   = apb_cov::type_id::create("cov", this);
    sbd   = apb_sbd::type_id::create("sbd", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mon.ap_port.connect(cov.analysis_export);
    mon.ap_port.connect(sbd.analysis_export);
  endfunction
endclass
