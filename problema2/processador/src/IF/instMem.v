/*
Memory module which holds all of the instructions
needed by the MIPS processor
*/

module instMem(
	input wire clk, rst,
	input wire [31:0] addr,
	output reg [31:0] data
);

reg [31:0]MEM[0:127];

always @ (posedge rst)
begin
	MEM[0] <= 0;
	MEM[1] <= 1;
	MEM[2] <= 2;
	MEM[3] <= 3;
	MEM[4] <= 4;
	MEM[5] <= 5;
	MEM[6] <= 6;
	MEM[7] <= 7;
	MEM[8] <= 8;
	MEM[9] <= 9;
end

always@(posedge clk )
begin
	data<= MEM[ addr ];
end
endmodule