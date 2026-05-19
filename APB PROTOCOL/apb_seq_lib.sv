class apb_seq_lib extends uvm_sequence#(apb_tx);
apb_tx tx,tx_t;
`uvm_object_utils(apb_seq_lib)
`NEW_OBJ
endclass

class apb_wr_rd_seq extends apb_seq_lib;
`uvm_object_utils(apb_wr_rd_seq)
`NEW_OBJ

task body();
bit[`ADDRWIDTH-1:0] saved_addr;
`uvm_do_with(req,{PWRITE==1;})
saved_addr = req.PADDR;
`uvm_do_with(req, {PWRITE==0;
				  PADDR == saved_addr;
				  })
endtask
endclass

class apb_5_wr_rd_seq extends apb_seq_lib;
`uvm_object_utils(apb_5_wr_rd_seq)
`NEW_OBJ

task body();
bit[`ADDRWIDTH-1:0] saved_addr;
repeat (5) begin
`uvm_do_with(req,{PWRITE==1;})
saved_addr = req.PADDR;
`uvm_do_with(req, {PWRITE==0;
				  PADDR == saved_addr;
				  })
end
endtask
endclass

