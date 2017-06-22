module muxAluSrc(

		input aluSrc,
		input [31:0] entrada0,
		input [31:0] entrada1,
		output reg [31:0] resultado
	);
	
	always @(*)
		begin
			out= 32'h00000000;
			case(aluSrc)
				1'b0: resultado <= entrada0;
				1'b1: resultado <= entrada1;
			endcase
		end 
endmodule