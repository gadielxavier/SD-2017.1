module fowarding_unit
(
    input [4:0] EX_MEM_RegisterRd,
    input [4:0] ID_EX_RegisterRt,
    input EX_MEM_RegWrite,
    input [4:0] EX_MEM_RegisterRd,
    input MEM_WB_RegWrite,
    input [4:0] MEM_WB_RegisterRd,
    output reg [1:0] fowardA,
    output reg [1:0] fowardB
);

always @(posedge clk or posedge rst) begin
  if (MEM_WB_RegWrite and (MEM_WB_RegisterRd !=  0)
    and not(EX_MEM_RegWrite and (EX_MEM_RegisterRd !=  0)
    and (EX_MEM_RegisterRd !=  ID_EX_RegisterRs))
    and (MEM_WB_RegisterRd == ID_EX_RegisterRs)) 
        forwardA = 01
  if (MEM_WB_RegWrite and (MEM_WB_RegisterRd !=  0)
    and not(EX_MEM_RegWrite and (EX_MEM_RegisterRd !=  0)
    and (EX_MEM_RegisterRd != ID_EX_RegisterRt))
    and (MEM_WB_RegisterRd == ID_EX_RegisterRt)) 
        forwardB = 01
end

endmodule

