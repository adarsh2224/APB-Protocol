class apb_tx extends uvm_sequence_item;
rand bit        [`ADDRWIDTH-1:0] PADDR;
rand bit                         PWRITE;
rand bit        [`DATAWIDTH-1:0] PWDATA;
bit 	   		[`DATAWIDTH-1:0] PRDATA;
`uvm_object_utils(apb_tx)
`NEW_OBJ

endclass
