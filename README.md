# APB Protocol Verification using UVM

This project focuses on verifying the APB (Advanced Peripheral Bus) protocol using UVM.

In this Project DUT acts as slave and Driver acts as Master.

The verification environment was developed with a modular and reusable architecture, making it easier to extend and debug.The project includes APB read/write transaction verification along with functional coverage and scoreboard-based checking.

## Features
* APB Read and Write transaction support
* Modular UVM testbench architecture
* Driver, Monitor, Sequencer, Agent, Environment
* Functional coverage collection
* Scoreboard for data checking
* Randomized test sequences
* Reusable verification components

## Language used:
* System Verilog
* Verilog
* TCL


## Tools Used
* QuestaSim

## Project Structure
* apb_driver.sv --> Drives APB transactions to DUT
* apb_mon.sv --> Monitors bus activity
* apb_sbd.sv --> Scoreboard for data comparison
* apb_cov.sv --> Functional coverage collection
* apb_agent.sv --> APB agent containing sequencer, driver
* apb_env.sv --> Contains the agents
* apb_seq_lib.sv --> Test sequences
* apb_slave.v --> APB slave DUT
* top.sv --> Top-level testbench

## What I Learned
* Basics of AMBA APB protocol
* UVM component communication
* Factory registration and configuration
* Verification flow from stimulus to checking
* Debugging protocol timing issues
* Coverage-driven verification concepts

## Waveform and Working of APB
<img width="1843" height="258" alt="image" src="https://github.com/user-attachments/assets/0791151e-6064-42dd-ae52-5d599704ce48" />

In the above image we can see that when the PSEL is high the Setup Phase starts and the Address and Data is loaded and PENABLE gets high and once the PWRITE becomes LOW,the READ Phase starts.
