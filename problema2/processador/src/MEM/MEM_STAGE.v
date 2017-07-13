module MEM_STAGE(
				input wire CLK, RST,
				input wire [1:0] control_wb,
				input wire [31:0] address, writeData, 
				input wire [4:0] write_register,
				input wire MemRead,
				input wire MemWrite,


				output wire control_wb_out_1,
				output wire [31:0] read_data_out_1,
				output wire [31:0] mem_alu_result_1,
				output wire [4:0] mem_write_reg_1
				);

wire [31:0] mem_data_out;


dataMem dataMEm_1(
					.addr(address),
					.clk(CLK),
					.rst(RST),
					.data_in(writeData),
					.data_out(mem_data_out),
					.memRead(MemRead),
					.memWrite(MemWrite)
				);

MEM_WB MEM_WB_1(
				.clk(CLK), 
				.rst(RST),
				.control_wb_in(control_wb),
				.read_data_in(mem_data_out),
				.alu_result_in(address),
				.write_reg_in(write_register),

				.mem_control_wb(control_wb_out_1),
				.read_data_out(read_data_out_1),
				.alu_result_out(mem_alu_result_1),
				.write_reg_out(mem_write_reg_1)
				);

endmodule