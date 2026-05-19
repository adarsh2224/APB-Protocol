class apb_cov extends uvm_subscriber#(apb_tx);
  `uvm_component_utils(apb_cov)

  apb_tx tx;

  covergroup apb_cg;
    PWRITE_cp: coverpoint tx.PWRITE {
      bins READ  = {0};
      bins WRITE = {1};
    }

    PADDR_cp: coverpoint tx.PADDR {
      bins low  = {[0:63]};
      bins mid  = {[64:191]};
      bins high = {[192:255]};
    }

    PWRITE_PADDR_x: cross PWRITE_cp, PADDR_cp;
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    apb_cg = new();
  endfunction

  function void write(apb_tx t);
    $cast(tx, t);
    apb_cg.sample();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("COV", $sformatf("Overall coverage = %.2f%%", apb_cg.get_coverage()), UVM_LOW)
    `uvm_info("COV", $sformatf("  PWRITE_cp      = %.2f%%", apb_cg.PWRITE_cp.get_coverage()), UVM_LOW)
    `uvm_info("COV", $sformatf("  PADDR_cp       = %.2f%%", apb_cg.PADDR_cp.get_coverage()), UVM_LOW)
    `uvm_info("COV", $sformatf("  PWRITE_PADDR_x = %.2f%%", apb_cg.PWRITE_PADDR_x.get_coverage()), UVM_LOW)
  endfunction
endclass
