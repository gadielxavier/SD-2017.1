module muxRegDst(

		input regDst,
		input [5:0] entrada0,
		input [5:0] entrada1,
		output reg [5:0] resultado
	);
	
	always @(*)
		begin
			resultado <= 32'h00000000;
			case(aluSrc)
				1'b0: resultado <= entrada0;
				1'b1: resultado <= entrada1; 
			endcase
		end 
endmodule