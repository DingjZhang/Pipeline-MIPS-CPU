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


wire [31:0]bpc, jpc, npc, pc4, ins, dpc4, da, db, dimm, ea, eb, eimm;
wire [31:0]epc4, mb, mmo, wmo, wdi;
wire [4:0]drn, ern0, ern, mrn, wrn;
wire [3:0]daluc, ealuc;
wire [1:0]pcsource;
wire wpcir;
wire dwreg, dm2reg, dwmem, daluimm, dshift;
wire ewreg, em2reg, ewmem, ealuimm, eshift, ejal;
wire mwreg, mm2reg, mwmem;
wire wwreg, wm2reg;
wire [31:0]inst_CU;
wire rsrtequ_CU;
wire rsrtequ_output;

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
	.inst_j_bug(inst_CU),
	.rsrtequ_j_bug(rsrtequ_CU),
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
	.jal(djal),
	.rsrtequ_output(rsrtequ_output)
);

reg_ID_EXE ID_EXE(
	.inst_DE_in(inst),
	.inst_DE_out(inst_CU),
	.rsrtequ_DE_in(rsrtequ_output),
	.rsrtequ_DE_out(rsrtequ_CU),
	.dwreg(dwreg),
	.dm2reg(dm2reg),
	.dwmem(dwmem),
	.daluc(daluc),
	.daluimm(daluimm),
	.da(da),
	.db(db),
	.dimm(dimm),
	.drn(drn),
	.dshift(dshift),
	.djal(djal),
	.dpc4(dpc4),
	.clk(clk),
	.rst_n(rst_n),
	.ewreg(ewreg),
	.em2reg(em2reg),
	.ealuc(ealuc),
	.ealuimm(ealuimm),
	.ea(ea),
	.eb(eb),
	.eimm(eimm),
	.ern(ern0),
	.eshift(eshift),
	.ejal(ejal),
	.epc4(epc4),
	.ewmem(ewmem)
);

EXE_stage EXE_module(
	.ealuc(ealuc),
	.ealuimm(ealuimm),
	.ea(ea),
	.eb(eb),
	.eimm(eimm),
	.eshift(eshift),
	.ern0(ern0),
	.epc4(epc4),
	.ejal(ejal),
	.ern(ern),
	.ealu(ealu)
);

reg_MEM_WB MEM_WB_reg(
	.mwreg(mwreg),
	.mm2reg(mm2reg),
	.mmo(mmo),
	.malu(malu),
	.mrn(mrn),
	.clk(clk),
	.rst_n(rst_n),
	.wwreg(wwreg),
	.wm2reg(wm2reg),
	.wmo(wmo),
	.walu(walu),
	.wrn(wrn)
);

reg_EXE_MEM EXE_MEM_reg(
	.ewreg(ewreg),
	.em2reg(em2reg),
	.ewmem(ewmem),
	.ealu(ealu),
	.eb(eb),
	.ern(ern),
	.clk(clk),
	.rst_n(rst_n),
	.mwreg(mwreg),
	.mm2reg(mm2reg),
	.mwmem(mwmem),
	.malu(malu),
	.mb(mb),
	.mrn(mrn)
);

data_mem MEM_module(
	.a(malu[4:0]),
	.d(mb),
	.clk(memclk),
	.we(mwmem),
	.spo(mmo)
);

assign wdi = wm2reg ? wmo : walu;

endmodule
