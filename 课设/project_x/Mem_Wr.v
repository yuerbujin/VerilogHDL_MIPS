module Mem_Wr(
    //data input
    input [31:0] Mem_npc,
    input [31:0] Mem_dataout, Mem_ALUout,
    input [4:0] Mem_Rw,
    
    //data output
    output reg [31:0] Wr_npc,
    output reg [31:0] Wr_dataout, Wr_ALUout,
    output reg [4:0] Wr_Rw,
    
    //control input
    input [1:0] Mem_MemtoReg,
    input Mem_RegWr,//5
    
    //control output
    output reg [1:0] Wr_MemtoReg,
    output reg Wr_RegWr,//5

    input clk, rst
);

    always @(negedge clk)
        begin
            Wr_npc <= Mem_npc;
            Wr_dataout <= Mem_dataout;
            Wr_ALUout <= Mem_ALUout;
            Wr_Rw <= Mem_Rw;

            Wr_MemtoReg <= Mem_MemtoReg;
            Wr_RegWr <= Mem_RegWr;
        end
endmodule