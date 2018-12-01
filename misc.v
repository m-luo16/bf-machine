module DataPtrALU (in, DPDecInc, out);


	input [15:0] in;
	input DPDecInc;
	output [15:0] out;
	
	assign out = DPDecInc? in - 16'b1: in + 16'b1;

endmodule



module DataALU (in, DDecInc, out);
	input [7:0] in;
	input DDecInc;
	output [7:0] out;
	
	assign out = DDecInc? in - 8'b1: in + 8'b1;

endmodule



module PCALU (in, PCDecInc, out);

	input [15:0] in;
	input PCDecInc;
	output [15:0] out;
	
	assign out = PCDecInc? in - 16'b1: in + 16'b1;

endmodule

module mux(in0, in1, choose, out);
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



