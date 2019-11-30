`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2019 09:56:14 PM
// Design Name: 
// Module Name: PE_cluster_tb
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


module PE_cluster_tb();

	parameter DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 9;
    
    parameter int X_dim = 5;
    parameter int Y_dim = 3;
    
    parameter int kernel_size = 3;
    parameter int act_size = 5;
    
    parameter W_READ_ADDR = 0;  
    parameter A_READ_ADDR = 100;
    
    parameter W_LOAD_ADDR = 0;  
    parameter A_LOAD_ADDR = 100;
    
    parameter PSUM_ADDR = 500;
	
    logic clk, reset;
    logic [DATA_WIDTH-1:0] act_in;
    logic [DATA_WIDTH-1:0] filt_in;
    logic load_en, start;
    logic [DATA_WIDTH-1:0] pe_out[X_dim-1:0];
    logic compute_done;
	
	
	PE_cluster #(
					.DATA_WIDTH(DATA_WIDTH),
					.ADDR_WIDTH(ADDR_WIDTH),
					
					.kernel_size(kernel_size),
					.act_size(act_size),
					
					.X_dim(X_dim),
					.Y_dim(Y_dim)
    			)
	pe_cluster_0
    			(
					.clk(clk),
				    .reset(reset),
				    .act_in(act_in),
				    .filt_in(filt_in),
				    .load_en(load_en), 
					.start(start),
                    .pe_out(pe_out),
					.compute_done(compute_done)
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
		
	//3rd row
		filt_in = 1; 
		#20;
		filt_in = 1; 
		#20;
		
		
	//Activations
		for(int i=1; i<=25; i++) begin
			act_in = i; 
			#20;
		end
		
//		load_en = 0;
//		#20
		
		start = 1; #25; 
		$display("\n\nReading & Computing Begins.....\n\n");
		start = 0;
	end
				
				
endmodule