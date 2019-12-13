`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2019 01:41:06 PM
// Design Name: 
// Module Name: HMNoC_cluster_west_tb
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


module HMNoC_cluster_west_tb();

		parameter DATA_BITWIDTH = 16;
		parameter ADDR_BITWIDTH = 10;
		
		parameter DATA_WIDTH = 16;
		parameter ADDR_WIDTH = 9;
		
		// GLB Cluster parameters. This TestBench uses only 1 of each
		parameter NUM_GLB_IACT = 1;
		parameter NUM_GLB_PSUM = 1;
		parameter NUM_GLB_WGHT = 1;
		
		parameter ADDR_BITWIDTH_GLB = 10;
		parameter ADDR_BITWIDTH_SPAD = 9;
		
		parameter NUM_ROUTER_PSUM = 1;
		parameter NUM_ROUTER_IACT = 1;
		parameter NUM_ROUTER_WGHT = 1;
				
		parameter int kernel_size = 3;
		parameter int act_size = 5;
		
		parameter int X_dim = 3;
		parameter int Y_dim = 3;
		
		parameter W_READ_ADDR = 0; 
		parameter A_READ_ADDR = 0;
		
		parameter W_LOAD_ADDR = 0;  
		parameter A_LOAD_ADDR = 0;
		
		parameter PSUM_READ_ADDR = 0;
		parameter PSUM_LOAD_ADDR = 0;

		
		// Logic
		logic clk;
		logic reset;
		
		//PE Cluster Interface
		logic start;
		logic load_done;
		
		logic load_en_wght;
		logic load_en_act;
		
        logic [DATA_WIDTH-1:0] pe_out[X_dim-1:0];
		logic compute_done;
		
		
		
		//GLB Cluster Interface

		logic write_en_iact;
		logic write_en_wght;
		
		logic [DATA_WIDTH-1:0] w_data_iact;
		logic [ADDR_WIDTH-1:0] w_addr_iact;
		
		logic [DATA_WIDTH-1:0] w_data_wght;
		logic [ADDR_WIDTH-1:0] w_addr_wght;
		
		logic [DATA_WIDTH-1:0] r_data_psum;
		logic [ADDR_WIDTH-1:0] r_addr_psum;
		
		logic [ADDR_WIDTH-1:0] w_addr_psum;
		
		logic read_req_iact;
		logic read_req_psum;
		logic read_req_wght;
		
		logic [ADDR_WIDTH-1:0] r_addr_iact;
		logic [ADDR_WIDTH-1:0] r_addr_wght;
		
		
		
		//WGHT Router Ports
		logic [3:0] router_mode_wght;
		
		//Interface with North
		//Source ports
		logic [DATA_WIDTH-1:0] north_data_i_wght;
		logic north_enable_i_wght;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] north_data_o_wght;
		logic north_enable_o_wght;
		
		
		//Interface with South
		//Source ports
		logic [DATA_WIDTH-1:0] south_data_i_wght;
		logic south_enable_i_wght;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] south_data_o_wght;
		logic south_enable_o_wght;
		
		
		//Interface with West
		//Source ports
//		logic [DATA_WIDTH-1:0] west_data_i_wght;
		logic west_enable_i_wght;
		
		//Destination ports
//		logic logic [DATA_WIDTH-1:0] west_data_o_wght;
		logic west_enable_o_wght;
		
		
		//Interface with East - Devices
		//Source ports
		logic [DATA_WIDTH-1:0] east_data_i_wght;
		logic east_enable_i_wght;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] east_data_o_wght;
		logic east_enable_o_wght;
		
	//IACT Router Ports
		logic [3:0] router_mode_iact;
		
		//Interface with North
		//Source ports
		logic [DATA_WIDTH-1:0] north_data_i_iact;
		logic north_enable_i_iact;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] north_data_o_iact;
		logic north_enable_o_iact;
		
		
		//Interface with South
		//Source ports
		logic [DATA_WIDTH-1:0] south_data_i_iact;
		logic south_enable_i_iact;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] south_data_o_iact;
		logic south_enable_o_iact;
		
		
		//Interface with West
		//Source ports
//		logic [DATA_WIDTH-1:0] west_data_i_iact;
		logic west_enable_i_iact;
		
		//Destination ports
//		logic logic [DATA_WIDTH-1:0] west_data_o_iact;
		logic west_enable_o_iact;
		
		
		//Interface with East - Devices
		//Source ports
		logic [DATA_WIDTH-1:0] east_data_i_iact;
		logic east_enable_i_iact;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] east_data_o_iact;
		logic east_enable_o_iact;
		
	
	//PSUM Router Ports
		logic [3:0] router_mode_psum;
		
		//Interface with North
		//Source ports
		logic [DATA_WIDTH-1:0] north_data_i_psum;
		logic north_enable_i_psum;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] north_data_o_psum;
		logic north_enable_o_psum;
		
		
		//Interface with South
		//Source ports
		logic [DATA_WIDTH-1:0] south_data_i_psum;
		logic south_enable_i_psum;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] south_data_o_psum;
		logic south_enable_o_psum;
		
		
		//Interface with West
		//Source ports
		logic [DATA_WIDTH-1:0] west_data_i_psum;
		logic west_enable_i_psum;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] west_data_o_psum;
		logic west_enable_o_psum;
		
		//Interface with East - Devices
		//Source ports
		logic [DATA_WIDTH-1:0] east_data_i_psum;
		logic east_enable_i_psum;
		
		//Destination ports
		logic [DATA_WIDTH-1:0] east_data_o_psum;
		logic east_enable_o_psum;
		
		
		
	//Instantiation
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
	HMNoC_cluster_west_0 
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
//			.west_data_i_wght(GLB_cluster_0.r_data_wght), //GLB_cluster
			.west_enable_i_wght(west_enable_i_wght),
			
			//Destination ports
//			.west_data_o_wght(pe_cluster_0.filt_in),  //PE_cluster
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
//			.west_data_i_iact(GLB_cluster_0.r_data_iact),   //GLB_cluster
			.west_enable_i_iact(west_enable_i_iact),
			
			//Destination ports
//			.west_data_o_iact(pe_cluster_0.act_in),  //PE_cluster
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
//			.west_data_o_psum(GLB_cluster_0.w_data_psum), //GLB_cluster
//			.west_enable_o_psum(GLB_cluster_0.write_en_psum), //GLB_cluster
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_psum(east_data_i_psum),
			.east_enable_i_psum(east_enable_i_psum),
	        
			//Destination ports
	        .east_data_o_psum(east_data_o_psum),
            .east_enable_o_psum(east_enable_o_psum),
			
			
			
			//PE Cluster
			.load_en_wght(load_en_wght),
			.load_en_act(load_en_act),
			.start(start),
			.pe_out(pe_out),
			.compute_done(compute_done),
			.load_done(load_done)
		);
		
	
		//Logic for Direction
	enum logic [3:0] {ALL=0, NORTH=1, SOUTH=2, WEST=3, EAST=4,
						EASTNORTH=5, EASTSOUTH=6, EASTWEST=7,
						WESTNORTH=8, WESTSOUTH=9, WESTEAST=10} direction;
						
	integer clk_prd = 10;
	
	always begin
		clk = 0; #(clk_prd/2);
		clk = 1; #(clk_prd/2);
		//0.1GHz
	end
	
	integer kernel_1,act_1,psum_1;
	integer w_addr = 0;
	int args;
	
	logic [DATA_WIDTH-1:0] cluster_out_1[0:8];
	
	initial begin
		reset = 1; #30;
		reset = 0;
		start = 0;
		
		//Write weights to weight glb
/* 		write_en_wght = 1;
		kernel_1 = $fopen("kernel_3x3.txt","r");		
		while(!$feof(kernel_1))begin
			w_addr_wght = w_addr;
			args = $fscanf(kernel_1,"%d\n",w_data_wght);
			$display("Writing value %0d to address %0d in weight glb",w_data_wght,w_addr);
			w_addr++;
			#(clk_prd);
		end
		write_en_wght = 0;
		$fclose(kernel_1); 
		
		
		//Write activations to weight glb
		write_en_iact = 1;
		w_addr = 0;
		act_1 = $fopen("act_5x5.txt","r");
		while(!$feof(act_1))begin
			w_addr_iact = w_addr;
			args = $fscanf(act_1,"%d\n",w_data_iact);
			$display("Writing value %0d to address %0d in iact glb",w_data_iact,w_addr);
			w_addr++;
			#(clk_prd);
		end
		write_en_iact = 0;
		$fclose(act_1);  */
		
		//Write weights to weight glb
 		write_en_wght = 1;		
		for(int i=0; i<kernel_size**2;i++) begin
			w_data_wght = 1;
			w_addr_wght = i;
			#(clk_prd);
		end
		write_en_wght = 0;
	
		//Write activations to weight glb
		write_en_iact = 1;
		for(int i=0; i<act_size**2;i++) begin
			w_data_iact = i+1;
			w_addr_iact = i;
			#(clk_prd);
		end
		write_en_iact = 0;

		
		
		#(clk_prd);
	
//		assign west_data_o_wght = router_cluster_0.west_data_o_wght;
		
		$display("\n\nLoading Begins: Weights.....\n\n");
			read_req_wght = 1;
			r_addr_wght	= 0;
			#(clk_prd);
			
			west_enable_i_wght = 1;
			router_mode_wght = WEST;
			
			
		//Filter
			load_en_wght = 1;
			for(int i=1; i<=kernel_size**2; i++) begin
				r_addr_wght = i; #(clk_prd);
//				$display("Weight Read: %d",west_data_o_wght);
				load_en_wght = 0;
			end
		
		read_req_wght = 0;
		west_enable_i_wght = 0;
		
		#(clk_prd);
		
		
		$display("\n\nLoading Begins: Activations.....\n\n");
			
			read_req_iact = 1;
			r_addr_iact	= 0;
			#(clk_prd);
			
			west_enable_i_iact = 1;
			router_mode_iact = WEST;
			load_en_act = 1;
			
		//Filter
			for(int i=1; i<=act_size**2; i++) begin
				r_addr_iact = i; #(clk_prd);
				load_en_act = 0;
			end
		
		read_req_iact = 0;	
		west_enable_i_iact = 0;
		
		#(clk_prd);
	
	
	end	

endmodule
