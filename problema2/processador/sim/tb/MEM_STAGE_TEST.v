module MEM_STAGE_TEST;

//inputs
reg clk, rst;
reg [1:0] control_wb;
reg [31:0] address, writeData; 
reg [4:0] write_register;
reg MemRead;
reg MemWrite;


//output
wire [1:0] control_wb_out_1;
wire [31:0] read_data_out_1;
wire [31:0] mem_alu_result_1;
wire [31:0] mem_write_reg_1;


parameter Halfcycle = 5; //half period is 5ns
				
// Clock Signal generation:
initial clk = 0; 
always #(Halfcycle) clk = ~clk;

MEM_STAGE MEM_STAGE_TEST_1(
				.CLK(clk), 
				.RST(rst),
				.control_wb(control_wb),
				.address(address), 
				.writeData(writeData), 
				.write_register(write_register),
				.MemRead(MemRead),
				.MemWrite(MemWrite),

				.control_wb_out_1(control_wb_out_1),
				.read_data_out_1(read_data_out_1),
				.mem_alu_result_1(mem_alu_result_1),
				.mem_write_reg_1(mem_write_reg_1)
	);

initial
begin

	address = 10; 
	writeData = 7; 
	write_register = 24;
	MemRead = 0;
	MemWrite = 1;

	#10
	address = 10; 
	MemRead = 1;
	MemWrite = 0;

	#20
	checkout;

	address = 20; 
	writeData = 3; 
	write_register = 2;
	MemRead = 0;
	MemWrite = 1;

	#10
	address = 20; 
	MemRead = 1;
	MemWrite = 0;

	#20
	checkout;

end

task checkout;
	begin
		if ( read_data_out_1 == writeData) 
			$display("Data Mem OK! @ %t , Esperado: %h,  Obteve %h",
			$time,  writeData, read_data_out_1);
        else begin
        	$display("Data Mem Erro! @ %t , Esperado: %h,  Obteve %h",
			$time,  writeData, read_data_out_1);
		end

		$display("Write Register in: @ %t %d", $time, write_register);
		$display("Write Register out: @ %t %d", $time, mem_write_reg_1);

	end
endtask

endmodule