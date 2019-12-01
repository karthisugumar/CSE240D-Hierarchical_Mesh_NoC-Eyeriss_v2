`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 01:54:30 PM
// Design Name: 
// Module Name: GLB_cluster_tb
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


module GLB_cluster_tb();

    parameter DATA_BITWIDTH = 16;
	parameter ADDR_BITWIDTH = 10;
    parameter NUM_GLB_IACT = 1;
    parameter NUM_GLB_PSUM = 1;

    logic clk;
    logic reset;

    logic read_req_iact[NUM_GLB_IACT-1:0], read_req_psum[NUM_GLB_PSUM-1:0];
    logic write_en_iact[NUM_GLB_IACT-1:0], write_en_psum[NUM_GLB_PSUM-1:0];

    logic [ADDR_BITWIDTH-1 : 0] r_addr_iact[NUM_GLB_IACT-1:0];
    logic [ADDR_BITWIDTH-1 : 0] r_addr_psum[NUM_GLB_PSUM-1:0];

    logic [ADDR_BITWIDTH-1 : 0] w_addr_iact[NUM_GLB_IACT-1:0];
    logic [ADDR_BITWIDTH-1 : 0] w_addr_psum[NUM_GLB_PSUM-1:0];

    logic [DATA_BITWIDTH-1 : 0] w_data_iact[NUM_GLB_IACT-1:0];
    logic [DATA_BITWIDTH-1 : 0] w_data_psum[NUM_GLB_PSUM-1:0];

    logic [DATA_BITWIDTH-1 : 0] r_data_iact[NUM_GLB_IACT-1:0];
    logic [DATA_BITWIDTH-1 : 0] r_data_psum[NUM_GLB_PSUM-1:0];
     

	GLB_cluster 
			#(	.DATA_BITWIDTH(DATA_BITWIDTH),
				.ADDR_BITWIDTH(ADDR_BITWIDTH),
				.NUM_GLB_IACT(NUM_GLB_IACT),
				.NUM_GLB_PSUM(NUM_GLB_PSUM)
			)
	GLB_cluster_0
			(
				.clk(clk), 
				.reset(reset),
				.read_req_iact(read_req_iact),
				.read_req_psum(read_req_psum),
				.write_en_iact(write_en_iact),
				.write_en_psum(write_en_psum),
				.r_addr_iact(r_addr_iact),
			    .r_addr_psum(r_addr_psum),

			    .w_addr_iact(w_addr_iact),
			    .w_addr_psum(w_addr_psum),

			    .w_data_iact(w_data_iact),
			    .w_data_psum(w_data_psum),

			    .r_data_iact(r_data_iact),
			    .r_data_psum(r_data_psum)
			);
			
			
	always begin
		clk = 0; #10;
		clk = 1; #10;
	end

	
	initial begin
		reset = 1; #30;
		reset = 0;
	
		write_en_iact[0] = 1;
		write_en_psum[0] = 1;
		
		for(int i=0; i<16; i++) begin
			w_addr_iact[0] = i;
			w_data_iact[0] = i*2;

			w_addr_psum[0] = i;
			w_data_psum[0] = i;
			
			#20;
		end
		
		write_en_iact[0] = 0;
		write_en_psum[0] = 0;
	
		for(int i=0; i<2; i++) begin
			w_addr_iact[0] = i;
			w_data_iact[0] = i*200;

			w_addr_psum[0] = i;
			w_data_psum[0] = i*200;
			
			#20;
		end
	
	#100;
	
		read_req_iact[0] = 1;
		read_req_psum[0] = 1;
		
		for(int i=0; i<16; i++) begin
			r_addr_iact[0] = i;

			r_addr_psum[0] = i;
			
			#20;
		end
	
		read_req_iact[0] = 0;
		read_req_psum[0] = 0;
		
		for(int i=0; i<2; i++) begin
			r_addr_iact[0] = i;

			r_addr_psum[0] = i;
			
			#20;
		end
		
	end
	 
endmodule