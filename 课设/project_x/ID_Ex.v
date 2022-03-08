module ID_Ex(
    //data input
    input [31:0] ID_npc,
    input [15:0] ID_imm16,
    input [31:0] ID_busA, ID_busB,
    input [25:0] ID_target,
    input [4:0] ID_Rs, ID_Rt, ID_Rd,
    input [4:0] ID_shamt,
    input [3:0] ID_pcHigh4,

    //data output
    output reg [31:0] Ex_npc,
    output reg [15:0] Ex_imm16,
    output reg [31:0] Ex_busA, Ex_busB,
    output reg [4:0] Ex_Rs, Ex_Rt, Ex_Rd,
    output reg [4:0] Ex_shamt,
    output reg [31:0] Ex_j_addr,

    //control input
    input [5:0] ID_func,
    input [3:0] ID_ALUop,
    input [1:0] ID_ExtOp1, ID_ExtOp2,
    input [1:0] ID_jump,
    input [1:0] ID_ALUsrc,
    input ID_ALUShamtSrc, ID_RegDst, ID_MemRead,//3
    input ID_MemWr,
    input [2:0] ID_Branch, ID_ExtOp3,//4
    input [1:0] ID_MemtoReg, 
    input ID_RegWr,//5

    //control output
    output reg [5:0] Ex_func,
    output reg [3:0] Ex_ALUop,
    output reg [1:0] Ex_ExtOp1, Ex_ExtOp2,
    output reg [1:0] Ex_jump,
    output reg [1:0] Ex_ALUsrc, 
    output reg Ex_ALUShamtSrc, Ex_RegDst, Ex_MemRead,//3
    output reg Ex_MemWr,
    output reg [2:0] Ex_Branch, Ex_ExtOp3,//4
    output reg [1:0]Ex_MemtoReg,
    output reg Ex_RegWr,//5

    input ID_Ex_flush, ID_Ex_flush2,
    input clk, rst
);

    always @(posedge clk)
        if (ID_Ex_flush || ID_Ex_flush2)
            begin
                Ex_jump <= 2'b00;
                Ex_MemRead <= 0;
                Ex_MemWr <= 0;
                Ex_Branch <= 3'b000;
                Ex_RegWr <= 0;
            end

    always @(negedge clk)
        begin
            Ex_npc <= ID_npc;
            Ex_imm16 <= ID_imm16;
            Ex_busA <= ID_busA;
            Ex_busB <= ID_busB;
            Ex_shamt <= ID_shamt;
            Ex_j_addr <= {ID_pcHigh4, ID_target, 2'b00};
            Ex_Rs <= ID_Rs;
            Ex_Rt <= ID_Rt;
            Ex_Rd <= ID_Rd;

            Ex_func <= ID_func;
            Ex_ALUop <= ID_ALUop;
            Ex_ExtOp1 <= ID_ExtOp1;
            Ex_ExtOp2 <= ID_ExtOp2;
            Ex_jump <= ID_jump;
            Ex_ExtOp3 <= ID_ExtOp3;
            Ex_ALUsrc <= ID_ALUsrc;
            Ex_ALUShamtSrc <= ID_ALUShamtSrc;
            Ex_RegDst <= ID_RegDst;
            Ex_MemRead <= ID_MemRead;
            Ex_MemWr <= ID_MemWr;
            Ex_Branch <= ID_Branch;
            Ex_MemtoReg <= ID_MemtoReg;
            Ex_RegWr <= ID_RegWr;
        end
endmodule