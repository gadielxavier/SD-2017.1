module control_unity(
			input wire clk, rst, 
			input  wire	[5:0]	opcode,
			output reg			branch_eq, branch_ne,
			output reg [5:0]	aluop,
			output reg			memread, memwrite, memtoreg,
			output reg			regdst, regwrite, alusrc,
			output reg			jump
		);

	always @(posedge clk or posedge rst) begin
		if (rst) begin
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
			6'b100011: begin	/* lw */
				memread  <= 1'b1;
				regdst   <= 1'b0;
				memtoreg <= 1'b1;
				alusrc   <= 1'b1;
			end
			6'b001000: begin	/* addi */
				regdst   <= 1'b0;
				alusrc   <= 1'b1;
			end
			6'b000100: begin	/* beq */

				branch_eq <= 1'b1;
				regwrite  <= 1'b0;
			end
			6'b101011: begin	/* sw */
				memwrite <= 1'b1;
				alusrc   <= 1'b1;
				regwrite <= 1'b0;
			end
			6'b000101: begin	/* bne */
				aluop[0]  <= 1'b1;
				branch_ne <= 1'b1;
				regwrite  <= 1'b0;
			end
			6'b000000: begin	/* add */
			end
			6'b000010: begin	/* j jump */
				jump <= 1'b1;
			end
			endcase
		end		
		
		assign aluop = opcode ;

	end
endmodule