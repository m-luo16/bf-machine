module hex (num, HEX);
	input [3:0]num;
	output [6:0]HEX;

	assign HEX[0] = ~(~num[2] & ~num[0] | ~num[0] & num[3] & num[2] | num[3] & ~num[2] & ~num[1] | num[2] & num[1] & num[0] | ~num[3] & num[2] & num[0] | ~num[3] & num[1]);
	assign HEX[1] = ~(~num[2] & ~num[0] | ~num[3] & ~num[2] | ~num[3] & ~num[1] & ~num[0] | num[3] & ~num[1] & num[0] | ~num[3] & num[1] & num[0]);
	assign HEX[2] = ~(num[3] & ~num[2] | ~num[3] & num[2] | ~num[1] & num[0] | ~num[3] & num[0] | ~num[3] & ~num[1] | ~num[3] & ~num[1] & num[0]);
	assign HEX[3] = ~(num[3] & ~num[1] | ~num[3] & ~num[2] & ~num[0] | num[2] & ~num[1] & num[0] | num[3] & ~num[2] & num[0] | num[2] & num[1] & ~num[0] | ~num[3]  & ~num[2] & num[1]);
	assign HEX[4] = ~(~num[2] & ~num[0] | num[3] & num[2] | num[3] & num[1] | num[1] & ~num[0]);
	assign HEX[5] = ~(~num[1] & ~num[0] | num[2] & ~num[0] | ~num[3] & num[2] & ~num[1] | num[3] & ~num[2] | num[3] & num[1]);
	assign HEX[6] = ~(num[3] & ~num[2] | num[3] & num[0] |  num[1] & ~num[0] | ~num[3] & ~num[2] & num[1] | ~num[3] & num[2] & ~num[1]);
endmodule
