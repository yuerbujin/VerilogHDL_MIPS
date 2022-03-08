module IM(
    input [11:2] cur_pc,

    output [31:0] IF_instruction
);
    reg [31:0] memory [2047:0];

    initial begin
        $readmemh("F:/study/homework/project/project_x/test_with.txt", memory, 32'h0000_0000);
        // $readmemh("F:/study/homework/project/project_x/code3.txt", memory, 32'h0000_0000);
    
        memory[32'h0000_0140] = 0;//nop指令
    end

    assign IF_instruction = memory[cur_pc];
endmodule