`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2019 03:55:23 AM
// Design Name: 
// Module Name: router_cluster_new_tb
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


module router_cluster_new_tb();

	parameter DATA_WIDTH = 16;
	
	
//Logic for WGHTs
	
	logic [3:0] router_mode_wght;
	
	//Interface with North
	//Source ports
	logic [DATA_WIDTH-1:0] north_data_i_wght;
	logic north_enable_i_wght;

	//Destination ports
	logic  [DATA_WIDTH-1:0] north_data_o_wght;
	logic  north_enable_o_wght;
	
	
	//Interface with South
	//Source ports
	logic [DATA_WIDTH-1:0] south_data_i_wght;
	logic south_enable_i_wght;
	
	//Destination ports
	logic [DATA_WIDTH-1:0] south_data_o_wght;
	logic south_enable_o_wght;
	
	
	//Interface with West
	//Source ports
	logic [DATA_WIDTH-1:0] west_data_i_wght;
	logic west_enable_i_wght;
	
	//Destination ports
	logic  [DATA_WIDTH-1:0] west_data_o_wght;
	logic  west_enable_o_wght;
	

    //Interface with East - Devices
    //Source ports
    logic [DATA_WIDTH-1:0] east_data_i_wght;
    logic east_enable_i_wght;

    //Destination ports
    logic  [DATA_WIDTH-1:0] east_data_o_wght;
    logic  east_enable_o_wght;
	
	
//Logic for IACTs
	logic [3:0] router_mode_iact;
	
	//Interface with North
	//Source ports
	logic [DATA_WIDTH-1:0] north_data_i_iact;
	logic north_enable_i_iact;

	//Destination ports
	logic  [DATA_WIDTH-1:0] north_data_o_iact;
	logic  north_enable_o_iact;
	
	
	//Interface with South
	//Source ports
	logic [DATA_WIDTH-1:0] south_data_i_iact;
	logic south_enable_i_iact;
	
	//Destination ports
	logic [DATA_WIDTH-1:0] south_data_o_iact;
	logic south_enable_o_iact;
	
	
	//Interface with West
	//Source ports
	logic [DATA_WIDTH-1:0] west_data_i_iact;
	logic west_enable_i_iact;
	
	//Destination ports
	logic  [DATA_WIDTH-1:0] west_data_o_iact;
	logic  west_enable_o_iact;
	

    //Interface with East - Devices
    //Source ports
    logic [DATA_WIDTH-1:0] east_data_i_iact;
    logic east_enable_i_iact;

    //Destination ports
    logic  [DATA_WIDTH-1:0] east_data_o_iact;
    logic  east_enable_o_iact;
	
	
//Logic for PSUM
	
	logic [3:0] router_mode_psum;
	
	//Interface with North
	//Source ports
	logic [DATA_WIDTH-1:0] north_data_i_psum;
	logic north_enable_i_psum;

	//Destination ports
	logic  [DATA_WIDTH-1:0] north_data_o_psum;
	logic  north_enable_o_psum;
	
	
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
	logic  [DATA_WIDTH-1:0] west_data_o_psum;
	logic  west_enable_o_psum;
	

    //Interface with East - Devices
    //Source ports
    logic [DATA_WIDTH-1:0] east_data_i_psum;
    logic east_enable_i_psum;

    //Destination ports
    logic  [DATA_WIDTH-1:0] east_data_o_psum;
    logic  east_enable_o_psum;
	
	
	//Other logic
	//Instantiation
	enum logic [3:0] {ALL=0, NORTH=1, SOUTH=2, WEST=3, EAST=4,
						EASTNORTH=5, EASTSOUTH=6, EASTWEST=7,
						WESTNORTH=8, WESTSOUTH=9, WESTEAST=10} direction;
	
	router_cluster
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_cluster_0
		(
		
		//Ports for WGHT router
			.router_mode_wght(router_mode_wght),
			
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
			.west_data_i_wght(GLB_cluster_0.r_data_wght),
			.west_enable_i_wght(west_enable_i_wght),
			
			//Destination ports
			.west_data_o_wght(west_data_o_wght),
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
			.router_mode_iact(router_mode_iact),
			
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
			.west_data_i_iact(GLB_cluster_0.r_data_iact),
			.west_enable_i_iact(west_enable_i_iact),
			
			//Destination ports
			.west_data_o_iact(west_data_o_iact),
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
			.west_data_i_psum(west_data_i_psum),
			.west_enable_i_psum(west_enable_i_psum),
			
			//Destination ports
			.west_data_o_psum(GLB_cluster_0.w_data_psum),
			.west_enable_o_psum(GLB_cluster_0.write_en_psum),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i_psum(east_data_i_psum),
			.east_enable_i_psum(east_enable_i_psum),
	        
			//Destination ports
	        .east_data_o_psum(east_data_o_psum),
            .east_enable_o_psum(east_enable_o_psum)	
	);
	
	
    parameter DATA_BITWIDTH = 16;
	parameter ADDR_BITWIDTH = 10;
    parameter NUM_GLB_IACT = 1;
    parameter NUM_GLB_PSUM = 1;
	parameter NUM_GLB_WGHT = 1;
	
    logic clk;
    logic reset;

    logic read_req_iact; //[NUM_GLB_IACT-1:0];
	logic read_req_psum; //[NUM_GLB_PSUM-1:0];
	logic read_req_wght; //[NUM_GLB_WGHT-1:0];
	                    //
    logic write_en_iact; //[NUM_GLB_IACT-1:0];
	logic write_en_psum; //[NUM_GLB_PSUM-1:0];
	logic write_en_wght; //[NUM_GLB_WGHT-1:0];
	
    logic [ADDR_BITWIDTH-1 : 0] r_addr_iact; //[NUM_GLB_IACT-1:0];
    logic [ADDR_BITWIDTH-1 : 0] r_addr_psum; //[NUM_GLB_PSUM-1:0];
	logic [ADDR_BITWIDTH-1 : 0] r_addr_wght; //[NUM_GLB_WGHT-1:0];
	                                        //
    logic [ADDR_BITWIDTH-1 : 0] w_addr_iact; //[NUM_GLB_IACT-1:0];
    logic [ADDR_BITWIDTH-1 : 0] w_addr_psum; //[NUM_GLB_PSUM-1:0];
	logic [ADDR_BITWIDTH-1 : 0] w_addr_wght; //[NUM_GLB_WGHT-1:0];
	                                        //
    logic [DATA_BITWIDTH-1 : 0] w_data_iact; //[NUM_GLB_IACT-1:0];
    logic [DATA_BITWIDTH-1 : 0] w_data_psum; //[NUM_GLB_PSUM-1:0];
	logic [DATA_BITWIDTH-1 : 0] w_data_wght; //[NUM_GLB_WGHT-1:0];
	                                        //
    logic [DATA_BITWIDTH-1 : 0] r_data_iact; //[NUM_GLB_IACT-1:0];
    logic [DATA_BITWIDTH-1 : 0] r_data_psum; //[NUM_GLB_PSUM-1:0];
//    logic [DATA_BITWIDTH-1 : 0] r_data_wght[NUM_GLB_WGHT-1:0];

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
				.write_en_psum(router_cluster_0.west_enable_o_psum),
				.write_en_wght(write_en_wght),
				
				.r_addr_iact(r_addr_iact),
			    .r_addr_psum(r_addr_psum),
				.r_addr_wght(r_addr_wght),

			    .w_addr_iact(w_addr_iact),
			    .w_addr_psum(w_addr_psum),
				.w_addr_wght(w_addr_wght),

			    .w_data_iact(w_data_iact),
			    .w_data_psum(router_cluster_0.west_data_o_psum),
				.w_data_wght(w_data_wght),

			    .r_data_iact(router_cluster_0.west_data_i_iact),
			    .r_data_psum(r_data_psum),
				.r_data_wght(router_cluster_0.west_data_i_wght)
			);

	
	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	
	initial begin
		reset = 1; #30;
		reset = 0;
	
		write_en_iact = 1;
		write_en_psum = 1;
		write_en_wght = 1;
		
		for(int i=0; i<25; i++) begin
			w_addr_iact = i;
			w_data_iact = i*2;

/* 			w_addr_psum = i;
			w_data_psum = i; */
			
			w_addr_wght = i;
			w_data_wght = i*3;
			
			#20;
		end
		
		write_en_iact = 0;
		write_en_psum = 0;
		write_en_wght = 0;
		
		for(int i=0; i<2; i++) begin
			w_addr_iact = i;
			w_data_iact = i*200;

/* 			w_addr_psum = i;
			w_data_psum = i*200; */
			
			w_addr_wght = i;
			w_data_wght = i*200;			
			
			#20;
		end
		
		
/* 		read_req_iact = 1;
		read_req_psum = 1;
		read_req_wght = 1;
		
		west_enable_i_iact = 1;
		router_mode_iact = EAST;
		
		for(int i=0; i<4; i++  ) begin
			r_addr_iact = i;

			r_addr_psum = i;
			
			r_addr_wght = i;
			#20;
		end
		
		west_enable_i_iact = 0;
		west_enable_i_wght = 1;
		router_mode_wght = WESTNORTH;
		
		for(int i=4; i<8; i++  ) begin
			r_addr_iact = i;

			r_addr_psum = i;
			
			r_addr_wght = i;
			#20;
		end
		
		
		west_enable_i_wght = 0;
		west_enable_i_iact = 1;
		router_mode_iact = SOUTH;
		
		for(int i=8; i<12; i++  ) begin
			r_addr_iact = i;

			r_addr_psum = i;
			
			r_addr_wght = i;
			#20;
		end */
		
		
	//	write_en_psum = 1;
		//write_en_wght = 1;
		
		west_enable_i_psum = 1;
		router_mode_psum = WEST;
		#5;
		
		for(int i=0; i<8; i++) begin
			w_addr_psum = i;
			west_data_i_psum = i;
			#20;
		end
		#20;
		
		read_req_iact = 0;
		read_req_psum = 0;
		read_req_wght = 0;
		
		for(int i=0; i<2; i++) begin
			r_addr_iact = i;

			r_addr_psum = i;
			
			r_addr_wght = i;
			
			#20;
		end
		
	end

endmodule
