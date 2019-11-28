`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2019 01:14:05 AM
// Design Name: 
// Module Name: mux_2_1
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


module mux2 #( parameter WIDTH = 16)
	(
    input [WIDTH-1:0] a_in,
    input [WIDTH-1:0] b_in,
    input sel,
    output [WIDTH-1:0] out
    );
	
	assign out = sel ? a_in : b_in;
	
endmodule
