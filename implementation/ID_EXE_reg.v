`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:45:35 05/24/2016 
// Design Name: 
// Module Name:    ID_EXE_reg 
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
module reg_ID_EXE(
	input [31:0]da, db, dimm, dpc4,
	input [4:0]drn,
	input [3:0]daluc,
	input dwreg, dm2reg, dwmem, daluimm, dshift, djal,
	input clk, rst_n,
	input [31:0]inst_DE_in,
	input rsrtequ_DE_in,
	output reg [31:0]ea, eb, epc4, eimm,
	output reg [4:0]ern,
	output reg [3:0]ealuc,
	output reg ewreg, em2reg, ewmem, ealuimm, eshift, ejal,
	output reg [31:0]inst_DE_out,
	output reg rsrtequ_DE_out
);

always @ (posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		ewreg <= 0;
		em2reg <= 0;
		ewmem <= 0;
		ealuc <= 0;
		ealuimm <= 0;
		ea <= 0;
		eb <= 0;
		eimm <= 0;
		ern <= 0;
		eshift <= 0;
		ejal <= 0;
		epc4 <= 0;
		inst_DE_out <= 0;
		rsrtequ_DE_out <= 0;
	end
	else
	begin 
		ewreg <= dwreg;
		em2reg <= dm2reg;
		ewmem <= dwmem;
		ealuc <= daluc;
		ealuimm <= daluimm;
		ea <= da;
		eb <= db;
		eimm <= dimm;
		ern <= drn;
		eshift <= dshift;
		ejal <= djal;epc4 <= dpc4;
		inst_DE_out <= inst_DE_in;
		rsrtequ_DE_out <= rsrtequ_DE_in;
	end
end

endmodule
