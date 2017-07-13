module MEM_STAGE(
				input wire CLK, RST,
				input wire ExRegWrite_in, ExMemtoReg_in,
				input wire [31:0] address, writeData, 
				input wire [4:0] write_register,
				input wire MemRead,
				input wire MemWrite,


				output wire ExRegWrite_out_1, ExMemtoReg_out_1, MEM_RegWrite_wire,
				output wire [31:0] read_data_out_1,
				output wire [31:0] mem_alu_result_1,
				output wire [4:0] mem_write_reg_1, MEMRegRd_wire,
				output wire [31:0] regExMem
				);

wire [31:0] mem_data_out;

assign regExMem = address;
assign MEMRegRd_wire = write_register;
assign  MEM_RegWrite_wire = ExRegWrite_in;


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
				.ExRegWrite_in(ExRegWrite_in), 
				.ExMemtoReg_in(ExMemtoReg_in),
				.read_data_in(mem_data_out),
				.alu_result_in(address),
				.write_reg_in(write_register),

				.ExRegWrite_out(ExRegWrite_out_1), 
				.ExMemtoReg_out(ExMemtoReg_out_1),
				.read_data_out(read_data_out_1),
				.alu_result_out(mem_alu_result_1),
				.write_reg_out(mem_write_reg_1)
				);

endmodule