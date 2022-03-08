module PROCESSOR(
    input clk,
    input rst
);
    wire [31:0] instruction;
    wire [5:0] op = instruction[31:26];
    wire [5:0] func = instruction[5:0];

    wire [3:0] ALUctr;
    wire [1:0] ExtOp;
    wire ALUsrc, RegDst, jump;//3
    wire MemWr, Branch;//4
    wire MemtoReg, RegWr;//5

    // initial
    //     begin
    //         $display("processor initial");
    //     end

    DATAPATH datapath(
        .ExtOp(ExtOp), .ALUsrc(ALUsrc), .RegDst(RegDst), .jump(jump), .ALUctr(ALUctr),
        .MemWr(MemWr), .Branch(Branch),
        .MemtoReg(MemtoReg), .RegWr(RegWr),
        .clk(clk), .rst(rst),
        .instruction(instruction)
    );
    CONTROL control(
        .op(op), .func(func),
        .ALUctr(ALUctr),
        .ExtOp(ExtOp), .ALUsrc(ALUsrc), .RegDst(RegDst), .jump(jump),
        .MemWr(MemWr), .Branch(Branch),
        .MemtoReg(MemtoReg), .RegWr(RegWr)
    );

endmodule