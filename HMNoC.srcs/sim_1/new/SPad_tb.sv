`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 08:46:43 PM
// Design Name: 
// Module Name: SPad_tb
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


module SPad_tb();
	
	parameter ADDR_BITWIDTH = 9;
	parameter DATA_BITWIDTH = 16;
	
	logic clk, reset, read_req, write_en;
	logic [ADDR_BITWIDTH-1 : 0] r_addr, w_addr;
	logic [DATA_BITWIDTH-1 : 0] w_data;
	logic [DATA_BITWIDTH-1 : 0] r_data;
	
	//
	SPad SPad_0 ( .clk(clk), .reset(reset), .read_req(read_req),
				  .write_en(write_en), .r_addr(r_addr), .w_data(w_data),
				  .r_data(r_data), .w_addr(w_addr)
				);
	
	always begin
		clk = 0; #10;
		clk = 1; #10;
	end
	
	initial begin
		reset = 1; #20
		reset = 0;
		//$display("Data at location 0 is %d", mem[0]);
		
		write_en = 1;
		w_addr = 0;
		w_data = 25;
		#40
		
		write_en = 0;
		read_req = 1;
		r_addr = 0;
		#40
		$display("Data at location 0 is %d", r_data);
		
		write_en = 1;
		for (int i = 1; i<8; i+=2) begin
			w_addr = i;
			w_data = i*2 + 10;
			#40;
		end
		write_en = 0;
		
		for (int i = 1; i<8; i+=2) begin
			r_addr = i;
			#40
			$display("Data at location %d is %d", i, r_data);
		end
		
	end
	
	
endmodule
