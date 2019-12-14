`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 07:39:19 AM
// Design Name: 
// Module Name: adder_tb
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

module adder_tb();

	logic A_in, B_in, C_in;
	logic HA_S_out,HA_C_out;
	logic FA_S_out,FA_C_out;
	
	HA HA_0 ( .A_in(A_in), .B_in(B_in), .C_out(HA_C_out), .S_out(HA_S_out) );
	
	FA FA_0 ( .A_in(A_in), .B_in(B_in), .C_in(C_in), .C_out(FA_C_out), .S_out(FA_S_out) );
	
	
	initial begin
		A_in = 0;
		B_in = 0;
		C_in = 0;
		
		#50
		
		A_in = 0;
		B_in = 1;
		C_in = 0;
		
		#50
		
		A_in = 1;
		B_in = 0;
		C_in = 0;
		
		#50
		
		A_in = 1;
		B_in = 1;
		C_in = 0;
		
		#50
		
		A_in = 0;
		B_in = 0;
		C_in = 1;
		
		#50
		
		A_in = 0;
		B_in = 1;
		C_in = 1;
		
		#50
		
		A_in = 1;
		B_in = 0;
		C_in = 1;
		
		#50
		
		A_in = 1;
		B_in = 1;
		C_in = 1;
	end
	
endmodule
