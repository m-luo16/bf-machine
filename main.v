

/////////////////////////////////////////////////////////////////////////////////////
// conventions :
// w<a>To<b> : A wire from a to b
// w<a> : a wire

/////////////////////////////////////////////////////////////////////////////////////
// general abreviations

// PC - Program Counter
// PM - ProgramMemory

	module main(clock, reset, PMInputDone, DataInputSwitches, 
				   ProgramAddrIn, ProgramDataIn, ProgramInEnable, out);

		input clock, reset, PMInputDone;
		input [7:0] DataInputSwitches;
		input [15:0] ProgramAddrIn;
		input ProgramInEnable;
		input [3:0] ProgramDataIn;
		
		
		// control signals from the finite control
		wire wDoutout, wPMtoFC, 
			  wDPEnable, wDEnable, wDOutEnable, wBCountEnable,
			  wDPDecInc, wDDecInc, wPCDecInc, wBCountDecInc,
			  wDInChoose, wLdPC, wLdOut, wResetBCount;

		wire [15:0] wm1ToPM;
		wire wm2ToPM;
		
		
	
		// datapath wires
		wire [15:0] wPCIn;
		wire [15:0] wPCOut;
		wire [3:0] wPMToFC;
		wire [7:0] wBCountToFC;
		wire [15:0] wDPIn;
		wire [15:0] wDPOut;
		wire [7:0] wDataOut;
		wire [7:0] wDataIn;
		wire [7:0] w666;
		wire [7:0] wDOutOut;
		
		
		// deal with these later		
		output [7:0] out;
		assign out = wDOutOut;
		
	
	// PC stuff
	PC PC0(.clock(clock), .in(wPCIn), .out(wPCOut), .LdPC(wLdPC), .reset(reset));
	PCALU PCALU0(.in(wPCOut), .out(wPCIn), .PCDecInc(wPCDecInc));

	
	//assign wPMEnable = 1; // always be able to write to PM
	
	// PM stuff
	pmemory PM0(
		.address(wm1ToPM), 
		.clock(wm2ToPM), 
		.data(ProgramDataIn), 
		.wren(reset), 
		.q(wPMToFC)
	);
					
	//mux(in0, in1, choose, out);
	mux m2( .in0(clock), .in1(ProgramInEnable), .choose(reset), .out(wm2ToPM) );
	mux m1( .in0(wPCOut), .in1(ProgramAddrIn), .choose(reset), .out(wm1ToPM) );

	
	
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
		.PCDecInc(wPCDecInc), 
		.BCountDecInc(wBCountDecInc),
		.DInChoose(WDInChoose), 
		.LdPC(wLdPC), 
		.LdOut(wLdOut), 
		.ResetBCount(wResetBCount)
	);
	
	
	BCount BCount0(
		.clock(clock),
		.out(wBCountToFC),
		.BCountDecInc(wBCountDecInc),
		.BCountEnable(wBCountEnable),
		.reset(reset));
		

	DP DP0(
		.clock(clock),
		.in(wDPIn),
		.out(wDPOut),
		.DPEnable(wDPEnable),
		.reset(reset)
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
		.out(wDOutOut),
		.DOutEnable(wDOutEnable),
		.reset(reset)
	);

	DataPtrALU DPALU0(
		.in(wDPOut),
		.DPDecInc(wDPDecInc),
		.out(wDPIn)
	);

	DataALU DALU0(
		.in(wDPOut),
		.DDecInc(wDDecInc),
		.out(w666) // W666 on schematic???
	);

	mux M0(
		.in0(w666), // W666 on schematic???
		.in1(DataInputSwitches), // Input from switches
		.choose(wDInChoose),
		.out(wDataIn)
	);




endmodule



















