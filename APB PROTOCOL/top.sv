`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "common.sv"
`include "intf.sv"
`include "apb_tx.sv"
`include "apb_driver.sv"
`include "apb_mon.sv"
`include "apb_sqr.sv"
`include "apb_cov.sv"
`include "apb_agent.sv"
`include "apb_seq_lib.sv"
`include "apb_sbd.sv"
`include "apb_env.sv"
`include "test_lib.sv"
module top;
reg clk,rst;
apb_intf pif(clk,rst);

apb_slave dut(
.PCLK 	(pif.PCLK),
.PRESETn(pif.PRESETn),
.PREADY (pif.PREADY),
.PRDATA (pif.PRDATA),
.PSEL 	(pif.PSEL),
.PENABLE(pif.PENABLE),
.PADDR 	(pif.PADDR),
.PWDATA (pif.PWDATA),
.PWRITE (pif.PWRITE)
);

initial begin
clk = 0;
forever #5 clk=~clk;
end

initial begin
uvm_resource_db#(virtual apb_intf)::set("GLOBAL","APB_VIF",pif,null);
rst=0;
$display("TIME %0t: Reset asserted", $time);
repeat(2)@(posedge clk);
rst=1;
  $display("TIME %0t: Reset deasserted, PRESETn=%0b", $time, pif.PRESETn);
end

initial begin 
run_test();
end
endmodule
