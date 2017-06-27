/*
Memory module which holds all of the instructions
needed by the MIPS processor
*/

module instMem(
    input rst,
    input [31:0] addr,

    output [31:0] instruction
);

reg [1:0] mem [255:0];

integer inst_in;
integer data;
integer i;

always @ (rst) begin
    inst_in = $fopen("data/inst_in.txt", "r");
    for (i = 0; i < 256; i = i + 1) begin
        $fscanf(inst_in,"%08H", data);
        if($feof(inst_in)) i = 256;
        else mem[i] = data;
    end
    $fclose(inst_in);
end

assign instruction = mem[addr];

endmodule // instruction_mem