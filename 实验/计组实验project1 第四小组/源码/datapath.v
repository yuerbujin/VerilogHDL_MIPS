module DATAPATH(
    input [3:0] ALUctr,
    input [1:0] ExtOp,
    input ALUsrc, RegDst, jump,//3
    input MemWr, Branch,//4
    input MemtoReg, RegWr,//5

    input clk, rst,

    output [31:0] instruction
);
    wire [31:0] cur_pc, next_pc;
    wire [4:0] Rs = instruction[25:21];
    wire [4:0] Rt = instruction[20:16];
    wire [4:0] Rd = instruction[15:11];
    wire [4:0] Rw;
    wire [15:0] imm16 = instruction[15:0];
    wire [25:0] target = instruction[25:0];
    wire [31:0] imm32;
    wire [31:0] ALUIn2;
    wire [31:0] busA, busB, busW;
    wire [31:0] aluResult;
    wire [31:0] DataOut;

    initial
        begin
            $display("datapath initial");
        end

    PC pc(.address(cur_pc), .result(next_pc), .clk(clk), .rst(rst));
    NPC npc(.pc(cur_pc), .result(next_pc), .imm16(imm16), .target(target), .jump(jump), .branch(Branch), .zero(zero));
    IM im(.address(cur_pc), .instruction(instruction));
    MUX1 mux1(.Rd(Rd), .Rt(Rt), .RegDst(RegDst), .Rw(Rw));
    REGFILE regfile(.Rw(Rw), .Ra(Rs), .Rb(Rt), .busW(busW), .RegWr(RegWr), .clk(clk), .rst(rst), .busA(busA), .busB(busB));
    EXTENSION extension(.imm16(imm16), .ExtOp(ExtOp), .imm32(imm32));
    MUX2 mux2(.busB(busB), .imm32(imm32), .ALUsrc(ALUsrc), .ALUIn2(ALUIn2));
    ALU alu(.A(busA), .B(ALUIn2), .ALUctr(ALUctr), .result(aluResult), .zero(zero));
    DM dm(.dataIn(busB), .Adr(aluResult), .MemWr(MemWr), .clk(clk), .rst(rst), .DataOut(DataOut));
    MUX3 mux3(.aluResult(aluResult), .DataOut(DataOut), .MemtoReg(MemtoReg), .busW(busW));
endmodule