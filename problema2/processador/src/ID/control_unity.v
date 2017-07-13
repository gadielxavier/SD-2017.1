`include "../Opcode.vh"
`include "../ALUop.vh"


module control_unity(
			input wire clk, rst, 
			input  wire	[5:0]	opcode,
			input wire hazardMux, //caso haja bolha zera sinais

			output reg			branch_eq, branch_ne,
			output reg [5:0]	aluop,
			output reg			memread, memwrite, memtoreg,
			output reg			regdst, regwrite, alusrc,
			output reg			jump
		);

	always @(posedge clk or posedge rst) begin
		assign aluop = opcode;
		if (rst || hazardMux) begin
			// reset
			/* defaults */
			aluop[5:0]	<= 5'b10;
			alusrc		<= 1'b0;
			branch_eq	<= 1'b0;
			branch_ne	<= 1'b0;
			memread		<= 1'b0;
			memtoreg	<= 1'b0;
			memwrite	<= 1'b0;
			regdst		<= 1'b1;
			regwrite	<= 1'b1;
			jump		<= 1'b0;
		end
		else begin
			case (opcode)
			`LW: begin	/* lw */
				regdst   <= 1'b0;
				memread  <= 1'b1;
				memtoreg <= 1'b1;
				alusrc   <= 1'b1;
				regwrite <= 1'b1;
			end
			`ADDI: begin	/* addi */
				regdst   <= 1'b0;
				alusrc   <= 1'b1;
				regwrite <= 1'b1;
			end
			`BEQ: begin	/* beq */
				branch_eq <= 1'b1;
				regwrite  <= 1'b0;
			end
			`SW: begin	/* sw */
				memwrite <= 1'b1;
				alusrc   <= 1'b1;
				regwrite <= 1'b0;
			end
			`BNE: begin	/* bne */
				branch_ne <= 1'b1;
				regwrite  <= 1'b0;
			end
			`RTYPE: begin
				regwrite <= 1;
				regdst <= 1;
			end
			`J: begin	/* j jump */
				jump <= 1'b1;
			end
			endcase
		end	

	end
endmodule