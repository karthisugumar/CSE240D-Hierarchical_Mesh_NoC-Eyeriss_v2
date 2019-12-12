`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2019 05:07:36 PM
// Design Name: 
// Module Name: router_broadcast_tb
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


module router_broadcast_tb();

	parameter DATA_WIDTH = 16;
	
	
	///////////////      ROUTER WEST 0      ///////////////////////////////////
	
	logic [3:0] router_mode_west_0;
	
	
	//Interface with North
	//Source ports
	logic [DATA_WIDTH-1:0] north_data_i_west_0;
	logic north_enable_i_west_0;

	//Destination ports
	logic [DATA_WIDTH-1:0] north_data_o_west_0;
	logic north_enable_o_west_0;

	
	
	//Interface with South
	//Source ports
	logic [DATA_WIDTH-1:0] south_data_i_west_0;
	logic south_enable_i_west_0;

	//Destination ports
	logic [DATA_WIDTH-1:0] south_data_o_west_0;
	logic south_enable_o_west_0;

	
	
	//Interface with West
	//Source ports
 logic [DATA_WIDTH-1:0] west_data_i_west_0;
	logic west_enable_i_west_0;
	
	//Destination ports
	logic [DATA_WIDTH-1:0] west_data_o_west_0;
	logic west_enable_o_west_0;

	
	
	//Interface with East
	//Source ports
//	logic [DATA_WIDTH-1:0] east_data_i_west_0;
//	logic east_enable_i_west_0;

	//Destination ports
//	logic [DATA_WIDTH-1:0] east_data_o_west_0;
//	logic east_enable_o_west_0;

	
	
	router 
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_west_0
		(
			.router_mode(router_mode_west_0),
			
			
			//Interface with North
			//Source ports
			.north_data_i(north_data_i_west_0),
			.north_enable_i(north_enable_i_west_0),
			
			//Destination ports
			.north_data_o(north_data_o_west_0),
			.north_enable_o(north_enable_o_west_0),
			
			
			//Interface with South
			//Source ports
			.south_data_i(south_data_i_west_0),
			.south_enable_i(south_enable_i_west_0),
			
			//Destination ports
			.south_data_o(south_data_o_west_0),
			.south_enable_o(south_enable_o_west_0),
			
			
			//Interface with West
			//Source ports
			.west_data_i(west_data_i_west_0),
			.west_enable_i(west_enable_i_west_0),
			
			//Destination ports
			.west_data_o(west_data_0_west_0),
			.west_enable_o(west_enable_o_west_0),
			
			
			//Interface with East
			//Source ports
			.east_data_i(router_east_0.west_data_o),
			.east_enable_i(router_east_0.west_enable_o),
	        
			//Destination ports
	        .east_data_o(router_east_0.west_data_i),
            .east_enable_o(router_east_0.west_enable_i)
		);
	
	
	
	///////////////      ROUTER EAST 0      ///////////////////////////////////
		
		
	logic [3:0] router_mode_east_0;
	

	//Interface with North
	//Source ports
	logic [DATA_WIDTH-1:0] north_data_i_east_0;
	logic north_enable_i_east_0;

	//Destination ports
	logic [DATA_WIDTH-1:0] north_data_o_east_0;
	logic north_enable_o_east_0;

	
	
	//Interface with South
	//Source ports
	logic [DATA_WIDTH-1:0] south_data_i_east_0;
	logic south_enable_i_east_0;

	//Destination ports
	logic [DATA_WIDTH-1:0] south_data_o_east_0;
	logic south_enable_o_east_0;

	
	
	//Interface with West
	//Source ports
//	logic [DATA_WIDTH-1:0] west_data_i_east_0;
//	logic west_enable_i_east_0;
	
	//Destination ports
//	logic [DATA_WIDTH-1:0] west_data_o_east_0;
//	logic west_enable_o_east_0;

	
	
	//Interface with East
	//Source ports
	logic [DATA_WIDTH-1:0] east_data_i_east_0;
	logic east_enable_i_east_0;

	//Destination ports
	logic [DATA_WIDTH-1:0] east_data_o_east_0;
	logic east_enable_o_east_0;

	
	
	router 
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_east_0
		(
			.router_mode(router_mode_east_0),
			
			
			//Interface with North
			//Source ports
			.north_data_i(north_data_i_east_0),
			.north_enable_i(north_enable_i_east_0),
			
			//Destination ports
			.north_data_o(north_data_o_east_0),
			.north_enable_o(north_enable_o_east_0),
			
			
			//Interface with South
			//Source ports
			.south_data_i(south_data_i_east_0),
			.south_enable_i(south_enable_i_east_0),
			
			//Destination ports
			.south_data_o(south_data_o_east_0),
			.south_enable_o(south_enable_o_east_0),
			
			
			//Interface with West
			//Source ports
			.west_data_i(router_west_0.east_data_o),
			.west_enable_i(router_west_0.east_enable_o),
			
			//Destination ports
			.west_data_o(router_west_0.east_data_i),
			.west_enable_o(router_west_0.east_enable_i),
			
			
			//Interface with East
			//Source ports
			.east_data_i(east_data_i_east_0),
			.east_enable_i(east_enable_i_east_0),
	        
			//Destination ports
	        .east_data_o(east_data_o_east_0),
            .east_enable_o(east_enable_o_east_0)
		);
		
 	initial begin
		for(int i=0; i<20; i++) begin
			north_data_i_west_0 = i;
//			south_data_i = i*2;
//			west_data_i = i*5;
//			east_data_i = i*100;
			#50;
		end
	end
	
	enum logic [3:0] {ALL=0, NORTH=1, SOUTH=2, WEST=3, EAST=4,
						EASTNORTH=5, EASTSOUTH=6, EASTWEST=7,
						WESTNORTH=8, WESTSOUTH=9, WESTEAST=10} direction;
	
	initial begin
		router_mode_west_0 = EASTSOUTH;
		north_enable_i_west_0 = 1;

		#100;
		router_mode_east_0 = SOUTH;
		
		#100;
		router_mode_east_0 = EASTNORTH;
		
		#100;
		router_mode_east_0 = NORTH;
		
		#100;
		router_mode_east_0 = EASTSOUTH;
		
	end 
	
endmodule