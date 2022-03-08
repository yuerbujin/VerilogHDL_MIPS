module MUX1(
    input [4:0] Rd,
    input [4:0] Rt,
    input RegDst,

    output [4:0] Rw
);

    assign Rw = (RegDst ? Rd : Rt);

endmodule

module MUX2(
    input [31:0] busB,
    input [31:0] imm32,
    input ALUsrc,

    output [31:0] ALUIn2
);

    assign ALUIn2 = (ALUsrc ? imm32 : busB);

endmodule

module MUX3(
    input [31:0] aluResult,
    input [31:0] DataOut,
    input MemtoReg,

    output [31:0] busW
);

    assign busW = (MemtoReg ? DataOut : aluResult);

endmodule