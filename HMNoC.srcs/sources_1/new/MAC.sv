`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 09:39:19 AM
// Design Name: 
// Module Name: MAC
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


module MAC #( parameter IN_BITWIDTH = 16,
			  parameter OUT_BITWIDTH = 2*IN_BITWIDTH )
			( input [IN_BITWIDTH-1 : 0] a_in,
			  input [IN_BITWIDTH-1 : 0] w_in,
			  input [IN_BITWIDTH-1 : 0] sum_in,
			  output [OUT_BITWIDTH-1 : 0] out
			);
	
	logic [OUT_BITWIDTH-1:0] mult_out;
	
	assign mult_out = a_in * w_in;
	assign out = mult_out + sum_in;
	
endmodule
