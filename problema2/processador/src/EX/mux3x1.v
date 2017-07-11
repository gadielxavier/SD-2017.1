module mux3x1(
		input [1:0] sel,
		input [31:0] entrada0,
		input [31:0] entrada1,
		input [31:0] entrada2,
		output reg [31:0] resultado
	);
	
	always @(*)
		begin
			case(sel)
				2'b00: resultado <= entrada0;
				2'b01: resultado <= entrada1;
				2'b10: resultado <= entrada1;
			endcase
		end 
endmodule