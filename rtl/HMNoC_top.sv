`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2019 03:22:12 PM
// Design Name: 
// Module Name: HMNoC_top
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


module HMNoC_top
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
		input [3:0] router_mode_iact,
		input [3:0] router_mode_psum
	);
	
	
	//Instantiation of NORTH WEST Cluster
	HMNoC_cluster_west 
		#(
			.DATA_BITWIDTH(DATA_BITWIDTH),
			.ADDR_BITWIDTH(ADDR_BITWIDTH),
			
			.DATA_WIDTH(DATA_WIDTH),
			.ADDR_WIDTH(ADDR_WIDTH),
			
			.NUM_GLB_IACT(NUM_GLB_IACT),
			.NUM_GLB_PSUM(NUM_GLB_PSUM),
			.NUM_GLB_WGHT(NUM_GLB_WGHT),

			.kernel_size(kernel_size),
			.act_size(act_size),
			
			.X_dim(X_dim),
			.Y_dim(Y_dim)
		)
	HMNoC_cluster_west_0 ///NORTH WEST Cluster
		(
			.clk(clk),   //TestBench/Controller
			.reset(reset),  //TestBench/Controller
			
			//Signals for reading from GLB
			.read_req_iact(read_req_iact),
			.read_req_psum(read_req_psum), //Read by testbench/controller
			.read_req_wght(read_req_wght),
			
//			.r_data_iact(router_cluster_0.r_data_glb_iact),
			.r_data_psum(r_data_psum), //Read by testbench/controller
//			.r_data_wght(router_cluster_0.r_data_glb_wght),
			
			.r_addr_iact(r_addr_iact),
			.r_addr_psum(r_addr_psum), //testbench for reading final psums
			.r_addr_wght(r_addr_wght),

			//Signals for writing to GLB
			.w_addr_iact(w_addr_iact), //testbench for writing
			.w_addr_psum(w_addr_psum),
			.w_addr_wght(w_addr_wght), //testbench for writing

			.w_data_iact(w_data_iact), //testbench for writing
//			.w_data_psum(router_cluster_0.w_data_glb_psum),
			.w_data_wght(w_data_wght), //testbench for writing

			.write_en_iact(write_en_iact), //testbench for writing
//			.write_en_psum(router_cluster_0.write_en_glb_psum),
			.write_en_wght(write_en_wght), //testbench for writing
				
				
	
			//Ports for WGHT router
			.router_mode_wght(router_mode_wght), //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_wght(),
			.north_enable_i_wght(),
			
			//Destination ports
			.north_data_o_wght(),
			.north_enable_o_wght(),
			
			
			//Interface with South
			//Source ports
			.south_data_i_wght(HMNoC_cluster_west_1.north_data_o_wght),
			.south_enable_i_wght(HMNoC_cluster_west_1.north_enable_o_wght),
			
			//Destination ports
			.south_data_o_wght(HMNoC_cluster_west_1.north_data_i_wght),
			.south_enable_o_wght(HMNoC_cluster_west_1.north_enable_i_wght),
			
			
			//Interface with West
			//Source ports
//			.west_data_i_wght(GLB_cluster_0.r_data_wght), //GLB_cluster
			.west_enable_i_wght(west_enable_i_wght),
			
			//Destination ports
//			.west_data_o_wght(pe_cluster_0.filt_in),  //PE_cluster
			.west_enable_o_wght(west_enable_o_wght),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_wght(HMNoC_cluster_east_0.west_data_o_wght),
			.east_enable_i_wght(HMNoC_cluster_east_0.west_enable_o_wght),
	        
			//Destination ports
	        .east_data_o_wght(HMNoC_cluster_east_0.west_data_i_wght),
            .east_enable_o_wght(HMNoC_cluster_east_0.west_enable_i_wght),
			
		////////////////////////////////////////////
			
		//Ports for IACT router
			.router_mode_iact(router_mode_iact),  //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_iact(),
			.north_enable_i_iact(),
			
			//Destination ports
			.north_data_o_iact(),
			.north_enable_o_iact(),
			
			
			//Interface with South
			//Source ports
			.south_data_i_iact(HMNoC_cluster_west_1.north_data_o_iact),
			.south_enable_i_iact(HMNoC_cluster_west_1.north_enable_o_iact),
			
			//Destination ports
			.south_data_o_iact(HMNoC_cluster_west_1.north_data_i_iact),
			.south_enable_o_iact(HMNoC_cluster_west_1.north_enable_i_iact),
			
			
			//Interface with West
			//Source ports
//			.west_data_i_iact(GLB_cluster_0.r_data_iact),   //GLB_cluster
			.west_enable_i_iact(west_enable_i_iact),
			
			//Destination ports
//			.west_data_o_iact(pe_cluster_0.act_in),  //PE_cluster
			.west_enable_o_iact(west_enable_o_iact),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_iact(HMNoC_cluster_east_0.west_data_o_iact),
			.east_enable_i_iact(HMNoC_cluster_east_0.west_enable_o_iact),
	        
			//Destination ports
	        .east_data_o_iact(HMNoC_cluster_east_0.west_data_i_iact),
            .east_enable_o_iact(HMNoC_cluster_east_0.west_enable_i_iact),
			
			
		////////////////////////////////////////////
			
		//Ports for PSUM router
			.router_mode_psum(router_mode_psum),
			
			//Interface with North
			//Source ports
			.north_data_i_psum(),
			.north_enable_i_psum(),
			
			//Destination ports
			.north_data_o_psum(),
			.north_enable_o_psum(),
			
			
			//Interface with South
			//Source ports
			.south_data_i_psum(HMNoC_cluster_west_1.north_data_o_psum),
			.south_enable_i_psum(HMNoC_cluster_west_1.north_enable_o_psum),
			
			//Destination ports
			.south_data_o_psum(HMNoC_cluster_west_1.north_data_i_psum),
			.south_enable_o_psum(HMNoC_cluster_west_1.north_enable_i_psum),
			
			
			//Interface with West
			//Source ports
			.west_data_i_psum(west_data_i_psum), //PE_cluster
			.west_enable_i_psum(west_enable_i_psum),
			
			//Destination ports
//			.west_data_o_psum(GLB_cluster_0.w_data_psum), //GLB_cluster
//			.west_enable_o_psum(GLB_cluster_0.write_en_psum), //GLB_cluster
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_psum(HMNoC_cluster_east_0.west_data_o_psum),
			.east_enable_i_psum(HMNoC_cluster_east_0.west_enable_o_psum),
	        
			//Destination ports
	        .east_data_o_psum(HMNoC_cluster_east_0.west_data_i_psum),
            .east_enable_o_psum(HMNoC_cluster_east_0.west_enable_i_psum),
			
			
			
			//PE Cluster
			.load_en_wght(load_en_wght),
			.load_en_act(load_en_act),
			.start(start),
			.pe_out(pe_out),
			.compute_done(compute_done),
			.load_done(load_done)
		);
		
		
		
		
	//Instantiation of SOUTH WEST Cluster
	HMNoC_cluster_west 
		#(
			.DATA_BITWIDTH(DATA_BITWIDTH),
			.ADDR_BITWIDTH(ADDR_BITWIDTH),
			
			.DATA_WIDTH(DATA_WIDTH),
			.ADDR_WIDTH(ADDR_WIDTH),
			
			.NUM_GLB_IACT(NUM_GLB_IACT),
			.NUM_GLB_PSUM(NUM_GLB_PSUM),
			.NUM_GLB_WGHT(NUM_GLB_WGHT),

			.kernel_size(kernel_size),
			.act_size(act_size),
			
			.X_dim(X_dim),
			.Y_dim(Y_dim)
		)
	HMNoC_cluster_west_1 ///SOUTH WEST Cluster
		(
			.clk(clk),   //TestBench/Controller
			.reset(reset),  //TestBench/Controller
			
			//Signals for reading from GLB
			.read_req_iact(),
			.read_req_psum(), //Read by testbench/controller
			.read_req_wght(),
			
//			.r_data_iact(router_cluster_0.r_data_glb_iact),
			.r_data_psum(), //Read by testbench/controller
//			.r_data_wght(router_cluster_0.r_data_glb_wght),
			
			.r_addr_iact(),
			.r_addr_psum(), //testbench for reading final psums
			.r_addr_wght(),

			//Signals for writing to GLB
			.w_addr_iact(), //testbench for writing
			.w_addr_psum(),
			.w_addr_wght(), //testbench for writing

			.w_data_iact(), //testbench for writing
//			.w_data_psum(router_cluster_0.w_data_glb_psum),
			.w_data_wght(), //testbench for writing

			.write_en_iact(), //testbench for writing
//			.write_en_psum(router_cluster_0.write_en_glb_psum),
			.write_en_wght(), //testbench for writing
				
				
	
			//Ports for WGHT router
			.router_mode_wght(), //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_wght(HMNoC_cluster_west_0.south_data_o_wght),
			.north_enable_i_wght(HMNoC_cluster_west_0.south_enable_o_wght),
			
			//Destination ports
			.north_data_o_wght(HMNoC_cluster_west_0.south_data_i_wght),
			.north_enable_o_wght(HMNoC_cluster_west_0.south_enable_i_wght),
			
			
			//Interface with South
			//Source ports
			.south_data_i_wght(),
			.south_enable_i_wght(),
			
			//Destination ports
			.south_data_o_wght(),
			.south_enable_o_wght(),
			
			
			//Interface with West
			//Source ports
//			.west_data_i_wght(GLB_cluster_0.r_data_wght), //GLB_cluster
			.west_enable_i_wght(),
			
			//Destination ports
//			.west_data_o_wght(pe_cluster_0.filt_in),  //PE_cluster
			.west_enable_o_wght(),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_wght(HMNoC_cluster_east_1.west_data_o_wght),
			.east_enable_i_wght(HMNoC_cluster_east_1.west_enable_o_wght),
	        
			//Destination ports
	        .east_data_o_wght(HMNoC_cluster_east_1.west_data_i_wght),
            .east_enable_o_wght(HMNoC_cluster_east_1.west_enable_i_wght),
			
		////////////////////////////////////////////
			
		//Ports for IACT router
			.router_mode_iact(),  //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_iact(HMNoC_cluster_west_0.south_data_o_iact),
			.north_enable_i_iact(HMNoC_cluster_west_0.south_enable_o_iact),
			
			//Destination ports
			.north_data_o_iact(HMNoC_cluster_west_0.south_data_i_iact),
			.north_enable_o_iact(HMNoC_cluster_west_0.south_enable_i_iact),
			
			
			//Interface with South
			//Source ports
			.south_data_i_iact(),
			.south_enable_i_iact(),

			//Destination ports
			.south_data_o_iact(),
			.south_enable_o_iact(),


			//Interface with West
			//Source ports
//			.west_data_i_iact(GLB_cluster_0.r_data_iact),   //GLB_cluster
			.west_enable_i_iact(),
			
			//Destination ports
//			.west_data_o_iact(pe_cluster_0.act_in),  //PE_cluster
			.west_enable_o_iact(),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_iact(),
			.east_enable_i_iact(),
	        
			//Destination ports
	        .east_data_o_iact(),
            .east_enable_o_iact(),
			
			
		////////////////////////////////////////////
			
		//Ports for PSUM router
			.router_mode_psum(),
			
			//Interface with North
			//Source ports
			.north_data_i_psum(HMNoC_cluster_west_0.south_data_o_psum),
			.north_enable_i_psum(HMNoC_cluster_west_0.south_enable_o_psum),
			
			//Destination ports
			.north_data_o_psum(HMNoC_cluster_west_0.south_data_i_psum),
			.north_enable_o_psum(HMNoC_cluster_west_0.south_enable_i_psum),
			
			
			//Interface with South
			//Source ports
			.south_data_i_psum(),
			.south_enable_i_psum(),
			
			//Destination ports
			.south_data_o_psum(),
			.south_enable_o_psum(),
			
			
			//Interface with West
			//Source ports
			.west_data_i_psum(), //PE_cluster
			.west_enable_i_psum(),
			
			//Destination ports
//			.west_data_o_psum(GLB_cluster_0.w_data_psum), //GLB_cluster
//			.west_enable_o_psum(GLB_cluster_0.write_en_psum), //GLB_cluster
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_psum(HMNoC_cluster_east_1.west_data_o_psum),
			.east_enable_i_psum(HMNoC_cluster_east_1.west_enable_o_psum),
	        
			//Destination ports
	        .east_data_o_psum(HMNoC_cluster_east_1.west_data_i_psum),
            .east_enable_o_psum(HMNoC_cluster_east_1.west_enable_i_psum),
			
			
			
			//PE Cluster
			.load_en_wght(),
			.load_en_act(),
			.start(),
			.pe_out(),
			.compute_done(),
			.load_done()
		);
		
		
		
	//Instantiation of NORTH_EAST Cluster
	HMNoC_cluster_east 
		#(
			.DATA_BITWIDTH(DATA_BITWIDTH),
			.ADDR_BITWIDTH(ADDR_BITWIDTH),
			
			.DATA_WIDTH(DATA_WIDTH),
			.ADDR_WIDTH(ADDR_WIDTH),
			
			.NUM_GLB_IACT(NUM_GLB_IACT),
			.NUM_GLB_PSUM(NUM_GLB_PSUM),
			.NUM_GLB_WGHT(NUM_GLB_WGHT),

			.kernel_size(kernel_size),
			.act_size(act_size),
			
			.X_dim(X_dim),
			.Y_dim(Y_dim)
		)
	HMNoC_cluster_east_0 
		(
			.clk(clk),   //TestBench/Controller
			.reset(reset),  //TestBench/Controller
			
			//Signals for reading from GLB
			.read_req_iact(),
			.read_req_psum(), //Read by testbench/controller
			.read_req_wght(),
			
//			.r_data_iact(router_cluster_0.r_data_glb_iact),
			.r_data_psum(), //Read by testbench/controller
//			.r_data_wght(router_cluster_0.r_data_glb_wght),
			
			.r_addr_iact(),
			.r_addr_psum(), //testbench for reading final psums
			.r_addr_wght(),

			//Signals for writing to GLB
			.w_addr_iact(), //testbench for writing
			.w_addr_psum(),
			.w_addr_wght(), //testbench for writing

			.w_data_iact(), //testbench for writing
//			.w_data_psum(router_cluster_0.w_data_glb_psum),
			.w_data_wght(), //testbench for writing

			.write_en_iact(), //testbench for writing
//			.write_en_psum(router_cluster_0.write_en_glb_psum),
			.write_en_wght(), //testbench for writing
				
				
	
			//Ports for WGHT router
			.router_mode_wght(), //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_wght(),
			.north_enable_i_wght(),
			
			//Destination ports
			.north_data_o_wght(),
			.north_enable_o_wght(),
			
			
			//Interface with South
			//Source ports
			.south_data_i_wght(HMNoC_cluster_east_1.north_data_o_wght),
			.south_enable_i_wght(HMNoC_cluster_east_1.north_enable_o_wght),
			
			//Destination ports
			.south_data_o_wght(HMNoC_cluster_east_1.north_data_i_wght),
			.south_enable_o_wght(HMNoC_cluster_east_1.north_enable_i_wght),
			
			
			//Interface with West
			//Source ports
			.west_data_i_wght(HMNoC_cluster_west_0.east_data_o_wght), //GLB_cluster
			.west_enable_i_wght(HMNoC_cluster_west_0.east_enable_o_wght),
			
			//Destination ports
			.west_data_o_wght(HMNoC_cluster_west_0.east_data_i_wght),  //PE_cluster
			.west_enable_o_wght(HMNoC_cluster_west_0.east_enable_i_wght),
			
			
			//Interface with East - Devices
			//Source ports
//			.east_data_i_wght(east_data_i_wght),
			.east_enable_i_wght(),
	        
			//Destination ports
//	        .east_data_o_wght(east_data_o_wght),
            .east_enable_o_wght(),
			
		////////////////////////////////////////////
			
		//Ports for IACT router
			.router_mode_iact(),  //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_iact(),
			.north_enable_i_iact(),
			
			//Destination ports
			.north_data_o_iact(),
			.north_enable_o_iact(),
			
			
			//Interface with South
			//Source ports
			.south_data_i_iact(HMNoC_cluster_east_1.north_data_o_iact),
			.south_enable_i_iact(HMNoC_cluster_east_1.north_enable_o_iact),
			
			//Destination ports
			.south_data_o_iact(HMNoC_cluster_east_1.north_data_i_iact),
			.south_enable_o_iact(HMNoC_cluster_east_1.north_enable_i_iact),
			
			
			//Interface with West
			//Source ports
			.west_data_i_iact(HMNoC_cluster_west_0.east_data_o_iact),   //GLB_cluster
			.west_enable_i_iact(HMNoC_cluster_west_0.east_enable_o_iact),
			
			//Destination ports
			.west_data_o_iact(HMNoC_cluster_west_0.east_data_i_iact),  //PE_cluster
			.west_enable_o_iact(HMNoC_cluster_west_0.east_enable_i_iact),
			
			
			//Interface with East - Devices
			//Source ports
//			.east_data_i_iact(east_data_i_iact),
			.east_enable_i_iact(),
	        
			//Destination ports
//	        .east_data_o_iact(east_data_o_iact),
            .east_enable_o_iact(),
		

		////////////////////////////////////////////
			
		//Ports for PSUM router
			.router_mode_psum(),
			
			//Interface with North
			//Source ports
			.north_data_i_psum(),
			.north_enable_i_psum(),
			
			//Destination ports
			.north_data_o_psum(),
			.north_enable_o_psum(),
			
			
			//Interface with South
			//Source ports
			.south_data_i_psum(HMNoC_cluster_east_1.north_data_i_psum),
			.south_enable_i_psum(HMNoC_cluster_east_1.north_enable_i_psum),
			
			//Destination ports
			.south_data_o_psum(HMNoC_cluster_east_1.north_data_o_psum),
			.south_enable_o_psum(HMNoC_cluster_east_1.north_enable_o_psum),
			
			
			//Interface with West
			//Source ports
			.west_data_i_psum(HMNoC_cluster_west_0.east_data_o_psum), //PE_cluster
			.west_enable_i_psum(HMNoC_cluster_west_0.east_enable_o_psum),
			
			//Destination ports
			.west_data_o_psum(HMNoC_cluster_west_0.east_data_i_psum), //GLB_cluster
			.west_enable_o_psum(HMNoC_cluster_west_0.east_enable_i_psum), //GLB_cluster
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_psum(),
			.east_enable_i_psum(),
	        
			//Destination ports
//	        .east_data_o_psum(east_data_o_psum),
//            .east_enable_o_psum(east_enable_o_psum),
			
			
			
			//PE Cluster
			.load_en_wght(),
			.load_en_act(),
			.start(),
			.pe_out(),
			.compute_done(),
			.load_done()
		);
		
	
		//Instantiation of SOUTH_EAST Cluster
	HMNoC_cluster_east 
		#(
			.DATA_BITWIDTH(DATA_BITWIDTH),
			.ADDR_BITWIDTH(ADDR_BITWIDTH),
			
			.DATA_WIDTH(DATA_WIDTH),
			.ADDR_WIDTH(ADDR_WIDTH),
			
			.NUM_GLB_IACT(NUM_GLB_IACT),
			.NUM_GLB_PSUM(NUM_GLB_PSUM),
			.NUM_GLB_WGHT(NUM_GLB_WGHT),

			.kernel_size(kernel_size),
			.act_size(act_size),
			
			.X_dim(X_dim),
			.Y_dim(Y_dim)
		)
	HMNoC_cluster_east_1 
		(
			.clk(clk),   //TestBench/Controller
			.reset(reset),  //TestBench/Controller
			
			//Signals for reading from GLB
			.read_req_iact(),
			.read_req_psum(), //Read by testbench/controller
			.read_req_wght(),
			
//			.r_data_iact(router_cluster_0.r_data_glb_iact),
			.r_data_psum(), //Read by testbench/controller
//			.r_data_wght(router_cluster_0.r_data_glb_wght),
			
			.r_addr_iact(),
			.r_addr_psum(), //testbench for reading final psums
			.r_addr_wght(),

			//Signals for writing to GLB
			.w_addr_iact(), //testbench for writing
			.w_addr_psum(),
			.w_addr_wght(), //testbench for writing

			.w_data_iact(), //testbench for writing
//			.w_data_psum(router_cluster_0.w_data_glb_psum),
			.w_data_wght(), //testbench for writing

			.write_en_iact(), //testbench for writing
//			.write_en_psum(router_cluster_0.write_en_glb_psum),
			.write_en_wght(), //testbench for writing
				
				
	
			//Ports for WGHT router
			.router_mode_wght(), //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_wght(HMNoC_cluster_east_0.south_data_o_wght),
			.north_enable_i_wght(HMNoC_cluster_east_0.south_enable_o_wght),
			
			//Destination ports
			.north_data_o_wght(HMNoC_cluster_east_0.south_data_i_wght),
			.north_enable_o_wght(HMNoC_cluster_east_0.south_enable_i_wght),
			
			
			//Interface with South
			//Source ports
			.south_data_i_wght(),
			.south_enable_i_wght(),
			
			//Destination ports
			.south_data_o_wght(),
			.south_enable_o_wght(),
			
			
			//Interface with West
			//Source ports
			.west_data_i_wght(HMNoC_cluster_west_1.east_data_o_wght), //GLB_cluster
			.west_enable_i_wght(HMNoC_cluster_west_1.east_enable_o_wght),
			
			//Destination ports
			.west_data_o_wght(HMNoC_cluster_west_1.east_data_i_wght),  //PE_cluster
			.west_enable_o_wght(HMNoC_cluster_west_1.east_enable_i_wght),
			
			
			//Interface with East - Devices
			//Source ports
//			.east_data_i_wght(east_data_i_wght),
			.east_enable_i_wght(),
	        
			//Destination ports
//	        .east_data_o_wght(east_data_o_wght),
            .east_enable_o_wght(),
			
		////////////////////////////////////////////
			
		//Ports for IACT router
			.router_mode_iact(router_mode_iact),  //TB*
			
			//Interface with North
			//Source ports
			.north_data_i_iact(HMNoC_cluster_east_0.south_data_o_iact),
			.north_enable_i_iact(HMNoC_cluster_east_0.south_enable_o_iact),
			
			//Destination ports
			.north_data_o_iact(HMNoC_cluster_east_0.south_data_i_iact),
			.north_enable_o_iact(HMNoC_cluster_east_0.south_enable_i_iact),
			
			
			//Interface with South
			//Source ports
			.south_data_i_iact(),
			.south_enable_i_iact(),
			
			//Destination ports
			.south_data_o_iact(),
			.south_enable_o_iact(),
			
			
			//Interface with West
			//Source ports
			.west_data_i_iact(HMNoC_cluster_west_1.east_data_o_iact),   //GLB_cluster
			.west_enable_i_iact(HMNoC_cluster_west_1.east_enable_o_iact),
			
			//Destination ports
			.west_data_o_iact(HMNoC_cluster_west_1.east_data_i_iact),  //PE_cluster
			.west_enable_o_iact(HMNoC_cluster_west_1.east_enable_i_iact),
			
			
			//Interface with East - Devices
			//Source ports
//			.east_data_i_iact(east_data_i_iact),
			.east_enable_i_iact(),
	        
			//Destination ports
//	        .east_data_o_iact(east_data_o_iact),
            .east_enable_o_iact(),
			
			
		////////////////////////////////////////////
			
		//Ports for PSUM router
			.router_mode_psum(),
			
			//Interface with North
			//Source ports
			.north_data_i_psum(HMNoC_cluster_east_0.south_data_o_psum),
			.north_enable_i_psum(HMNoC_cluster_east_0.south_enable_o_psum),
			
			//Destination ports
			.north_data_o_psum(HMNoC_cluster_east_0.south_data_i_psum),
			.north_enable_o_psum(HMNoC_cluster_east_0.south_enable_i_psum),
			
			
			//Interface with South
			//Source ports
			.south_data_i_psum(),
			.south_enable_i_psum(),
			
			//Destination ports
			.south_data_o_psum(),
			.south_enable_o_psum(),
			
			
			//Interface with West
			//Source ports
			.west_data_i_psum(HMNoC_cluster_west_1.east_data_o_psum), //PE_cluster
			.west_enable_i_psum(HMNoC_cluster_west_1.east_enable_o_psum),
			
			//Destination ports
			.west_data_o_psum(HMNoC_cluster_west_1.east_data_i_psum), //GLB_cluster
			.west_enable_o_psum(HMNoC_cluster_west_1.east_enable_i_psum), //GLB_cluster
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_psum(),
			.east_enable_i_psum(),
	        
			//Destination ports
//	        .east_data_o_psum(east_data_o_psum),
//            .east_enable_o_psum(east_enable_o_psum),
			
			
			
			//PE Cluster
			.load_en_wght(),
			.load_en_act(),
			.start(),
			.pe_out(),
			.compute_done(),
			.load_done()
		);
		
		
endmodule
