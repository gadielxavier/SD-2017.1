module I_DECODE_TEST;

		//inputs
		reg [31:0] instruction_in_2;
		reg [31:0] npc_in_2;
		reg RegWriteFromWB_2;
		reg clk, rst;

		//outputs
		wire branch_out_2;
		wire jump_out_2;
		wire AluSrc_out_2;
		wire [1:0] AluOp_out_2;
		wire MemRead_out_2;
		wire MemWrite_out_2;
		wire RegWrite_out_2;
		wire RegDst_out_2;
		wire MemtoReg_out_2;
		wire [31:0] npc_out_2;
		wire [31:0] readdata1_out_2;
		wire [31:0] readdata2_out_2;
		wire [31:0] sigext_out_2;
		wire [31:0] instruction_2015_out_2;
		wire [31:0] instruction_1511_out_2;

		parameter Halfcycle = 5; //half period is 5ns

I_DECODE uut(

		.instruction_in(instruction_in_2),
		.npc_in(npc_in_2),
		.CLK(clk),
		.RST(rst),
		.RegWriteFromWB(RegWriteFromWB_2),

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
		.instruction_2015_out_1(instruction_2015_out_2),
		.instruction_1511_out_1(instruction_1511_out_2)
			);

// Clock Signal generation:
    initial clk = 0; 
    always #(Halfcycle) clk = ~clk;

initial
begin
	npc_in_2 =  32'd01;
	instruction_in_2 =  32'h012DB820;
	rst = 0;
	RegWriteFromWB_2 = 0;
	#20
	setup;
	#20
	checkout;

end

task setup;
	begin

	end
endtask

task checkout;
	begin

	end
endtask

endmodule 