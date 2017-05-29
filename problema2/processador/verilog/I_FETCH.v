/*
The Top Level for the Instruction Fetch Stage.
This is how all the individuals modules are 
connected with each other.
*/

module I_FETCH(
				input EX_MEM_PCSrc, RST,
				input wire [31:0] EX_MEM_NPC, 
				output wire [31:0 ] IF_ID_INSTR, IF_ID_NPC
				);

//signals
wire [31:0] PC;
wire [31:0] dataout;
wire [31:0] npc, npc_mux;

//instantiations

muxIF muxIF_1 (
				.npc(npc_mux),
				.s1(EX_MEM_NPC),
				.s0(npc),
				.select(EX_MEM_PCSrc)
			);

pc pc_1 (
			.pc_out(PC),
			.npc(npc_mux)
		);

instMem instMem_1 (
					.rst(RST),
					.addr(PC),
					.instruction(dataout)
				);

IF_ID IF_ID_1 (
				.instruction_out(IF_ID_INSTR),
				.npc_out(IF_ID_NPC),
				.instruction_in(dataout),
				.npc_in(npc)
			);

incrementer incrementer_1 (
							.pc_out(npc),
							.pc_in(PC)
						);

endmodule