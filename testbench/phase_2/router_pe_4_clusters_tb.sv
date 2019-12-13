`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2019 04:47:06 AM
// Design Name: 
// Module Name: router_pe_4_clusters
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


module router_pe_4_clusters_tb();

	parameter DATA_WIDTH = 16;
	
	
	///////////////      WGHT ROUTER WEST 0      ///////////////////////////////////
	
	logic [3:0] router_mode_west_0_whgt;
	
	//Interface with West
	//Source ports
	logic [DATA_WIDTH-1:0] west_data_i_west_0_whgt;
	logic west_enable_i_west_0_whgt;
	
	//Destination ports
	logic [DATA_WIDTH-1:0] west_data_o_west_0_whgt;
	logic west_enable_o_west_0_whgt;

	
	
		///////////////      WGHT ROUTER WEST 1     ///////////////////////////////////
	
	logic [3:0] router_mode_west_1_whgt;
	
	
	//Interface with West
	//Source ports
	logic [DATA_WIDTH-1:0] west_data_i_west_1_whgt;
	logic west_enable_i_west_1_whgt;
	
	//Destination ports
	logic [DATA_WIDTH-1:0] west_data_o_west_1_whgt;
	logic west_enable_o_west_1_whgt;

		
			///////////////      WGHT ROUTER EAST 0    ///////////////////////////////////
	
	logic [3:0] router_mode_east_0_whgt;
	
	
	//Interface with East
	//Source ports
	logic [DATA_WIDTH-1:0] east_data_i_east_0_whgt;
	logic east_enable_i_east_0_whgt;

	//Destination ports
	logic [DATA_WIDTH-1:0] east_data_o_east_0_whgt;
	logic east_enable_o_east_0_whgt;

		
		
			///////////////      WGHT ROUTER EAST 1     ///////////////////////////////////
	
	logic [3:0] router_mode_east_1_whgt;
	
	
	//Interface with East
	//Source ports
	logic [DATA_WIDTH-1:0] east_data_i_east_1_whgt;
	logic east_enable_i_east_1_whgt;

	//Destination ports
	logic [DATA_WIDTH-1:0] east_data_o_east_1_whgt;
	logic east_enable_o_east_1_whgt;

	
	
	router_network4 
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	network_wght
		(
			.router_mode_west_0(router_mode_west_0_whgt),
			.router_mode_west_1(router_mode_west_1_whgt),
			.router_mode_east_0(router_mode_east_0_whgt),
			.router_mode_east_1(router_mode_east_1_whgt),
			
			
			//WEST 0
			//Source Ports
			.west_data_i_west_0(west_data_i_west_0_whgt),
			.west_enable_i_west_0(west_enable_i_west_0_whgt),
			
			//Destination ports
			.west_data_o_west_0(west_data_o_west_0_whgt),
			.west_enable_o_west_0(west_enable_o_west_0_whgt),
			
			
			
			//WEST 1
			//Source Ports
			.west_data_i_west_1(west_data_i_west_1_whgt),
			.west_enable_i_west_1(west_enable_i_west_1_whgt),
			
			//Destination ports
			.west_data_o_west_1(west_data_o_west_1_whgt),
			.west_enable_o_west_1(west_enable_o_west_1_whgt),
			
			
			
			//EAST 0
			//Source Ports
			.east_data_i_east_0(east_data_i_east_0_whgt),
			.east_enable_i_east_0(east_enable_i_east_0_whgt),
			
			//Destination ports
			.east_data_o_east_0(east_data_o_east_0_whgt),
			.east_enable_o_east_0(east_enable_o_east_0_whgt),
			
			
			//east 1
			//Source Ports
			.east_data_i_east_1(east_data_i_east_1_whgt),
			.east_enable_i_east_1(east_enable_i_east_1_whgt),
			
			//Destination ports
			.east_data_o_east_1(east_data_o_east_1_whgt),
			.east_enable_o_east_1(east_enable_o_east_1_whgt)
			
		);

	
	
	
		///////////////      IACT ROUTER WEST 0      ///////////////////////////////////
	
	logic [3:0] router_mode_west_0_iact;
	
	//Interface with West
	//Source ports
	logic [DATA_WIDTH-1:0] west_data_i_west_0_iact;
	logic west_enable_i_west_0_iact;
	
	//Destination ports
	logic [DATA_WIDTH-1:0] west_data_o_west_0_iact;
	logic west_enable_o_west_0_iact;

	
	
		///////////////      IACT ROUTER WEST 1     ///////////////////////////////////
	
	logic [3:0] router_mode_west_1_iact;
	
	
	//Interface with West
	//Source ports
	logic [DATA_WIDTH-1:0] west_data_i_west_1_iact;
	logic west_enable_i_west_1_iact;
	
	//Destination ports
	logic [DATA_WIDTH-1:0] west_data_o_west_1_iact;
	logic west_enable_o_west_1_iact;

		
			///////////////      IACT ROUTER EAST 0    ///////////////////////////////////
	
	logic [3:0] router_mode_east_0_iact;
	
	
	//Interface with East
	//Source ports
	logic [DATA_WIDTH-1:0] east_data_i_east_0_iact;
	logic east_enable_i_east_0_iact;

	//Destination ports
	logic [DATA_WIDTH-1:0] east_data_o_east_0_iact;
	logic east_enable_o_east_0_iact;

		
		
			///////////////      IACT ROUTER EAST 1     ///////////////////////////////////
	
	logic [3:0] router_mode_east_1_iact;
	
	
	//Interface with East
	//Source ports
	logic [DATA_WIDTH-1:0] east_data_i_east_1_iact;
	logic east_enable_i_east_1_iact;

	//Destination ports
	logic [DATA_WIDTH-1:0] east_data_o_east_1_iact;
	logic east_enable_o_east_1_iact;

	
	
	router_network4 
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	network_iact
		(
			.router_mode_west_0(router_mode_west_0_iact),
			.router_mode_west_1(router_mode_west_1_iact),
			.router_mode_east_0(router_mode_east_0_iact),
			.router_mode_east_1(router_mode_east_1_iact),
			
			
			//WEST 0
			//Source Ports
			.west_data_i_west_0(west_data_i_west_0_iact),
			.west_enable_i_west_0(west_enable_i_west_0_iact),
			
			//Destination ports
			.west_data_o_west_0(west_data_o_west_0_iact),
			.west_enable_o_west_0(west_enable_o_west_0_iact),
			
			
			
			//WEST 1
			//Source Ports
			.west_data_i_west_1(west_data_i_west_1_iact),
			.west_enable_i_west_1(west_enable_i_west_1_iact),
			
			//Destination ports
			.west_data_o_west_1(west_data_o_west_1_iact),
			.west_enable_o_west_1(west_enable_o_west_1_iact),
			
			
			
			//EAST 0
			//Source Ports
			.east_data_i_east_0(east_data_i_east_0_iact),
			.east_enable_i_east_0(east_enable_i_east_0_iact),
			
			//Destination ports
			.east_data_o_east_0(east_data_o_east_0_iact),
			.east_enable_o_east_0(east_enable_o_east_0_iact),
			
			
			//east 1
			//Source Ports
			.east_data_i_east_1(east_data_i_east_1_iact),
			.east_enable_i_east_1(east_enable_i_east_1_iact),
			
			//Destination ports
			.east_data_o_east_1(east_data_o_east_1_iact),
			.east_enable_o_east_1(east_enable_o_east_1_iact)
			
		);
		
		
	
	logic clk, reset;
	
	
	/////// INST PE CLUSTER
	parameter ADDR_WIDTH = 9;
    
    parameter int X_dim = 3;
    parameter int Y_dim = 3;
    
    parameter int kernel_size = 3;
    parameter int act_size = 5;
		
//    logic [DATA_WIDTH-1:0] act_in;
//    logic [DATA_WIDTH-1:0] filt_in;

	logic start;
	logic load_en_wght, load_en_iact;
  
	logic compute_done;
	logic load_done;
	
	
	logic [DATA_WIDTH-1:0] pe_out[X_dim-1:0];
	logic [DATA_WIDTH-1:0] pe_out_west_0[X_dim-1:0];
	logic [DATA_WIDTH-1:0] pe_out_west_1[X_dim-1:0];
	logic [DATA_WIDTH-1:0] pe_out_east_0[X_dim-1:0];
	logic [DATA_WIDTH-1:0] pe_out_east_1[X_dim-1:0];
	
	// PE CLUSTER WEST 0	
	PE_cluster #(
					.DATA_WIDTH(DATA_WIDTH),
					.ADDR_WIDTH(ADDR_WIDTH),
					
					.kernel_size(kernel_size),
					.act_size(act_size),
					
					.X_dim(X_dim),
					.Y_dim(Y_dim)
    			)
	pe_cluster_west_0
    			(
					.clk(clk),
				    .reset(reset),
					
				    .act_in(network_iact.west_data_o_west_0),
				    .filt_in(network_wght.west_data_o_west_0),
					
					.load_en_wght(load_en_wght),
					.load_en_act(load_en_iact),
					
					.start(start),
                    .pe_out(pe_out_west_0),
					.compute_done(compute_done),
					.load_done(load_done)
    			);
		
	
	// PE CLUSTER WEST 1
	PE_cluster #(
					.DATA_WIDTH(DATA_WIDTH),
					.ADDR_WIDTH(ADDR_WIDTH),
					
					.kernel_size(kernel_size),
					.act_size(act_size),
					
					.X_dim(X_dim),
					.Y_dim(Y_dim)
    			)
	pe_cluster_west_1
    			(
					.clk(clk),
				    .reset(reset),
					
				    .act_in(network_iact.west_data_o_west_1),
				    .filt_in(network_wght.west_data_o_west_1),
					
					.load_en_wght(load_en_wght),
					.load_en_act(load_en_iact),
					
					.start(start),
                    .pe_out(pe_out_west_1),
					.compute_done(),
					.load_done()
    			);
				
	
	// PE CLUSTER EAST 0
	PE_cluster #(
					.DATA_WIDTH(DATA_WIDTH),
					.ADDR_WIDTH(ADDR_WIDTH),
					
					.kernel_size(kernel_size),
					.act_size(act_size),
					
					.X_dim(X_dim),
					.Y_dim(Y_dim)
    			)
	pe_cluster_east_0
    			(
					.clk(clk),
				    .reset(reset),
					
				    .act_in(network_iact.east_data_o_east_0),
				    .filt_in(network_wght.east_data_o_east_0),
					
					.load_en_wght(load_en_wght),
					.load_en_act(load_en_iact),
					
					.start(start),
                    .pe_out(pe_out_east_0),
					.compute_done(),
					.load_done()
    			);
				
			
	// PE CLUSTER EAST 1	
	PE_cluster #(
					.DATA_WIDTH(DATA_WIDTH),
					.ADDR_WIDTH(ADDR_WIDTH),
					
					.kernel_size(kernel_size),
					.act_size(act_size),
					
					.X_dim(X_dim),
					.Y_dim(Y_dim)
    			)
	pe_cluster_east_1
    			(
					.clk(clk),
				    .reset(reset),
					
				    .act_in(network_iact.east_data_o_east_1),
				    .filt_in(network_wght.east_data_o_east_1),
					
					.load_en_wght(load_en_wght),
					.load_en_act(load_en_iact),
					
					.start(start),
                    .pe_out(pe_out_east_1),
					.compute_done(),
					.load_done()
    			);
		
/* 	logic [DATA_WIDTH-1:0] temp;
	assign temp = wght_router_east_0.south_data_o;
	
	logic temp_en;
	assign temp_en = wght_router_east_0.south_enable_o; */
	
		
/* 	initial begin
		for(int i=0; i<20; i++) begin
			west_data_i_west_0 = i;
//			south_data_i = i*2;
//			west_data_i = i*5;
//			east_data_i = i*100;
			#50;
		end
	end */
	
	
	integer clk_prd = 10;
	logic [DATA_WIDTH-1:0] cluster_out_1[0:8];
	
	always begin
		clk = 0; #(clk_prd/2);
		clk = 1; #(clk_prd/2);
		//0.1GHz
	end
	
	
	enum logic [3:0] {ALL=0, NORTH=1, SOUTH=2, WEST=3, EAST=4,
						EASTNORTH=5, EASTSOUTH=6, EASTWEST=7,
						WESTNORTH=8, WESTSOUTH=9, WESTEAST=10} direction;
	
	initial begin
	
		reset = 1; #30;
		reset = 0;
		start = 0;
		
		
		router_mode_west_0_whgt = ALL;

		router_mode_east_0_whgt = EASTSOUTH;
		
		router_mode_west_1_whgt = WEST;
		
		router_mode_east_1_whgt = EAST;
		
		

		#100;
		
		$display("\n\nLoading Begins: Weights.....\n\n");
		
		load_en_wght = 1;
		west_enable_i_west_0_whgt = 1;
		
		for(int i=0; i<kernel_size**2; i++) begin
			west_data_i_west_0_whgt = i+1;
			#(clk_prd);
			load_en_wght = 0;
		end
		
		
		
		
		
		router_mode_east_0_iact = EAST;
		router_mode_east_1_iact = EAST;
		
		router_mode_west_0_iact = WEST;
		router_mode_west_1_iact = WEST;
		
		#100;
		
		$display("\n\nLoading Begins: Iacts.....\n\n");
		
		load_en_iact = 1;
		
		east_enable_i_east_0_iact = 1;
		east_enable_i_east_1_iact = 1;
		
		west_enable_i_west_0_iact = 1;
		west_enable_i_west_1_iact = 1;
		
		for(int i=1; i<act_size**2+1; i++) begin
			east_data_i_east_0_iact = i;
			east_data_i_east_1_iact = i+2;
			west_data_i_west_0_iact = i*5;
			west_data_i_west_1_iact = i+3;
			#(clk_prd);
			load_en_iact = 0;
		end
		
		
		
		
		#50;
		
		assign pe_out = pe_out_east_0;
		
		start = 1; #25; 
		$display("\n\nReading & Computing Begins.....\n\n");
		start = 0;
		
		wait (compute_done == 1);
		
		$display("\n\nFinal PSUM of Iteration 1");
 		for(int i=0; i<X_dim; i++) begin
			cluster_out_1[i] = pe_out[X_dim-i-1];
			$display("\npsum from column %d is:%d",i+1,pe_out[X_dim-i-1]);
		end
		
		
		#40;
		start = 1; #25; 
		$display("\n\nReading & Computing Begins for iter 2.....\n\n");
		start = 0;
		
				wait (compute_done == 1);	
		$display("\n\nFinal PSUM of Iteration 2:");
 		for(int i=0; i<X_dim; i++) begin
			cluster_out_1[i+3] = pe_out[X_dim-i-1];
			$display("\npsum from column %d is:%d",i+1,pe_out[X_dim-i-1]);
		end
		
		#40;
		start = 1; #25; 
		$display("\n\nReading & Computing Begins for iter 3.....\n\n");
		start = 0;
		
		wait (compute_done == 1);	
		$display("\n\nFinal PSUM of Iteration 3:");
 		for(int i=0; i<X_dim; i++) begin
		cluster_out_1[i+6] = pe_out[X_dim-i-1];
			$display("\npsum from column %d is:%d",i+1,pe_out[X_dim-i-1]);
		end
		 
		
		$display("\tFinal psums of Cluster 1:\n");
		for(int a=0; a<kernel_size**2; a++) begin
			$display("\t\t %d \n",cluster_out_1[a]);
		end
		
		$display("\tTotal #cycles taken: %d",cycles);
		$stop;
		
		
	end 
	
		int cycles;
		// track # of cycles
	always @(posedge clk)
	begin
		if (reset)
			cycles = 0;
		else
			cycles = cycles + 1;
	end


endmodule
