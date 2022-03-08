module DATAPATH(
    input [3:0] ID_ALUop,
    input [1:0] ID_ExtOp1, ID_ExtOp2,
    input [1:0] ID_jump,
    input [1:0] ID_ALUsrc,
    input ID_ALUShamtSrc, ID_RegDst, ID_MemRead,//3
    input ID_MemWr,
    input [2:0] ID_Branch, ID_ExtOp3,//4
    input [1:0] ID_MemtoReg, 
    input ID_RegWr,//5

    output [31:0] ID_instruction,

    input clk, rst
);

    /////////////////////////////////wire begin
    //IF
    wire [31:0] IF_pc_4, IF_instruction;
    wire [31:0] cur_pc, next_addr;
    wire [3:0] IF_pcHigh4 = cur_pc[31:28];

    //ID
    wire [31:0] ID_pc_4, ID_busA, ID_busB;
    wire [4:0] ID_Rs = ID_instruction[25:21];
    wire [4:0] ID_Rt = ID_instruction[20:16];
    wire [4:0] ID_Rd = ID_instruction[15:11];
    wire [15:0] ID_imm16 = ID_instruction[15:0];
    wire [25:0] ID_target = ID_instruction[25:0];
    wire [4:0] ID_shamt = ID_instruction[10:6];
    wire [5:0] ID_func = ID_instruction[5:0];
    wire [3:0] ID_pcHigh4;

    //Ex
    wire [31:0] Ex_npc, Ex_j_addr, Ex_branch_addr;
    wire [15:0] Ex_imm16;
    wire [31:0] Ex_busA, Ex_busB, Ex_imm32, Ex_ALUin2, Ex_datain, Ex_ALUout;
    wire [31:0] Ex_ALUA, Ex_ALUB;
    wire [4:0] Ex_Rs, Ex_Rt, Ex_Rd, Ex_Rw;
    wire [4:0] Ex_shamt, Ex_ALUShamt;
        //Ex control
        wire [5:0] Ex_func;
        wire [3:0] Ex_ALUop, Ex_ALUctr;
        wire [1:0] Ex_ExtOp1, Ex_ExtOp2;
        wire [1:0] Ex_jump;
        wire [1:0] Ex_ALUsrc;
        wire Ex_ALUShamtSrc, Ex_RegDst;
        wire Ex_MemRead;//3
        wire Ex_MemWr;
        wire [2:0] Ex_Branch;
        wire Ex_Zero, Ex_Sign;
        wire [2:0] Ex_ExtOp3;//4
        wire [1:0] Ex_MemtoReg;
        wire Ex_RegWr;//5

    //Mem
    wire [31:0] Mem_branch_addr, Mem_npc;
    wire [31:0] Mem_ALUout;
    wire [31:0] Mem_datain, Mem_Do, Mem_dataout;
    wire [4:0] Mem_Rw;
        //Mem control
        wire Mem_MemWr; 
        wire [2:0] Mem_Branch;
        wire Mem_Zero, Mem_Sign;
        wire [2:0] Mem_ExtOp3;//4
        wire [1:0] Mem_MemtoReg;
        wire Mem_RegWr;//5

    //Wr
    wire [31:0] Wr_npc;
    wire [31:0] Wr_dataout, Wr_ALUout;
    wire [31:0] Wr_RegDi;
    wire [4:0] Wr_Rw;
        //Wr control
        wire [1:0] Wr_MemtoReg;
        wire Wr_RegWr;//5
    /////////////////////////////////wire end


    /////////////////////////////////hazard begin
    wire [1:0] ALUSrcA, ALUSrcB;
    wire ID_Ex_flush, IF_ID_sleep, PC_sleep;

    wire PC_flush, IF_ID_nop, ID_Ex_flush2;
    /////////////////////////////////hazard end

    
    /////////////////////////////////module begin
    //IF
    PC pc(.cur_pc(cur_pc), .next_addr(next_addr), .PC_sleep(PC_sleep), .PC_flush(PC_flush), .IF_pcHigh4(IF_pcHigh4), .clk(clk), .rst(rst));
    NPC npc(.cur_pc(cur_pc), .Mem_branch_addr(Mem_branch_addr), .jr_addr(Ex_busA), .j_addr(Ex_j_addr), .Mem_Zero(Mem_Zero), .Mem_Sign(Mem_Sign), .Mem_Branch(Mem_Branch), .Ex_jump(Ex_jump), .IF_pc_4(IF_pc_4), .next_addr(next_addr));
    IM im(.cur_pc(cur_pc[11:2]), .IF_instruction(IF_instruction));

    //ID
    IF_ID if_id(.IF_pc_4(IF_pc_4), .IF_instruction(IF_instruction), .IF_pcHigh4(IF_pcHigh4), .ID_pc_4(ID_pc_4), .IF_ID_sleep(IF_ID_sleep), .IF_ID_nop(IF_ID_nop), .ID_instruction(ID_instruction), .ID_pcHigh4(ID_pcHigh4), .clk(clk), .rst(rst));
    REGFILE regfile(.ID_Ra(ID_Rs), .ID_Rb(ID_Rt), .Wr_Rw(Wr_Rw), .Wr_RegDi(Wr_RegDi), .Wr_RegWr(Wr_RegWr), .Wr_MemtoReg(Wr_MemtoReg), .ID_busA(ID_busA), .ID_busB(ID_busB), .clk(clk), .rst(rst));
    
    //Ex
    ID_Ex id_ex(.ID_npc(ID_pc_4), .ID_imm16(ID_imm16), .ID_busA(ID_busA), .ID_busB(ID_busB), .ID_target(ID_target), .ID_Rs(ID_Rs), .ID_Rt(ID_Rt), .ID_Rd(ID_Rd), .ID_shamt(ID_shamt), .ID_pcHigh4(ID_pcHigh4),
                .Ex_npc(Ex_npc), .Ex_imm16(Ex_imm16), .Ex_busA(Ex_busA), .Ex_busB(Ex_busB), .Ex_Rs(Ex_Rs), .Ex_Rt(Ex_Rt), .Ex_Rd(Ex_Rd), .Ex_shamt(Ex_shamt), .Ex_j_addr(Ex_j_addr),
                .ID_func(ID_func), .ID_ALUop(ID_ALUop), .ID_ExtOp1(ID_ExtOp1), .ID_ExtOp2(ID_ExtOp2), .ID_jump(ID_jump), .ID_ALUsrc(ID_ALUsrc), .ID_ALUShamtSrc(ID_ALUShamtSrc), .ID_RegDst(ID_RegDst), .ID_MemRead(ID_MemRead), .ID_MemWr(ID_MemWr), .ID_Branch(ID_Branch), .ID_ExtOp3(ID_ExtOp3), .ID_MemtoReg(ID_MemtoReg), .ID_RegWr(ID_RegWr),
                .Ex_func(Ex_func), .Ex_ALUop(Ex_ALUop), .Ex_ExtOp1(Ex_ExtOp1), .Ex_ExtOp2(Ex_ExtOp2), .Ex_jump(Ex_jump), .Ex_ALUsrc(Ex_ALUsrc), .Ex_ALUShamtSrc(Ex_ALUShamtSrc), .Ex_RegDst(Ex_RegDst), .Ex_MemRead(Ex_MemRead), .Ex_MemWr(Ex_MemWr), .Ex_Branch(Ex_Branch), .Ex_ExtOp3(Ex_ExtOp3), .Ex_MemtoReg(Ex_MemtoReg), .Ex_RegWr(Ex_RegWr),
                .ID_Ex_flush(ID_Ex_flush), .ID_Ex_flush2(ID_Ex_flush2),
                .clk(clk), .rst(rst));
    EX_EXTENDER1 ex_extender1(.Ex_imm16(Ex_imm16), .Ex_ExtOp1(Ex_ExtOp1), .Ex_imm32(Ex_imm32));
    Ex_MUX1 ex_mux1(.Ex_Rt(Ex_Rt), .Ex_Rd(Ex_Rd), .Ex_RegDst(Ex_RegDst), .Ex_Rw(Ex_Rw));
    Ex_MUX2 ex_mux2(.Ex_ALUB(Ex_ALUB), .Ex_imm32(Ex_imm32), .Ex_ALUsrc(Ex_ALUsrc), .Ex_ALUin2(Ex_ALUin2));
    EX_EXTENDER2 ex_extender2(.Ex_ALUB(Ex_ALUB), .Ex_ExtOp2(Ex_ExtOp2), .Ex_datain(Ex_datain));
    Ex_Adder ex_adder(.Ex_imm32(Ex_imm32), .Ex_npc(Ex_npc), .Ex_branch_addr(Ex_branch_addr));
    Ex_MUX3 ex_mux3(.Ex_busA_low5(ALUSrcA[4:0]), .Ex_shamt(Ex_shamt), .Ex_ALUShamtSrc(Ex_ALUShamtSrc), .Ex_ALUShamt(Ex_ALUShamt));
    ALU_CTR alu_ctr(.ALUop(Ex_ALUop), .func(Ex_func), .ALUctr(Ex_ALUctr));
    ALU alu(.A(Ex_ALUA), .B(Ex_ALUin2), .Ex_ALUctr(Ex_ALUctr), .shamt(Ex_ALUShamt), .Ex_ALUout(Ex_ALUout), .Ex_Zero(Ex_Zero), .Ex_Sign(Ex_Sign));
  
    //Mem
    Ex_Mem ex_mem(.Ex_branch_addr(Ex_branch_addr), .Ex_npc(Ex_npc), .Ex_ALUout(Ex_ALUout), .Ex_datain(Ex_datain), .Ex_Rw(Ex_Rw),
                  .Mem_branch_addr(Mem_branch_addr), .Mem_npc(Mem_npc), .Mem_ALUout(Mem_ALUout), .Mem_datain(Mem_datain), .Mem_Rw(Mem_Rw),
                  .Ex_MemWr(Ex_MemWr), .Ex_Branch(Ex_Branch), .Ex_Zero(Ex_Zero), .Ex_Sign(Ex_Sign), .Ex_ExtOp3(Ex_ExtOp3), .Ex_MemtoReg(Ex_MemtoReg), .Ex_RegWr(Ex_RegWr),
                  .Mem_MemWr(Mem_MemWr), .Mem_Branch(Mem_Branch), .Mem_Zero(Mem_Zero), .Mem_Sign(Mem_Sign), .Mem_ExtOp3(Mem_ExtOp3), .Mem_MemtoReg(Mem_MemtoReg), .Mem_RegWr(Mem_RegWr),
                  .clk(clk), .rst(rst));
    DM dm(.Mem_datain(Mem_datain), .Mem_ALUout(Mem_ALUout), .Mem_MemWr(Mem_MemWr), .Mem_Do(Mem_Do), .clk(clk), .rst(rst));
    Mem_Extender mem_extender(.Mem_Do(Mem_Do), .Mem_ExtOp3(Mem_ExtOp3), .Mem_dataout(Mem_dataout));

    //Wr
    Mem_Wr mem_wr(.Mem_npc(Mem_npc), .Mem_dataout(Mem_dataout), .Mem_ALUout(Mem_ALUout), .Mem_Rw(Mem_Rw),
                  .Wr_npc(Wr_npc), .Wr_dataout(Wr_dataout), .Wr_ALUout(Wr_ALUout), .Wr_Rw(Wr_Rw),
                  .Mem_MemtoReg(Mem_MemtoReg), .Mem_RegWr(Mem_RegWr),
                  .Wr_MemtoReg(Wr_MemtoReg), .Wr_RegWr(Wr_RegWr),
                  .clk(clk), .rst(rst));
    Mem_MUX mem_mux(.Wr_npc(Wr_npc), .Wr_dataout(Wr_dataout), .Wr_ALUout(Wr_ALUout), .Wr_MemtoReg(Wr_MemtoReg), .Wr_RegDi(Wr_RegDi));
    /////////////////////////////////module end

    /////////////////////////////////hazard begin
    Ex_MUXA_FORWARDING ex_muxA(.Ex_busA(Ex_busA), .Mem_ALUout(Mem_ALUout), .Wr_RegDi(Wr_RegDi), .ALUSrcA(ALUSrcA), .Ex_ALUA(Ex_ALUA));
    Ex_MUXB_FORWARDING ex_muxB(.Ex_busB(Ex_busB), .Mem_ALUout(Mem_ALUout), .Wr_RegDi(Wr_RegDi), .ALUSrcB(ALUSrcB), .Ex_ALUB(Ex_ALUB));
    FORWARDING forwarding(.Mem_RegWr(Mem_RegWr), .Wr_RegWr(Wr_RegWr), .Mem_Rw(Mem_Rw), .Ex_Rs(Ex_Rs), .Ex_Rt(Ex_Rt), .Wr_Rw(Wr_Rw), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB));

    Loaduse loaduse(.Ex_MemRead(Ex_MemRead), .Ex_Rt(Ex_Rt), .ID_Rs(ID_Rs), .ID_Rt(ID_Rt), .ID_Ex_flush(ID_Ex_flush), .IF_ID_sleep(IF_ID_sleep), .PC_sleep(PC_sleep));
    
    BJ_Unit bj_unit(.Mem_Zero(Mem_Zero), .Mem_Sign(Mem_Sign), .Mem_Branch(Mem_Branch), .Ex_jump(Ex_jump), .PC_flush(PC_flush), .IF_ID_nop(IF_ID_nop), .ID_Ex_flush2(ID_Ex_flush2));
    /////////////////////////////////hazard end

endmodule