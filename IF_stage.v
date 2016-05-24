`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:40:32 05/24/2016 
// Design Name: 
// Module Name:    IF_stage 
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
module IF_stage(
	input [31:0]pc, bpc, rpc, jpc,
	input [1:0]PCSrc,
	output [31:0]npc, pc4, ins,
	
	input clk, 
	input [31:0]data,
	input we
);

mux4 mux4_IF(
	.select4(PCSrc),
	.mux4_out(npc),
	.mux4_0(pc4),
	.mux4_1(bpc),
	.mux4_2(rpc),
	.mux4_2(jpc)
);

alu_imm4 alu_IF(
	.pc(pc),
	.pc_plus(pc4)
);

instr_mem instr_mem_IF(
	.a(pc[4:0]),
	.d(data),
	.clk(clk),
	.we(we),
	.spo(ins)
);

endmodule
