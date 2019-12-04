`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2019 03:07:28 PM
// Design Name: 
// Module Name: router_cluster_tb
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


module router_cluster_tb();
	
	parameter DATA_BITWIDTH = 16;
	parameter ADDR_BITWIDTH = 10;
	
	// GLB Cluster parameters. This TestBench uses only 1 of each
    parameter NUM_GLB_IACT = 1;
    parameter NUM_GLB_PSUM = 1;
	parameter NUM_GLB_WGHT = 1;
	
	parameter ADDR_BITWIDTH_GLB = 10;
	parameter ADDR_BITWIDTH_SPAD = 9;
	
	parameter NUM_ROUTER_PSUM = 1;
	parameter NUM_ROUTER_IACT = 1;
	parameter NUM_ROUTER_WGHT = 1;
			
    logic clk;
    logic reset;

	//logic for GLB cluster
//    logic read_req_iact;
	logic read_req_psum;
//	logic read_req_wght;
	
    logic write_en_iact;
	logic write_en_psum;
	logic write_en_wght;
	
//    logic [ADDR_BITWIDTH-1 : 0] r_addr_iact;
    logic [ADDR_BITWIDTH-1 : 0] r_addr_psum;
//	logic [ADDR_BITWIDTH-1 : 0] r_addr_wght;
	
    logic [ADDR_BITWIDTH-1 : 0] w_addr_iact;
    logic [ADDR_BITWIDTH-1 : 0] w_addr_psum;
	logic [ADDR_BITWIDTH-1 : 0] w_addr_wght;
	
    logic [DATA_BITWIDTH-1 : 0] w_data_iact;
    logic [DATA_BITWIDTH-1 : 0] w_data_psum;
	logic [DATA_BITWIDTH-1 : 0] w_data_wght;
	
//    logic [DATA_BITWIDTH-1 : 0] r_data_iact;
    logic [DATA_BITWIDTH-1 : 0] r_data_psum;
//   logic [DATA_BITWIDTH-1 : 0] r_data_wght;
	
	logic compute_done;
	
	
	//GLB cluster initialization
	GLB_cluster 
			#(	.DATA_BITWIDTH(DATA_BITWIDTH),
				.ADDR_BITWIDTH(ADDR_BITWIDTH),
				.NUM_GLB_IACT(NUM_GLB_IACT),
				.NUM_GLB_PSUM(NUM_GLB_PSUM),
				.NUM_GLB_WGHT(NUM_GLB_WGHT)
			)
	GLB_cluster_0
			(
				.clk(clk), 
				.reset(reset),
				
				.read_req_iact(router_iact_0.read_req_glb_iact),
				.read_req_psum(read_req_psum),
//				.read_req_wght(read_req_wght),
				.read_req_wght(router_weight_0.read_req_glb_wght),
				
				.write_en_iact(write_en_iact),
				.write_en_psum(write_en_psum),
				.write_en_wght(write_en_wght),
				
				.r_addr_iact(router_iact_0.r_addr_glb_iact),
			    .r_addr_psum(r_addr_psum),
//				.r_addr_wght(r_addr_wght),
				.r_addr_wght(router_weight_0.r_addr_glb_wght),

			    .w_addr_iact(w_addr_iact),
			    .w_addr_psum(w_addr_psum),
				.w_addr_wght(w_addr_wght),

			    .w_data_iact(w_data_iact),
			    .w_data_psum(w_data_psum),
				.w_data_wght(w_data_wght),

			    .r_data_iact(router_iact_0.r_data_glb_iact),
			    .r_data_psum(r_data_psum),
//				.r_data_wght(r_data_wght)
				.r_data_wght(router_weight_0.r_data_glb_wght)
			);

			
	logic [DATA_BITWIDTH-1 : 0] r_data_spad_psum[0:kernel_size-1];		
	
	//Router Cluster Instantiation
	router_cluster#(.DATA_BITWIDTH(DATA_BITWIDTH),
	                .ADDR_BITWIDTH_GLB(ADDR_BITWIDTH_GLB),
	                .ADDR_BITWIDTH_SPAD(ADDR_BITWIDTH_SPAD),

	                .kernel_size(kernel_size),
	                .act_size(act_size),

	                .NUM_ROUTER_PSUM(NUM_ROUTER_PSUM),
	                .NUM_ROUTER_IACT(NUM_ROUTER_IACT),
	                .NUM_ROUTER_WGHT(NUM_ROUTER_WGHT),

	                .A_READ_ADDR(A_READ_ADDR), 
	                .A_LOAD_ADDR(A_LOAD_ADDR),

	                .W_READ_ADDR(W_READ_ADDR), 
	                .W_LOAD_ADDR(W_LOAD_ADDR),

	                .PSUM_READ_ADDR(PSUM_READ_ADDR),
	                .PSUM_LOAD_ADDR(PSUM_LOAD_ADDR)
					)
	router_cluster_0
					(
					.clk(clk),
					.reset(reset),
					
					//Signals for weight router
					.r_data_glb_iact(GLB_cluster_0.r_data_wght),
					.r_addr_glb_wght(GLB_cluster_0.r_addr_wght),
					.read_req_glb_wght(GLB_cluster_0.read_req_wght),

					w_data_spad(w_data_spad_wght),
					load_en_spad_wght(load_en_spad_wght),
					
					load_spad_ctrl_iact(load_spad_ctrl_iact),
					
					
					//Signals for activation router
					.r_data_glb_wght(r_data_glb_wght),
					
					.r_addr_glb_wght(r_addr_glb_wght),
					.read_req_glb_wght(read_req_glb_wght),
					
					.w_data_spad_wght(w_data_spad_wght),
					.load_en_spad_wght(load_en_spad_wght),
					//Input from control unit to load weight
					.load_spad_ctrl_wght(load_spad_ctrl_wght),

					
					//Signals for psum router
					.r_data_spad_psum(r_data_spad_psum),
					
					.w_addr_glb_psum(w_addr_glb_psum),
					.write_en_glb_psum(write_en_glb_psum),
					.w_data_glb_psum(w_data_glb_psum),
					
					//Input from control unit to load weights to spad
					.write_psum_ctrl(write_psum_ctrl)
					);
	

//Declarations for PE_cluster
				
	parameter DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 9;
	parameter int X_dim = 3;
    parameter int Y_dim = 3;
	
	logic [DATA_WIDTH-1:0] act_in;
    logic [DATA_WIDTH-1:0] filt_in;

	logic start;
	logic load_en_wght, load_en_act;

    logic [DATA_WIDTH-1:0] pe_out[X_dim-1:0];
  
	logic load_done;
	
//PE_cluster Instantiation
	PE_cluster #(
					.DATA_WIDTH(DATA_WIDTH),
					.ADDR_WIDTH(ADDR_WIDTH),
					
					.kernel_size(kernel_size),
					.act_size(act_size),
					
					.X_dim(X_dim),
					.Y_dim(Y_dim)
    			)
	pe_cluster_0
    			(
					.clk(clk),
				    .reset(reset),
				    .act_in(w_data_spad_iact),
//				    .filt_in(filt_in),
					.filt_in(w_data_spad_wght),
//				    .load_en(load_en),
					.load_en_wght(load_en_spad_wght),
					.load_en_act(load_en_spad_iact),
					.start(start),
                    .pe_out(router_psum_0.r_data_spad_psum),
					.compute_done(compute_done),
					.load_done(load_done)
					
		//extra
//					.psum_out(psum_out)
    			);
				

	
	integer clk_prd = 10;
	
	always begin
		clk = 0; #(clk_prd/2);
		clk = 1; #(clk_prd/2);
		//0.1GHz
	end
	
	integer kernel_1,act_1;
	integer w_addr = 0;
	int args;
	
	initial begin
		reset = 1; #30;
		reset = 0;
		

		//Write weights to weight glb
		write_en_wght = 1;
		kernel_1 = $fopen("kernel_3x3.txt","r");		
		while(!$feof(kernel_1))begin
			w_addr_wght = w_addr;
			args = $fscanf(kernel_1,"%d\n",w_data_wght);
			$display("Writing value %0d to address %0d in weight glb",w_data_wght,w_addr);
			w_addr++;
			#(clk_prd);
		end
		write_en_wght = 0;
		$fclose(kernel_1); 
		
		
		//Write activations to weight glb
		write_en_iact = 1;
		w_addr = 0;
		act_1 = $fopen("act_5x5.txt","r");
		while(!$feof(act_1))begin
			w_addr_iact = w_addr;
			args = $fscanf(act_1,"%d\n",w_data_iact);
			$display("Writing value %0d to address %0d in iact glb",w_data_iact,w_addr);
			w_addr++;
			#(clk_prd);
		end
		write_en_iact = 0;
		$fclose(act_1); 
		
		
		
		#300;
		load_spad_ctrl_wght = 1; #15;
		load_spad_ctrl_wght = 0;
		
		wait (load_done == 1);
		
		#50;
		load_spad_ctrl_iact = 1; #15;
		load_spad_ctrl_iact = 0;
	
		wait (load_done == 1);
	
		#100;
		
		start = 1; #25; 
		$display("\n\nReading & Computing Begins.....\n\n");
		start = 0;
		
		wait (compute_done == 1);
		$display("\n\nPE_OUT from cluster is:%d\n,%d\n,%d\n",pe_cluster_0.pe_out[0],pe_cluster_0.pe_out[1],pe_cluster_0.pe_out[2]);
		#40
		$display("\n\nFinal PSUM of Iteration 1");
 		for(int i=0; i<X_dim; i++) begin
			$display("\npsum from column %d is:%d",i+1,pe_out[i]);
		end
		
		
		#40;
		start = 1; #25; 
		$display("\n\nReading & Computing Begins for iter 2.....\n\n");
		start = 0;
		
				wait (compute_done == 1);	
		$display("\n\nFinal PSUM of Iteration 2:");
 		for(int i=0; i<X_dim; i++) begin
			$display("\npsum from column %d is:%d",i+1,pe_out[i]);
		end
		
		#40;
		start = 1; #25; 
		$display("\n\nReading & Computing Begins for iter 3.....\n\n");
		start = 0;
		
		wait (compute_done == 1);	
		$display("\n\nFinal PSUM of Iteration 3:");
 		for(int i=0; i<X_dim; i++) begin
			$display("\npsum from column %d is:%d",i+1,pe_out[i]);
		end

	end
	
endmodule
