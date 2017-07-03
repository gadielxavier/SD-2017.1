module dataMem(
	addr,
	clk, rst,
	data_in,
	data_out,
	memRead,
	memWrite);


input [31:0] addr;
input clk, rst;
input [31:0] data_in;
output reg [31:0] data_out;
input memRead;
input memWrite;
reg [31:0] musaRAM [0:2047];

always @(posedge clk) begin
	if (memRead) begin
		data_out <= musaRAM [addr];
	end
end

always @(posedge clk) begin
	if (memWrite) 
		musaRAM [addr] <= data_in;
end
 
endmodule