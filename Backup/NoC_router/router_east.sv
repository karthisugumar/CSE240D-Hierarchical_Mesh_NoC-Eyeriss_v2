`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 04:48:15 AM
// Design Name: 
// Module Name: router_east
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

//typedef struct packed {
//
//} 

//Defining Names for routing directions
//`define ALL 0
//`define NORTH 1
//`define SOUTH 2
//`define WEST 3
//`define EAST 4


module router_east
	#(
		parameter DATA_WIDTH = 16
	)
	(
		input [3:0] router_mode,
		
		//Interface with North
		//Source ports
		input [DATA_WIDTH-1:0] north_data_i,
		input north_enable_i,
//		output logic north_ready_o,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] north_data_o,
		output logic north_enable_o,
//		input north_ready_i,
		
		
		//Interface with South
		//Source ports
		input [DATA_WIDTH-1:0] south_data_i,
		input south_enable_i,
//		output logic south_ready_o,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] south_data_o,
		output logic south_enable_o,
//		input south_ready_i,
		
		
		//Interface with West
		//Source ports
		input [DATA_WIDTH-1:0] west_data_i,
		input west_enable_i,
//		output logic west_ready_o,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] west_data_o,
		output logic west_enable_o,
//		input west_ready_i,
		
		
		//Interface with East - Devices
		//Source ports
		input [DATA_WIDTH-1:0] east_data_i,
		input east_enable_i,
//		output logic east_ready_o,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] east_data_o,
		output logic east_enable_o
//		input east_ready_i
    );
	
	logic [DATA_WIDTH-1:0] data_out;
	enum logic [3:0] {ALL=0, NORTH=1, SOUTH=2, WEST=3, EAST=4,
						EASTNORTH=5, EASTSOUTH=6, EASTWEST=7,
						WESTNORTH=8, WESTSOUTH=9, WESTEAST=10} direction;
	
	//Logic for selecting data_out based on enable
	always_comb
		begin:data_switch
			unique if(north_enable_i)
				data_out = north_data_i;
			else if(south_enable_i)
				data_out = south_data_i;
			else if(west_enable_i)
				data_out = west_data_i;
			else if(east_enable_i)
				data_out = east_data_i;
			else
				data_out = 10101; //Default value for verification
		end
	
	//Logic for data out in destination ports based on routing_mode
	always_comb
		begin: routing_logic
			case(router_mode)
				ALL:begin
					north_data_o = data_out;
					north_enable_o = 1;
					
					south_data_o = data_out;
					south_enable_o = 1;
					
					west_data_o = data_out;
					west_enable_o = 1;
					
					east_data_o = data_out;
					east_enable_o = 1;
				end
				
				NORTH:begin
					north_data_o = data_out;
					north_enable_o = 1;
					south_enable_o = 0;
					west_enable_o = 0;
					east_enable_o = 0;
				end
				
				SOUTH:begin
					south_data_o = data_out;
					north_enable_o = 0;
					south_enable_o = 1;
					west_enable_o = 0;
					east_enable_o = 0;
				end
				
				WEST:begin
					west_data_o = data_out;
					north_enable_o = 0;
					south_enable_o = 0;
					west_enable_o = 1;
					east_enable_o = 0;
				end
				
				EAST:begin
					east_data_o = data_out;
					north_enable_o = 0;
					south_enable_o = 0;
					west_enable_o = 0;
					east_enable_o = 1;
				end
				
				//Two Directions - Used for storing in PE cluster and routing
				//With East as compute unit
				EASTNORTH:begin
					east_data_o = data_out;
					north_data_o = data_out;
					north_enable_o = 1;
					south_enable_o = 0;
					west_enable_o = 0;
					east_enable_o = 1;
				end
				
				EASTSOUTH:begin
					east_data_o = data_out;
					south_data_o = data_out;
					north_enable_o = 0;
					south_enable_o = 1;
					west_enable_o = 0;
					east_enable_o = 1;
				end
				
				EASTWEST:begin
					east_data_o = data_out;
					west_data_o = data_out;
					north_enable_o = 0;
					south_enable_o = 0;
					west_enable_o = 1;
					east_enable_o = 1;
				end
				
				//With West as compute unit
				WESTNORTH:begin
					west_data_o = data_out;
					north_data_o = data_out;
					north_enable_o = 1;
					south_enable_o = 0;
					west_enable_o = 1;
					east_enable_o = 0;
				end
				
				WESTSOUTH:begin
					west_data_o = data_out;
					south_data_o = data_out;
					north_enable_o = 0;
					south_enable_o = 1;
					west_enable_o = 1;
					east_enable_o = 0;
				end
				
				WESTEAST:begin
					west_data_o = data_out;
					east_data_o = data_out;
					north_enable_o = 0;
					south_enable_o = 0;
					west_enable_o = 1;
					east_enable_o = 1;
				end
			endcase
		end
		
	
	
endmodule
