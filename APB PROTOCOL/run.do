catch {quit -sim}
if {[file exists work]} { vdel -all -lib work }
vlib work
vmap work work

# Compile with functional coverage (covergroups in apb_cov.sv)
vlog -sv -timescale 1ns/1ps -cover bcestf apb_slave.v
vlog -sv -timescale 1ns/1ps -cover bcestf \
  +incdir+C:/questasim64_10.7c/verilog_src/uvm-1.2/src \
  C:/questasim64_10.7c/verilog_src/uvm-1.2/src/uvm_pkg.sv \
  top.sv

# Simulate (+acc for waves, -coverage for covergroups)
vsim -coverage -voptargs="+acc" \
  -sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi \
  work.top \
  +UVM_TESTNAME=apb_5_wr_rd_test \
  +UVM_VERBOSITY=UVM_MEDIUM

# Save coverage database when simulation ends
coverage save -onexit apb_cov.ucdb

# Add waves before run
add wave -noupdate sim:/top/pif/PCLK
add wave -noupdate sim:/top/pif/PRESETn
add wave -noupdate sim:/top/pif/PSEL
add wave -noupdate sim:/top/pif/PENABLE
add wave -noupdate sim:/top/pif/PWRITE
add wave -noupdate sim:/top/pif/PADDR
add wave -noupdate sim:/top/pif/PWDATA
add wave -noupdate sim:/top/pif/PRDATA
add wave -noupdate sim:/top/pif/PREADY

run -all
wave zoom full

# Text coverage report in project directory
coverage report -file cov_report.txt -detail
coverage report -detail

# To open coverage GUI later: coverage open apb_cov.ucdb
