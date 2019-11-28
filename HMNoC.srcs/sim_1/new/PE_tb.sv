`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2019 02:02:47 AM
// Design Name: 
// Module Name: PE_tb
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


module PE_tb();

	parameter DATA_WIDTH = 16;
	logic clk, reset;
	logic [DATA_WIDTH-1:0] act_in, filt_in, pe_out, act_out;
	logic [1:0] filt_count;
	
	logic [DATA_WIDTH-1:0] mac_out;
	
	PE pe_0 ( .clk(clk), .reset(reset), .act_in(act_in), .filt_in(filt_in),
			  .pe_out(pe_out), .act_out(act_out),
	//extra		
			  .filt_count(filt_count), .mac_out(mac_out)
			);
			  
	always begin
		clk = 0; #10;
		clk = 1; #10;
	end
	
	initial begin
		reset = 1; #30;
		reset = 0;
	
	//First 3 acts
		act_in = 1;
		filt_in = 1; 
		#20;
		$display("Output from PE is %d",pe_out);
		
		act_in = 2;
		filt_in = 2; 
		#20;
		$display("Output from PE is %d",pe_out);
		
		act_in = 3;
		filt_in = 3; 
		#20;
		$display("Output from PE is %d",pe_out);
		
	//next 3
		act_in = 2;
		filt_in = 1; 
		#40;
		$display("Output from PE is %d",pe_out);
		
		act_in = 3;
		filt_in = 2; 
		#20;
		$display("Output from PE is %d",pe_out);
		
		act_in = 4;
		filt_in = 3; 
		#20;
		$display("Output from PE is %d",pe_out);
	
	//next 3
		act_in = 3;
		filt_in = 1; 
		#40;
		$display("Output from PE is %d",pe_out);
		
		act_in = 4;
		filt_in = 2; 
		#20;
		$display("Output from PE is %d",pe_out);
		
		act_in = 5;
		filt_in = 3; 
		#20;
		$display("Output from PE is %d",pe_out);
		
	end
	
endmodule
