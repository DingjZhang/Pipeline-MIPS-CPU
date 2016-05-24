`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:44 05/24/2016 
// Design Name: 
// Module Name:    IR 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IR(
	input [31:0]pc4, ins,
	input wir, clk, rst_n,
	output [31:0]dpc4, inst
);	

pc pc_plus_4(
	.npc(pc4),
	.clk(clk),
	.wpc(wir),
	.rst_n(rst_n),
	.pc(dpc4)
);
	
pc instruction(
	.npc(ins),
	.clk(clk),
	.wpc(wir),
	.rst_n(rst_n),
	.pc(inst)
);
	



endmodule
