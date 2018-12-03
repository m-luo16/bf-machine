`define PMAW 8
`define DAW 8
`define DOW 8

/////////////////////////////////////////////////////////////////////////////////////
// conventions :
// w<a>To<b> : A wire from a to b
// w<a> : a wire

/////////////////////////////////////////////////////////////////////////////////////
// general abreviations

// PC - Program Counter
// PM - ProgramMemory

module main(clock, reset, PMInputDone, DataInputSwitches, out, outReady, go);

   input clock, reset, PMInputDone;
   input [7:0] DataInputSwitches;
   input       go;
   
   input      outReady;
   
   wire        DOutout;
    
   wire	       wDPEnable, wDEnable, wDOutEnable, wBCountEnable,
	       wDPDecInc, wDDecInc, wPCDecInc, wBCountDecInc,
	       wDInChoose, wLdPC, wLdOut, wResetBCount;
   
   
   
   // datapath wires
   wire [7:0] wPCIn;
   wire [7:0] wPCOut;
   wire [3:0]  wPMToFC;
   wire [7:0]  wBCountToFC;
   wire [7:0] wDPIn;
   wire [7:0] wDPOut;
   wire [7:0]  wDataOut;
   wire [7:0]  wDataIn;
   wire [7:0]  w666;
   wire [7:0]  wDOutOut;
   
   
   // deal with these later		
   output [7:0] out;
   assign out = wDOutOut;
   
   
   // PC stuff
   PC PC0(.clock(clock), 
	  .in(wPCIn), 
	  .out(wPCOut), 
	  .LdPC(wLdPC), 
	  .reset(reset));
   
   
   PCALU PCALU0(.in(wPCOut), 
		.out(wPCIn), 
		.PCDecInc(wPCDecInc));

   // PM stuff
   pmemory2 PM0(
		.address(wPCOut), 
		.clock(clock), 
		.q(wPMToFC)
	        );
   
   // do
   control C0(
	      .clk(clock), 
	      .inputDone(PMInputDone), 
	      .reset(reset), 
	      .Dout(wDOutOut), 
	      .BCount(wBCountToFC), 
	      .in(wPMToFC),
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
	      .ResetBCount(wResetBCount),
	      .ResetOutsideCounters(reset),	      
	      .go(go)
	      );
   
   // end do	
   
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
   
   data3 D0(.address(wDPOut), 
	    .clock(clock), 
	    .data(wDataIn), 
	    .wren(wDEnable),
            .reset(reset),
	    .q(wDataOut));

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

   mux8 M0(
	  .in0(w666), // W666 on schematic???
	  .in1(DataInputSwitches), // Input from switches
	  .choose(wDInChoose),
	  .out(wDataIn)
	  );

endmodule



















