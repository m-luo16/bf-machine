module data3(address, clock, data, wren, reset, q);
   input [7:0] address;
   input              clock;
   input [7:0] data;
   input              wren;
   input              reset;
   
   output reg [7:0] q;
   
   reg [7:0]    data_all[255:0];
   reg [7:0] i;

   initial
     begin
        for(i=0; i<255; i=i+8'b1) data_all[i] <= 8'b0;        
     end
      
   always @(posedge clock)
     begin
        if (wren)
          begin
             data_all[address] <= data;             
          end 
        q <= data_all[address];
			if (reset)
				begin
					for(i=0; i<255; i=i+1) data_all[i] <= 0;
				end
     end
endmodule
