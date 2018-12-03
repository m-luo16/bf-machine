`define PMAW 8


module pmemory2 (
   input [(`PMAW-1):0] addr,
   input clock, 
   output reg [3:0] q
);

   reg [3:0] rom[2**(`PMAW)-1:0];
   initial // Read the memory contents in the file
           // dual_port_rom_init.txt. 
   begin
      $readmemb("rom_init.txt", rom);
   end
   always @ (posedge clock)
   begin
      q <= rom[addr];
   end
	
endmodule
