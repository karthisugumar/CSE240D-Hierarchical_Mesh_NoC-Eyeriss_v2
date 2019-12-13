`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 07:43:21 AM
// Design Name: 
// Module Name: FA
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


module FA( input A_in,
			input B_in,
			input C_in,
			output logic S_out,
			output logic C_out
    );
	
	assign {C_out, S_out} = A_in + B_in + C_in;
	
endmodule
