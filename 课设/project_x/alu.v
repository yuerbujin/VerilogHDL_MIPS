module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] Ex_ALUctr,
    input [4:0] shamt,

    output reg [31:0] Ex_ALUout,
    output wire Ex_Zero,
    output reg Ex_Sign
);

    //Ex_ALUctr
    parameter ADD = 4'b0000;
    parameter SUB = 4'b0001;
    parameter AND = 4'b0010;
    parameter OR  = 4'b0011;
    parameter NOR = 4'b0100;
    parameter XOR = 4'b0101;
    parameter SLT = 4'b0110;
    parameter SLTU= 4'b0111;
    parameter SLL = 4'b1000;
    parameter SRL = 4'b1001;
    // parameter SLA = 4'b1010;
    parameter SRA = 4'b1010;

    always @(*)
        case (Ex_ALUctr)
            ADD: Ex_ALUout <= A + B;
            SUB: Ex_ALUout <= A - B;
            AND: Ex_ALUout <= A & B;
            OR:  Ex_ALUout <= A | B;
            NOR: Ex_ALUout <= ~(A | B);
            XOR: Ex_ALUout <= A ^ B;
            SLT: Ex_ALUout <= ($signed(A) < $signed(B) ? 1:0);
            SLTU:Ex_ALUout <= (A<B ? 1:0);
            SLL: Ex_ALUout <= (B << shamt);
            // SLA: Ex_ALUout <= (B <<< shamt);
            SRL: Ex_ALUout <= (B >> shamt);
            SRA: Ex_ALUout <= ($signed(B) >>> shamt);
        endcase

    assign Ex_Zero = (Ex_ALUout == 0 ? 1:0);

    always @(*)
        if (Ex_ALUout > 0)
            Ex_Sign = 0;
        else if (Ex_ALUout < 0)
            Ex_Sign = 1;

endmodule


module Ex_Adder(
    input [31:0] Ex_imm32, Ex_npc,

    output [31:0] Ex_branch_addr
);

    assign Ex_branch_addr = Ex_npc + (Ex_imm32 << 2);
endmodule