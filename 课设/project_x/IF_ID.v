module IF_ID(
    input [31:0] IF_pc_4,
    input [31:0] IF_instruction,
    input [3:0] IF_pcHigh4,

    output reg [31:0] ID_pc_4,
    output reg [31:0] ID_instruction,
    output reg  [3:0] ID_pcHigh4,

    input IF_ID_sleep, IF_ID_nop,
    input clk, rst
);

    always @(posedge clk) begin
        if(IF_ID_nop) 
            ID_instruction = 0;
    end

    always @(negedge clk)
        begin
            ID_pc_4 = IF_pc_4;
            ID_instruction = IF_instruction;
            ID_pcHigh4 = IF_pcHigh4;
        end

endmodule