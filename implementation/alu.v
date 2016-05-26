`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:11:44 05/24/2016 
// Design Name: 
// Module Name:    alu 
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
/*
module alu(
	input signed [31:0]a,
	input signed [31:0]b,
	input [3:0]aluc,
	output [31:0]r,
	output z
);

wire [31:0]d_and = a & b;
wire [31:0]d_or = a | b;
wire [31:0]d_xor = a ^ b;
wire [31:0]d_lui = {b[15:0], 15'b0};
wire [31:0]d_and_or = aluc[2] ? d_or : d_and;
wire [31:0]d_xor_lui = aluc[2] ? d_lui : d_xor;
wire [31:0]d_as, d_sh;

assign d_as = aluc[2] ? (a - b) : (a + b);
shift shifter(
	.d(b),
	.sa(a[4:0]),
	.right(aluc[2]),
	.arith(aluc[3]),
	.sh(d_sh)
);

mux4 mux4_EXE(
	.mux4_0(d_as),
	.mux4_1(d_and_or),
	.mux4_2(d_xor_lui),
	.mux4_3(d_sh),
	.select4(aluc[1:0]),
	.mux4_out(r)
);
assign z = ~|r;

endmodule
*/

module alu(
	input signed [31:0]a,
	input signed [31:0]b,
	input [3:0]aluc,
	output reg [31:0]r,
	output z
);

parameter ADD = 3'b000;
parameter SUB = 3'b100;
parameter AND = 3'b001;
parameter OR = 3'b101;
parameter XOR = 3'b010;
parameter LUI = 3'b10;
parameter SLL = 3'b011;
parameter SRL_A = 3'b111;

always @ (*)
begin
	case(aluc[2:0])
		ADD: r = a + b;
		SUB: r = a - b;
		AND: r = a & b;
		OR: r = a | b;
		XOR: r = a ^ b;
		LUI: r = {b[15:0], 16'h0};
		SLL: r = b << a[4:0];
		SRL_A:
			if(aluc[3] == 1'b0) r = b >> a[4:0];
			else r = b >>> a[4:0];
	endcase
end

assign z = ~|r;

endmodule
