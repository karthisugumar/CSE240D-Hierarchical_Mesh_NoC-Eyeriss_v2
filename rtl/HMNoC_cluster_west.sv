`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2019 11:42:17 AM
// Design Name: 
// Module Name: HMNoC_cluster_new
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


module HMNoC_cluster_west
	#(
		parameter DATA_BITWIDTH = 16,
		parameter ADDR_BITWIDTH = 10,
		
		parameter DATA_WIDTH = 16,
		parameter ADDR_WIDTH = 9,
		
		// GLB Cluster parameters. This TestBench uses only 1 of each
		parameter NUM_GLB_IACT = 1,
		parameter NUM_GLB_PSUM = 1,
		parameter NUM_GLB_WGHT = 1,
		
		parameter ADDR_BITWIDTH_GLB = 10,
		parameter ADDR_BITWIDTH_SPAD = 9,
		
		parameter NUM_ROUTER_PSUM = 1,
		parameter NUM_ROUTER_IACT = 1,
		parameter NUM_ROUTER_WGHT = 1,
				
		parameter int kernel_size = 3,
		parameter int act_size = 5,
		
		parameter int X_dim = 3,
		parameter int Y_dim = 3,
		
		parameter W_READ_ADDR = 0, 
		parameter A_READ_ADDR = 0,
		
		parameter W_LOAD_ADDR = 0,  
		parameter A_LOAD_ADDR = 0,
		
		parameter PSUM_READ_ADDR = 0,
		parameter PSUM_LOAD_ADDR = 0
	
    )
	(	
		input clk,
		input reset,
		
		//PE Cluster Interface
		input start,
		output load_done,
		
		input load_en_wght,
		input load_en_act,
		
        output [DATA_WIDTH-1:0] pe_out[X_dim-1:0],
		output compute_done,
		
		
		//GLB Cluster Interface

		input write_en_iact,
		input write_en_wght,
		
		input [DATA_WIDTH-1:0] w_data_iact,
		input [ADDR_WIDTH-1:0] w_addr_iact,
		
		input [DATA_WIDTH-1:0] w_data_wght,
		input [ADDR_WIDTH-1:0] w_addr_wght,
		
		input [ADDR_WIDTH-1:0] w_addr_psum,		
				
		output [DATA_WIDTH-1:0] r_data_psum,
		input [ADDR_WIDTH-1:0] r_addr_psum,
	
		input read_req_iact,
		input read_req_psum,
		input read_req_wght,
		
		input [ADDR_WIDTH-1:0] r_addr_iact,
		input [ADDR_WIDTH-1:0] r_addr_wght,
		

		
		//WGHT Router Ports
		input [3:0] router_mode_wght,
		
		//Interface with North
		//Source ports
		input [DATA_WIDTH-1:0] north_data_i_wght,
		input north_enable_i_wght,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] north_data_o_wght,
		output logic north_enable_o_wght,
		
		
		//Interface with South
		//Source ports
		input [DATA_WIDTH-1:0] south_data_i_wght,
		input south_enable_i_wght,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] south_data_o_wght,
		output logic south_enable_o_wght,
		
		
		//Interface with West
		//Source ports
//		input [DATA_WIDTH-1:0] west_data_i_wght,
		input west_enable_i_wght,
		
		//Destination ports
//		output logic [DATA_WIDTH-1:0] west_data_o_wght,
		output logic west_enable_o_wght,
		
		
		//Interface with East - Devices
		//Source ports
		input [DATA_WIDTH-1:0] east_data_i_wght,
		input east_enable_i_wght,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] east_data_o_wght,
		output logic east_enable_o_wght,
		
	//IACT Router Ports
		input [3:0] router_mode_iact,
		
		//Interface with North
		//Source ports
		input [DATA_WIDTH-1:0] north_data_i_iact,
		input north_enable_i_iact,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] north_data_o_iact,
		output logic north_enable_o_iact,
		
		
		//Interface with South
		//Source ports
		input [DATA_WIDTH-1:0] south_data_i_iact,
		input south_enable_i_iact,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] south_data_o_iact,
		output logic south_enable_o_iact,
		
		
		//Interface with West
		//Source ports
//		input [DATA_WIDTH-1:0] west_data_i_iact,
		input west_enable_i_iact,
		
		//Destination ports
//		output logic [DATA_WIDTH-1:0] west_data_o_iact,
		output logic west_enable_o_iact,
		
		
		//Interface with East - Devices
		//Source ports
		input [DATA_WIDTH-1:0] east_data_i_iact,
		input east_enable_i_iact,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] east_data_o_iact,
		output logic east_enable_o_iact,
		
	
	//PSUM Router Ports
		input [3:0] router_mode_psum,
		
		//Interface with North
		//Source ports
		input [DATA_WIDTH-1:0] north_data_i_psum,
		input north_enable_i_psum,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] north_data_o_psum,
		output logic north_enable_o_psum,
		
		
		//Interface with South
		//Source ports
		input [DATA_WIDTH-1:0] south_data_i_psum,
		input south_enable_i_psum,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] south_data_o_psum,
		output logic south_enable_o_psum,
		
		
		//Interface with West
		//Source ports
		input [DATA_WIDTH-1:0] west_data_i_psum,
		input west_enable_i_psum,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] west_data_o_psum,
		output logic west_enable_o_psum,
		
		//Interface with East - Devices
		//Source ports
		input [DATA_WIDTH-1:0] east_data_i_psum,
		input east_enable_i_psum,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] east_data_o_psum,
		output logic east_enable_o_psum
	
	);
	
	
	//Logic for Direction
		enum logic [3:0] {ALL=0, NORTH=1, SOUTH=2, WEST=3, EAST=4,
						EASTNORTH=5, EASTSOUTH=6, EASTWEST=7,
						WESTNORTH=8, WESTSOUTH=9, WESTEAST=10} direction;
						
						
						
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
				.clk(clk),   //TestBench/Controller
				.reset(reset),  //TestBench/Controller
				
				//Signals for reading from GLB
				.read_req_iact(read_req_iact),
				.read_req_psum(read_req_psum), //Read by testbench/controller
				.read_req_wght(read_req_wght),
				
			    .r_data_iact(router_cluster_0.west_data_i_iact),
			    .r_data_psum(r_data_psum), //Read by testbench/controller
				.r_data_wght(router_cluster_0.west_data_i_wght),
				
				.r_addr_iact(r_addr_iact),
			    .r_addr_psum(r_addr_psum), //testbench for reading final psums
				.r_addr_wght(r_addr_wght),

				
				//Signals for writing to GLB
			    .w_addr_iact(w_addr_iact), //testbench for writing
			    .w_addr_psum(w_addr_psum),
				.w_addr_wght(w_addr_wght), //testbench for writing
 
			    .w_data_iact(w_data_iact), //testbench for writing
			    .w_data_psum(router_cluster_0.west_data_o_psum),
				.w_data_wght(w_data_wght), //testbench for writing

				.write_en_iact(write_en_iact), //testbench for writing
				.write_en_psum(router_cluster_0.west_enable_o_psum),
				.write_en_wght(write_en_wght) //testbench for writing
			
			);
			
	
	
	
		router_cluster
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_cluster_0
		(
		
		//Ports for WGHT router
			.router_mode_wght(router_mode_wght), //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_wght(north_data_i_wght),
			.north_enable_i_wght(north_enable_i_wght),
			
			//Destination ports
			.north_data_o_wght(north_data_o_wght),
			.north_enable_o_wght(north_enable_o_wght),
			
			
			//Interface with South
			//Source ports
			.south_data_i_wght(south_data_i_wght),
			.south_enable_i_wght(south_enable_i_wght),
			
			//Destination ports
			.south_data_o_wght(south_data_o_wght),
			.south_enable_o_wght(south_enable_o_wght),
			
			
			//Interface with West
			//Source ports
			.west_data_i_wght(GLB_cluster_0.r_data_wght), //GLB_cluster
			.west_enable_i_wght(west_enable_i_wght),
			
			//Destination ports
			.west_data_o_wght(pe_cluster_0.filt_in),  //PE_cluster
			.west_enable_o_wght(west_enable_o_wght),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_wght(east_data_i_wght),
			.east_enable_i_wght(east_enable_i_wght),
	        
			//Destination ports
	        .east_data_o_wght(east_data_o_wght),
            .east_enable_o_wght(east_enable_o_wght),
			
		////////////////////////////////////////////
			
		//Ports for IACT router
			.router_mode_iact(router_mode_iact),  //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_iact(north_data_i_iact),
			.north_enable_i_iact(north_enable_i_iact),
			
			//Destination ports
			.north_data_o_iact(north_data_o_iact),
			.north_enable_o_iact(north_enable_o_iact),
			
			
			//Interface with South
			//Source ports
			.south_data_i_iact(south_data_i_iact),
			.south_enable_i_iact(south_enable_i_iact),
			
			//Destination ports
			.south_data_o_iact(south_data_o_iact),
			.south_enable_o_iact(south_enable_o_iact),
			
			
			//Interface with West
			//Source ports
			.west_data_i_iact(GLB_cluster_0.r_data_iact),   //GLB_cluster
			.west_enable_i_iact(west_enable_i_iact),
			
			//Destination ports
			.west_data_o_iact(pe_cluster_0.act_in),  //PE_cluster
			.west_enable_o_iact(west_enable_o_iact),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_iact(east_data_i_iact),
			.east_enable_i_iact(east_enable_i_iact),
	        
			//Destination ports
	        .east_data_o_iact(east_data_o_iact),
            .east_enable_o_iact(east_enable_o_iact),
			
			
		////////////////////////////////////////////
			
		//Ports for PSUM router
			.router_mode_psum(router_mode_psum),
			
			//Interface with North
			//Source ports
			.north_data_i_psum(north_data_i_psum),
			.north_enable_i_psum(north_enable_i_psum),
			
			//Destination ports
			.north_data_o_psum(north_data_o_psum),
			.north_enable_o_psum(north_enable_o_psum),
			
			
			//Interface with South
			//Source ports
			.south_data_i_psum(south_data_i_psum),
			.south_enable_i_psum(south_enable_i_psum),
			
			//Destination ports
			.south_data_o_psum(south_data_o_psum),
			.south_enable_o_psum(south_enable_o_psum),
			
			
			//Interface with West
			//Source ports
			.west_data_i_psum(west_data_i_psum), //PE_cluster
			.west_enable_i_psum(west_enable_i_psum),
			
			//Destination ports
			.west_data_o_psum(GLB_cluster_0.w_data_psum), //GLB_cluster
			.west_enable_o_psum(GLB_cluster_0.write_en_psum), //GLB_cluster
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_psum(east_data_i_psum),
			.east_enable_i_psum(east_enable_i_psum),
	        
			//Destination ports
	        .east_data_o_psum(east_data_o_psum),
            .east_enable_o_psum(east_enable_o_psum)	
	);
	

	
	PE_cluster #(
					.DATA_WIDTH(DATA_WIDTH),
					.ADDR_WIDTH(ADDR_WIDTH),
					
					.kernel_size(kernel_size),
					.act_size(act_size),
					
					.X_dim(X_dim),
					.Y_dim(Y_dim)
    			)
	pe_cluster_0
    			(
					.clk(clk),
				    .reset(reset),
				    .act_in(router_cluster_0.west_data_o_iact),
				    .filt_in(router_cluster_0.west_data_o_wght),
					.load_en_wght(load_en_wght),
					.load_en_act(load_en_act),
					.start(start),
                    .pe_out(pe_out),
					.compute_done(compute_done),
					.load_done(load_done)
    			);

	
	
endmodule
