module PIPELINE_TEST;

//inputs
reg clk, rst;

//IF
wire [31:0] IF_ID_INSTR;
wire [31:0] IF_ID_NPC;

//ID
wire [31:0] npc_out_2;
wire [31:0] readdata1_out_2;
wire [31:0] readdata2_out_2;
wire [31:0] sigext_out_2;
wire [4:0] instruction_2521_out_2;
wire [4:0] instruction_2016_out_2;
wire [4:0] instruction_1511_out_2;

//EX
wire [31:0] alu_out;
wire [31:0] readdata2_out;
wire [4:0] muxRegDst_out;

//MEM
wire [31:0] read_data_out_1;
wire [31:0] mem_alu_result_1;

//WB
wire[31:0] wb_data;

parameter Halfcycle = 5; //half period is 5ns

// Clock Signal generation:
initial clk = 0; 
always #(Halfcycle) clk = ~clk;

PIPELINE PIPELINE_1(
	.clk(clk),
	.rst(rst),

	//IF
	.IF_ID_INSTR(IF_ID_INSTR),
	.IF_ID_NPC(IF_ID_NPC),

	//ID
	.npc_out_2(npc_out_2),
	.readdata1_out_2(readdata1_out_2),
	.readdata2_out_2(readdata2_out_2),
	.sigext_out_2(sigext_out_2),
	.instruction_2521_out_2(instruction_2521_out_2),
	.instruction_2016_out_2(instruction_2016_out_2),
	.instruction_1511_out_2(instruction_1511_out_2),

	//EX
	.alu_out(alu_out),
	.readdata2_out(readdata2_out),
	.muxRegDst_out(muxRegDst_out),

	//MEM
	.read_data_out_1(read_data_out_1),
	.mem_alu_result_1(mem_alu_result_1),

	//WB
 	.wb_data(wb_data)
);

initial
begin
	rst = 0;
	#10
	checkout;
	rst = 0;
	#10
	checkout;
	#10
	checkout;
	#10
	checkout;
	#10
	checkout;
	#10
	checkout;
	#10
	checkout;
	#10
	checkout;
	#10
	checkout;
	#10
	checkout;
	#10
	checkout;
	#10
	checkout;


end

task checkout;
	begin
		//IF
		$display("\nIF_ID_INSTR: %t %d", $time, IF_ID_INSTR);
		$display("IF_ID_NPC: %t %d", $time, IF_ID_NPC);

		//ID
		$display("npc_out_2: %t %d", $time, npc_out_2);
		$display("readdata1_out ID: %t %d", $time, readdata1_out_2);
		$display("readdata2_out ID: %t %d", $time, readdata2_out_2);
		$display("sigext_out_2 ID: %t %d", $time, sigext_out_2);
		$display("instruction_2521 ID: %t %d", $time,  instruction_2521_out_2);
		$display("instruction_1511 ID: %t %d \n", $time, instruction_1511_out_2);

		
	end
endtask

endmodule
