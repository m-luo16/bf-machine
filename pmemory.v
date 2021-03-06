module pmemory2 (
   input [7:0] address,
   input clock, 
   output reg [3:0] q
);

   reg [3:0] rom[2**8-1:0];
   initial // Read the memory contents in the file
           // dual_port_rom_init.txt. 
   begin
      $readmemb("./bf_programs/decrement.bfo", rom);
   end
   always @ (*)
   begin
      q <= rom[address];
   end
	
endmodule
