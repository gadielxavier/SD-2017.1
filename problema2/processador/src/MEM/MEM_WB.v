module 	MEM_WB(
				input clk, rst,
				input wire ExRegWrite_in, ExMemtoReg_in,
				input wire [31:0] read_data_in,
				input wire [31:0] alu_result_in,
				input wire [4:0] write_reg_in,

				output reg ExRegWrite_out, ExMemtoReg_out, 
				output reg [31:0] read_data_out,
				output reg [31:0] alu_result_out,
				output reg [4:0] write_reg_out
			);

always @ (posedge rst)
begin
	ExRegWrite_out <= 0;
	ExMemtoReg_out <= 0;
	read_data_out <= 0;
	alu_result_out <= 0;
	write_reg_out <= 0;
end

always@(posedge clk )
begin
	ExRegWrite_out <= ExRegWrite_in;
	ExMemtoReg_out<= ExMemtoReg_out;
	read_data_out <= read_data_in;
	alu_result_out <= alu_result_in;
	write_reg_out <= write_reg_in;
end

endmodule