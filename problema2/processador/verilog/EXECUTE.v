module EXECUTE( 
				input wire branch,
				input wire jump,
				input wire AluSrc,
				input wire [5:0] AluOp,
				input wire MemRead,
				input wire MemWrite,
				input wire RegWrite,
				input wire RegDst,
				input wire MemtoReg,
				input wire [31:0] npc,
				input wire [31:0] readdata1,
				input wire [31:0] readdata2,
				input wire [31:0] sigext,
				input wire [4:0] instruction_2015,
				input wire [4:0] instruction_1511,

				output reg branch_out,
				output reg jump_out,
				output reg MemRead_out,
				output reg MemWrite_out,
				output reg MemtoReg_out,
				output reg [31:0] add_out;
				output reg [31:0] alu_out;
				output reg aluzero;
				output reg readdata2_out;
				output reg [5:0] muxRegDst;
				 );

//sigext
wire [15:0] signext_in;
wire [31:0] signext_out;

//control_unity
wire [5:0] opcode_1;
wire branch_eq_1, branch_ne_1;
wire [1:0]	aluop_1;
wire memread_1, memwrite_1, memtoreg_1;
wire regdst_1, regwrite_1, alusrc_1;
wire jump_1;

//regfile
wire [4:0] readRegister1, readRegister2, writeRegister3;
wire [31:0] writeData;
wire [31:0] readData1, readDatad2;

assign signext_in = instruction_in[15:0];
assign readRegister2 = instruction_in[20:16];
assign readRegister1 = instruction_in[25:21];
assign opcode_1 = instruction_in[31:26];


//Instantiantions
muxRegDst muxRegDst_1(
					.regDst(RegDst),
					.entrada0(instruction_1511),
					.entrada1(instruction_2015),
					.resultado(muxRegDst)
				);

control_unity control_unity1(
								.opcode(opcode_1),
								.branch_eq(branch_eq_1),
								.branch_ne(branch_ne_1),
								.aluop(aluop_1),
								.memread(memread_1),
								.memwrite(memwrite_1),
								.memtoreg(memtoreg_1),
								.regdst(regdst_1),
								.regwrite(regwrite_1),
								.alusrc(alusrc_1),
								.jump(jump_1)
							);

RegisterFile RegisterFile_1(

					.ReadRegister1(readRegister1),
					.ReadRegister2(readRegister2),
					.WriteRegister(writeRegister3),
					.WriteData(writeData),
					.Clk(clk),
					.RegWrite(RegWriteFromWB),
					.ReadData1(readData1),
					.ReadData2(readDatad2)
					);

ID_EX ID_EX_1(
				.branch(branch_eq_1),
				.jump(jump_1),
				.AluSrc(alusrc_1),
				.AluOp(aluop_1),
				.MemRead(memread_1),
				.MemWrite(memwrite_1),
				.RegWrite(regwrite_1),
				.RegDst(regdst_1),
				.MemtoReg(memtoreg_1),
				.npc(npc_in),
				.readdata1(readData1),
				.readdata2(readDatad2),
				.sigext(signext_out),
				.instruction_2015(instruction_in[20:15]),
				.instruction_1511(instruction_in[15:11]),

				.branch_out(branch_out_1),
				.jump_out(jump_out_1),
				.AluSrc_out(AluSrc_out_1),
				.AluOp_out(AluOp_out_1),
				.MemRead_out(MemRead_out_1),
				.MemWrite_out(MemWrite_out_1),
				.RegWrite_out(RegWrite_out_1),
				.RegDst_out(RegDst_out_1),
				.MemtoReg_out(memtoreg_1),
				.npc_out(npc_out_1),
				.readdata1_out(readdata1_out_1),
				.readdata2_out(readdata2_out_1),
				.sigext_out(sigext_out_1),
				.instruction_2015_out(instruction_2015_out_1),
				.instruction_1511_out(instruction_1511_out_1)
			);

endmodule
