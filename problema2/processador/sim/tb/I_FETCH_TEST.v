module I_FETCH_TEST;

//inputs
reg EX_MEM_PCSrc, rst, clk;
reg [31:0] EX_MEM_NPC;

//Outputs
wire [31:0] IF_ID_INSTR;
wire [31:0] IF_ID_NPC;

 integer i;
 reg [31:0] expected_mem_values [7:0];

//Instantiate the Unit Under Test uut

parameter Halfcycle = 5; //half period is 5ns

I_FETCH uut (
	.EX_MEM_PCSrc(EX_MEM_PCSrc),
	.RST(rst),
	.CLK(clk),
	.EX_MEM_NPC(EX_MEM_NPC),
	.IF_ID_INSTR(IF_ID_INSTR),
	.IF_ID_NPC(IF_ID_NPC)
	);

// Clock Signal generation:
    initial clk = 0; 
    always #(Halfcycle) clk = ~clk;

initial
begin
	rst = 1;
	EX_MEM_NPC = 0;
	EX_MEM_PCSrc = 0;
	#20
	load_expected_mem_values;
	rst = 0;
	#20
	set_up;
	//$stop;
end

task set_up;
    begin
        $display("------------------------------");
        $display("set_up:");
        $display("------------------------------");
        rst = 1;
        #10; // Para povoar a memoria, o read_file tem que estar ativo quando o clock for de 0 para 1
        for (i = 0; i < 4; i = i + 1) begin
            if (uut.instMem_1.MEM[i] == expected_mem_values[i]) $display("OK! @ %t , Esperado (MEM[%d]): %h,  Obteve %h",
                $time, i, expected_mem_values[i], uut.instMem_1.MEM[i]);
            else begin
                $display("ERRO! @ %t , Esperado (MEM[%d]): %h,  Obteve %h",
                $time, i, expected_mem_values[i], uut.instMem_1.MEM[i]);
            end
        end
        rst = 0;
    end
endtask

 task load_expected_mem_values;
    begin
        expected_mem_values[0] = 32'h012DB820;
        expected_mem_values[1] = 32'h50016bff;
        expected_mem_values[2] = 32'h70060000;
        expected_mem_values[3] = 32'ha0118d50;
    end
endtask

endmodule