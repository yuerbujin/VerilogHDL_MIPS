module ALU_CTR(
    input [5:0] op,
    input [5:0] func,

    output reg [3:0] ALUctr
);
    always @(*)
        case (op)
            //R
            6'b000000:
                case (func)
                    6'b100000: ALUctr = 4'b0000;//add
                    6'b100010: ALUctr = 4'b0001;//sub
                    6'b100100: ALUctr = 4'b0010;//and
                    6'b100101: ALUctr = 4'b0011;//or
                    6'b100110: ALUctr = 4'b0100;//xor
                    6'b101010: ALUctr = 4'b0110;//slt
                endcase
                //not R
            6'b001001: ALUctr = 4'b0000;//addiu
            6'b001000: ALUctr = 4'b0000;//addi
            6'b001101: ALUctr = 4'b0011;//ori???????
            6'b001111: ALUctr = 4'b0101;//lui
            6'b100011: ALUctr = 4'b0000;//lw
            6'b101011: ALUctr = 4'b0000;//sw
            6'b000100: ALUctr = 4'b0001;//beq
            6'b000010: ALUctr = 4'bxxxx;//jump
        endcase

endmodule