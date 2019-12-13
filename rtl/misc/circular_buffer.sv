`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2019 04:33:37 PM
// Design Name: 
// Module Name: circular_buffer
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


module circular_buffer#(
	parameter BUFFER_SIZE = 8,
	parameter DATA_SIZE = 16
    )
	( 
	input clk,
	input reset,
	
	input [DATA_SIZE-1:0] data_i,
	input read_en_i,
	input write_en_i,
	
	output [DATA_SIZE-1:0] data_o,
	output logic full_o,
	output logic empty_o
//	output logic on_off_o
	);
	
	localparam [31:0] POINTER_SIZE = $clog2(BUFFER_SIZE);
	
	logic [DATA_SIZE-1:0] mem[BUFFER_SIZE-1:0];
	
	logic [POINTER_SIZE-1:0] read_ptr;
	logic [POINTER_SIZE-1:0] write_ptr;
	
	logic [POINTER_SIZE-1:0] read_ptr_next;
	logic [POINTER_SIZE-1:0] write_ptr_next;
	
	logic full_next;
	logic empty_next;
	logic on_off_next;
	
	logic [POINTER_SIZE:0] num_flits;
	logic [POINTER_SIZE:0] num_flits_next;	
	
	
	always_ff@(posedge clk) begin
		if(reset) begin
			read_ptr <= 0;
			write_ptr <= 0;
			full_o <= 0;
			empty_o <= 0;
//			on_off_o <= 0;
		end else begin
			read_ptr <= read_ptr_next;
			write_ptr <= write_ptr_next;
			
			full_o <= full_next;
			empty_o <= empty_next;
			
//			on_off_o <= on_off_next;
			
			if((!read_en_i & write_en_i & !full_o) | (read_en_i & write_en_i))
				mem[write_ptr] <= data_i;
		end
	end
	
	
	always_comb begin
		data_o = mem[read_ptr];
		unique
		if(read_en_i & !write_en_i & !empty_o)
		begin: read_not_empty
			read_ptr_next = incr_ptr(read_ptr);
			write_ptr_next = write_ptr;
			full_next = 0;
			update_empty();
			num_flits_next = num_flits - 1;
		end
		
		else if(!read_en_i & write_en_i & !full_o)
		begin:write_not_full
			read_ptr_next = read_ptr;
			write_ptr_next = incr_ptr(write_ptr);
			update_full();
			num_flits_next = num_flits + 1;
		end
		
		else if(read_en_i & write_en_i & !empty_o)
		begin:read_write_not_empty
			read_ptr_next = incr_ptr(read_ptr);
			write_ptr_next = incr_ptr(write_ptr);
			full_next = full_o;
			empty_next = empty_o;
			num_flits_next = num_flits;
		end
		else
		begin:idle
			read_ptr_next = read_ptr;
			write_ptr_next = write_ptr;
			full_next = full_o;
			empty_next = empty_o;
			num_flits_next = num_flits;
		end
		
//		begin:update_
		
	end
	
	function logic [POINTER_SIZE-1:0] incr_ptr (
							input logic [POINTER_SIZE-1:0] ptr );
		if(ptr == BUFFER_SIZE-1)
			incr_ptr = 0;
		else
			incr_ptr = ptr + 1;
	endfunction
	
	function void update_empty();
		if(read_ptr_next == write_ptr)
			empty_next = 1;
		else
			empty_next = 0;
	endfunction
	
	function void update_full();
		if(write_ptr_next == read_ptr)
			full_next = 1;
		else
			full_next = 0;
	endfunction
	
endmodule
