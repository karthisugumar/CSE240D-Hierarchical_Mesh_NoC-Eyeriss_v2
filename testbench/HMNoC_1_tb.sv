`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 04:37:46 PM
// Design Name: 
// Module Name: HMNoC_1_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HMNoC_1_tb();

	parameter DATA_BITWIDTH = 16;
	parameter ADDR_BITWIDTH = 10;
	
	// GLB Cluster parameters. This TestBench uses only 1 of each
    parameter NUM_GLB_IACT = 1;
    parameter NUM_GLB_PSUM = 1;
	parameter NUM_GLB_WGHT = 1;
	
	
    logic clk;
    logic reset;

	//logic for GLB cluster
    logic read_req_iact[NUM_GLB_IACT-1:0];
	logic read_req_psum[NUM_GLB_PSUM-1:0];
	logic read_req_wght[NUM_GLB_WGHT-1:0];
	
    logic write_en_iact[NUM_GLB_IACT-1:0];
	logic write_en_psum[NUM_GLB_PSUM-1:0];
	logic write_en_wght[NUM_GLB_WGHT-1:0];
	
    logic [ADDR_BITWIDTH-1 : 0] r_addr_iact[NUM_GLB_IACT-1:0];
    logic [ADDR_BITWIDTH-1 : 0] r_addr_psum[NUM_GLB_PSUM-1:0];
	logic [ADDR_BITWIDTH-1 : 0] r_addr_wght[NUM_GLB_WGHT-1:0];
	
    logic [ADDR_BITWIDTH-1 : 0] w_addr_iact[NUM_GLB_IACT-1:0];
    logic [ADDR_BITWIDTH-1 : 0] w_addr_psum[NUM_GLB_PSUM-1:0];
	logic [ADDR_BITWIDTH-1 : 0] w_addr_wght[NUM_GLB_WGHT-1:0];
	
    logic [DATA_BITWIDTH-1 : 0] w_data_iact[NUM_GLB_IACT-1:0];
    logic [DATA_BITWIDTH-1 : 0] w_data_psum[NUM_GLB_PSUM-1:0];
	logic [DATA_BITWIDTH-1 : 0] w_data_wght[NUM_GLB_WGHT-1:0];
	
    logic [DATA_BITWIDTH-1 : 0] r_data_iact[NUM_GLB_IACT-1:0];
    logic [DATA_BITWIDTH-1 : 0] r_data_psum[NUM_GLB_PSUM-1:0];
    logic [DATA_BITWIDTH-1 : 0] r_data_wght[NUM_GLB_WGHT-1:0];

	
	//GLB cluster initialization
	GLB_cluster 
			#(	.DATA_BITWIDTH(DATA_BITWIDTH),
				.ADDR_BITWIDTH(ADDR_BITWIDTH),
				.NUM_GLB_IACT(NUM_GLB_IACT),
				.NUM_GLB_PSUM(NUM_GLB_PSUM),
				.NUM_GLB_WGHT(NUM_GLB_WGHT)
			)
	GLB_cluster_0
			(
				.clk(clk), 
				.reset(reset),
				
				.read_req_iact(read_req_iact),
				.read_req_psum(read_req_psum),
				.read_req_wght(read_req_wght),
				
				.write_en_iact(write_en_iact),
				.write_en_psum(write_en_psum),
				.write_en_wght(write_en_wght),
				
				.r_addr_iact(r_addr_iact),
			    .r_addr_psum(r_addr_psum),
				.r_addr_wght(r_addr_wght),

			    .w_addr_iact(w_addr_iact),
			    .w_addr_psum(w_addr_psum),
				.w_addr_wght(w_addr_wght),

			    .w_data_iact(w_data_iact),
			    .w_data_psum(w_data_psum),
				.w_data_wght(w_data_wght),

			    .r_data_iact(r_data_iact),
			    .r_data_psum(r_data_psum),
				.r_data_wght(r_data_wght)
			);

			
	// Router Instantiation
			
	integer clk_prd = 10;
	
	always begin
		clk = 0; #(clk_prd/2);
		clk = 1; #(clk_prd/2);
		//0.1GHz
	end
	
	integer kernel_1,act_1;
	integer w_addr = 0;
	int args;
	
	initial begin
		reset = 1; #30;
		reset = 0;
		

		//Write weights to weight glb
		write_en_wght[0] = 1;
		kernel_1 = $fopen("kernel_3x3.txt","r");		
		while(!$feof(kernel_1))begin
			w_addr_wght[0] = w_addr;
			args = $fscanf(kernel_1,"%d\n",w_data_wght[0]);
			$display("Writing value %0d to address %0d in weight glb",w_data_wght[0],w_addr);
			w_addr++;
			#(clk_prd);
		end
		write_en_wght[0] = 0;
		$fclose(kernel_1); 
		
		
		//Write activations to weight glb
		write_en_iact[0] = 1;
		w_addr = 0;
		act_1 = $fopen("act_5x5.txt","r");
		while(!$feof(act_1))begin
			w_addr_iact[0] = w_addr;
			args = $fscanf(act_1,"%d\n",w_data_iact[0]);
			$display("Writing value %0d to address %0d in iact glb",w_data_iact[0],w_addr);
			w_addr++;
			#(clk_prd);
		end
		write_en_iact[0] = 0;
		$fclose(act_1); 
		
		
//		write_en_wght[0] = 0;
	
	end
	
endmodule
