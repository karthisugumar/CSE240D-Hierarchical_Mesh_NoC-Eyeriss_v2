### UCSD CSE 240D Fall '19

# Hierarchical Mesh NoC - Eyeriss v2
## A SystemVerilog implementation of Row-Stationary dataflow based on Eyeriss and Hierarchical Mesh NoC based on the [Eyeriss v2 CNN accelerator](https://arxiv.org/abs/1807.07928).

### Prerequisites
#### Simulation requires a Verilog/SystemVerilog syntheis software package. Xilinx's Vivado Suite is recommended (available for free at the [Xilinx downloads webpage](https://www.xilinx.com/support/download.html))

### File structure
- **constraints/** - constraints folder
  - *.xdc* file to specify timing constraints - clock period, waveform shape (can also be used to include jitter, uncertainty, false paths etc for more accurate STA)
- **images/** - dataflow figures and sample graphs in PNG format
  - *Eyeriss_compare.png* - comparison of Eyeriss v1 and Eyeriss v2 architectures
  - *Eyeriss_scaled_down_top* - top level overview of GLBs and PEs assigned to router clusters - scaled down from the original Eyeriss v2 paper for purposes of the project
  - *Eyeriss_top* - overview of all components with a zoom in on one router + GLB + PE cluster combination
  - *PE_3* - components of one Processing Engine - control unit, scratch pad memory, multiply-and-accumulate unit, and multiplexer to select between incoming and previously computed partial sum
  - *RS* - Row Stationary dataflow, splitting inputs into 1D convolutions and performing row-wise computation - the partial sums are accumulated vertically
  - *phase_1_2* - data movement - transfer of weights, iacts and psums from GLB to PE clusters through routers
  - *router* - components of one router - black-boxed switching logic to arbitrate between data inflow and outflow from and to source and destination ports, controlled by the "routing mode" signal
  - *router_config.png* - working of mesh network  - in order, high level structure of the hierarchy, operation in high bandwidth mode, high reuse mode, grouped-multicast mode, and interleaved-multicast mode
- **rtl/** - main code directory
  - **misc/** - combinational logic blocks for miscellaneous tasks
    - *FA.sv* - full adder module, later instantiated in MAC unit
    - *HA.sv* - half adder module, for MAC unit
    - *circular_buffer.sv* - implements a circular buffer
    - *mux_4x1.sv* - 4:1 mux with bussed inputs and output
    - *switch.sv* - instantiation of multiplexers for lookup
  - **phase_1/** - design phase - focus on demonstration of a convolution operation through a grouped cluster of PEs, routers and GLBs
    - *GLB_cluster.sv* - instantiations of activations, weight and partial sum buffers
    - *HMNoC_cluster.sv* - parametrize and instantiate the GLB, PE and router clusters
    - *PE.sv* - FSM of one Processing Unit - read and load weights, activations, compute, write to GLB
    - *PE_cluster.sv* - clusterize PEs based on data and address widths
    - *SPad.sv* - bookkeeping for scratchpad memory - reads and writes
    - *glb_iact.sv* - input activation component of global buffer
    - *glb_psum.sv* - partial sum component of global buffer
    - *glb_weight.sv* - weight component of global buffer
    - *router_cluster.sv* - instantiations of activation, weight and partial sum routers (parametrized by kernel size)
    - *router_iact.sv* - FSM of activation router - idle, read from GLB, write to spad
    - *router_psum.sv* - similar FSM for partial sum router
    - *router_weight.sv* - similar FSM for weight router
  - **phase_2/** - scaling up the design with provisions for direction control
    - *HMNoC_cluster_east.sv* - interfacing router clusters on east side of PE array with its corresponding PE and GLB clusters
    - *HMNoC_cluster_west.sv* - similar cluster interfaces on the west side
    - *HMNoC_top.sv* - ports and interfacing of north-west, south-west, north-east and south-east clusters
    - *router.sv* - main source code of router - switch data between all direction (broadcast), unidirectional (unicast) and bidirectional (multicast)
    - *router_cluster.sv* - clusterization of router; instantiate routers based on data widths and interface with devices on different directions
  - **phase_3/** - design space exploration for data reuse opportunities
    - *router.sv*
    - *router_cluster.sv*
  - *MAC.sv* - multiply-and-accumulate compute unit
  - *lookup_mux4.sv* - combinational 4:1 mux for lookup
  - *mux2.sv* - combinational 2:1 mux
  - *router_east.sv* - connection of east router to device elements on every side
  - *router_iact.sv* - input activation component of router - cycle through read GLB and write SPad states
  - *router_psum.sv* - similar FSM for partial sums
  - *router_weight.sv* - similar FSM for weights
- **synth/** - constraints and reports directory - synthesis results containing top level and clusterized reports for timing and area utilization
- **testbench/** - directory containing testbenches of to simulate different working conditions to verify operation and functionality of the design - for kernel sizes 3x3 and 5x5
- **waveforms/** - directory containing simulation output graphs
  - *4_Convs.PNG* - convolution output of 4 PEs
  - *conv_3x3.PNG* - convolution with 3x3 kernel size
  - *conv_5x5.PNG* - convolution with 5x5 kernel size
  - *conv_out.PNG* - 
