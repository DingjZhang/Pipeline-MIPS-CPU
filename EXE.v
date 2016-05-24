`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:53:11 05/24/2016 
// Design Name: 
// Module Name:    EXE 
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
module EXE(
	input [31:0]ea, eb, eimm, epc4,
	input [4:0]ern0,
	input [3:0]ealuc,
	input ealuimm, eshift, ejal,
	output [31:0]ealu,
	output [4:0]ern
);

wire [31:0]alua, alub, sa, ealu0, epc8;
wire z;
assign sa = {eimm[5:0], eimm[31:6]};

alu_imm4 alu_imm4_EXE(
	.pc(epc4),
	.pc_plus(epc8)
);

assign alua = eshift ? sa : ea;
assign alub = ealuimm ? eimm : eb;
assign ealu = ejal ? epc8 : ealu0;
assign ern = ern0 | {5{ejal}};

alu alu_EE(
	.a(alua),
	.b(alub),
	.aluc(ealuc),
	.r(ealu0),
	.z(z)
);


endmodule
