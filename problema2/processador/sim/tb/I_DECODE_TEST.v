module I_DECODE_TEST;

	//ID inputs
	reg [31:0] instruction_in, npc_in;
	reg clk, rst;
	reg RegWriteFromWB;
	reg[4:0]  writeRegister3;
	reg [4:0] EXRegRt_wire;
	reg [31:0] writeData;
	reg EXMemRead_wire;

		
		

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
	wire [31:0] npc_out_2;
	wire [31:0] readdata1_out_2;
	wire [31:0] readdata2_out_2;
	wire [31:0] sigext_out_2;
	wire [4:0] instruction_2521_out_2;
	wire [4:0] instruction_2016_out_2;
	wire [4:0] instruction_1511_out_2;
	wire IFIDWrite_wire;
	wire branchTaken_2;
	wire [31:0] add_outWire_2;


	//variaveis locais
	reg [4:0] readRegisterRs, readRegisterRt, readRegisterRd;
	reg [31:0] signext_in;
	reg [5:0] opcode_1;

	parameter Halfcycle = 5; //half period is 5ns

// Clock Signal generation:
initial clk = 0; 
always #(Halfcycle) clk = ~clk;



I_DECODE I_DECODE_1(
		.instruction_in(instruction_in),
		.npc_in(npc_in),
		.CLK(clk),
		.RST(rst),
		.RegWriteFromWB(RegWriteFromWB),
		.writeRegister3(writeRegister3),
		.EXRegRt_wire(EXRegRt_wire),
		.writeData(writeData),
		.EXMemRead_wire(EXMemRead_wire),

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
		.shift2_outWire(shift2_outWire_2),
		.branchTaken(branchTaken_2),
		.add_outWire(add_outWire_2)
		);


initial
begin
	rst = 1;
	RegWriteFromWB = 0;
	EXRegRt_wire = 0;
	writeData = 0;
	EXMemRead_wire = 0;
	writeRegister3 = 0;
	EXRegRt_wire = 0;
	writeData = 0;

	instruction_in = 32'h012db820;
	npc_in = 1;
	assign signext_in = instruction_in[15:0];
	assign readRegisterRd = instruction_in[15:11]; //rd
	assign readRegisterRt = instruction_in[20:16]; //rt
	assign readRegisterRs = instruction_in[25:21]; //rs


	#10
	rst = 0;
	check_out;
	instruction_in = 32'h50016bff;
	npc_in = 2;
	

	#10
	check_out;
	instruction_in = 32'h70060000;
	npc_in = 3;
	

	#10
	check_out;


	//$stop;
end

task check_out;
	begin

		$display("instruction_in: %h", instruction_in);

		if (signext_in == sigext_out_2) $display("Signext OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  signext_in, sigext_out_2);
		else begin
                $display("Signext ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  signext_in, sigext_out_2);
  		end 

   		 if (readRegisterRd == instruction_1511_out_2) $display("Rd OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  readRegisterRd, instruction_1511_out_2);
		else begin
                $display("Rd ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  readRegisterRd, instruction_1511_out_2);
  	 	end 

    	if (readRegisterRt == instruction_2016_out_2) $display("Rt OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  readRegisterRt, instruction_2016_out_2);
		else begin
                $display("Rt ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  readRegisterRt, instruction_2016_out_2);
    	end 

   		if (readRegisterRs == instruction_2521_out_2) $display("Rs OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  readRegisterRs, instruction_2521_out_2);
		else begin
                $display("Rs ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  readRegisterRs, instruction_2521_out_2);
    	end 

     	$display("ID PC: %d", npc_out_2);

            
	end
endtask


endmodule 