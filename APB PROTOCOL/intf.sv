interface apb_intf(input logic PCLK,PRESETn);
bit                         PENABLE;
bit        [`ADDRWIDTH-1:0] PADDR;
bit                         PWRITE;
bit                         PSEL;
bit        [`DATAWIDTH-1:0] PWDATA;
logic 	   [`DATAWIDTH-1:0] PRDATA;
logic                     	PREADY;

modport master(
input PCLK,PRESETn,PREADY,PRDATA,
output PADDR,PWRITE,PWDATA,PENABLE,PSEL
);
endinterface
