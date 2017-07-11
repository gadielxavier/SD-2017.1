module EXECUTE( 
				input CLK, RST,
				input wire branch,
				input wire jump,
				input wire AluSrc,
				input wire [5:0] opcode,
				input wire MemRead,
				input wire MemWrite,
				input wire RegWrite,
				input wire RegDst,
				input wire MemtoReg,
				input wire [31:0] npc,
				input wire [31:0] readdata1,
				input wire [31:0] readdata2,
				input wire [31:0] sigext,
				input wire [4:0] instruction_2521,
				input wire [4:0] instruction_2016,
				input wire [4:0] instruction_1511,
				input wire [4:0] MEMRegRd_wire,
				input wire [4:0] WBRegRd_wire,
				input wire MEM_RegWrite_wire,
				input wire WB_RegWrite_wire,
				input wire [31:0]regMemWb,
				input wire [31:0]regExMem,

				output wire branch_out,
				output wire jump_out,
				output wire MemRead_out,
				output wire MemWrite_out,
				output wire MemtoReg_out,
				output wire [31:0] add_out1,
				output wire [31:0] alu_out,
				output wire aluzero_out,
				output wire readdata2_out,
				output wire [5:0] muxRegDst_out
				 );

//adder
wire [31:0] add_outWire; 

//muxAluSrc 
wire [31:0] muxAluSrc_outWire;

//muxRegDst
wire [4:0] muxRegDst_outWire;

//ALUdec
wire [3:0] ALUop_outWire;
wire [5:0] funct_inWire;

//ALU
wire [31:0] ALU_outWire;
wire flagZeroWire;

//shift2
wire [31:0] shift2_outWire;

//Forward Unity
wire [1:0] ForwardA_wire;
wire [1:0] ForwardB_wire;

assign funct_inWire = sigext[5:0];


//Instantiantions
adder adder_1(
				.add_in1(npc),
				.add_in2(shift2_outWire),
				.add_out(add_outWire)
		);
muxAluSrc muxAluSrc_1(
					.aluSrc(AluSrc),
					.entrada0(ALUSrcB),
					.entrada1(sigext),
					.resultado(muxAluSrc_outWire)
		);

muxRegDst muxRegDst_1(
					.regDst(RegDst),
					.entrada0(instruction_1511),
					.entrada1(instruction_2016),
					.resultado(muxRegDst_outWire)
				);

ALUdec ALUdec_1(
				.funct(funct_inWire),
				.opcode(opcode),
				.ALUop(ALUop_outWire)
		);

ALU ALU_1(
		.A(ALUSrcA),
		.B(muxAluSrc_outWire),
    	.ALUop(ALUop_outWire),
    	.Out(ALU_outWire),
    	.flagZero(flagZeroWire)
);

shiftLeft2 shiftLeft2_1(
						.in(sigext),
						.out(shift2_outWire)
					);

EX_MEM EX_MEM_1(
				.clk(CLK),
				.rst(RST),
				.branch(branch), // Combined with a condition test boolean to enable loading the branch target address into the PC. 
				.jump(jump), //  Enables loading the jump target address into the PC. 
				.MemRead(MemRead), //  Enables a memory read for load instructions. 
				.MemWrite(MemWrite), // Enables a memory write for store instructions. 
				.RegWrite(RegWrite), //  Enables a write to one of the registers. 
				.MemtoReg(MemtoReg), //  Determines where the value to be written comes from (ALU result or memory). 
				.adder(add_outWire),
				.aluzero(flagZeroWire),
				.alu(ALU_outWire),
				.readdata2(ALUSrcB), 
				.mux(muxRegDst_outWire),

				.branch_out(branch_out),
				.jump_out(jump_out),
				.MemRead_out(MemtoReg_out),
				.MemWrite_out(MemWrite_out),
				.RegWrite_out(RegWrite_out),
				.MemtoReg_out(MemtoReg_out),
				.adder_out(add_out1),
				.aluzero_out(aluzero_out),
				.alu_out(alu_out),
				.readdata2_out(readdata2_out), 
				.mux_out(muxRegDst_out)
				);

    mux3x1 mux0(
    			.sel(ForwardA_wire),
    			.entrada0(readdata1),
    			.entrada1(datatowrite),
    			.entrada2(MEMALUOut),
    			.resultado(ALUSrcA)
    			); 

    mux3x1 mux1(
    	.sel(ForwardB_wire),
    	.entrada0(readdata2),
    	.entrada1(datatowrite),
    	.entrada2(MEMALUOut),
    	.resultado(ALUSrcB)
    ); 

ForwardUnit  ForwardUnity_1(

						.MEMRegRd(MEMRegRd_wire),
						.WBRegRd(WBRegRd_wire),
						.EXRegRs(instruction_2521),
						.EXRegRt(instruction_2016),
						.MEM_RegWrite(MEM_RegWrite_wire),
						.WB_RegWrite(WB_RegWrite_wire),
						.ForwardA(ForwardA_wire),
						.ForwardB(ForwardB_wire)
						);
endmodule
