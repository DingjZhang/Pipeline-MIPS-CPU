`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:57:43 05/24/2016 
// Design Name: 
// Module Name:    ID_stage 
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
module ID_stage(
	input [31:0]dpc4, inst, wdi, ealu, malu, mmo,
	input [4:0]ern, mrn, wrn,
	input mwreg, ewreg, em2reg, mm2reg, wwreg,
	input clk, rst_n,
	output [31:0]bpc, jpc, a, b, imm,
	output [4:0]rn,
	output [3:0]aluc,
	output [1:0]pcsource,
	output nostall, wreg, m2reg, wmem, aluimm, shift, jal
);

wire [5:0]op, func;
wire [4:0]rs, rt, rd;
wire [31:0]qa, qb, br_offset;
wire [15:0]ext16;
wire [1:0]fwda, fwdb;
wire regrt, sext, rsrtequ, e;

assign func = inst[5:0];
assign op = inst[31:26];
assign rs = inst[25:21];
assign rt = inst[20:16];
assign rd = inst[15:11];
assign jpc = {dpc4[31:28], inst[25:0], 2'b00};

cu control_unit(
	.mwreg(mwreg),
	.mrn(mrn),
	.ern(ern),
	.ewreg(ewreg),
	.em2reg(em2reg),
	.mm2reg(mm2rreg),
	.rsrtequ(rsrtequ),
	.func(func),
	.op(op),
	.rs(rs),
	.rt(rt),
	.wreg(wreg),
	.m2reg(m2reg),
	.wmem(wmem),
	.aluc(aluc),
	.regrt(regrt),
	.aluimm(aluimm),
	.fwda(fwda),
	.fwdb(fwdb),
	.nostall(nostall),
	.sext(sext),
	.pcsource(pcsource),
	.shift(shift),
	.jail(jail)
);

reg_file reg_files(
	.rna(rs),
	.rnb(rt),
	.d(wdi),
	.wn(wrn),
	.we(wwreg),
	.clk(~clk),
	.rst_n(rst_n),
	.qa(qa),
	.qb(qb)
);

assign rn = regrt ? rt : rs;

mux4 mux4_ID_1(
	.mux4_0(qa),
	.nux4_1(ealu),
	.mux4_2(malu),
	.mux4_3(mmo),
	.select4(fwda),
	.mux4_out(a)
);

mux4 mux4_ID_2(
	.mux4_0(qb),
	.mux4_1(ealu),
	.mux4_2(malu),
	.mux4_3(mmo),
	.select4(fwdb),
	.mux4_out(b)
);

assign rsrtequ = ~|(a ^ b);
assign e = sext & inst[15];
assign ext16 = {16{e}};
assign imm = {ext16, inst[15:0]};
assign br_offset = {imm[29:0], 2'b00};

alu_add alu_add_ID(
	.a(dpc4),
	.b(br_offset),
	.out(bpc)
);

endmodule
