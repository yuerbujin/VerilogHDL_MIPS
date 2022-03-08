module ALU_CTR(
    input [3:0] ALUop,
    input [5:0] func,

    output reg [3:0] ALUctr
);

    //FUNCT FIELD ()
    parameter   ADD   = 6'b100000;                  // add
    parameter   ADDU  = 6'b100001;                  // addu
    parameter   SUB   = 6'b100010;                  // sub
    parameter   SUBU  = 6'b100011;                  // subu
    parameter   AND   = 6'b100100;                  // and
    parameter   OR    = 6'b100101;                  // or
    parameter   NOR   = 6'b100111;                  // nor
    parameter   XOR   = 6'b100110;                  // xor
    parameter   SLT   = 6'b101010;                  // slt
    parameter   SLTU  = 6'b101011;                  // sltu
    parameter   SLL   = 6'b000000;                  // sll
    parameter   SRL   = 6'b000010;                  // srl
    parameter   SRA   = 6'b000011;                  // sra
    parameter   SLLV  = 6'b000100;                  // sllv
    parameter   SRLV  = 6'b000110;                  // srlv
    parameter   SRAV  = 6'b000111;                  // srav
    parameter   JR    = 6'b001000;                  // jr

    //ALUctr
    parameter ALU_ADD = 4'b0000;
    parameter ALU_SUB = 4'b0001;
    parameter ALU_AND = 4'b0010;
    parameter ALU_OR  = 4'b0011;
    parameter ALU_NOR = 4'b0100;
    parameter ALU_XOR = 4'b0101;
    parameter ALU_SLT = 4'b0110;
    parameter ALU_SLTU= 4'b0111;
    parameter ALU_SLL = 4'b1000;
    parameter ALU_SRL = 4'b1001;
    parameter ALU_SRA = 4'b1010;
    parameter ALU_X   = 4'bxxxx;

    always @(*)
        case (ALUop)
            4'b1111:
                case (func)
                    ADD:    ALUctr <= ALU_ADD;
                    ADDU:   ALUctr <= ALU_ADD;
                    SUB:    ALUctr <= ALU_SUB;
                    SUBU:   ALUctr <= ALU_SUB;
                    AND:    ALUctr <= ALU_AND;
                    OR:     ALUctr <= ALU_OR;
                    NOR:    ALUctr <= ALU_NOR;
                    XOR:    ALUctr <= ALU_XOR;
                    SLT:    ALUctr <= ALU_SLT;
                    SLTU:   ALUctr <= ALU_SLTU;
                    SLL:    ALUctr <= ALU_SLL;
                    SRL:    ALUctr <= ALU_SRL;
                    SRA:    ALUctr <= ALU_SRA;
                    SLLV:   ALUctr <= ALU_SLL;
                    SRLV:   ALUctr <= ALU_SRL;
                    SRAV:   ALUctr <= ALU_SRA;
                    JR:     ALUctr <= ALU_X;
                endcase
            4'b0000: ALUctr <= ALU_ADD;
            4'b0001: ALUctr <= ALU_SUB;
            4'b0010: ALUctr <= ALU_AND;
            4'b0011: ALUctr <= ALU_OR;
            4'b0100: ALUctr <= ALU_NOR;
            4'b0101: ALUctr <= ALU_XOR;
            4'b0110: ALUctr <= ALU_SLT;
            4'b0111: ALUctr <= ALU_SLTU;
        endcase

endmodule