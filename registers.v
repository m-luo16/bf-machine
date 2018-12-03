module PC (clock, in, out, LdPC, reset);
	input clock;
	input [7:0] in;
	input LdPC;
	input reset;
	output reg [7:0] out;

	
	always @(posedge clock)
	begin
		if (reset)
		begin
			out <= 0;
		end
		else if (LdPC)
		begin
			out <= in;
		end
	end
	
endmodule


module BCount (clock, out, BCountDecInc, BCountEnable, reset);
	input clock;
	input BCountDecInc;
	input BCountEnable;
	input reset;
	
	output [7:0] out;
	
	reg [7:0] out;
	
	always @(posedge clock)
	begin
		if (reset)
		begin
			out <= 0;
		end
		else if (BCountEnable & !BCountDecInc)
		begin
			out <= out + 1;
		end
		else if (BCountEnable & BCountDecInc)
		begin
			out <= out - 1;
		end
	end

endmodule



module DP (clock, in, out, DPEnable, reset);
	input clock, DPEnable, reset;
	input [7:0] in;
	output reg [7:0] out;

	always @(posedge clock)
	begin
		if (reset)
	  	begin
	  		out <= 0;
		end
		else if (DPEnable)
		begin
			out <= in;
		end
	end
endmodule

module DOut (clock, in, out, DOutEnable, reset);
	input clock, DOutEnable, reset;
	input [7:0] in;
	output reg [7:0] out;

	always @(posedge clock)
	begin
		if (reset)
		begin
			out <= 0;
		end
		else if (DOutEnable)
		begin
			out <= in;
		end
	end
endmodule
