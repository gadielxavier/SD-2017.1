module pc(
			input clk, rst, 
			input [31:0] npc, 
			output reg [31:0] pc_out
			);


always @(posedge clk) begin 
 if (~rst) begin 
 	pc_out <= 32'b0; 
 	end  
 else  begin 
 	pc_out <= npc;
 	end
end

endmodule