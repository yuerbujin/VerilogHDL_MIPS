module REGFILE(
    input [4:0] ID_Ra,
    input [4:0] ID_Rb,
    input [4:0] Wr_Rw,
    input [31:0] Wr_RegDi,

    input Wr_RegWr,
    input [1:0] Wr_MemtoReg,//5

    output [31:0] ID_busA,
    output [31:0] ID_busB,

    input clk, rst
);

    parameter JAL = 2'b10;

    reg [31:0] Registers [31:0];

    integer i;
    initial begin
        Registers[0] <= 0;//$zero = 0
        
        for (i = 1; i <= 31; i=i+1) begin
            #1;
            Registers[i] <= 0;
        end
    end

    //first half
    always @(posedge clk)
        if (Wr_RegWr)
            if (Wr_MemtoReg == JAL)
                Registers[31] = Wr_RegDi;
            else
                Registers[Wr_Rw] = Wr_RegDi;

    //second half
    assign ID_busA = Registers[ID_Ra];
    assign ID_busB = Registers[ID_Rb];

endmodule