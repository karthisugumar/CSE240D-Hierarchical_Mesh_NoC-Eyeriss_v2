`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 07:20:21 AM
// Design Name: 
// Module Name: PE
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


module PE #( parameter DATA_WIDTH = 16,
			 parameter ADDR_WIDTH = 9 )
		   ( input clk, reset,
			 input [DATA_WIDTH-1:0] act_in,
			 input [DATA_WIDTH-1:0] filt_in,
			 output logic [DATA_WIDTH-1:0] pe_out,
			 output logic [DATA_WIDTH-1:0] act_out,
//extra
			output logic [1:0] filt_count,
			output logic [DATA_WIDTH-1:0] mac_out
			
    );
	
	parameter int kernel_size = 3;
	
// ScratchPad Instantiation
/*
	wire read_en, write_en;
	
	SPad spad_pe0 ( .clk(clk), .reset(reset), 
					.read_req(read_en),
					.write_en(write_en), 
					.r_addr(r_addr), 
					.w_addr(w_addr),
					.w_data(w_data),
					.r_data(r_data)
					);
*/

	logic [DATA_WIDTH-1:0] psum_reg;
	logic [DATA_WIDTH-1:0] sum_in;
	logic sum_in_mux_sel;
	logic [DATA_WIDTH-1:0] psum_reg_out;
	logic [DATA_WIDTH-1:0] act_reg_out;
	
	//MAC Instantiation
	
	MAC  #( .IN_BITWIDTH(DATA_WIDTH),
			     .OUT_BITWIDTH(DATA_WIDTH) )
	mac_0
				( .a_in(act_in),
				  .w_in(filt_in),
				  .sum_in(sum_in),
				  .out(psum_reg_out)
				);
			
	mux2 #( .WIDTH(DATA_WIDTH) ) mux2_0 ( .a_in(psum_reg), 
										.b_in(32'b0), 
										.sel(sum_in_mux_sel), 
										.out(sum_in) 
										);
	
//Count for psum accumulation based on kernel size - RS dataflow
	always@(posedge clk) begin
		if(reset) begin
			filt_count <= 0;
			sum_in_mux_sel <= 0;
			psum_reg <= 0;
			act_reg_out <= 0;
		
		end else begin
			if(filt_count == (kernel_size) ) begin
				filt_count <= 0;
				sum_in_mux_sel <= 0;
				act_reg_out <= 0;
				psum_reg <= psum_reg_out;
			
			end else if(filt_count == 0) begin
				filt_count <= filt_count + 1;
				sum_in_mux_sel <= 0;
				psum_reg <= psum_reg_out;
				act_reg_out <= 0;
				
			end else begin
				filt_count <= filt_count + 1;
				sum_in_mux_sel <= 1;
				psum_reg <= psum_reg_out;
				act_reg_out <= 0;
			end
		end
	end

	
	
// Assign output from psum_reg
/* 	logic [DATA_WIDTH-1:0] psum_reg_out;
	logic [DATA_WIDTH-1:0] act_reg_out;

	always@(posedge clk) begin
		if(reset) begin
			psum_reg <= 0;
			act_reg_out <= 0;
		end else begin
			psum_reg_out <= psum_reg;
			act_reg_out <= 0;
		end
	end */
	
	assign mac_out = psum_reg_out;
	assign pe_out = psum_reg;
	assign act_out = act_reg_out;

endmodule
