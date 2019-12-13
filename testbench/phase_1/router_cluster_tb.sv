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
	
	parameter DATA_WIDTH = 16;
    parameter ADDR_WIDTH = 9;
	
	// GLB Cluster parameters. This TestBench uses only 1 of each
    parameter NUM_GLB_IACT = 1;
    parameter NUM_GLB_PSUM = 1;
	parameter NUM_GLB_WGHT = 1;
	
	parameter ADDR_BITWIDTH_GLB = 10;
	parameter ADDR_BITWIDTH_SPAD = 9;
	
	parameter NUM_ROUTER_PSUM = 1;
	parameter NUM_ROUTER_IACT = 1;
	parameter NUM_ROUTER_WGHT = 1;
			
	parameter int kernel_size = 3;
    parameter int act_size = 5;
	
	parameter int X_dim = 3;
    parameter int Y_dim = 3;
	
	//Used inside PEs
/* 	parameter W_READ_ADDR = 0;  
    parameter A_READ_ADDR_PE = 100;
    
    parameter W_LOAD_ADDR = 0;  
    parameter A_LOAD_ADDR_PE = 100;
    
    parameter PSUM_ADDR = 500; */
	
	parameter W_READ_ADDR = 0;  
    parameter A_READ_ADDR = 0;
    
    parameter W_LOAD_ADDR = 0;  
    parameter A_LOAD_ADDR = 0;
	
	parameter PSUM_READ_ADDR = 0;
	parameter PSUM_LOAD_ADDR = 0;
	
	int cycles, pe_cycles;
	
    logic clk;
    logic reset;

	//logic for GLB cluster
//    logic read_req_iact;
	logic read_req_psum;
//	logic read_req_wght;
	
    logic write_en_iact;
//	logic write_en_psum;
	logic write_en_wght;
	
			
	logic load_spad_ctrl_wght;
	logic load_spad_ctrl_iact;
		
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
				.clk(clk),   //TestBench/Controller
				.reset(reset),  //TestBench/Controller
				
				//Signals for reading from GLB
				.read_req_iact(router_cluster.read_req_glb_iact),
				.read_req_psum(read_req_psum), //Read by testbench/controller
				.read_req_wght(router_cluster_0.read_req_glb_wght),
				
			    .r_data_iact(router_cluster_0.r_data_glb_iact),
			    .r_data_psum(r_data_psum), //Read by testbench/controller
				.r_data_wght(router_cluster_0.r_data_glb_wght),
				
				.r_addr_iact(router_cluster_0.r_addr_glb_iact),
			    .r_addr_psum(r_addr_psum), //testbench for reading final psums
				.r_addr_wght(router_cluster_0.r_addr_glb_wght),

				
				//Signals for writing to GLB
			    .w_addr_iact(w_addr_iact), //testbench for writing
			    .w_addr_psum(router_cluster_0.w_addr_glb_psum),
				.w_addr_wght(w_addr_wght), //testbench for writing
 
			    .w_data_iact(w_data_iact), //testbench for writing
			    .w_data_psum(router_cluster_0.w_data_glb_psum),
				.w_data_wght(w_data_wght), //testbench for writing

				.write_en_iact(write_en_iact), //testbench for writing
				.write_en_psum(router_cluster_0.write_en_glb_psum),
				.write_en_wght(write_en_wght) //testbench for writing
			
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
					.clk(clk),  //TestBench/Controller
					.reset(reset),  //TestBench/Controller
					
					//Signals for activation router
					.r_data_glb_iact(GLB_cluster_0.r_data_iact),
					.r_addr_glb_iact(GLB_cluster_0.r_addr_iact),
					.read_req_glb_iact(GLB_cluster_0.read_req_iact),

					.w_data_spad_iact(pe_cluster_0.act_in),
					.load_en_spad_iact(pe_cluster_0.load_en_act),
					
					.load_spad_ctrl_iact(load_spad_ctrl_iact), //TestBench/Controller
					
					
					//Signals for weight router
					.r_data_glb_wght(GLB_cluster_0.r_data_wght),
					.r_addr_glb_wght(GLB_cluster_0.r_addr_wght),
					.read_req_glb_wght(GLB_cluster_0.read_req_wght),
					
					.w_data_spad_wght(pe_cluster_0.filt_in),
					.load_en_spad_wght(pe_cluster_0.load_en_wght),

					.load_spad_ctrl_wght(load_spad_ctrl_wght), //TestBench/Controller

					
					//Signals for psum router
					.r_data_spad_psum(pe_cluster_0.pe_out),
					
					.w_addr_glb_psum(GLB_cluster_0.w_addr_psum),
					.write_en_glb_psum(GLB_cluster_0.write_en_psum),
					.w_data_glb_psum(GLB_cluster_0.w_data_psum),
					
					.write_psum_ctrl(pe_cluster_0.compute_done) //Connected to compute done of PE
					);
	

