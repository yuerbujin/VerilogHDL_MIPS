module PIPELINE_PROCESSOR(
    input clk, rst
);

    //data signal
    wire [31:0] ID_instruction;
    wire [5:0] op = ID_instruction[31:26];
    wire [5:0] func = ID_instruction[5:0];

    //control signal
    wire [3:0] ID_ALUop;
    wire [1:0] ID_ExtOp1, ID_ExtOp2;
    wire [1:0] ID_jump;
    wire [1:0] ID_ALUsrc;
    wire ID_ALUShamtSrc, ID_RegDst;
    wire ID_MemRead;//3
    wire ID_MemWr;
    wire [2:0] ID_Branch, ID_ExtOp3;//4
    wire [1:0] ID_MemtoReg;
    wire ID_RegWr;//5

    DATAPATH datapath(
        .ID_ALUop(ID_ALUop), .ID_ExtOp1(ID_ExtOp1), .ID_ExtOp2(ID_ExtOp2), .ID_jump(ID_jump), .ID_ALUsrc(ID_ALUsrc), .ID_ALUShamtSrc(ID_ALUShamtSrc), .ID_RegDst(ID_RegDst), .ID_MemRead(ID_MemRead),
        .ID_MemWr(ID_MemWr), .ID_Branch(ID_Branch), .ID_ExtOp3(ID_ExtOp3),
        .ID_MemtoReg(ID_MemtoReg), .ID_RegWr(ID_RegWr),
        .ID_instruction(ID_instruction),
        .clk(clk), .rst(rst)
    );
    MAIN_CTRL main_ctrl(
        .op(op), .func(func),
        .ID_ALUop(ID_ALUop), .ID_ExtOp1(ID_ExtOp1), .ID_ExtOp2(ID_ExtOp2), .ID_jump(ID_jump), .ID_ALUsrc(ID_ALUsrc), .ID_ALUShamtSrc(ID_ALUShamtSrc), .ID_RegDst(ID_RegDst), .ID_MemRead(ID_MemRead),
        .ID_MemWr(ID_MemWr), .ID_Branch(ID_Branch), .ID_ExtOp3(ID_ExtOp3),
        .ID_MemtoReg(ID_MemtoReg), .ID_RegWr(ID_RegWr)
    );

endmodule