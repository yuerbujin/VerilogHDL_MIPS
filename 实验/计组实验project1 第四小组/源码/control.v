module CONTROL(
    input [5:0] op,
    input [5:0] func,

    output [3:0] ALUctr,
    output [1:0] ExtOp,
    output ALUsrc, RegDst, jump,//3
    output MemWr, Branch,//4
    output MemtoReg, RegWr//5
);
    // reg [11:0] control;
    reg [8:0] mainCtr;

    initial
        begin
            $display("control initial");
        end

    always @(*)
        begin
            case (op)
                6'b000000: mainCtr = 9'bx_x010_0001;//R (6)
                //
                6'b001001: mainCtr = 9'b0_1100_0001;//addiu
                6'b001000: mainCtr = 9'b0_1100_0001;//addi
                6'b001101: mainCtr = 9'b0_0100_0001;//ori
                6'b001111: mainCtr = 9'b1_0100_0001;//lui//NO
                6'b100011: mainCtr = 9'b0_1100_0011;//lw
                6'b101011: mainCtr = 9'b0_11x0_10x0;//sw
                6'b000100: mainCtr = 9'bx_x0x0_01x0;//beq
                6'b000010: mainCtr = 9'bx_xxx1_00x0;//jump

                // default: control = 12'b0000_0000_0000;
            endcase
        end

    ALU_CTR alu_ctr(.op(op), .func(func), .ALUctr(ALUctr));
    assign {ExtOp, ALUsrc, RegDst, jump, MemWr, Branch, MemtoReg, RegWr} = mainCtr;

endmodule