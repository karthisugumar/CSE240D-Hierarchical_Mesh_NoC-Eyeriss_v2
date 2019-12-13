`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 11:53:15 PM
// Design Name: 
// Module Name: router_east_tb
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


module router_east_tb();

	parameter DATA_WIDTH = 16;
	
	logic [2:0] router_mode;
	
	//Interface with North
	//Source ports
	logic [DATA_WIDTH-1:0] north_data_i;
	logic north_enable_i;
	logic  north_ready_o;
	
	//Destination ports
	logic  [DATA_WIDTH-1:0] north_data_o;
	logic  north_enable_o;
	logic north_ready_i;
	
	
	//Interface with South
	//Source ports
	logic [DATA_WIDTH-1:0] south_data_i;
	logic south_enable_i;
	logic  south_ready_o;
	
	//Destination ports
	logic [DATA_WIDTH-1:0] south_data_o;
	logic south_enable_o;
	logic south_ready_i;
	
	
	//Interface with West
	//Source ports
	logic [DATA_WIDTH-1:0] west_data_i;
	logic west_enable_i;
	logic  west_ready_o;
	
	//Destination ports
	logic  [DATA_WIDTH-1:0] west_data_o;
	logic  west_enable_o;
    logic west_ready_i;

    //Interface with East - Devices
    //Source ports
    logic [DATA_WIDTH-1:0] east_data_i;
    logic east_enable_i;
    logic  east_ready_o;
    
    //Destination ports
    logic  [DATA_WIDTH-1:0] east_data_o;
    logic  east_enable_o;
    logic east_ready_i;
	
	
	//Other logic

	//Instantiation
	
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
			.north_ready_o(north_ready_o),
			
			//Destination ports
			.north_data_o(north_data_o),
			.north_enable_o(north_enable_o),
			.north_ready_i(north_ready_i),
			
			
			//Interface with South
			//Source ports
			.south_data_i(south_data_i),
			.south_enable_i(south_enable_i),
			.south_ready_o(south_ready_o),
			
			//Destination ports
			.south_data_o(south_data_o),
			.south_enable_o(south_enable_o),
			.south_ready_i(south_ready_i),
			
			//Interface with West
			//Source ports
			.west_data_i(west_data_i),
			.west_enable_i(west_enable_i),
			.west_ready_o(west_ready_o),
			
			//Destination ports
			.west_data_o(west_data_o),
			.west_enable_o(west_enable_o),
			.west_ready_i(west_ready_i),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i(east_data_i),
			.east_enable_i(east_enable_i),
			.east_ready_o(east_ready_o),
	        
			//Destination ports
	        .east_data_o(east_data_o),
            .east_enable_o(east_enable_o),
            .east_ready_i(east_ready_i)
	);
	
	initial begin
		for(int i=0; i<20; i++) begin
			north_data_i = i;
			south_data_i = i*2;
			west_data_i = i*5;
			east_data_i = i*100;
			#50;
		end
	end
	
	enum logic [2:0] {ALL=0, NORTH=1, SOUTH=2, WEST=3, EAST=4} direction;
	
	initial begin
		router_mode = ALL;
		north_enable_i = 1;
		#100;
		
		router_mode = SOUTH;
		east_enable_i = 1;
		north_enable_i = 0;
		#100;
		
		router_mode = EAST;
		east_enable_i = 1;
		north_enable_i = 0;
		#100;
		
		router_mode = WEST;
		east_enable_i = 1;
		north_enable_i = 0;
		#100;
	end
	
endmodule