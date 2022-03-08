module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUctr,

    output reg [31:0] result,
    output wire zero
);
    always @(*)
        case (ALUctr)
            4'b0000: result = A + B;//add,addi,addiu,lw,sw
            4'b0001: result = A - B;//sub,beq
            4'b0010: result = A & B;//and
            4'b0011: result = A | B;//or,ori
            4'b0100: result = A ^ B;//xor
            4'b0101: result = A + B;//lui
            4'b0110: result = (A<B ? 1:0);//slt
        endcase
    assign zero = (result==0 ? 1:0);

endmodule