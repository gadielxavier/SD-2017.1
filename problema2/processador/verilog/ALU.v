// Universidade Estadual de Feira de Santana 
// TEC499 - MI - Sistemas Digitais
// Lab 3, 2016.1
//
// Module: ALU.v
// Desc:   32-bit ALU for the MIPS150 Processor
// Inputs: 
// 	A: 32-bit value
// 	B: 32-bit value
// 	ALUop: Selects the ALU's operation 
// 						
// Outputs:
// 	Out: The chosen function mapped to A and B.

`include "Opcode.vh"
`include "ALUop.vh"

module ALU(
    input [31:0] A,B,
    input [3:0] ALUop,
    output reg [31:0] Out
);

 // Implement your ALU here, then delete this comment
always @ ( * ) begin 

	case (ALUop)
        `ALU_ADDU : begin
            Out <= A + B;
         end

    	`ALU_SUBU : begin
    		Out <= A - B; 
    	end

    	`ALU_SLT: begin
    		Out <= $signed(A) < $signed(B);
    	end

    	`ALU_SLTU: begin
            Out <= A < B;
    	end

    	`ALU_AND: begin
            Out <= A & B;
    	end

    	`ALU_OR: begin
            Out <= A | B;
    	end

    	`ALU_XOR: begin
            Out <= A ^ B;
    	end

    	`ALU_LUI: begin
    		Out <= A << 16;
    	end	
    	
    	`ALU_SLL: begin
    		Out <= A << B;
    	end 

    	`ALU_SRL: begin
    		Out <= A >> B;
    	end

    	`ALU_SRA: begin
    		Out <= B >>> A;
    	end

    	`ALU_NOR: begin
    		Out <= ~(A | B);
    	end

    	`ALU_XXX: begin
    		Out <= 32'b0;
    	end

    endcase

	
end 

endmodule
