/*
The Top Level for the Instruction Fetch Stage.
This is how all the individuals modules are 
connected with each other.
*/

module I_FETCH(
				input BRANCH, RST, CLK, PC_WRITE,
				input wire [31:0] EX_MEM_NPC, 
				output wire [31:0 ] IF_ID_INSTR, IF_ID_NPC
				);

//signals
wire [31:0] PC;
wire [31:0] dataout;
wire [31:0] npc_incrementer, npc_mux;

//instantiations

muxIF muxIF_1 (
				.s0(npc_incrementer),
				.s1(EX_MEM_NPC),
				.select(BRANCH),
				.npc(npc_mux)
			);

pc pc_1 (
			.clk(CLK),
			.rst(RST),
			.pcWrite(PC_WRITE),
			.npc(npc_mux),
			.pc_out(PC)
		);

instMem instMem_1 (
					.clk(CLK),
					.rst(RST),
					.addr(PC),
					.data(dataout)
				);

IF_ID IF_ID_1 (
				.clk(CLK),
				.rst(RST),
				.instruction_in(dataout),
				.npc_in(npc_incrementer),
				.instruction_out(IF_ID_INSTR),
				.npc_out(IF_ID_NPC)
			);

incrementer incrementer_1 (
							.pc_in(PC),
							.pc_out(npc_incrementer)
						);

endmodule