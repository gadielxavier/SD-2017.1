/*
Latch which passes data from the Fetch Stage to
the Decode Stage.
*/

module 	IF_ID(
				input wire clk, rst, 
				input wire [31:0] instruction_in, npc_in,
				output reg [31:0] instruction_out, npc_out
			);

always @(posedge rst)
begin
	instruction_out <= 0;
	npc_out <=0;
end

always @(posedge clk) 
begin
	instruction_out <= instruction_in;
	npc_out <= npc_in;
end

endmodule