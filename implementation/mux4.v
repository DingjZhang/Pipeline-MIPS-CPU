`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:35:08 05/24/2016 
// Design Name: 
// Module Name:    mux4 
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
module mux4(
	input [31:0]mux4_1, mux4_2, mux4_3, mux4_0,
	output reg [31:0]mux4_out,
	input [1:0]select4
);

always @ (*)
begin
	case(select4)
		2'd0: mux4_out = mux4_0;
		2'd1: mux4_out = mux4_1;
		2'd2: mux4_out = mux4_2;
		2'd3: mux4_out = mux4_3;
		default: mux4_out = mux4_0;
	endcase
end


endmodule
