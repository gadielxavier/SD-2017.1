module pc(
			input clk, rst, pcWrite,
			input [31:0] npc, 
			output reg [31:0] pc_out
			);


always @(posedge clk or posedge rst) begin

	if(rst)begin
		pc_out =  32'b0;
	end

	case(npc)
			32'bxx: pc_out = 0;
			default: begin
				if(pcWrite)
					pc_out = npc;
			end
	endcase

end

endmodule
