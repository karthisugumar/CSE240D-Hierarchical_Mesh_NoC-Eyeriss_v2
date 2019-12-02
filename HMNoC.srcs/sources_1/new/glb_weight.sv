`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 04:07:04 PM
// Design Name: 
// Module Name: glb_weight
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


module glb_weight #( parameter DATA_BITWIDTH = 16,
			 parameter ADDR_BITWIDTH = 10 )
		   ( input clk,
			 input reset,
			 input read_req,
			 input write_en,
			 input [ADDR_BITWIDTH-1 : 0] r_addr,
			 input [ADDR_BITWIDTH-1 : 0] w_addr,
			 input [DATA_BITWIDTH-1 : 0] w_data,
			 output logic [DATA_BITWIDTH-1 : 0] r_data
    );
	
	logic [DATA_BITWIDTH-1 : 0] mem [0 : (1 << ADDR_BITWIDTH) - 1]; 
		// default - 1024(2^10) 16-bit memory. Total size = 2kB 
	logic [DATA_BITWIDTH-1 : 0] data;
	
	always@(posedge clk)
		begin : READ
			if(reset)
				data = 0;
			else
			begin
				if(read_req) begin
					data = mem[r_addr];
//					$display("Read Address to SPad:%d",r_addr);
				end else begin
					data = 10101; //Random default value to verify model
				end
			end
		end
	
	assign r_data = data;
	
	always@(posedge clk)
		begin : WRITE	
			if(write_en && !reset) begin
				mem[w_addr] = w_data;
			end
		end
	
endmodule
