module IM(
    input [31:0] address,

    output [31:0] instruction
);
    reg [31:0] memory [1023:0];

    initial begin
        // $display("im initial");
        // $readmemh("F:/study/homework/project/project1/test_addiu.txt", memory, 32'h0000_0000);
        $readmemh("F:/study/homework/project/project1/code.txt", memory, 32'h0000_0000);
    end

    wire [31:2] bias = {28'h0000_300, 2'b00};
    assign instruction = memory[address[31:2] - bias];

endmodule