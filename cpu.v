`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:17 05/24/2016 
// Design Name: 
// Module Name:    cpu 
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
module cpu(
	input clk, memclk, rst_n,
	output [31:0]pc, inst, ealu, malu, walu
);

wire [31:0]bpc, jpc, npc, pc4, ins, dpc4, inst, da, db, dimm, ea, eb, eimm;
wire [31:0]epc4, mb, mmo, wmo, wdi;
wire [4:0]drn, ern0, ern, mrn, wrn;
wire [3:0]adluc, ealuc;
wire [1:0]pcsource;
wire wpcir;
wire dwreg, dmreg, dwmem, daluimm, dshift;
wire ewreg, em2reg, ewmem, ealuimm, eshift, ejail;
wire mwreg, mm2reg, mwmem;
wire wwreg, wm2reg;

pc prog_cnt(
	.npc(npc),
	.clk(clk),
	.wpc(wpcir),
	.rst_n(rst_n),
	.pc(pc)
);

IF_stage IF_module(
	.PCSrc(pcsource),
	.pc(pc),
	.bpc(bpc),
	.rpc(da),
	.jpc(jpc),
	.npc(npc),
	.pc4(pc4),
	.ins(ins)
);

IR IR_module(
	.pc4(pc4),
	.ins(ins),
	.wir(wpcir),
	.clk(clk),
	.rst_n(rst_n),
	.dpc4(dpc4),
	.inst(inst)
);

ID_stage ID_module(
	.mwreg(mwreg),
	.mrn(mrn),
	.ern(ern),
	.ewreg(ewreg),
	.em2reg(em2reg),
	.mm2reg(mm2reg),
	.dpc4(dpc4),
	.inst(inst),
	.wrn(wrn),
	.wdi(wdi),
	.ealu(ealu),
	.malu(malu),
	.mmo(mmo),
	.wwreg(wwreg),
	.clk(clk),
	.rst_n(rst_n),
	.bpc(bpc),
	.jpc(jpc),
	.pcsource(pcsource),
	.nostall(wpcir),
	.wreg(dwreg),
	.m2reg(dm2reg),
	.wmem(dwmem),
	.aluc(daluc),
	.aluimm(daluimm),
	.a(da),
	.b(db),
	.imm(dimm),
	.rn(drn),
	.shift(dshift),
	.jal(djal)
);



endmodule
