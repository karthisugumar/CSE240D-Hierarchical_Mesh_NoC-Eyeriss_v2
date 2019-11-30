`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2019 09:11:06 PM
// Design Name: 
// Module Name: PE_cluster
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


module PE_cluster #(parameter DATA_WIDTH = 16,
					parameter ADDR_WIDTH = 9,
					
					parameter int X_dim = 5,
					parameter int Y_dim = 3,
   
					parameter int kernel_size = 3,
					parameter int act_size = 5,
					
					parameter W_READ_ADDR = 0,  
					parameter A_READ_ADDR = 100,
					
					parameter W_LOAD_ADDR = 0,  
					parameter A_LOAD_ADDR = 100,
					
					parameter PSUM_ADDR = 500
					)
					( 
					input clk, reset,
					input [DATA_WIDTH-1:0] act_in,
					input [DATA_WIDTH-1:0] filt_in,
					input load_en, start,
					output logic [DATA_WIDTH-1:0] pe_out[X_dim-1:0],
					output logic compute_done
					);
		
		logic psum_out[X_dim*Y_dim-1 : 0];
		
		generate
		genvar i;
		for(i=0; i<X_dim; i++) 
			begin:gen_X
				genvar j;
				for(j=0; j<Y_dim; j++)
					begin:gen_Y
					
						PE #( 	.DATA_WIDTH(DATA_WIDTH),
								.ADDR_WIDTH(ADDR_WIDTH),
								.kernel_size(kernel_size),
								.act_size(act_size),
								.W_READ_ADDR(W_READ_ADDR+kernel_size*j),  
								.A_READ_ADDR(A_READ_ADDR+kernel_size*j+i),
								.W_LOAD_ADDR(W_LOAD_ADDR),  
								.A_LOAD_ADDR(A_LOAD_ADDR),
								.PSUM_ADDR(PSUM_ADDR)
							)
						pe (	
								.clk(clk),
								.reset(reset),
								.act_in(act_in),
								.filt_in(filt_in),
								.load_en(load_en), 
								.start(start),
								.pe_out(psum_out[i*Y_dim+j]),
								.act_out()
							);
					
					end
			end
		endgenerate
			  
endmodule
				   
				   
				   
				   
				   
				   
				   
				   
				   
				   