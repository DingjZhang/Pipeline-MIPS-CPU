`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:14:47 05/24/2016 
// Design Name: 
// Module Name:    cu 
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

module cu(
	input mwreg, ewreg, em2reg, mm2reg, rsrtequ,
	input [4:0]mrn, ern, rs, rt,
	input [5:0]op, func,
	input [31:0]inst_j_bug,
	input rsrtequ_j_bug,
	output wreg, m2reg, wmem, regrt, aluimm, sext, shift, jal,
	output [3:0]aluc,
	output reg [1:0]pcsource,
	output reg [1:0]fwda, fwdb,
	output nostall
);

wire r_type, i_add, i_sub, i_and, i_xor, i_or, i_sll, i_srl, i_sra, i_jr;
wire i_addi, i_andi, i_ori, i_xori, i_lw, i_sw, i_beq, i_bne, i_lui, i_j, i_jal;
wire i_rs, i_rt;

assign r_type = ((op == 6'b0) ? 1 : 0);

assign i_add = (r_type && (func == 6'b100000)) ? 1 : 0;
assign i_sub = (r_type && (func == 6'b100010)) ? 1 : 0;
assign i_and = (r_type && (func == 6'b100100)) ? 1 : 0;
assign i_or = (r_type && (func == 6'b100101)) ? 1 : 0;
assign i_xor = (r_type && (func == 6'b100110)) ? 1 : 0;
assign i_sll = (r_type && (func == 6'b000000)) ? 1 : 0;
assign i_srl = (r_type && (func == 6'b000010)) ? 1 : 0;
assign i_sra = (r_type && (func == 6'b000011)) ? 1 : 0;
assign i_jr = (r_type && (func == 6'b001000)) ? 1 : 0;

assign i_addi = (op == 6'b001000) ? 1 : 0;
assign i_andi = (op == 6'b001100) ? 1 : 0;
assign i_ori = (op == 6'b001101) ? 1 : 0;
assign i_xori = (op == 6'b001110) ? 1 : 0;
assign i_lw = (op == 6'b100011) ? 1 : 0;
assign i_sw = (op == 6'b101011) ? 1 : 0;
assign i_beq = (op == 6'b000100) ? 1 : 0;
assign i_bne = (op == 6'b000101) ? 1 : 0;
assign i_lui = (op == 6'b001111) ? 1 : 0;
assign i_j = (op == 6'b000010) ? 1 : 0;
assign i_jal = (op == 6'b000011) ? 1 : 0;

assign i_rs = (i_add | i_sub | i_and | i_or | i_xor | i_jr | i_addi | 
	i_andi | i_ori | i_xori | i_lw | i_sw | i_beq | i_bne) ? 1 : 0;
	
assign i_rt = (i_add | i_sub | i_and | i_or | i_xor | i_sll | i_srl | 
	i_sra | i_sw | i_beq | i_bne) ? 1 : 0;
	
assign nostall = ~(ewreg & em2reg & (ern != 0) & (i_rs & (ern == rs) | i_rt & (ern == rt)));

always @ (ewreg or mwreg or ern or mrn or em2reg or mm2reg or rs or rt)
begin
	fwda = 2'b00; //default forward no hazards
	if(ewreg & (ern != 0) & (ern == rs) & ~em2reg)
	begin
		fwda = 2'b01;
	end
	else
	begin
		if(mwreg & (mrn != 0) & (mrn == rs) & ~mm2reg)
		begin
			fwda = 2'b10;
		end
		else
		begin
			if(mwreg & (mrn != 0) & (mrn == rs) & mm2reg)
			begin
				fwda = 2'b11;
			end
		end
	end
	fwdb = 2'b00;
	if(ewreg & (ern != 0) & (ern == rt) & ~em2reg)
	begin
		fwdb = 2'b01;
	end
	else if(mwreg & (mrn != 0) & (mrn == rt) & ~mm2reg)
	begin
		fwdb = 2'b10;
	end
	else if(mwreg & (mrn != 0) & (mrn == rt) & mm2reg)
	begin
		fwdb = 2'b11;
	end
end

assign wreg = (i_add | i_sub | i_and | i_or | i_xor | i_xor | i_sll | i_srl | 
	i_sra | i_addi | i_andi | i_ori | i_xori | i_lw | i_lui | i_jal) & nostall;

assign regrt = i_addi | i_andi | i_ori | i_xori | i_lw | i_lui;
assign jal = i_jal;
assign m2reg = i_lw;
assign shift = i_sll | i_srl | i_sra;
assign aluimm = i_addi | i_andi | i_ori | i_xori | i_lw | i_lui | i_sw;
assign sext = i_addi | i_lw | i_sw | i_beq | i_bne;
assign aluc[3] = i_sra;
assign aluc[2] = i_sub | i_or | i_srl | i_sra | i_ori | i_lui;
assign aluc[1] = i_xor | i_sll | i_srl | i_sra | i_xori | i_beq | i_bne | i_lui;
assign aluc[0] = i_and | i_or | i_sll | i_sra | i_srl | i_andi | i_ori;
assign wmem = i_sw & nostall;

//assign pcsource[1] = i_jr | i_j | i_jal;
//assign pcsource[0] = i_beq & rsrtequ | i_bne & ~rsrtequ | i_j | i_jal;
always @ (*)
begin
	if((inst_j_bug[31:26] == 6'b000101) & ~rsrtequ_j_bug | (inst_j_bug[31:26] == 6'b000100) & rsrtequ_j_bug)
	begin
		pcsource <= 2'd0;
	end
	else
	begin
		pcsource[1] = i_jr | i_j | i_jal;
		pcsource[0] = i_beq & rsrtequ | i_bne & ~rsrtequ | i_j | i_jal;
	end
end

endmodule
