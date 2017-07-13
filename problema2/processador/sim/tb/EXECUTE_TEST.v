`include "Opcode.vh"
`include "ALUop.vh"

module EXECUTE_TEST;

//inputs
reg clk, rst;
reg branch;
reg jump;
reg AluSrc;
reg [5:0] opcode;
reg MemRead;
reg MemWrite;
reg RegWrite;
reg RegDst;
reg MemtoReg;
reg [31:0] npc;
reg [31:0] readdata1;
reg [31:0] readdata2;
reg [31:0] sigext;
reg [4:0] instruction_2521;
reg [4:0] instruction_2016;
reg [4:0] instruction_1511;
reg [4:0] MEMRegRd_wire;
reg [4:0] WBRegRd_wire;
reg MEM_RegWrite_wire;
reg WB_RegWrite_wire;
reg [31:0]regMemWb;
reg [31:0]regExMem;

//Outputs
wire branch_out;
wire jump_out;
wire MemRead_out;
wire MemWrite_out;
wire MemtoReg_out;
wire [31:0] alu_out;
wire [31:0] readdata2_out;
wire [4:0] muxRegDst_out;

//variaveis locais
integer result;


parameter Halfcycle = 5; //half period is 5ns

// Clock Signal generation:
initial clk = 0; 
always #(Halfcycle) clk = ~clk;

   


//Instantiate the Unit Under Test uut
EXECUTE uut(
        .CLK(clk),
        .RST(rst),
        .branch(branch),
        .jump(jump),
        .AluSrc(AluSrc),
        .opcode(opcode),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .RegDst(RegDst),
        .MemtoReg(MemtoReg),
        .npc(npc),
        .readdata1(readdata1),
        .readdata2(readdata2),
        .sigext(sigext),
        .instruction_2521(instruction_2521),
        .instruction_2016(instruction_2016),
        .instruction_1511(instruction_1511),
        .MEMRegRd_wire(MEMRegRd_wire),
        .WBRegRd_wire(WBRegRd_wire),
        .MEM_RegWrite_wire(MEM_RegWrite_wire),
        .WB_RegWrite_wire(WB_RegWrite_wire),
        .regMemWb(regMemWb),
        .regExMem(regExMem),


        .branch_out(branch_out),
        .jump_out(jump_out),
        .MemRead_out(MemRead_out),
        .MemWrite_out(MemWrite_out),
        .MemtoReg_out(MemtoReg_out),
        .alu_out(alu_out),
        .readdata2_out(readdata2_out),
        .muxRegDst_out(muxRegDst_out)
	);



initial
begin
	rst = 0;
    branch = 0;
    jump = 0;
    AluSrc = 0;
    opcode = 0;
    MemWrite = 0;
    RegWrite = 0;
    RegDst = 0;
    MemtoReg = 0;
    npc = 0;
    readdata1 = 0;
    readdata2 = 0;
    sigext = 0;
    instruction_2521 = 0;
    instruction_2016 = 0;
    instruction_1511 = 0;
    MEMRegRd_wire = 0;
    WBRegRd_wire = 0;
    MEM_RegWrite_wire = 0;
    WB_RegWrite_wire = 0;
    regMemWb = 0;
    regExMem = 0;

    #10
    opcode = `RTYPE;
    sigext = 32'b10111000000000001011100101100001; //addu
    readdata1 = 5;
    readdata2 = -2;
    result = readdata1 + readdata2;

    #10
    checkout;
    AluSrc = 1;
    opcode = `ORI;
    sigext = 1; 
    readdata1 = 0;
    result = readdata1 | sigext;

    #10
    checkout;
    AluSrc = 1;
    opcode = `ADDIU;
    sigext = 2; 
    readdata1 = 3;
    result = readdata1 + sigext;

    #10
    checkout;
    AluSrc = 0;
    opcode = `RTYPE;
    sigext =  32'b10111000000000001011100100100101; //and
    readdata1 = 1;
    readdata2 = 0;
    result = readdata1 | readdata2;

    #10
    checkout;
    AluSrc = 0;
    opcode = `BEQ;
    readdata1 = 1;
    readdata2 = 0;
    result = readdata1 == readdata2;

    #10
    checkout;
    AluSrc = 0;
    opcode = `BNE;
    readdata1 = 1;
    readdata2 = 0;
    result = readdata1 != readdata2;

    #10
    checkout;

end





task checkout ;
    begin
        if (alu_out == result) $display("Alu OK! @ %t , Esperado: %h,  Obteve %h",
                $time,  result, alu_out);
        else begin
                $display("Alu ERRO! @ %t , Esperado: %h,  Obteve %h",
                $time,  result, alu_out);
        end 

    end
endtask

endmodule