`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2019 02:02:47 AM
// Design Name: 
// Module Name: PE_tb
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


module PE_tb();

	parameter DATA_WIDTH = 16;
	parameter ADDR_WIDTH = 9;
	
	
	//KEEP READ AND WRITE ADDRESSES SAME for proper working of RS-PE 
	//Addresses to READ weights and activations from SPad
	parameter W_READ_ADDR = 0; 
	parameter A_READ_ADDR = 100;
	
	//Addresses to WRITE weights and activations in SPad
	parameter W_LOAD_ADDR = 0;
	parameter A_LOAD_ADDR = 100;
	
	parameter PSUM_ADDR = 500;
	
	parameter int kernel_size = 3;
	parameter int act_size = 5;
			 
	logic clk, reset;
	logic [DATA_WIDTH-1:0] act_in, filt_in, pe_out;
	
	logic load_en, start;
	
	PE  #( 	.kernel_size(kernel_size),
			.act_size(act_size),
			.W_READ_ADDR(W_READ_ADDR),
			.A_READ_ADDR(A_READ_ADDR),
			.W_LOAD_ADDR(W_LOAD_ADDR),
			.A_LOAD_ADDR(A_LOAD_ADDR)
		   )
	pe_0		   
		( .clk(clk), .reset(reset), 
		  .act_in(act_in), .filt_in(filt_in),
		  .pe_out(pe_out),  //out
		  .act_out(), //out
		  .load_en(load_en),
		  .start(start)
		);
			  
	always begin
		clk = 0; #10;
		clk = 1; #10;
	end
	
	initial begin
		reset = 1; #30;
		reset = 0;
		start = 0;
		
	$display("\n\nLoading Begins.....\n\n");
		load_en = 1;
		
	//Filter
		filt_in = 4; 
		#20; load_en = 0;
		filt_in = 5; 
		#20;
		filt_in = 6; 
		#20;
//		filt_in = 4;
//		#20;
//		filt_in = 5;
//		#20;
//		filt_in = 0;
		
	//Activations
		act_in = 2; 
		#20;
		act_in = 3; 
		#20;
		act_in = 4; 
		#20;
		act_in = 9; 
		#20;
		act_in = 10; 
		#20;
//		act_in = 0; 
		
//		load_en = 0;
//		#20
		
		start = 1; #25; 
		$display("\n\nReading & Computing Begins.....\n\n");
		start = 0;
	end
	
endmodule
