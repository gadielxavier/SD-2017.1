module I_DECODE( 

				input wire [31:0] instruction_in, npc_in,
				input wire clk,
				input wire RegWriteFromWB,


				output wire branch_out_1,
				output wire jump_out_1,
				output wire AluSrc_out_1,
				output wire [1:0] AluOp_out_1,
				output wire MemRead_out_1,
				output wire MemWrite_out_1,
				output wire RegWrite_out_1,
				output wire RegDst_out_1,
				output wire MemtoReg_out_1,
				output wire [31:0] npc_out_1,
				output wire [31:0] readdata1_out_1,
				output wire [31:0] readdata2_out_1,
				output wire [31:0] sigext_out_1,
				output wire [31:0] instruction_2015_out_1,
				output wire [31:0] instruction_1511_out_1

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
signext signext_1(
					.a(signext_in), 
					.y(signext_out)
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