//Declarations for PE_cluster
				

	
	logic [DATA_WIDTH-1:0] act_in;
    logic [DATA_WIDTH-1:0] filt_in;

	logic start;
	logic load_en_wght, load_en_act;

    logic [DATA_WIDTH-1:0] pe_out[X_dim-1:0];
  
	logic load_done; //TestBench/Controller
	
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
					.clk(clk), 	   //TestBench/Controller
				    .reset(reset), //TestBench/Controller
					.start(start), //TestBench/Controller
					
				    .act_in(router_cluster_0.w_data_spad_iact),
					.filt_in(router_cluster_0.w_data_spad_wght),
					
					.load_en_wght(router_cluster_0.load_en_spad_wght),
					.load_en_act(router_cluster_0.load_en_spad_iact),
					
                    .pe_out(router_cluster_0.r_data_spad_psum),
					.compute_done(router_cluster_0.write_psum_ctrl),
					.load_done(load_done) //TestBench/Controller
    			);
				

	
	integer clk_prd = 10;
	
	always begin
		clk = 0; #(clk_prd/2);
		clk = 1; #(clk_prd/2);
		//0.1GHz
	end
	
	integer kernel_1,act_1,psum_1;
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
		
		
		assign pe_out = pe_cluster_0.pe_out;
		assign compute_done = pe_cluster_0.compute_done;
		
		#(clk_prd);
		load_spad_ctrl_wght = 1; #15;
		load_spad_ctrl_wght = 0;
		
		wait (load_done == 1);
		
		#(clk_prd);
		load_spad_ctrl_iact = 1; #15;
		load_spad_ctrl_iact = 0;
	
		wait (load_done == 1);
	
		#(clk_prd);
		
		start = 1; 
		pe_cycles = cycles;
		#25; 
		$display("\n\nReading & Computing Begins.....\n\n");
		start = 0;
		
		wait (compute_done == 1);
		pe_cycles = cycles - pe_cycles;
		
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

		
		//Write Outputs to file
		
		$display("Total Cycles taken(including data transfer): %0d", cycles);
		$display("Total Cycle taken for computation: %0d", pe_cycles*3);
		$finish;
		
		#100;
		read_req_psum = 1;
		psum_1 = $fopen("./psum_3x3.txt","w");
		if (psum_1)  $display("File was opened successfully : %0d", psum_1);
		else     $display("File was NOT opened successfully : %0d", psum_1);
		for(int p=0; p<kernel_size**2; p++) begin
			r_addr_psum = p;
//			$fwrite(psum_1,"%d\n",r_data_psum);
			$fwrite(psum_1,"Hello\n");
			$display("Writing value %0d from address %0d GLB_psum to output text file",r_data_psum,p);
			#(clk_prd);
		end
		read_req_psum = 0;
		$fclose(psum_1);
		
		
	end

		
		// track # of cycles
		always @(posedge clk)
		begin
			if (reset)
				cycles = 0;
			else
				cycles = cycles + 1;
		end
		
endmodule
