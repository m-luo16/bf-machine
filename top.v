module top(CLOCK_50, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	input CLOCK_50;

	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [5:0] LEDR;
	
	wire [3:0] upper;
	wire [3:0] lower;
	
	wire [3:0] DPupper;
	wire [3:0] DPlower;
	
	wire [3:0] PCupper;
	wire [3:0] PClower;
	
	wire clock;
	
	hex h1(
		.num(upper),
		.HEX(HEX1)
		);
	hex h0(
		.num(lower),
		.HEX(HEX0)
		);
		
	hex h5(
		.num(PCupper),
		.HEX(HEX5)
		);
		
	hex h4(
		.num(PClower),
		.HEX(HEX4)
		);
		
	hex h3(
		.num(DPupper),
		.HEX(HEX3)
		);
		
	hex h2(
		.num(DPlower),
		.HEX(HEX2)
		);
		
	clock1 clk(
		.clock(CLOCK_50),
		.out(clock)
		);
	
	main m(
		.clock(clock), 
		.reset(~KEY[0]), 
		.PMInputDone(~KEY[1]), 
		.DataInputSwitches(SW[7:0]), 
		.out({upper, lower}), 
		.outReady(~KEY[2]), 
		.go(~KEY[3]),
		.state(LEDR[5:0]),
		.pc({PCupper, PClower}),
		.dp({DPupper, DPlower})
		);
		
endmodule