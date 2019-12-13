`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2019 01:39:48 AM
// Design Name: 
// Module Name: router_glb_tb
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


module router_glb_tb();

	parameter DATA_WIDTH = 16;
	
	logic [3:0] router_mode;
	
	//Interface with North
	//Source ports
	logic [DATA_WIDTH-1:0] north_data_i;
	logic north_enable_i;
//	logic  north_ready_o;
	
	//Destination ports
	logic  [DATA_WIDTH-1:0] north_data_o;
	logic  north_enable_o;
//	logic north_ready_i;
	
	
	//Interface with South
	//Source ports
	logic [DATA_WIDTH-1:0] south_data_i;
	logic south_enable_i;
//	logic  south_ready_o;
	
	//Destination ports
	logic [DATA_WIDTH-1:0] south_data_o;
	logic south_enable_o;
//	logic south_ready_i;
	
	
	//Interface with West
	//Source ports
	logic [DATA_WIDTH-1:0] west_data_i;
	logic west_enable_i;
//	logic  west_ready_o;
	
	//Destination ports
	logic  [DATA_WIDTH-1:0] west_data_o;
	logic  west_enable_o;
 //   logic west_ready_i;

    //Interface with East - Devices
    //Source ports
    logic [DATA_WIDTH-1:0] east_data_i;
    logic east_enable_i;
 //   logic  east_ready_o;
    
    //Destination ports
    logic  [DATA_WIDTH-1:0] east_data_o;
    logic  east_enable_o;
 //  logic east_ready_i;
	
	
	//Other logic

	//Instantiation
		enum logic [3:0] {ALL=0, NORTH=1, SOUTH=2, WEST=3, EAST=4,
						EASTNORTH=5, EASTSOUTH=6, EASTWEST=7,
						WESTNORTH=8, WESTSOUTH=9, WESTEAST=10} direction;
	
	router_east 
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_east_0
		(
			.router_mode(router_mode),
			
			//Interface with North
			//Source ports
			.north_data_i(north_data_i),
			.north_enable_i(north_enable_i),
//			.north_ready_o(north_ready_o),
			
			//Destination ports
			.north_data_o(north_data_o),
			.north_enable_o(north_enable_o),
//			.north_ready_i(north_ready_i),
			
			
			//Interface with South
			//Source ports
			.south_data_i(south_data_i),
			.south_enable_i(south_enable_i),
//			.south_ready_o(south_ready_o),
			
			//Destination ports
			.south_data_o(south_data_o),
			.south_enable_o(south_enable_o),
//			.south_ready_i(south_ready_i),
			
			//Interface with West
			//Source ports
			.west_data_i(west_data_i),
			.west_enable_i(west_enable_i),
	//		.west_ready_o(west_ready_o),
			
			//Destination ports
			.west_data_o(west_data_o),
			.west_enable_o(west_enable_o),
	//		.west_ready_i(west_ready_i),
			
			
			//Interface with East - Devices
			//Source ports
//			.east_data_i(east_data_i),
			.east_data_i(GLB_cluster_0.r_data_wght),
			.east_enable_i(east_enable_i),
	//		.east_ready_o(east_ready_o),
	        
			//Destination ports
	        .east_data_o(east_data_o),
            .east_enable_o(east_enable_o)
     //       .east_ready_i(east_ready_i)
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
				.r_data_wght(east_data_i)
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

			w_addr_psum = i;
			w_data_psum = i;
			
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

			w_addr_psum = i;
			w_data_psum = i*200;
			
			w_addr_wght = i;
			w_data_wght = i*200;			
			
			#20;
		end
		
		
		read_req_iact = 1;
		read_req_psum = 1;
		read_req_wght = 1;
		
		east_enable_i = 1;
		router_mode = EAST;
		
		for(int i=0; i<4; i++  ) begin
			r_addr_iact = i;

			r_addr_psum = i;
			
			r_addr_wght = i;
			#20;
		end
	
		east_enable_i = 1;
		router_mode = NORTH;
		
		for(int i=4; i<8; i++  ) begin
			r_addr_iact = i;

			r_addr_psum = i;
			
			r_addr_wght = i;
			#20;
		end
		
		east_enable_i = 1;
		router_mode = ALL;
		
		for(int i=8; i<12; i++  ) begin
			r_addr_iact = i;

			r_addr_psum = i;
			
			r_addr_wght = i;
			#20;
		end
		
				east_enable_i = 1;
		router_mode = EASTSOUTH;
		
		for(int i=12; i<16; i++  ) begin
			r_addr_iact = i;

			r_addr_psum = i;
			
			r_addr_wght = i;
			#20;
		end
		
				east_enable_i = 1;
		router_mode = EASTWEST;
		
		for(int i=16; i<20; i++  ) begin
			r_addr_iact = i;

			r_addr_psum = i;
			
			r_addr_wght = i;
			#20;
		end
		
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
