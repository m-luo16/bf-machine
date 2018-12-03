`define DAW 8
`define DOW 8

module data3(address, clock, data, wren, q)
  
   input [(`DAW-1):0] address;
   input              clock;
   input [(`DOW-1):0] data;
   input              wren;
   
   output [(`DOW-1):0] q;
   
   reg [(`DOW-1):0]    data[2**(`DAW)-1:0];

   initial
     begin
        for(i=0; i<2**(`DAW); i++) data[i] <= `DOW'b0;        
     end
   
   
   always @(posedge clock)
     begin
        if (wren)
          begin
             data[address] <= data;             
          end 
        data <= data[address];        
     end

   always @(posedge reset)
     begin
        for(i=0; i<2**(`DAW); i++) data[i] <= `DOW'b0;
     end

endmodule
