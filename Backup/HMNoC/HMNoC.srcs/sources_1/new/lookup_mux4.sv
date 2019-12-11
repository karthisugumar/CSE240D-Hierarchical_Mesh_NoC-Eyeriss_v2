`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 07:41:07 AM
// Design Name: 
// Module Name: lookup_mux4
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


module lookup_mux4
	(
	input [3:0] in,
	output logic [1:0] out
    );
	
	always_comb begin
		unique if(in == 4'b0000)
			out = 0;
		else if(in == 4'b0010)
			out = 1;
		else if(in == 4'b0100)
			out = 2;
		else if(in == 4'b1000)
			out = 3;
	end
endmodule
