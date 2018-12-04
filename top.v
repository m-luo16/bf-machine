module top(CLOCK_50, SW, KEY, HEX0, HEX1, LEDR);
	input [7:0] SW;
	input [3:0] KEY;
	input CLOCK_50;

	output [6:0] HEX0, HEX1;
	output [5:0] LEDR;
	
	wire [3:0] upper;
	wire [3:0] lower;
	hex h1(
		.num(upper),
		.HEX(HEX1)
		);
	hex h0(
		.num(lower),
		.HEX(HEX0)
		);
	
	main m(
		.clock(KEY[1]), 
		.reset(~KEY[0]), 
		.PMInputDone(0), 
		.DataInputSwitches(SW[7:0]), 
		.out({upper, lower}), 
		.outReady(~KEY[2]), 
		.go(~KEY[3]),
		.state(LEDR[5:0])
		);
endmodule