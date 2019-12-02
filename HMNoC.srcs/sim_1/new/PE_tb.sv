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
	
	parameter int kernel_size = 3;
	parameter int act_size = 5;
	
	//KEEP READ AND WRITE ADDRESSES SAME for proper working of RS-PE 
	//Addresses to READ weights and activations from SPad
	parameter W_READ_ADDR = 0; 
	parameter A_READ_ADDR = 100;
	
	//Addresses to WRITE weights and activations in SPad
	parameter W_LOAD_ADDR = 0;
	parameter A_LOAD_ADDR = 100;
	
	parameter PSUM_ADDR = 500;
	

			 
	logic clk, reset;
	logic [DATA_WIDTH-1:0] act_in, filt_in, pe_out;
	
//	logic load_en, start;
	logic load_en_wght, load_en_act, start;
	
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
		  .compute_done(compute_done), //out
//		  .load_en(load_en),
		  .load_en_wght(load_en_wght),
		  .load_en_act(load_en_act),
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
		
	$display("\n\nLoading Begins: Weights.....\n\n");
		load_en_wght = 1;
/*	
	//Filter
	//1st row
		filt_in = 1; 
		#20; load_en = 0;
		filt_in = 1; 
		#20;
		filt_in = 1; 
		#20;
	
	//2nd row	
		filt_in = 1; 
		#20;
		filt_in = 1; 
		#20;
		filt_in = 1; 
		#20;
		
	//3rd row
		filt_in = 1; 
		#20;
		filt_in = 1; 
		#20;
		filt_in = 1; 
		#20;
*/
		
	//Filter
		for(int i=1; i<=kernel_size**2; i++) begin
			filt_in = i; #20;
			load_en_wght = 0;
		end
		
		#50;
		
		
		$display("\n\nLoading Begins: Activations.....\n\n");
		load_en_act = 1;
	//Activations
		for(int i=1; i<=act_size**2; i++) begin
			act_in = i; #20;
			load_en_act = 0;
		end
		
//		load_en = 0;
		#20
		
		start = 1; #25; 
		$display("\n\nReading & Computing Begins for iter 1.....\n\n");
		start = 0;
		
		wait (compute_done == 1);	
		$display("\n\nFinal PSUM of Iteration 1:%d\n\n",pe_out);
		
		#40;
		start = 1; #25; 
		$display("\n\nReading & Computing Begins for iter 2.....\n\n");
		start = 0;
		
				wait (compute_done == 1);	
		$display("\n\nFinal PSUM of Iteration 2:%d\n\n",pe_out);
		
		#40;
		start = 1; #25; 
		$display("\n\nReading & Computing Begins for iter 3.....\n\n");
		start = 0;
		
		wait (compute_done == 1);	
		$display("\n\nFinal PSUM of Iteration 3:%d\n\n",pe_out);
		
		#40;
		start = 1; #25; 
		$display("\n\nReading & Computing Begins for iter 4.....\n\n");
		start = 0;
		
		wait (compute_done == 1);	
		$display("\n\nFinal PSUM of Iteration 4:%d\n\n",pe_out);
		
		#40;
		start = 1; #25; 
		$display("\n\nReading & Computing Begins for iter 5.....\n\n");
		start = 0;
		
		wait (compute_done == 1);	
		$display("\n\nFinal PSUM of Iteration 5:%d\n\n",pe_out);
	end
	
endmodule
