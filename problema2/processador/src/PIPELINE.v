module PIPELINE(

	input wire clk, rst,

	//IF
	output wire [31:0] IF_ID_INSTR,
	output wire [31:0] IF_ID_NPC,

	//ID
	output wire [31:0] npc_out_2,
	output wire [31:0] readdata1_out_2,
	output wire [31:0] readdata2_out_2,
	output wire [31:0] sigext_out_2,
	output wire [4:0] instruction_2521_out_2,
	output wire [4:0] instruction_2016_out_2,
	output wire [4:0] instruction_1511_out_2,

	//EX
	output wire [31:0] alu_out,
	output wire [31:0] readdata2_out,
	output wire [4:0] muxRegDst_out,

	//MEM
	output wire [31:0] read_data_out_1,
	output wire [31:0] mem_alu_result_1,

	//WB
	output wire[31:0] wb_data
);


//IF outputs


//ID outputs
wire PCWrite_2;
wire branch_out_2;
wire jump_out_2;
wire AluSrc_out_2;
wire [5:0] AluOp_out_2;
wire MemRead_out_2;
wire MemWrite_out_2;
wire RegWrite_out_2;
wire RegDst_out_2;
wire MemtoReg_out_2;
wire IFIDWrite_wire;
wire [31:0] shift2_outWire_2;
wire branchTaken_2;
wire [31:0] add_outWire_2;


//EX Outputs
wire branch_out;
wire [4:0] ExRt;
wire jump_out;
wire MemRead_out;
wire MemWrite_out;
wire RegWrite_out;	
wire MemtoReg_out;


//MEM outputS
wire ExRegWrite_out;
wire ExMemtoReg_out;
wire MEM_RegWrite_wire;
wire [4:0] mem_write_reg_1;
wire [4:0] MEMRegRd_wire;
wire [31:0] regExMem;

//WB outputs



I_FETCH I_FETCH_1 (
	.BRANCH(branchTaken_2),
	.RST(rst),
	.CLK(clk),
	.IFIDWrite(IFIDWrite_wire_2),
    .PC_WRITE(PCWrite_2),
	.EX_MEM_NPC(add_outWire_2),

	.IF_ID_INSTR(IF_ID_INSTR),
	.IF_ID_NPC(IF_ID_NPC)
);

I_DECODE I_DECODE_1(
	.instruction_in(IF_ID_INSTR),
	.npc_in(IF_ID_NPC),
	.CLK(clk),
	.RST(rst),
	.RegWriteFromWB(ExRegWrite_out),
	.writeRegister3(mem_write_reg_1),
	.EXRegRt_wire(ExRt),
	.writeData(wb_data),
	.EXMemRead_wire(MemRead_out),

	.PCWrite_wire(PCWrite_2),
	.branch_out_1(branch_out_2),
	.jump_out_1(jump_out_2),
	.AluSrc_out_1(AluSrc_out_2),
	.AluOp_out_1(AluOp_out_2),
	.MemRead_out_1(MemRead_out_2),
	.MemWrite_out_1(MemWrite_out_2),
	.RegWrite_out_1(RegWrite_out_2),
	.RegDst_out_1(RegDst_out_2),
	.MemtoReg_out_1(MemtoReg_out_2),
	.npc_out_1(npc_out_2),
	.readdata1_out_1(readdata1_out_2),
	.readdata2_out_1(readdata2_out_2),
	.sigext_out_1(sigext_out_2),
	.instruction_2521_out_1(instruction_2521_out_2),
	.instruction_2016_out_1(instruction_2016_out_2),
	.instruction_1511_out_1(instruction_1511_out_2),
	.IFIDWrite_wire(IFIDWrite_wire_2),
	.branchTaken(branchTaken_2),
	.add_outWire(add_outWire_2)
);


EXECUTE EXECUTE_1(
 	.CLK(clk),
	.RST(rst),
	.branch(branch_out_2),
	.jump(jump_out_2),
	.AluSrc(AluSrc_out_2),
	.opcode(AluOp_out_2),
    .MemRead(MemRead_out_2),
    .MemWrite(MemWrite_out_2),
    .RegWrite(RegWrite_out_2),
    .RegDst(RegDst_out_2),
    .MemtoReg(MemtoReg_out_2),
    .npc(npc_out_2),
    .readdata1(readdata1_out_2),
    .readdata2(readdata2_out_2),
    .sigext(sigext_out_2),
    .instruction_2521(instruction_2521_out_2),
    .instruction_2016(instruction_2016_out_2),
    .instruction_1511(instruction_1511_out_2),
    .MEMRegRd_wire(MEMRegRd_wire),
    .WBRegRd_wire(mem_write_reg_1),
    .MEM_RegWrite_wire(MEM_RegWrite_wire),
    .WB_RegWrite_wire(ExRegWrite_out),
    .regMemWb(wb_data),
    .regExMem(regExMem),

    .branch_out(branch_out),
    .ExRt(ExRt),
    .jump_out(jump_out),
    .MemRead_out(MemRead_out),
    .MemWrite_out(MemWrite_out),
    .RegWrite_out(RegWrite_out),
    .MemtoReg_out(MemtoReg_out),
    .alu_out(alu_out),
    .readdata2_out(readdata2_out),
    .muxRegDst_out(muxRegDst_out)
);

MEM_STAGE MEM_STAGE_TEST_1(
	.CLK(clk), 
	.RST(rst),
	.ExRegWrite_in(RegWrite_out), 
	.ExMemtoReg_in(MemtoReg_out),
	.address(alu_out), 
	.writeData(readdata2_out), 
	.write_register(muxRegDst_out),
	.MemRead(MemRead_out),
	.MemWrite(MemWrite_out),

	.ExRegWrite_out_1(ExRegWrite_out),
	.ExMemtoReg_out_1(ExMemtoReg_out),
	.MEM_RegWrite_wire(MEM_RegWrite_wire),
	.read_data_out_1(read_data_out_1),
	.mem_alu_result_1(mem_alu_result_1),
	.mem_write_reg_1(mem_write_reg_1),
	.MEMRegRd_wire(MEMRegRd_wire),
	.regExMem(regExMem)
);

WB_STAGE WB_STAGE_1(
	.MemtoReg(ExMemtoReg_out),
	.mem_read_data(read_data_out_1),
	.mem_alu_result(mem_alu_result_1),

	.wb_data(wb_data)
);

endmodule