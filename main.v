

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
	wire wPCDecInc, wLdPC,
	
	// datapath wires
	wire [15:0] wPCIn;
	wire [15:0] wPCOut;
	wire [3:0] wPMToFC;
	wire [7:0] wBcountToFC;
	
	// deal with these later
	wire [3:0] wPMIn; // involve input to the program memory, maybe make these inputs
	wire wPMEnable
	
	
	// PC stuff
	PC PC0(.clock(clock), .in(wPCIn), .out(wPCOut), .LdPC(wLdPC), .reset(reset));
	PCALU PCALU0(.in(PCOut), .out(wPCIn), .PCDecInc(wPCDecInc));

	
	// PM stuff
	pmemory PM0(.address(wPCOut), 
					.clock(clock), 
					.data(wPMIn), 
					.wren(wPMEnable), 
					.q(wPMToFC));
					
	
	control C0(.clk(clock), 
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
				  .ResetBCount() )

endmodule








input clk,
   inputDone,
	reset,
	input [7:0] Dout,  // output register of Program Data
	input [7:0] BCount,
	input [3:0] out,

    output reg DPEnable, DEnable, DOutEnable, BCountEnable,
    DPDecInc, DDecInc, PCDecInc, BCountDecInc,
    DInChoose, LdPC, LdOut, ResetBCount
    );



















