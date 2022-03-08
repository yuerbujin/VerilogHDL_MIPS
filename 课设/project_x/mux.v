module Ex_MUX1(
    input [4:0] Ex_Rt,
    input [4:0] Ex_Rd,
    input Ex_RegDst,

    output [4:0] Ex_Rw
);

    assign Ex_Rw = (Ex_RegDst ? Ex_Rd : Ex_Rt);
endmodule


module Ex_MUX2(
    input [31:0] Ex_ALUB,
    input [31:0] Ex_imm32,
    input [1:0] Ex_ALUsrc,

    output reg [31:0] Ex_ALUin2
);

    always @(*) 
        begin
            case (Ex_ALUsrc)
                2'b00: Ex_ALUin2 <= Ex_ALUB;
                2'b01: Ex_ALUin2 <= Ex_imm32;
                2'b10: Ex_ALUin2 <= 32'b0;
            endcase
        end
endmodule


module Ex_MUX3(
    input [4:0] Ex_busA_low5,
    input [4:0] Ex_shamt,
    input Ex_ALUShamtSrc,

    output [4:0] Ex_ALUShamt
);

    assign Ex_ALUShamt = (Ex_ALUShamtSrc ? Ex_busA_low5 : Ex_shamt);
endmodule


module Ex_MUXA_FORWARDING(
    input [31:0] Ex_busA,
    input [31:0] Mem_ALUout, Wr_RegDi,
    input [1:0] ALUSrcA,

    output reg [31:0] Ex_ALUA
);

    always @(*) 
        begin
            case (ALUSrcA)
                2'b00: Ex_ALUA <= Ex_busA;
                2'b01: Ex_ALUA <= Mem_ALUout;
                2'b10: Ex_ALUA <= Wr_RegDi;
            endcase
        end
endmodule


module Ex_MUXB_FORWARDING(
    input [31:0] Ex_busB,
    input [31:0] Mem_ALUout, Wr_RegDi,
    input [1:0] ALUSrcB,

    output reg [31:0] Ex_ALUB
);

    always @(*) 
        begin
            case (ALUSrcB)
                2'b00: Ex_ALUB <= Ex_busB;
                2'b01: Ex_ALUB <= Mem_ALUout;
                2'b10: Ex_ALUB <= Wr_RegDi;
            endcase
        end
endmodule


module Mem_MUX(
    input [31:0] Wr_npc, Wr_dataout, Wr_ALUout,
    input [1:0] Wr_MemtoReg,

    output reg [31:0] Wr_RegDi
);

    always @(*) 
        begin
            case (Wr_MemtoReg)
                2'b00: Wr_RegDi <= Wr_ALUout;//add,sub                
                2'b01: Wr_RegDi <= Wr_dataout;//lw
                2'b10: Wr_RegDi <= Wr_npc;//jal
            endcase
        end
endmodule

