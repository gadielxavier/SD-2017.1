module pc(input [31:0] npc, 
			output reg [31:0] pc_out
			);

initial
begin
	/* Initial thread which will set pc_out to zero
	on the first run
	*/
	pc_out <=0;
end

always @(npc) begin
// Update value of PC
	#1	
	pc_out <= npc;

end

endmodule