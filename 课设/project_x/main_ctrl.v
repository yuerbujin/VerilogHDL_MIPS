module MAIN_CTRL(
    input [5:0] op,
    input [5:0] func,

    output [3:0] ID_ALUop,
    output [1:0] ID_ExtOp1, ID_ExtOp2,
    output [1:0] ID_jump,
    output [1:0] ID_ALUsrc,
    output ID_ALUShamtSrc, ID_RegDst,
    output reg ID_MemRead,//3
    output ID_MemWr,
    output [2:0] ID_Branch, ID_ExtOp3,//4
    output [1:0] ID_MemtoReg, 
    output ID_RegWr//5
);

    //OPCODE FIELD (23-1)
    parameter   R_TYPE= 6'b000000;                  // R-type
    parameter   JAL   = 6'b000011;                  // jal
    parameter   JUMP  = 6'b000010;                  // j
    parameter   ADDI  = 6'b001000;                  // addi
    parameter   ADDIU = 6'b001001;                  // addiu
    parameter   ANDI  = 6'b001100;                  // andi
    parameter   ORI   = 6'b001101;                  // ori
    parameter   XORI  = 6'b001110;                  // xori
    parameter   SLTI  = 6'b001010;                  // slti
    parameter   SLTIU = 6'b001011;                  // sltiu
    parameter   LUI   = 6'b001111;                  // lui
    parameter   LW    = 6'b100011;                  // lw
    parameter   LH    = 6'b100001;                  // lh
    parameter   LHU   = 6'b100101;                  // lhu
    parameter   LB    = 6'b100000;                  // lb
    parameter   LBU   = 6'b100100;                  // lbu
    parameter   SW    = 6'b101011;                  // sw
    parameter   SH    = 6'b101001;                  // sh
    parameter   SB    = 6'b101000;                  // sb
    parameter   BEQ   = 6'b000100;                  // beq
    parameter   BNE   = 6'b000101;                  // bne
    parameter   BGEZ  = 6'b000001;                  // bgez
    parameter   BLEZ  = 6'b000110;                  // blez

    //FUNCT FIELD (17)
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

    reg [23:0] mainCtr;
    assign {ID_ALUop, ID_ExtOp1, ID_ExtOp2, ID_jump, ID_ALUsrc, ID_ALUShamtSrc, ID_RegDst, ID_MemWr, ID_Branch, ID_ExtOp3, ID_MemtoReg, ID_RegWr} = mainCtr;

    initial
        begin
            $display("control initial");
        end

    always @(*)
        begin
            case (op)
                R_TYPE:
                    begin
                        case (func)
                            ADD:    mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            ADDU:   mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            SUB:    mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            SUBU:   mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            AND:    mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            OR:     mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            NOR:    mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            XOR:    mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            SLT:    mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            SLTU:   mainCtr <= 24'b1111_xxxx_0000_x100_0000_0001;
                            SLL:    mainCtr <= 24'b1111_xxxx_0000_0100_0000_0001;
                            SRL:    mainCtr <= 24'b1111_xxxx_0000_0100_0000_0001;
                            SRA:    mainCtr <= 24'b1111_xxxx_0000_0100_0000_0001;
                            SLLV:   mainCtr <= 24'b1111_xxxx_0000_1100_0000_0001;
                            SRLV:   mainCtr <= 24'b1111_xxxx_0000_1100_0000_0001;
                            SRAV:   mainCtr <= 24'b1111_xxxx_0000_1100_0000_0001;
                            JR:     mainCtr <= 24'b1111_xxxx_1000_x100_0000_0xx0;
                        endcase
                    end
                JAL:     mainCtr <= 24'bxxxx_xxxx_01xx_x100_0000_0101;
                JUMP:    mainCtr <= 24'bxxxx_xxxx_01xx_x100_0000_0xx0;
                ADDI:    mainCtr <= 24'b0000_01xx_0001_x000_0000_0001;
                ADDIU:   mainCtr <= 24'b0000_01xx_0001_x000_0000_0001;
                ANDI:    mainCtr <= 24'b0010_01xx_0001_x000_0000_0001;
                ORI:     mainCtr <= 24'b0011_00xx_0001_x000_0000_0001;
                XORI:    mainCtr <= 24'b0101_00xx_0001_x000_0000_0001;
                SLTI:    mainCtr <= 24'b0110_01xx_0001_x000_0000_0001;
                SLTIU:   mainCtr <= 24'b0111_01xx_0001_x000_0000_0001;
                LUI:     mainCtr <= 24'b0000_10xx_0001_x000_0000_0001;
                LW:      mainCtr <= 24'b0000_01xx_0001_x000_0000_0011;
                LH:      mainCtr <= 24'b0000_01xx_0001_x000_0000_1011;
                LHU:     mainCtr <= 24'b0000_01xx_0001_x000_0001_0011;
                LB:      mainCtr <= 24'b0000_01xx_0001_x000_0001_1011;
                LBU:     mainCtr <= 24'b0000_01xx_0001_x000_0010_0011;
                SW:      mainCtr <= 24'b0000_0100_0001_x110_0000_0xx0;
                SH:      mainCtr <= 24'b0000_0101_0001_x110_0000_0xx0;
                SB:      mainCtr <= 24'b0000_0110_0001_x110_0000_0xx0;
                BEQ:     mainCtr <= 24'b0001_01xx_0000_x100_0100_0xx0;
                BNE:     mainCtr <= 24'b0001_01xx_0000_x100_1000_0xx0;
                BGEZ:    mainCtr <= 24'b0001_01xx_0010_x100_1100_0xx0;
                BLEZ:    mainCtr <= 24'b0001_01xx_0010_x101_0000_0xx0;
            endcase
        end

    always @(*) begin
        case (op)
            LW:     ID_MemRead <= 1;
            LH:     ID_MemRead <= 1;
            LHU:    ID_MemRead <= 1;
            LB:     ID_MemRead <= 1;
            LBU:    ID_MemRead <= 1;

            default:ID_MemRead <= 0;
        endcase
    end
endmodule