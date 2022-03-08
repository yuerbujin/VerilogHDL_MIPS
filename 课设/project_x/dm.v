module DM(
    input [31:0] Mem_datain,
    input [31:0] Mem_ALUout,
    input Mem_MemWr,

    output [31:0] Mem_Do,
    
    input clk, rst
);
    reg [31:0] memory [2047:0];
    wire [12:2] read_addr, write_addr;

    initial begin
        $display("dm initial");
    end

    assign read_addr = Mem_ALUout[12:2];
    assign write_addr = Mem_ALUout[12:2];

    //first half
    always @(posedge clk)
        if (Mem_MemWr)
            memory[write_addr] = Mem_datain;

    //second half
    assign Mem_Do = memory[write_addr];

endmodule