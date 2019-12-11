`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 02:24:04 PM
// Design Name: 
// Module Name: router_cluster
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


module router_cluster	
	#(
		parameter DATA_WIDTH = 16
	)
	(
	
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
		input [DATA_WIDTH-1:0] west_data_i_wght,
		input west_enable_i_wght,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] west_data_o_wght,
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
		input [DATA_WIDTH-1:0] west_data_i_iact,
		input west_enable_i_iact,
		
		//Destination ports
		output logic [DATA_WIDTH-1:0] west_data_o_iact,
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
	
	
	
	router
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_wght
		(
			.router_mode(router_mode_wght),
			
			//Interface with North
			//Source ports
			.north_data_i(north_data_i_wght),
			.north_enable_i(north_enable_i_wght),
			
			//Destination ports
			.north_data_o(north_data_o_wght),
			.north_enable_o(north_enable_o_wght),
			
			
			//Interface with South
			//Source ports
			.south_data_i(south_data_i_wght),
			.south_enable_i(south_enable_i_wght),
			
			//Destination ports
			.south_data_o(south_data_o_wght),
			.south_enable_o(south_enable_o_wght),
			
			
			//Interface with West
			//Source ports
			.west_data_i(west_data_i_wght),
			.west_enable_i(west_enable_i_wght),
			
			//Destination ports
			.west_data_o(west_data_o_wght),
			.west_enable_o(west_enable_o_wght),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i(east_data_i_wght),
			.east_enable_i(east_enable_i_wght),
	        
			//Destination ports
	        .east_data_o(east_data_o_wght),
            .east_enable_o(east_enable_o_wght)
	);
	
	
	router
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_iact
		(
			.router_mode(router_mode_iact),
			
			//Interface with North
			//Source ports
			.north_data_i(north_data_i_iact),
			.north_enable_i(north_enable_i_iact),
			
			//Destination ports
			.north_data_o(north_data_o_iact),
			.north_enable_o(north_enable_o_iact),
			
			
			//Interface with South
			//Source ports
			.south_data_i(south_data_i_iact),
			.south_enable_i(south_enable_i_iact),
			
			//Destination ports
			.south_data_o(south_data_o_iact),
			.south_enable_o(south_enable_o_iact),
			
			
			//Interface with West
			//Source ports
			.west_data_i(west_data_i_iact),
			.west_enable_i(west_enable_i_iact),
			
			//Destination ports
			.west_data_o(west_data_o_iact),
			.west_enable_o(west_enable_o_iact),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i(east_data_i_iact),
			.east_enable_i(east_enable_i_iact),
	        
			//Destination ports
	        .east_data_o(east_data_o_iact),
            .east_enable_o(east_enable_o_iact)
	);
	
	
	router
		#(
			.DATA_WIDTH(DATA_WIDTH)
		)
	router_psum
		(
			.router_mode(router_mode_psum),
			
			//Interface with North
			//Source ports
			.north_data_i(north_data_i_psum),
			.north_enable_i(north_enable_i_psum),
			
			//Destination ports
			.north_data_o(north_data_o_psum),
			.north_enable_o(north_enable_o_psum),
			
			
			//Interface with South
			//Source ports
			.south_data_i(south_data_i_psum),
			.south_enable_i(south_enable_i_psum),
			
			//Destination ports
			.south_data_o(south_data_o_psum),
			.south_enable_o(south_enable_o_psum),
			
			
			//Interface with West
			//Source ports
			.west_data_i(west_data_i_psum),
			.west_enable_i(west_enable_i_psum),
			
			//Destination ports
			.west_data_o(west_data_o_psum),
			.west_enable_o(west_enable_o_psum),
			
			
			//Interface with East - Devices
			//Source ports
			.east_data_i(east_data_i_psum),
			.east_enable_i(east_enable_i_psum),
	        
			//Destination ports
	        .east_data_o(east_data_o_psum),
            .east_enable_o(east_enable_o_psum)
	);
	
	
endmodule
