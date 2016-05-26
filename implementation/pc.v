`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:02:34 05/24/2016 
// Design Name: 
// Module Name:    pc 
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
module pc(
	input [31:0]npc,
	input wpc, clk, rst_n,
	output reg [31:0]pc
);

always @ (posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		pc <= 32'b0;
	end
	else
	begin
		if(wpc) pc <= npc;
		else	pc <= pc;
	end
end

endmodule
