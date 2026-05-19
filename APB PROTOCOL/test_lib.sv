class apb_base_test extends uvm_test;
apb_env env;
`uvm_component_utils(apb_base_test);
`NEW_COMP

function void build_phase(uvm_phase phase);
super.build_phase(phase);
env = apb_env::type_id::create("env",this);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_top.print_topology();
endfunction
endclass

class apb_wr_rd_test extends apb_base_test;
`uvm_component_utils(apb_wr_rd_test);
`NEW_COMP
task run_phase(uvm_phase phase);
apb_wr_rd_seq wr_rd_seq;
wr_rd_seq = apb_wr_rd_seq::type_id::create("wr_rd_seq");
phase.raise_objection(this);
phase.phase_done.set_drain_time(this,100);
wr_rd_seq.start(env.agent.sqr);
phase.drop_objection(this);
endtask
endclass

class apb_5_wr_rd_test extends apb_base_test;
`uvm_component_utils(apb_5_wr_rd_test);
`NEW_COMP
task run_phase(uvm_phase phase);
apb_5_wr_rd_seq wr_rd_seq;
wr_rd_seq = apb_5_wr_rd_seq::type_id::create("wr_rd_seq");
phase.raise_objection(this);
phase.phase_done.set_drain_time(this,100);
wr_rd_seq.start(env.agent.sqr);
phase.drop_objection(this);
endtask
endclass
