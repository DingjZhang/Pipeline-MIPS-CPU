`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:15:18 05/24/2016 
// Design Name: 
// Module Name:    reg_file 
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
module reg_file(
	input [4:0]rna, rnb, wn,
	input [31:0]d,
	input we, clk, rst_n,
	output [31:0]qa, qb
);
integer i;
reg [31:0]registers[0:31];

assign qa = (rna == 0) ? 0 : registers[rna];
assign qb = (rnb == 0) ? 0 : registers[rnb];

always @ (posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		
		for(i = 0; i < 32; i = i + 1)
		begin
			registers[i] = 0;
		end
	end
	else if((wn != 0) && we)
	begin
		registers[wn] <= d;
	end
end


endmodule
