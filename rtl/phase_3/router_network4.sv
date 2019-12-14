`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2019 05:43:25 AM
// Design Name: 
// Module Name: router_network4
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


module router_network4
	#(
		parameter DATA_WIDTH = 16
	)
	(
	
	
		///////////////      ROUTER WEST 0      ///////////////////////////////////

	input [3:0] router_mode_west_0,
	
	//Interface with West
	//Source ports
	input [DATA_WIDTH-1:0] west_data_i_west_0,
	input west_enable_i_west_0,
	
	//Destination ports
	output [DATA_WIDTH-1:0] west_data_o_west_0,
	output west_enable_o_west_0,


	
		
		///////////////      ROUTER WEST 1     ///////////////////////////////////
	
	input [3:0] router_mode_west_1,
	
	
	//Interface with West
	//Source ports
	input [DATA_WIDTH-1:0] west_data_i_west_1,
	input west_enable_i_west_1,
	
	//Destination ports
	output [DATA_WIDTH-1:0] west_data_o_west_1,
	output west_enable_o_west_1,

	
	
	
		///////////////      ROUTER EAST 0    ///////////////////////////////////
	
	input [3:0] router_mode_east_0,
	
	
	//Interface with East
	//Source ports
	input [DATA_WIDTH-1:0] east_data_i_east_0,
	input east_enable_i_east_0,

	//Destination ports
	output [DATA_WIDTH-1:0] east_data_o_east_0,
	output east_enable_o_east_0,
	
	
		///////////////      ROUTER EAST 1     ///////////////////////////////////
	
	input [3:0] router_mode_east_1,
	
	
	//Interface with East
	//Source ports
	input [DATA_WIDTH-1:0] east_data_i_east_1,
	input east_enable_i_east_1,

	//Destination ports
	output [DATA_WIDTH-1:0] east_data_o_east_1,
	output east_enable_o_east_1


	);


	
	router 
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_west_0
		(
			.router_mode(router_mode_west_0),
			
			
			//Interface with North
			//Source ports
			.north_data_i(),
			.north_enable_i(),
			
			//Destination ports
			.north_data_o(),
			.north_enable_o(),
			
			
			//Interface with South
			//Source ports
			.south_data_i(router_west_1.north_data_o),
			.south_enable_i(router_west_1.north_enable_o),
			
			//Destination ports
			.south_data_o(router_west_1.north_data_i),
			.south_enable_o(router_west_1.north_enable_i),
			
			
			//Interface with West
			//Source ports
			.west_data_i(west_data_i_west_0),
			.west_enable_i(west_enable_i_west_0),
			
			//Destination ports
			.west_data_o(west_data_o_west_0),
			.west_enable_o(west_enable_o_west_0),
			
			
			//Interface with East
			//Source ports
			.east_data_i(router_east_0.west_data_o),
			.east_enable_i(router_east_0.west_enable_o),
	        
			//Destination ports
	        .east_data_o(router_east_0.west_data_i),
            .east_enable_o(router_east_0.west_enable_i)
		);
	
	

	
	router 
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_west_1
		(
			.router_mode(router_mode_west_1),
			
			
			//Interface with North
			//Source ports
			.north_data_i(router_west_0.south_data_o),
			.north_enable_i(router_west_0.south_enable_o),
			
			//Destination ports
			.north_data_o(router_west_0.south_data_i),
			.north_enable_o(router_west_0.south_enable_i),
			
			
			//Interface with South
			//Source ports
			.south_data_i(),
			.south_enable_i(),
			
			//Destination ports
			.south_data_o(),
			.south_enable_o(),
			
			
			//Interface with West
			//Source ports
			.west_data_i(west_data_i_west_1),
			.west_enable_i(west_enable_i_west_1),
			
			//Destination ports
			.west_data_o(west_data_o_west_1),
			.west_enable_o(west_enable_o_west_1),
			
			
			//Interface with East
			//Source ports
			.east_data_i(router_east_1.west_data_o),
			.east_enable_i(router_east_1.west_enable_o),
	        
			//Destination ports
	        .east_data_o(router_east_1.west_data_i),
            .east_enable_o(router_east_1.west_enable_i)
		);
		
	
	

	
	
	router 
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_east_0
		(
			.router_mode(router_mode_east_0),
			
			
			//Interface with North
			//Source ports
			.north_data_i(),
			.north_enable_i(),
			
			//Destination ports
			.north_data_o(),
			.north_enable_o(),
			
			
			//Interface with South
			//Source ports
			.south_data_i(router_east_1.north_data_o),
			.south_enable_i(router_east_1.north_enable_o),
			
			//Destination ports
			.south_data_o(router_east_1.north_data_i),
			.south_enable_o(router_east_1.north_enable_i),
			
			
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
		
		
		

	router 
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_east_1
		(
			.router_mode(router_mode_east_1),
			
			
			//Interface with North
			//Source ports
			.north_data_i(router_east_0.south_data_o),
			.north_enable_i(router_east_0.south_enable_o),
			
			//Destination ports
			.north_data_o(router_east_0.south_data_i),
			.north_enable_o(router_east_0.south_enable_i),
			
			
			//Interface with South
			//Source ports
			.south_data_i(),
			.south_enable_i(),
			
			//Destination ports
			.south_data_o(),
			.south_enable_o(),
			
			
			//Interface with West
			//Source ports
			.west_data_i(router_west_1.east_data_o),
			.west_enable_i(router_west_1.east_enable_o),
			
			//Destination ports
			.west_data_o(router_west_1.east_data_i),
			.west_enable_o(router_west_1.east_enable_i),
			
			
			//Interface with East
			//Source ports
			.east_data_i(east_data_i_east_1),
			.east_enable_i(east_enable_i_east_1),
	        
			//Destination ports
	        .east_data_o(east_data_o_east_1),
            .east_enable_o(east_enable_o_east_1)
		);
		
endmodule
