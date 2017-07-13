module I_FETCH_TEST;

//inputs
reg EX_MEM_PCSrc, rst, clk, pc_write, IFIDWrite;
reg [31:0] EX_MEM_NPC;

//Outputs
wire [31:0] IF_ID_INSTR;
wire [31:0] IF_ID_NPC;


//variaveis locais
integer i;
reg [31:0] expected_mem_values [7:0];



parameter Halfcycle = 5; //half period is 5ns

// Clock Signal generation:
initial clk = 0; 
always #(Halfcycle) clk = ~clk;


//Instantiate the Unit Under Test uut
I_FETCH uut (
	.BRANCH(EX_MEM_PCSrc),
	.RST(rst),
	.CLK(clk),
    .IFIDWrite(IFIDWrite),
    .PC_WRITE(pc_write),
	.EX_MEM_NPC(EX_MEM_NPC),

	.IF_ID_INSTR(IF_ID_INSTR),
	.IF_ID_NPC(IF_ID_NPC)
	);

initial
begin
	EX_MEM_NPC = 0;
	EX_MEM_PCSrc = 0;
    pc_write = 1;
    rst = 1; //para povoar a memoria o rst precisa estar ativo
	#10
    checkout_instruction;
	load_expected_mem_values; 
    rst = 0;
	#10
    checkout_instruction;
	set_up;
    #10
    checkout_instruction;
    #10
    checkout_instruction;
	//$stop;
end

task set_up;
    begin
        $display("------------------------------");
        $display("set_up:");
        $display("------------------------------");

        for (i = 0; i < 4; i = i + 1) begin
            if (uut.instMem_1.MEM[i] == expected_mem_values[i]) $display("OK! @ %t , Esperado (MEM[%d]): %h,  Obteve %h",
                $time, i, expected_mem_values[i], uut.instMem_1.MEM[i]);
            else begin
                $display("ERRO! @ %t , Esperado (MEM[%d]): %h,  Obteve %h",
                $time, i, expected_mem_values[i], uut.instMem_1.MEM[i]);
            end
        end

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

task checkout_instruction ;
    begin
        $display("Instruction: %h", IF_ID_INSTR);
        $display("pc: %h", IF_ID_NPC);
    end
endtask

endmodule