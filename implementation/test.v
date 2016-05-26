`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:30:39 05/25/2016
// Design Name:   cpu
// Module Name:   D:/cslab/pipeline_cpu/test.v
// Project Name:  pipeline_cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module test;

	// Inputs
	reg clk;
	reg memclk;
	reg rst_n;
	// Outputs
	wire [31:0] pc;
	wire [31:0] inst;
	wire [31:0] ealu;
	wire [31:0] malu;
	wire [31:0] walu;
	
	
	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.clk(clk), 
		.memclk(memclk), 
		.rst_n(rst_n), 
		.pc(pc), 
		.inst(inst), 
		.ealu(ealu), 
		.malu(malu), 
		.walu(walu)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		memclk = 0;
		rst_n = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst_n = 1;
        
		// Add stimulus here

	end
	
	always #50 clk  = ~clk;
	always #50 memclk = ~memclk;
      
endmodule

