module WB_STAGE(
		input wire MemtoReg,
		input wire [31:0] mem_read_data,
		input wire [31:0] mem_alu_result,
		
		output reg [31:0] wb_data
	);

	always @(*)
		begin
			case(MemtoReg)
				1'b0: wb_data <= mem_read_data;
				1'b1: wb_data <= mem_alu_result;
			endcase
		end 

endmodule 