module NPC(
    input [31:0] cur_pc, Mem_branch_addr, jr_addr, j_addr,
    input Mem_Zero, Mem_Sign,
    input [2:0] Mem_Branch,
    input [1:0] Ex_jump,

    output [31:0] IF_pc_4,
    output reg [31:0] next_addr
);
    parameter NOT_BRANCH = 3'b000;//not branch
    parameter BEQ = 3'b001;//beq
    parameter BNE = 3'b010;//bne
    parameter BGEZ = 3'b011;//bgez
    parameter BLEZ = 3'b100;//blez

    assign IF_pc_4 = cur_pc + 4;

    always @(*)
        begin
            case (Mem_Branch)
                NOT_BRANCH:
                    case (Ex_jump)
                        2'b00: next_addr <= IF_pc_4;//not jump
                        2'b01: next_addr <= j_addr;//j or jal
                        2'b10: next_addr <= jr_addr;//jr
                    endcase
                BEQ:
                    if (Mem_Zero)               next_addr <= Mem_branch_addr;
                    else                        next_addr <= IF_pc_4;
                BNE:
                    if (~Mem_Zero)              next_addr <= Mem_branch_addr;
                    else                        next_addr <= IF_pc_4;
                BGEZ:
                    if (~Mem_Sign || Mem_Zero)  next_addr <= Mem_branch_addr;
                    else                        next_addr <= IF_pc_4;
                BLEZ:
                    if (Mem_Sign || Mem_Zero)   next_addr <= Mem_branch_addr;
                    else                        next_addr <= IF_pc_4;
            endcase
        end
        
endmodule