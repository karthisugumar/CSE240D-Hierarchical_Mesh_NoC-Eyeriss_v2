`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 03:50:08 PM
// Design Name: 
// Module Name: router_weight
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


module router_weight #( parameter DATA_BITWIDTH = 16,
						parameter ADDR_BITWIDTH_GLB = 10,
						parameter ADDR_BITWIDTH_SPAD = 9,
						
						parameter int X_dim = 5,
                        parameter int Y_dim = 3,
                        parameter int kernel_size = 3,
                        parameter int act_size = 5,
						
						parameter W_READ_ADDR = 0, 
                        
                        parameter W_LOAD_ADDR = 0,
						
						parameter PSUM_READ_ADDR = 500,
						parameter PSUM_LOAD_ADDR = 0
					)
					
					(	input clk,
						input reset,
						
						//for reading glb
						input [DATA_BITWIDTH-1 : 0] r_data_glb_wght,
						output logic [ADDR_BITWIDTH_GLB-1 : 0] r_addr_glb_wght,
						output logic read_req_glb_wght,
						
						//for writing to spad
						output logic [DATA_BITWIDTH-1 : 0] w_data_spad,
						output logic load_en_spad,
						
						//Input from control unit to load weights to spad
						input load_spad_ctrl
			
					);
				
					
		enum logic [2:0] {IDLE=3'b000, READ_GLB=3'b001, WRITE_SPAD=3'b010, READ_GLB_0=3'b011} state;
		
		logic [4:0] filt_count;
		
		always@(posedge clk) begin
//			$display("State: %s", state.name());
			if(reset) begin
				read_req_glb_wght <= 0;
				r_addr_glb_wght <= 0;
				load_en_spad <= 0;
				filt_count <= 0;
				state <= IDLE;
			end else begin
				case(state)
					IDLE:begin
						if(load_spad_ctrl) begin
							read_req_glb_wght <= 1;
							r_addr_glb_wght <= W_READ_ADDR;
							state <= READ_GLB;
						end else begin
							read_req_glb_wght = 0;
							load_en_spad = 0;
							state <= IDLE;
						end
					end
					
					READ_GLB:begin
						load_en_spad <= 1;
						filt_count <= filt_count + 1;
						r_addr_glb_wght <= r_addr_glb_wght + 1;
						w_data_spad <= r_data_glb_wght;
						state <= WRITE_SPAD;
					end
					
					WRITE_SPAD:begin
						if(filt_count == (kernel_size**2)) begin
							w_data_spad <= r_data_glb_wght;
							filt_count <= 0;
							r_addr_glb_wght <= W_READ_ADDR;
							
							state <= IDLE;
						end else begin
							w_data_spad <= r_data_glb_wght;
							filt_count <= filt_count + 1;
							r_addr_glb_wght <= r_addr_glb_wght + 1;
							state <= WRITE_SPAD;
						end
					end
				endcase
			end
		end
 
endmodule
