class apb_agent extends uvm_agent;
apb_driver drv;
apb_sqr sqr;
`uvm_component_utils(apb_agent);
`NEW_COMP
function void build_phase(uvm_phase phase);
super.build_phase(phase);
drv = apb_driver::type_id::create("drv",this);
sqr = apb_sqr::type_id::create("sqr",this);
endfunction
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
drv.seq_item_port.connect(sqr.seq_item_export);
endfunction
endclass
