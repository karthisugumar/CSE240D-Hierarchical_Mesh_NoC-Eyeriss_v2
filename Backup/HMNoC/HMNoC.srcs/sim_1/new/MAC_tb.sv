`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 10:01:40 AM
// Design Name: 
// Module Name: MAC_tb
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

module MAC_tb(

    );
	
	parameter IN_BITWIDTH = 16;
	parameter OUT_BITWIDTH = 2*IN_BITWIDTH;
	
	logic [IN_BITWIDTH-1 : 0] a_in; 
	logic [IN_BITWIDTH-1 : 0] w_in;
	logic [IN_BITWIDTH-1 : 0] sum_in;
	logic [OUT_BITWIDTH-1 : 0] out;
	
	MAC mac_0 ( .a_in(a_in), .w_in(w_in), .sum_in(sum_in), .out(out) );
	
	
	initial begin
	
		a_in = 0;
		w_in = 0;
		sum_in = 0;
		
		#50
		
		a_in = 15;
		w_in = 0;
		sum_in = 0;
		
		#50
		
		a_in = 1;
		w_in = 61000;
		sum_in = 0;
		
		#50
	
		a_in = 1;
		w_in = 61000;
		sum_in = 4000;
		
				#50
	
		a_in = 1;
		w_in = 61000;
		sum_in = 4000;
		
				#50
	
		a_in = 500;
		w_in = 50;
		sum_in = 17000;
		
				#50
	
		a_in = 2;
		w_in = 12000;
		sum_in = 4000;
		
						#50
	
		a_in = 60000;
		w_in = 12000;
		sum_in = 15000;
	
		
	end
	
endmodule
