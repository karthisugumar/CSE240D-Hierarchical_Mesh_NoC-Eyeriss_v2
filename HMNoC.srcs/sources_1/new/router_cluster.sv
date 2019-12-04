`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 02:24:04 PM
// Design Name: 
// Module Name: router_cluster
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


module router_cluster#(

			parameter DATA_BITWIDTH = 16,
			parameter ADDR_BITWIDTH_GLB = 10,
			parameter ADDR_BITWIDTH_SPAD = 9,
			
			parameter kernel_size,
	        parameter act_size,
					
			parameter NUM_ROUTER_PSUM = 1,
			parameter NUM_ROUTER_IACT = 1,
			parameter NUM_ROUTER_WGHT = 1,
			
			parameter A_READ_ADDR =100, 
            parameter A_LOAD_ADDR = 0,
			
			parameter W_READ_ADDR = 0, 
            parameter W_LOAD_ADDR = 0,
			
			parameter PSUM_READ_ADDR = 0,
			parameter PSUM_LOAD_ADDR = 0
			)
		   ( input clk,
			 input reset,
			 
			 //Signals for Activation Router
			 input [DATA_BITWIDTH-1 : 0] r_data_glb_iact,
			 input load_spad_ctrl_iact,
			 
			 output logic [ADDR_BITWIDTH_GLB-1 : 0] r_addr_glb_iact,
			 output logic read_req_glb_iact,
			 
			 output logic [DATA_BITWIDTH-1 : 0] w_data_spad_iact,
			 output logic load_en_spad_iact,
			 
			 
			 //Signals for Weight Router
			 input [DATA_BITWIDTH-1 : 0] r_data_glb_wght,
			 input load_spad_ctrl_wght,
			 
			 output logic [ADDR_BITWIDTH_GLB-1 : 0] r_addr_glb_wght,
			 output logic read_req_glb_wght,

			 output logic [DATA_BITWIDTH-1 : 0] w_data_spad_wght,
			 output logic load_en_spad_wght,
			 
			 
			 //Signals for psum router
			 input [DATA_BITWIDTH-1 : 0] r_data_spad_psum[0:kernel_size-1],
			 input write_psum_ctrl, //connected to compute_done of pe_cluster
			 
			 output logic [ADDR_BITWIDTH_GLB-1 : 0] w_addr_glb_psum,
			 output logic write_en_glb_psum,
			 output logic [DATA_BITWIDTH-1 : 0] w_data_glb_psum
			 );
			
			//Instantiate iact router
			generate
			genvar i;
			for(i=0; i<NUM_ROUTER_IACT; i++) 
				begin:router_iact_gen
					router_iact #(.DATA_BITWIDTH(DATA_BITWIDTH),
									.ADDR_BITWIDTH_GLB(ADDR_BITWIDTH_GLB),
									.ADDR_BITWIDTH_SPAD(ADDR_BITWIDTH_SPAD),

									.kernel_size(kernel_size),
									.act_size(act_size),
									
									.A_READ_ADDR(A_READ_ADDR), 
									.A_LOAD_ADDR(A_LOAD_ADDR)
								)
					router_iact_0
								(	.clk(clk),
									.reset(reset),
									
									.r_data_glb_iact(r_data_glb_iact),

									.r_addr_glb_iact(r_addr_glb_iact),
									.read_req_glb_iact(read_req_glb_iact),
									
									.w_data_spad(w_data_spad_iact),
									.load_en_spad(load_en_spad_iact),
									
									//Input from control unit to load weights to spad
									.load_spad_ctrl(load_spad_ctrl_iact)
								);	
				end
			endgenerate
			
						//Instantiate weight router
			generate
			genvar k;
			for(k=0; k<NUM_ROUTER_WGHT; k++) 
				begin:router_weight_gen
					router_weight #(.DATA_BITWIDTH(DATA_BITWIDTH),
									.ADDR_BITWIDTH_GLB(ADDR_BITWIDTH_GLB),
									.ADDR_BITWIDTH_SPAD(ADDR_BITWIDTH_SPAD),

									.kernel_size(kernel_size),
									.act_size(act_size),
									
									.W_READ_ADDR(W_READ_ADDR), 
									.W_LOAD_ADDR(W_LOAD_ADDR)
								)
					router_weight_0
								(	.clk(clk),
									.reset(reset),
									
									.r_data_glb_wght(r_data_glb_wght),

									.r_addr_glb_wght(r_addr_glb_wght),
									.read_req_glb_wght(read_req_glb_wght),
									
									.w_data_spad(w_data_spad_wght),
									.load_en_spad(load_en_spad_wght),
									
									//Input from control unit to load weights to spad
									.load_spad_ctrl(load_spad_ctrl_wght)
								);	
				end
			endgenerate
			
						//Instantiate iact router
			generate
			genvar j;
			for(j=0; j<NUM_ROUTER_PSUM; j++) 
				begin:router_psum_gen
					router_psum #(.DATA_BITWIDTH(DATA_BITWIDTH),
									.ADDR_BITWIDTH_GLB(ADDR_BITWIDTH_GLB),
									.ADDR_BITWIDTH_SPAD(ADDR_BITWIDTH_SPAD),

									.kernel_size(kernel_size),
									.act_size(act_size),
									
									.PSUM_LOAD_ADDR(PSUM_LOAD_ADDR)
								)
					router_psum_0
								(	.clk(clk),
									.reset(reset),
									
									.r_data_spad_psum(r_data_spad_psum[0:kernel_size-1]),

									.w_addr_glb_psum(w_addr_glb_psum),
									.write_en_glb_psum(write_en_glb_psum),
									
									.w_data_glb_psum(w_data_glb_psum),

									//Input from control unit to load weights to spad
									.write_psum_ctrl(write_psum_ctrl)
								);	
				end
			endgenerate
			
endmodule
