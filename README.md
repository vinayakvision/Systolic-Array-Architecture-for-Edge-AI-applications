# Systolic Array Architecture for Edge AI Applications

## Project Overview
This project implements a **parameterized systolic array architecture** in **Verilog HDL** for efficient matrix multiplication in **edge AI applications**. The design focuses on **high throughput, low latency, and optimized resource utilization**, making it suitable for deployment on FPGA-based AI accelerators.

## Features
- **Parameterized Design:** Array size, data width, and pipelining depth can be easily modified.  
- **Pipelined Processing Elements:** Supports parallel computation for faster matrix operations.  
- **Power and Performance Optimization:** Optimized dataflow and resource usage for reduced dynamic power and improved performance.  
- **FPGA-Ready:** Tested on **Xilinx Arty A7-100T FPGA** using Vivado.

## Tech Stack
- **Hardware Description Languages:** Verilog HDL, IPs  
- **FPGA Tools:** Xilinx Vivado 
- **Interfaces:** AXI / BRAM (optional integration for memory-mapped operations)  

## How to Run
1. Open the project in **Xilinx Vivado**.  
2. Synthesize and implement the **systolic array RTL**.  
3. Run the **simulation using ModelSim** testbench or Vivado simulator.  
4. Optionally, deploy the design on **Arty A7-100T FPGA** for real hardware testing.  

## Results
- Successfully validated **matrix multiplication operations** with parameterized array sizes.  
- Achieved **high throughput** and **low-latency computation** on FPGA.  
- Optimized **power and resource usage** for edge AI deployment.

## Future Work
- Integration with **on-chip memory (SRAM/BRAM)** for large matrix operations.  
- Extension to support **quantized AI models** for ultra-low-power edge inference.  
- Implement **scalable systolic arrays** for larger AI workloads.  

## License
This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details. 
