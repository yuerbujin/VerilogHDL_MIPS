module EXTENSION(
    input [15:0] imm16,
    input [1:0] ExtOp,
    output reg [31:0] imm32
);

    always @(*)
        case (ExtOp)
            2'b00: imm32 = {16'h0000, imm16};//zero extension
            2'b01: imm32 = {{16{imm16[15]}}, imm16};//sign extension
            2'b10: imm32 = {imm16, 16'h0000};//lui
        endcase
endmodule