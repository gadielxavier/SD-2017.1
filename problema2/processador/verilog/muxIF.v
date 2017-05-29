/*
Multiplexer Module which will pick between
the next sequential PC value and the 
PC Value calculated in the Execute stage
depending on the value of the select line
set in the Memory Stage.
*/
module muxIF(input [31:0] s0, s1,
			input select, 
			output [31:0] npc
			);

assign npc = (select) ? s1 : s0 ;

endmodule