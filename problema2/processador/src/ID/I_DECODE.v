module I_DECODE( 

				input wire [31:0] instruction_in, npc_in,
				input wire CLK, RST, 
				input wire RegWriteFromWB,
				input wire [4:0]  writeRegister3,
				input wire [4:0] EXRegRt_wire,
				input wire [31:0] writeData,
				input wire EXMemRead_wire,


				output wire PCWrite_wire,
				output wire branch_out_1,
				output wire jump_out_1,
				output wire AluSrc_out_1,
				output wire [5:0] AluOp_out_1,
				output wire MemRead_out_1,
				output wire MemWrite_out_1,
				output wire RegWrite_out_1,
				output wire RegDst_out_1,
				output wire MemtoReg_out_1,
				output wire [31:0] npc_out_1,
				output wire [31:0] readdata1_out_1,
				output wire [31:0] readdata2_out_1,
				output wire [31:0] sigext_out_1,
				output wire [4:0] instruction_2521_out_1,
				output wire [4:0] instruction_2016_out_1,
				output wire [4:0] instruction_1511_out_1,
				output wire IFIDWrite_wire,
				output wire branchTaken,
				output wire [31:0] add_outWire 

				 );

//sigext
wire [15:0] signext_in;
wire [31:0] signext_out;

//control_unity
wire [5:0] opcode_1;
wire branch_eq_1, branch_ne_1;
wire [5:0]	aluop_1;
wire memread_1, memwrite_1, memtoreg_1;
wire regdst_1, regwrite_1, alusrc_1;
wire jump_1;

//regfile
wire [4:0] readRegisterRs, readRegisterRt, readRegisterRd;
wire [31:0] readData1, readDatad2;

//shift2
wire [31:0] shift2_outWire;


//hazard
wire HazMuxCon_wire;

//and
wire zero;

assign signext_in = instruction_in[15:0];
assign readRegisterRd = instruction_in[15:11]; //rd
assign readRegisterRt = instruction_in[20:16]; //rt
assign readRegisterRs = instruction_in[25:21]; //rs
assign opcode_1 = instruction_in[31:26];


//Instantiantions
signext signext_1(
					.a(signext_in), 
					.y(signext_out)
				);

shiftLeft2 shiftLeft2_1(
						.in(signext_out),
						.out(shift2_outWire)
					);

adder adder_1(
				.add_in1(npc_in),
				.add_in2(shift2_outWire),
				.add_out(add_outWire)
		);

and branch (branchTaken, branch_eq, zero);

control_unity control_unity1(
								.clk(CLK),
								.rst(RST),
								.opcode(opcode_1),
								.hazardMux(HazMuxCon_wire), //caso haja bolha zera sinais

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

					.ReadRegister1(readRegisterRs),
					.ReadRegister2(readRegisterRt),
					.WriteRegister(writeRegister3),
					.WriteData(writeData),
					.clk(CLK),
					.rst(RST),
					.RegWrite(RegWriteFromWB),
					.ReadData1(readData1),
					.ReadData2(readDatad2)
					);

ID_EX ID_EX_1(
				.clk(CLK),
				.rst(RST),
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
				.instruction_2521(readRegisterRs), //rs
				.instruction_2016(readRegisterRt), //rt
				.instruction_1511(readRegisterRd), //rd

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
				.instruction_2521_out(instruction_2521_out_1),
				.instruction_2016_out(instruction_2016_out_1),
				.instruction_1511_out(instruction_1511_out_1)
			);

HazardUnit HazardUnit_1(
						.IDRegRs(readRegisterRs),
						.IDRegRt(readRegisterRt),
						.EXRegRt(EXRegRt_wire),
						.EXMemRead(EXMemRead_wire),
						.PCWrite(PCWrite_wire),
						.IFIDWrite(IFIDWrite_wire),
						.HazMuxCon(HazMuxCon_wire)
					);

assign zero =  (readData1 ==  readDatad2)? 1'b1:1'b0; 

endmodule
