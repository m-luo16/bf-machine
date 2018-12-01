module control(
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

    reg [5:0] current_state, next_state; 
    
    localparam
    start = 6'd0, // Start state: reset PC, data_ptr amd memory to zero
    read = 6'd1, // Reading the command that PC is pointing to
    PCinc = 6'd2, // Increment the PC to the next command
    q0 = 6'd3, // Decrement the data pointer
    q1 = 6'd4, // Increment the data pointer
    q2 = 6'd5, // Load Dout with the value at the data pointer
    q21 = 6'd6, // Increment value at pointer by 1
    q3 = 6'd7, // Load Dout with the value at the data pointer
    q31 = 6'd8, // Decrement value by 1
    q4 = 6'd9, // Start of "loop". Load Dout with the value at the data pointer.
    q41 = 6'd10, // Check value of Dout. 
    q42 = 6'd11, // Dout = 0. We don't execute any instructions until we find the right closing brace. Start BCount at 1. Increment the PC.
    q43 = 6'd12, // Read the command that PC is now pointing to. 
    q44 = 6'd13, // Command read was a "]", decrement BCount by 1. 
    q45 = 6'd14, // Check the value of BCount. Move to PCInc if BCount = 0. (We found the matching close brace). Otherwise move to q47 (forward).
    q46 = 6'd15, // Command wasn't a "[" or a "]", increment the PC, go forward to q43 and read the next instruction. (Non brace commands are ignored)
    q47 = 6'd28, // BCount wasn't 0 after the previous "]" (Haven't found correct closing brace). Increment PC and try again. 
    q5 = 6'd16, // End of "loop". Load Dout with the value at the data pointer.
    q51 = 6'd17, // Check value of Dout.
    q52 = 6'd18, // Dout != 0. We want to go backwards and find the appropriate opening brace. Start BCount at 1. Decrement the PC. 
    q53 = 6'd19, // Read the command that PC is now pointing to.
    q54 = 6'd20, // Command read was a "[", decrement BCount by 1.
    q55 = 6'd21, // Check the value of BCount. Move to PCInc if BCount = 0. (We found the matching open brace). Otherwise move to q57 (backward).
    q56 = 6'd22, // Command wasn't a "[" or a "]", increment the PC, go back to q53 and read the next instruction. (Non brace commands are ignored)
	q57 = 6'd29, // BCount wasn't a 0 ofter the previous "[" (Haven't found correct opening brace). Decrement PC and try again. 
    q6 = 6'd23, // Get ready to display whatever data pointer is pointing to. 
    q61 = 6'd24, // Load Dout onto out.
    q7 = 6'd25, // Get ready to store the value on input switches to whatever data pointer is pointing to. 
	q71 = 6'd26, // Load the value on input switches. Increment PC after. 
    stop = 6'd27, // PC command was stop. Transition to start and get ready to do more commands. 
    INVALID = 6'b111111,
    smaller = 4'b0000,
    greater = 4'b0001,
    plus = 4'b0010,
    minus = 4'b0011,
    openBracket = 4'b0100,
    closeBracket = 4'b0101,
    dot = 4'b0110,
    comma = 4'b0111,
	 stop_c = 4'b1111;
    
    // Next state logic aka our state table
    always@(*)

    begin: state_table 
	 	if (reset) begin
		next_state = start;
	end
	else
        case (current_state)
           start: next_state = read;
			  PCinc: next_state = read;
            read: begin
                case (out)
                    smaller: next_state <= q0;
                    greater: next_state <= q1;
                    plus: next_state <= q2;
                    minus: next_state <= q3;
                    openBracket: next_state <= q4;
                    closeBracket: next_state <= q5;
                    dot: next_state <= q6;
                    comma: next_state <= q7;
                    stop_c: next_state <= stop;
                    default: next_state <= INVALID;
                endcase
            end
            q0: next_state <= PCinc;
            q1: next_state <= PCinc;
            q2: next_state <= q21;
            q3: next_state <= q31;
            q21: next_state <= PCinc;
            q31: next_state <= PCinc;
            q4: next_state <= q41;
            q41: begin
                case (Dout)
                    0: next_state = q42;
                    default: next_state = PCinc;
                endcase
            end
            q42: next_state = q43;
            q43: begin
                case (out)
                    closeBracket: next_state = q44;
                    openBracket: next_state = q42;
                    default: next_state = q46;
                endcase
            end
            q44: next_state = q45;
            q45: begin
                case (BCount)
                    0: next_state = PCinc;
                    default: next_state = q45;
                endcase
            end
            q46: next_state = q47;
				q47: next_state = q43;
            q5: next_state = q51;
            q51: begin
                case (Dout)
                    0: next_state = PCinc;
                    default: next_state = q52;
                endcase
            end
            q52: next_state = q53;
            q53: begin
                case (out)
                    closeBracket: next_state = q52;
                    openBracket: next_state = q54;
                    default: next_state = q56;
                endcase
            end
            q54: next_state = q55;
            q55: begin
                case (BCount)
                    0: next_state = PCinc;
                    default: next_state = q53;
                endcase
            end
            q56: next_state = q57;
				q57: next_state = q53;
            q6: next_state = q61;
            q61: next_state = PCinc;
            q7: next_state = inputDone ? q71 : q7;
				q71: next_state = !inputDone ? PCinc: q71;
            stop: next_state = start;
            default: next_state = start;
        endcase
    end // state_table
	
    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        DPEnable = 0;
        DEnable = 0;
        DOutEnable = 0;
        BCountEnable = 0;
        DPDecInc = 0;
        DDecInc = 0;
        PCDecInc = 0;
        BCountDecInc = 0;
        DInChoose = 0;
        LdPC = 0;
        LdOut = 0;
        ResetBCount = 0;

        case (current_state)
        start: begin
        end
        read: begin
        end
        PCinc: begin
        end
        q0: begin
        DPEnable = 1;
        DPDecInc = 1;
        end
        q1: begin
        DPEnable = 1;
        DPDecInc = 0;
        end
        q2: begin
        DOutEnable = 1;
        DDecInc = 0;
        end
        q21: begin
        DDecInc = 0;
        DEnable = 1;
        end
        q3: begin
        DOutEnable = 1;
        DDecInc = 1;
        end
        q31: begin
        DDecInc = 1;
        DEnable = 1;
        end
        q4: begin
        DOutEnable = 1;
        ResetBCount = 1;
        end
        q41: begin
        end
        q42: begin
        BCountEnable = 1;
        BCountDecInc = 0;
        LdPC = 1;
        PCDecInc = 0;
        end
        q43: begin
        end
        q44: begin
        BCountEnable = 1;
        BCountDecInc = 1;
        end
        q45: begin
        end
        q46: begin
        LdPC = 1;
        PCDecInc = 0;
        end
		  q47: begin
		  LdPC = 1;
		  PCDecInc = 0;
        q5: begin
        DOutEnable = 1;
        ResetBCount = 1;
        end
        q51: begin
        end
        q52: begin
        BCountEnable = 1;
        BCountDecInc = 0;
        LdPC = 1;
        PCDecInc = 1;
        end
        q53: begin
        end
        q54: begin
        BCountEnable = 1;
        BCountDecInc = 0;
        end
        q55: begin
        end
        q56: begin
        LdPC = 1;
        PCDecInc = 1;
        end
		  q57: begin
		  LdPC = 1;
		  PCDecInc = 1;
        q6: begin
        DOutEnable = 1;
        end
        q61: begin
        LdOut = 1;
        end
        q7: begin
        DInChoose = 1;
        DEnable = 1;
        end
        stop: begin
        end
        default: begin
		  end
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
            current_state <= next_state;
    end // state_FFS
endmodule
