module muxRegDst(

		input regDst,
		input [4:0] entrada0,
		input [4:0] entrada1,
		output reg [4:0] resultado
	);
	
	always @(*)
		begin
			resultado <= 32'h00000000;
			case(regDst)
				1'b0: resultado <= entrada0;
				1'b1: resultado <= entrada1; 
			endcase
		end 
endmodule