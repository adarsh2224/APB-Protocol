class apb_sbd extends uvm_subscriber#(apb_tx);

  bit [`DATAWIDTH-1:0] ref_mem [0:(1<<`ADDRWIDTH)-1];
  bit                  valid   [0:(1<<`ADDRWIDTH)-1];

  int unsigned n_writes;
  int unsigned n_reads;
  int unsigned n_errors;

  `uvm_component_utils(apb_sbd)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void write(apb_tx t);
    if (t.PWRITE) begin
      ref_mem[t.PADDR] = t.PWDATA;
      valid[t.PADDR]   = 1'b1;
      n_writes++;
      `uvm_info("SCB", $sformatf("WRITE addr=0x%0h data=0x%0h", t.PADDR, t.PWDATA), UVM_MEDIUM)
    end
    else begin
      n_reads++;
      if (!valid[t.PADDR]) begin
        n_errors++;
        `uvm_error("SCB", $sformatf("READ from unwritten addr=0x%0h, got data=0x%0h",
          t.PADDR, t.PRDATA))
      end
      else if (t.PRDATA !== ref_mem[t.PADDR]) begin
        n_errors++;
        `uvm_error("SCB", $sformatf("READ mismatch addr=0x%0h exp=0x%0h got=0x%0h",
          t.PADDR, ref_mem[t.PADDR], t.PRDATA))
      end
      else
        `uvm_info("SCB", $sformatf("READ OK addr=0x%0h data=0x%0h", t.PADDR, t.PRDATA), UVM_MEDIUM)
    end
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCB", $sformatf("Summary: writes=%0d reads=%0d errors=%0d",
      n_writes, n_reads, n_errors), UVM_LOW)
    if (n_errors > 0)
      `uvm_error("SCB", "Scoreboard reported mismatches or unwritten reads")
  endfunction
endclass
