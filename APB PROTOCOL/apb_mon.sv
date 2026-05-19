class apb_mon extends uvm_monitor;
  uvm_analysis_port#(apb_tx) ap_port;
  virtual apb_intf vif;

  `uvm_component_utils(apb_mon)
  `NEW_COMP

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_port = new("ap_port", this);
    if (!uvm_resource_db#(virtual apb_intf)::read_by_name("GLOBAL", "APB_VIF", vif, this))
      `uvm_fatal("MON_VIF", "interface not found")
  endfunction

  task run_phase(uvm_phase phase);
    apb_tx tx;
    forever begin
      // Sample at negedge when access completes (same window driver uses for PREADY)
      @(negedge vif.PCLK);
      if (vif.PSEL && vif.PENABLE && vif.PREADY) begin
        tx = apb_tx::type_id::create("tx", this);
        tx.PADDR  = vif.PADDR;
        tx.PWRITE = vif.PWRITE;
        if (vif.PWRITE)
          tx.PWDATA = vif.PWDATA;
        else
          tx.PRDATA = vif.PRDATA;
        ap_port.write(tx);
        `uvm_info("MON", $sformatf("captured %s", tx.sprint()), UVM_LOW)
      end
    end
  endtask
endclass
