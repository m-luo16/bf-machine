module control(
    input clk,
    input command, // Current command the PC is pointing to
    input Dout, // output register of Program Data
    input [7:0] BCount
    input inputDone,

    output reg DPEnable, DEnable, DOutEnable, BCountEnable,
    DPDecInc, DDecInc, PCDecInc, BCountDecInc,
    DInChoose, LdPC, LdOut, ResetBCount
    );

    reg [5:0] current_state, next_state; 
    
    localparam
    start = 4'd0, // Start state
    read = 4'd1, // Reading the command that PC is pointing to
    PCinc = 4'd2, // Increment the PC to the next command
    q0 = 4'd3, // Decrement the data pointer
    q1 = 4'd4, // Increment the data pointer
    q2 = 4'd5, // Load Dout with the value at the data pointer
    q21 = 4'd6, // Increment Dout by 1
    q3 = 4'd7, // Load Dout with the value at the data pointer
    q31 = 4'd8, // Decrement Dout by 1
    q4 = 4'd9, // Start of "loop". Load Dout with the value at the data pointer.
    q41 = 4'd10, // Check value of Dout. 
    q42 = 4'd11,
    q43 = 4'd12,
    q44 = 4'd13,
    q45 = 4'd14,
    q46 = 4'd15,
    q5 = 4'd16,
    q51 = 4'd17
    q52 = 4'd18,
    q53 = 4'd19,
    q54 = 4'd20,
    q55 = 4'd21,
    q56 = 4'd22
    q6 = 4'd23,
    q61 = 4'd24,
    q7 = 4'd25,
    stop = 4'd26,
    INVALID = 4'b111111,
    smaller = 4'b0000,
    greater = 4'b0001,
    plus = 4'b0010,
    minus = 4'b0011,
    openBracket = 4'b0100,
    closeBracket = 4'b0101,
    dot = 4'b0110,
    comma = 4'b0111;
    
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
        case (current_state)
           start: next_state <= read;
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
                    stop: next_state <= stop;
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
            q46: next_state = q43;
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
            q56: next_state = q53;
            q6: next_state = q61;
            q61: next_state = PCinc;
            q7: next_state = inputDone ? PCInc : q7;
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
        q5: begin
        DOutEnable = 1;
        ResetBCount = 1;
        end
        q51: begin
        end
        q52: begin
        BCountEnable = 1;
        BCountDecInc = 1;
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
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
            current_state <= next_state;
    end // state_FFS
endmodule
