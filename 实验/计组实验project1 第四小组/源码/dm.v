module DM(
    input [31:0] dataIn,
    input [31:0] Adr,

    input MemWr,
    input clk, rst,

    output [31:0] DataOut
);
    reg [31:0] memory [1023:0];
    initial begin
        $display("dm initial");
    end

    assign DataOut = memory[Adr[31:2]];

    always @(posedge clk)
        if (MemWr)
            memory[Adr[31:2]] = dataIn;
endmodule