`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 07:38:58 AM
// Design Name: 
// Module Name: switch_tb
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


module switch_tb();

	parameter DATA_WIDTH = 16;
	
	logic [DATA_WIDTH-1:0] a, b, c, d;
	
	logic [3:0] s;
//	logic [1:0] sel;
	
	logic [DATA_WIDTH-1:0] out;

	
/* 	lookup_mux4 lookup_0 ( .in(s), .out(sel) );
	mux_4x1 mux_0 ( .sel(sel), .a(a), .b(b), .c(c), .d(d), .out(out) ); */
	
	switch switch_0 ( .a(a), .b(b), .c(c), .d(d), .out(out), .sel(s) );

	initial begin
		for(int i=0; i<10; i++) begin
			a = i;
			#50;
		end
	end
	
	initial begin
		for(int i=10; i<20; i++) begin
			b = i;
			#50;
		end
	end
	
	initial begin
		for(int i=20; i<30; i++) begin
			c = i;
			#50;
		end
	end
	
		initial begin
		for(int i=30; i<40; i++) begin
			d = i;
			#50;
		end
	end
	
	initial begin
		s = 4'b0000;
		#100;
		
		s = 4'b1000;
		#100;
		
		s = 4'b0010;
		#100;
		
		s = 4'b0100;
		#100;
			
		s = 4'b1100;
		#100;
		
	end
	
endmodule
