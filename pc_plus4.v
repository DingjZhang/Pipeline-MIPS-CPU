`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:15 05/24/2016 
// Design Name: 
// Module Name:    pc_plus4 
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
module alu_imm4(
		input [31:0]pc,
		output [31:0]pc_plus
);

assign pc_plus = pc + 3'd4;

endmodule
