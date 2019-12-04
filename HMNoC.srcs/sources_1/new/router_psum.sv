`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 11:22:43 AM
// Design Name: 
// Module Name: router_psum
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


module router_psum #( parameter DATA_BITWIDTH = 16,
						parameter ADDR_BITWIDTH_GLB = 10,
						parameter ADDR_BITWIDTH_SPAD = 9,
						
						parameter int X_dim = 5,
                        parameter int Y_dim = 3,
                        parameter int kernel_size = 3,
                        parameter int act_size = 5,
						
//						parameter A_READ_ADDR =100, 
                        
//                        parameter A_LOAD_ADDR = 0,
						
						parameter PSUM_READ_ADDR = 0,
						parameter PSUM_LOAD_ADDR = 0
					)
					
					(	input clk,
						input reset,
						
						//for reading glb
						input [DATA_BITWIDTH-1 : 0] r_data_spad_psum[0:kernel_size-1],
						output logic [ADDR_BITWIDTH_GLB-1 : 0] w_addr_glb_psum,
						output logic write_en_glb_psum,
						
						//for writing to spad
						output logic [DATA_BITWIDTH-1 : 0] w_data_glb_psum,
//						output logic load_en_spad,
						
						//Input from PE cluster to write psums to glb
						input write_psum_ctrl
			
					);
				
					
		enum logic [2:0] {IDLE=3'b000, WRITE_GLB=3'b001, READ_PSUM=3'b010} state;
		
		logic [4:0] psum_count;
		logic [DATA_BITWIDTH-1 : 0] pe_psum[0:kernel_size-1];
		
		always@(posedge clk) begin
			$display("State: %s", state.name());
			if(reset) begin
				w_addr_glb_psum <= PSUM_LOAD_ADDR;
				psum_count <= 0;
				write_en_glb_psum <= 0;
				state <= IDLE;
			end else begin
				case(state)
					IDLE:begin
						if(write_psum_ctrl) begin
							//write_en_glb_psum <= 1;
							state <= READ_PSUM;
						end else begin
							psum_count <= 0;
							write_en_glb_psum <= 0;
							state <= IDLE;
						end
					end
					
					READ_PSUM:begin
						pe_psum <= r_data_spad_psum;
						$display("Psum read in router:%d",pe_psum[0:kernel_size-1]);
						write_en_glb_psum <= 1;
						psum_count <= 0;
						w_addr_glb_psum <= PSUM_LOAD_ADDR;
						state <= WRITE_GLB;
					end
					
					WRITE_GLB:begin
						if(pe_psum == (kernel_size-1)) begin
							w_data_glb_psum <= pe_psum[psum_count];
							psum_count <= 0;
							w_addr_glb_psum <= w_addr_glb_psum + 1;
							state <= IDLE;
						end else begin
							w_data_glb_psum <= pe_psum[psum_count];
							w_addr_glb_psum <= w_addr_glb_psum + 1;
							psum_count <= psum_count + 1;
							state <= WRITE_GLB;
						end
					end
				endcase
			end
		end
 
endmodule
