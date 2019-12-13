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
//					input load_en, 
					input load_en_wght, load_en_act,
					input start,
					output logic [DATA_WIDTH-1:0] pe_out[0 : X_dim-1],
					output logic compute_done,
					output logic load_done
					
		//extra 
		//			output logic [DATA_WIDTH-1:0] psum_out[0 : X_dim*Y_dim-1]
					);
		
		logic [DATA_WIDTH-1:0] psum_out[0 : X_dim*Y_dim-1];
		
		logic cluster_done[0 : X_dim*Y_dim-1];
		logic cluster_load_done[0 : X_dim*Y_dim-1];
		
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
								.W_READ_ADDR(W_READ_ADDR + kernel_size*j),  
								.A_READ_ADDR(A_READ_ADDR + act_size*j + i),
								.W_LOAD_ADDR(W_LOAD_ADDR),  
								.A_LOAD_ADDR(A_LOAD_ADDR),
								.PSUM_ADDR(PSUM_ADDR)
							)
						pe (	
								.clk(clk),
								.reset(reset),
								.act_in(act_in),
								.filt_in(filt_in),
//								.load_en(load_en),
								.load_en_wght(load_en_wght),
								.load_en_act(load_en_act),
								.start(start),
								.pe_out(psum_out[i*Y_dim+j]),
								.compute_done(cluster_done[i*Y_dim+j]),
								.load_done(cluster_load_done[i*Y_dim+j])
							);
					
					end
			end
		endgenerate
		
		
/*  		virtual class psum_adder_class #(parameter X_dim, parameter Y_dim, parameter DATA_WIDTH);
			static function logic [DATA_WIDTH-1 : 0] psum_adder 
				(
					input logic [DATA_WIDTH-1:0] psum_out[X_dim*Y_dim-1 : 0]
				);
				begin
					psum_adder = {(DATA_WIDTH){1'b0}};
					for(int i=0; i<Y_dim; i++) begin
						psum_adder = psum_adder + psum_out[Y_dim*X_dim+i];
					end
				end
			endfunction
		endclass  */
					
		


 			function logic [DATA_WIDTH-1 : 0] psum_adder 
				(
					input logic [DATA_WIDTH-1:0] psum_out[0 : X_dim*Y_dim-1],
					input logic [3:0] X_dim,
					input logic [3:0] Y_dim
				);
				begin
					psum_adder = {(DATA_WIDTH){1'b0}};
					for(int i=0; i<Y_dim; i++) begin
						psum_adder = psum_adder + psum_out[Y_dim*X_dim+i];
					end
				end
			endfunction
				
				
				
/* 		always@(posedge clk) begin
			if(reset) begin
				for(int i=0; i<X_dim; i++) begin
					pe_out[i] <= 0;
				end
			end else begin
				for(int i=0; i<X_dim; i++) begin
					pe_out[i] <= psum_adder_class#
									(.X_dim(i),
									 .Y_dim(Y_dim),
									 .DATA_WIDTH(DATA_WIDTH)
									)
									::psum_adder(psum_out);
				end
			end
			
		end */
		
		
		// Add partial sums and register at pe_out
		always@(posedge clk) begin
			if(reset) begin
				for(int i=0; i<X_dim; i++) begin
					pe_out[i] <= 0;
				end
			end else begin
				for(int i=0; i<X_dim; i++) begin
					pe_out[i] <= psum_adder(psum_out,i,Y_dim);
				end
			end
			
		end
		
		
		assign compute_done = cluster_done[0];
		assign load_done = cluster_load_done[0];
		
	//	assign pe_out[X_dim-1:0] = psum_out[X_dim*Y_dim-1 : 0]
			  
endmodule
				   
				   
				   
				   
				   
				   
				   
				   
				   
				   