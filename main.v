

/////////////////////////////////////////////////////////////////////////////////////
// conventions :
// w<a>To<b> : A wire from a to b
// w<a> : a wire

/////////////////////////////////////////////////////////////////////////////////////
// general abreviations

// PC - Program Counter
// PM - ProgramMemory

module main(clock, PMinputDone);

	input clock, reset, PMinputDone;
	
	// control signals from the finite control
	wire wPCDecInc, wLdPC, wDPEnable, wDEnable;
	
	// datapath wires
	wire [15:0] wPCIn;
	wire [15:0] wPCOut;
	wire [3:0] wPMToFC;
	wire [7:0] wBcountToFC;
	wire [15:0] wDPIn;
	wire [15:0] wDPOut;
	wire [7:0] wDataOut;
	wire [7:0] wDataIn;
	
	// deal with these later
	wire [3:0] wPMIn; // involve input to the program memory, maybe make these inputs
	wire wPMEnable
	
	
	// PC stuff
	PC PC0(.clock(clock), .in(wPCIn), .out(wPCOut), .LdPC(wLdPC), .reset(reset));
	PCALU PCALU0(.in(PCOut), .out(wPCIn), .PCDecInc(wPCDecInc));

	
	// PM stuff
	pmemory PM0(
		.address(wPCOut), 
		.clock(clock), 
		.data(wPMIn), 
		.wren(wPMEnable), 
		.q(wPMToFC)
	);
					
	
	control C0(
		.clk(clock), 
		.inputDone(PMInputDone), 
		.reset(reset), 
		.Dout(wDoutout), 
		.BCount(wBCountToFC), 
		.out(wPMtoFC), // why is this called out? it should be the "in" at least
		.DPEnable(wDPEnable), 
		.DEnable(wDEnable), 
		.DOutEnable(wDOutEnable), 
		.BCountEnable(wBCountEnable),
		.DPDecInc(wDPDecInc), 
		.DDecInc(wDDecInc), 
		.PCDecInc(wPDecInc), 
		.BCountDecInc(w),
		.DInChoose(), 
		.LdPC(), 
		.LdOut(), 
		.ResetBCount()
	);

	DP DP0(
		.clock(clock),
		.in(wDPin),
		.out(wDPOut),
		.DPEnable(wDPEnable),
		.reset()
	);

	data D0(
		.address(wDPOut),
		.clock(clock),
		.data(wDataIn),
		.wren(wDEnable),
		.q(wDataOut)
	);

	DOut DOut0(
		.clock(clock),
		.in(wDataOut),
		.out(wDataOut), // Need to make a new wire instead of using wDataOut
		.DOutEnable(DOutEnable),
		.reset()
	);

	DataPtrALU DPALU0(
		.in(wDPOut),
		.DPDecInc(wDPDecInc),
		.out(wDPIn)
	);

	DataALU DALU0(
		.in(wDPOut),
		.DDecInc(wDDecInc),
		.out() // W666 on schematic???
	);

	mux M0(
		.in0(), // W666 on schematic???
		.in1(), // Input from switches
		.choose(DInChoose),
		.out(wDataIn)
	);




	

endmodule



















