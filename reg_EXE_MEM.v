`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:57:23 05/24/2016 
// Design Name: 
// Module Name:    reg_EXE_MEM 
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
module reg_EXE_MEM(
	input [31:0]ealu, eb,
	input [4:0]ern,
	input ewreg, em2reg, ewmem,
	input clk, rst_n,
	output reg [31:0]malu, mb,
	output reg [4:0]mrn,
	output reg mwreg, mm2reg, mwmem
);

always @ (posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		mwreg <= 0;
		mm2reg <= 0;
		mwreg <= 0;
		malu <= 0;
		mb <= 0;
		mrn <= 0;
	end
	else
	begin
		mwreg <= ewreg;
		mm2reg <= em2reg;
		mwmem <= ewmem;
		malu <= ealu;
		mb <= eb;
		mrn <= ern;
	end
end

endmodule
