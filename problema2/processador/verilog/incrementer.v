module incrementer(
	input wire [31:0] pc_in,
	output wire [31:0] pc_out);

//add 1 to pc_in
assign pc_out = pc_in + 1;

endmodule