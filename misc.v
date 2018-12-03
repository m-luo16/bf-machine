module DataPtrALU (in, DPDecInc, out);
	input [7:0] in;
	input DPDecInc;
	output [7:0] out;
	
	assign out = DPDecInc? in - 1: in + 1;

endmodule



module DataALU (in, DDecInc, out);
	input [7:0] in;
	input DDecInc;
	output [7:0] out;
	
	assign out = DDecInc? in - 1: in + 1;

endmodule



module PCALU (in, PCDecInc, out);

	input [7:0] in;
	input PCDecInc;
	output [7:0] out;
	
	assign out = PCDecInc? in - 1: in + 1;

endmodule

module mux8(in0, in1, choose, out);
	input [7:0] in0, in1;
	input choose;
	output reg [7:0] out;

	always @(*)
	begin
		if (choose)
			out = in1;
		else
			out = in0;
	end
endmodule



