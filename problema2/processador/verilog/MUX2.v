module mux3(parameter W = 32)
	(
		input select_in,
		input [W-1:0] entrada0,
		input [W-1:0] entrada1,
		output reg [W-1:0] resultado
	);
	
	always @(*)
		begin
			out= 32'h00000000;
			if(select_in == 2'b01)
				begin
					resultado = entrada1;
				end
			if(select_in == 2'b00)
				begin
					resultado = entrada0;
				end
		end
endmodule