module clock1(clock, out);

	input clock;
	output reg out;
	
	reg [7:0] counter; 
	
	initial begin
		counter <= 0;
		out <= 0;
	end
	
	
	always@(posedge clock) begin
		if (counter == 8'd50)
		begin 
			if(out == 1)
			begin
				out <= 0;
			end
			else begin 
				out <= 1; 
			end
			counter <= 0;
		end
			counter <= counter + 1;
	end
endmodule
