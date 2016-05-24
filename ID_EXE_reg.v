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
module ID_EXE_reg(
	input [31:0]da, db, dimm, dpc4,
	input [4:0]drn,
	input [3:0]daluc,
	input dwreg, dm2reg, dwmem, daluimm, dshift, djal,
	input clk, rst_n,
	output reg [31:0]ea, eb, epc4, eimm,
	output reg [4:0]ern,
	output reg [3:0]ealuc,
	output reg ewreg, em2reg, ewmem, ealuimm, eshift, ejal
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
	end
end

endmodule
