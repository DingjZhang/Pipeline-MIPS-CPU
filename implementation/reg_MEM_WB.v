`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:10:28 05/24/2016 
// Design Name: 
// Module Name:    reg_MEM_WB 
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
module reg_MEM_WB(
	input [31:0]mmo, malu,
	input [4:0]mrn,
	input mwreg, mm2reg,
	input clk, rst_n,
	output reg [31:0]wmo, walu,
	output reg [4:0]wrn,
	output reg wwreg, wm2reg
);

always @ (posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		wwreg <= 0;
		wm2reg <= 0;
		wmo <= 0;
		walu <= 0;
		wrn <= 0;
	end
	else
	begin
		wwreg <= mwreg;
		wm2reg <= mm2reg;
		wmo <= mmo;
		walu <= malu;
		wrn <= mrn;
	end
end

endmodule
