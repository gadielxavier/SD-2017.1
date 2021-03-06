module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, clk, rst, ReadData1, ReadData2);

	input [4:0] ReadRegister1,ReadRegister2,WriteRegister;
	input [31:0] WriteData;
	input RegWrite, clk, rst;
	
	output reg [31:0] ReadData1,ReadData2;
	
	
	//reg [31:0] Registers = new reg[32];
	reg [31:0] Registers [0:31];
	
	always @(posedge  rst) begin
		Registers[0] <= 32'h00000000;
		Registers[8] <= 32'h00000000;
		Registers[9] <= 32'h00000000;
		Registers[10] <= 32'h00000000;
		Registers[11] <= 32'h00000000;
		Registers[12] <= 32'h00000000;
		Registers[13] <= 32'h00000000;
		Registers[14] <= 32'h00000000;
		Registers[15] <= 32'h00000000;
		Registers[16] <= 32'h00000000;
		Registers[17] <= 32'h00000000;
		Registers[18] <= 32'h00000000;
		Registers[19] <= 32'h00000000;
		Registers[20] <= 32'h00000000;
		Registers[21] <= 32'h00000000;
		Registers[22] <= 32'h00000000;
		Registers[23] <= 32'h00000000;
		Registers[24] <= 32'h00000000;
		Registers[25] <= 32'h00000000;
		Registers[29] <= 32'd252; // this value should point to the top of data memory, dont forget byte addressing
		Registers[31] <= 32'b0;
	end
	
	always @(posedge clk)
	begin
		
		if (RegWrite == 1) 
		begin
			Registers[WriteRegister] <= WriteData;
		end
	end
	
	always @(negedge clk)
	begin
		ReadData1 <= Registers[ReadRegister1];
		ReadData2 <= Registers[ReadRegister2];
	end
	
	

endmodule