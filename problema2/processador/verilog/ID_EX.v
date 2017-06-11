/*
Latch which passes data from the Fetch Stage to
the Decode Stage.
*/

module 	IF_ID(
				input wire branch, // Combined with a condition test boolean to enable loading the branch target address into the PC. 
				input wire jump, //  Enables loading the jump target address into the PC. 
				input wire AluSrc, //  Selects the second source operand for the ALU (rt or sign-extended immediate field in Patterson and Hennessey). 
				input wire [1:0] AluOp,  //  Either specifies the ALU operation to be performed or specifies that the operation should be determined from the function bits. 
				input wire MemRead, //  Enables a memory read for load instructions. 
				input wire MemWrite, // Enables a memory write for store instructions. 
				input wire RegWrite, //  Enables a write to one of the registers. 
				input wire RegDst, //  Determines how the destination register is specified (rt or rd). 
				input wire MemtoReg, //  Determines where the value to be written comes from (ALU result or memory). 
				input wire [31:0] npc,
				input wire [31:0] readdata1,
				input wire [31:0] readdata2,
				input wire [31:0] sigext, 
				input wire [31:0] instruction_2015,
				input wire [31:0] instruction_1511,


				output reg branch_out,
				output reg jump_out,
				output reg AluSrc_out,
				output reg [1:0] AluOp_out,
				output reg MemRead_out,
				output reg MemWrite_out,
				output reg RegWrite_out,
				output reg RegDst_out,
				output reg MemtoReg_out,
				output reg [31:0] npc_out,
				output reg [31:0] readdata1_out,
				output reg [31:0] readdata2_out,
				output reg [31:0] sigext_out,
				output reg [31:0] instruction_2015_out,
				output reg [31:0] instruction_1511_out
			);

initial
begin
	branch_out <= 0;
	jump_out <= 0;
	AluSrc_out <= 0;
	AluOp_out <= 0;
	MemRead_out <= 0;
	MemWrite_out <= 0;
	RegWrite_out <= 0;
	RegDst_out <= 0;
	MemtoReg_out <= 0;
	npc_out <= 0;
	readdata1_out <=0;
	readdata2_out <= 0;
	sigext_out <= 0;
	instruction_2015_out <=0;
	instruction_1511_out <= 0;
end

always @ * begin
	branch_out <= branch;
	jump_out <= jump;
	AluSrc_out <= AluSrc;
	AluOp_out <= AluOp;
	MemRead_out <= MemRead;
	MemWrite_out <= MemWrite;
	RegWrite_out <= RegWrite;
	RegDst_out <= RegDst;
	MemtoReg_out <= MemtoReg;
	npc_out <= npc;
	readdata1_out <=readdata1;
	readdata2_out <= readdata2;
	sigext_out <= sigext;
	instruction_2015_out <=instruction_2015;
	instruction_1511_out <= instruction_1511;
end

endmodule