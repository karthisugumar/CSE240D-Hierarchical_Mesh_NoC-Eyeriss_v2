`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 07:22:05 AM
// Design Name: 
// Module Name: mux_4x1
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


module mux_4x1 #(parameter DATA_WIDTH=16)
	(
		input [DATA_WIDTH-1:0] a,
		input [DATA_WIDTH-1:0] b,
		input [DATA_WIDTH-1:0] c,
		input [DATA_WIDTH-1:0] d,
		
		input [1:0] sel,
		
		output logic [DATA_WIDTH-1:0] out
    );
	
		assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a) ;
		
endmodule
