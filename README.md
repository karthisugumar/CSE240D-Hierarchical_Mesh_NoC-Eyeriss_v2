### UCSD CSE 240D Fall '19

# Hierarchical Mesh NoC - Eyeriss v2
## A SystemVerilog implementation of Row-Stationary dataflow based on Eyeriss and Hierarchical Mesh NoC based on the [Eyeriss v2 CNN accelerator](https://arxiv.org/abs/1807.07928).

This repository contains the SystemVerilog source code developed as part of the final project for the course "Accelerator Design for Deep Learning" at UCSD. Eyeriss is a popular CNN accelerator that showcased dataflow-based architectures using systolic arrays. The project implemented is inspired by the RS dataflow from the original Eyeriss paper and the Hierarchical Mesh NoC Architecture from the follow-up paper Eyeriss v2. 

![Image of top-level Architecture](https://github.com/karthisugumar/CSE240D-Hierarchical_Mesh_NoC-Eyeriss_v2/blob/master/images/Eyeriss_scaled_down_top.PNG)

### Prerequisites
#### Simulation requires a Verilog/SystemVerilog syntheis software package. Xilinx's Vivado Suite is recommended (available for free at the [Xilinx downloads webpage](https://www.xilinx.com/support/download.html))

### File structure

- **images/** - Figures used in report
  
- **synth/** - synthesis folder
  - *.xdc* file to specify timing constraints - clock period, waveform shape (can also be used to include jitter, uncertainty, false paths etc for more accurate STA)
  - *.vds* files contain synthesis log
  - *.rpt* files contain area utlization report
  
- **rtl/** - Contains SystemVerilog models of all components designed
  - **misc/** - combinational logic blocks for miscellaneous tasks
  - **phase_1/** - Focus on demonstration of a convolution operation through a single grouped cluster of PEs, routers and GLBs
  - **phase_2/** - Scaled-up design with 4 grouped clusters. Has new routers with provisions for direction control and configuration
  - **phase_3/** - Exploration of router design for data reuse opportunities - Unicast, Multicast, Broadcast
    
- **synth/** - constraints and reports directory - synthesis results containing top level and clusterized reports for timing and area utilization

- **testbench/** - Contains all testbenches, verification code, and experiments. 
  - **phase_1/, phase_2/, phase_3/** - Contains testbenches specific to each design phase
  
- **waveforms/** - directory containing simulation output graphs
  - *4_Convs.PNG* - parallel convolution output of 4 PE clusters
  - *conv_3x3.PNG* - convolution with 3x3 kernel size
  - *conv_5x5.PNG* - convolution with 5x5 kernel size
  - *conv_out.PNG* - phase_1 convolution output
