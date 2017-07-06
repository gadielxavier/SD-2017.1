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
	MEM[0] <= 32'h012DB820;
	MEM[1] <= 32'h50016bff;
	MEM[2] <= 32'h70060000;
	MEM[3] <= 32'ha0118d50;
end

always@(posedge clk )
begin
	data<= MEM[ addr ];
end
endmodule