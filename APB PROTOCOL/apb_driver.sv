
class apb_driver extends uvm_driver#(apb_tx);
virtual apb_intf.master vif;
apb_tx tx;
`uvm_component_utils(apb_driver);
`NEW_COMP
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_resource_db#(virtual apb_intf)::read_by_name("GLOBAL","APB_VIF",vif,this))begin
`uvm_error("resource_db","interface not found");
end
endfunction

task run_phase(uvm_phase phase);
apb_tx req;
$display("TIME %0t: Driver run_phase started, vif is %s", $time, (vif==null)?"NULL":"OK");

wait(vif.PRESETn === 1);
$display("TIME %0t: Driver saw reset deassert", $time);

@(posedge vif.PCLK);
$display("TIME %0t: Driver starting forever loop", $time);

vif.PSEL <= 0;
vif.PENABLE <= 0;
forever begin
  seq_item_port.get_next_item(req);
  $display("TIME %0t: Driver got item PWRITE=%0b PADDR=%0h", $time, req.PWRITE, req.PADDR);

  // SETUP phase
  @(negedge vif.PCLK);  // drive on negedge to be stable at posedge
  vif.PSEL   <= 1;
  vif.PENABLE<= 0;
  vif.PADDR  <= req.PADDR;
  vif.PWRITE <= req.PWRITE;
  if(req.PWRITE)
  vif.PWDATA <= req.PWDATA;

  // ACCESS phase
  @(negedge vif.PCLK);
  vif.PENABLE <= 1;

  // Wait for PREADY
  do begin
  @(negedge vif.PCLK);
  end
  while (!vif.PREADY);
  
  // Capture read data
  if (!vif.PWRITE)
    req.PRDATA = vif.PRDATA;

  // IDLE
  vif.PSEL    <= 0;
  vif.PENABLE <= 0;

  @(negedge vif.PCLK);
  seq_item_port.item_done();

  $display("TIME %0t: Driver item done", $time);
end
endtask
endclass
