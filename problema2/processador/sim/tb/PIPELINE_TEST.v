module PIPELINE_TEST;

//inputs
reg clk, rst;

parameter Halfcycle = 5; //half period is 5ns

// Clock Signal generation:
initial clk = 0; 
always #(Halfcycle) clk = ~clk;

PIPELINE PIPELINE_1(
	.clk(clk),
	.rst(rst)
);

initial
begin
	rst = 1;
	#10
	rst = 0;
end


endmodule
