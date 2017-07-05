module 	MEM_WB(
				input clk, rst,
				input wire [1:0] control_wb_in,
				input wire [31:0] read_data_in,
				input wire [31:0] alu_result_in,
				input wire [4:0] write_reg_in,

				output reg [1:0] mem_control_wb,
				output reg [31:0] read_data_out,
				output reg [31:0] alu_result_out,
				output reg [31:0] write_reg_out
			);

always @ (posedge rst)
begin
	mem_control_wb <= 0;
	read_data_out <= 0;
	alu_result_out <= 0;
	write_reg_out <= 0;
end

always@(posedge clk )
begin
	mem_control_wb <= control_wb_in;
	read_data_out <= read_data_in;
	alu_result_out <= alu_result_in;
	write_reg_out <= write_reg_in;
end

endmodule