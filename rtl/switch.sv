`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 08:10:01 AM
// Design Name: 
// Module Name: switch
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


module switch
	#(
		parameter DATA_WIDTH = 16
	)
	(
		input [DATA_WIDTH-1:0] a,
		input [DATA_WIDTH-1:0] b,
		input [DATA_WIDTH-1:0] c,
		input [DATA_WIDTH-1:0] d,
		input [3:0] sel,

		output logic [DATA_WIDTH-1:0] out
	);
	
		logic [1:0] s;
		
		lookup_mux4 lookup_0 ( .in(sel), .out(s) );
		mux_4x1 mux_0 ( .sel(s), .a(a), .b(b), .c(c), .d(d), .out(out) );
	
endmodule
