/*
Latch which passes data from the Fetch Stage to
the Decode Stage.
*/

module 	EX_MEM(
				input wire clk, rst, 
				input wire branch, // Combined with a condition test boolean to enable loading the branch target address into the PC. 
				input wire jump, //  Enables loading the jump target address into the PC. 
				input wire MemRead, //  Enables a memory read for load instructions. 
				input wire MemWrite, // Enables a memory write for store instructions. 
				input wire RegWrite, //  Enables a write to one of the registers. 
				input wire MemtoReg, //  Determines where the value to be written comes from (ALU result or memory). 
				input wire [31:0] adder,
				input wire [1:0] aluzero,
				input wire [31:0] alu,
				input wire [31:0] readdata2, 
				input wire [4:0] mux,

				output reg branch_out,
				output reg jump_out,
				output reg MemRead_out,
				output reg MemWrite_out,
				output reg RegWrite_out,
				output reg MemtoReg_out,
				output reg [31:0] adder_out,
				output reg [1:0] aluzero_out,
				output reg [31:0] alu_out,
				output reg [31:0] readdata2_out, 
				output reg [4:0] mux_out
			);

always @(posedge rst)
begin
	branch_out <= 0;
	jump_out <= 0;
	MemRead_out <= 0;
	MemWrite_out <= 0;
	RegWrite_out <= 0;
	MemtoReg_out <= 0;
	adder_out <= 0;
	aluzero_out <= 0;
	alu_out <= 0;
	readdata2_out <= 0; 
	mux_out <= 0;
end

always @(posedge clk) 
begin
	branch_out <= branch;
	jump_out <= jump;
	MemRead_out <= MemRead;
	MemWrite_out <= MemWrite;
	RegWrite_out <= RegWrite;
	MemtoReg_out <= MemtoReg;
	adder_out <= adder;
	aluzero_out <= aluzero;
	alu_out <= alu;
	readdata2_out <= readdata2;
	mux_out <= mux;
end

endmodule