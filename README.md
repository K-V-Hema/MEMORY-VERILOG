#Memory Design - Verilog

This project implements basic memory modules in Verilog HDL including register-based storage, read/write logic, and address decoding. The design demonstrates how memory elements can be modeled and tested for various digital design applications.

**Overview**:
The Verilog memory design focuses on modeling storage elements such as RAM, ROM, and simple data memories using behavioral and structural coding styles. It provides a foundation for understanding how memory components operate inside digital systems, microcontrollers, and processors.

**Main Features**:

Parameterized memory depth and width.

Synchronous and asynchronous read/write operations.

Separate address, data, and control signals.

Clear initialization and reset logic.

Simple Verilog testbench for simulation and verification.

**Design Details**:
The memory is implemented as a two-dimensional array representing addressable storage locations.
When the write enable signal is asserted, data from the input port is written into the specified memory address on the rising edge of the clock.
During read operations, the data stored at the specified address is made available on the output port.
The design can be easily extended for larger memories or integrated into larger datapath modules such as processors or FIFOs.

**Testbench Description**:
The testbench performs multiple write and read operations at various memory addresses.
It initializes the memory, resets it, writes data to different locations, and verifies that reads return the expected values.
This verifies the correct functioning of the memory module and helps in debugging timing or control issues.
