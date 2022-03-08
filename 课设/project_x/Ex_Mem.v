module Ex_Mem(
    //data input
    input [31:0] Ex_branch_addr, Ex_npc,
    input [31:0] Ex_ALUout,
    input [31:0] Ex_datain,
    input [4:0] Ex_Rw,

    //data output
    output reg [31:0] Mem_branch_addr, Mem_npc,
    output reg [31:0] Mem_ALUout,
    output reg [31:0] Mem_datain,
    output reg [4:0] Mem_Rw,
    
    //control input
    input Ex_MemWr,
    input [2:0] Ex_Branch, 
    input Ex_Zero, Ex_Sign,
    input [2:0] Ex_ExtOp3,//4
    input [1:0] Ex_MemtoReg, 
    input Ex_RegWr,//5
    
    //control output
    output reg Mem_MemWr, 
    output reg [2:0] Mem_Branch,
    output reg Mem_Zero, Mem_Sign,
    output reg [2:0] Mem_ExtOp3,//4
    output reg [1:0] Mem_MemtoReg,
    output reg Mem_RegWr,//5

    input clk, rst
);

    always @(negedge clk)
        begin
            Mem_branch_addr <= Ex_branch_addr;
            Mem_npc <= Ex_npc;
            Mem_ALUout <= Ex_ALUout;
            Mem_datain <= Ex_datain;
            Mem_Rw <= Ex_Rw;

            Mem_MemWr <= Ex_MemWr;
            Mem_Branch <= Ex_Branch;
            Mem_Zero <= Ex_Zero;
            Mem_Sign <= Ex_Sign;
            Mem_ExtOp3 <= Ex_ExtOp3;
            Mem_MemtoReg <= Ex_MemtoReg;
            Mem_RegWr <= Ex_RegWr;
        end
endmodule