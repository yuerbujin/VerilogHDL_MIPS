module REGFILE(
    input [4:0] Rw,
    input [4:0] Ra,
    input [4:0] Rb,
    input [31:0] busW,
    input RegWr,

    input clk, rst,
    output [31:0] busA,
    output [31:0] busB
);
    reg [31:0] Registers [31:0];
    integer i;

    initial begin
        // $display("regfile initial");
        Registers[0] <= 0;//$zero = 0
        
        for (i = 1; i <= 31; i=i+1) begin
           #1;
            Registers[i] <= 0;
        end
    end

    assign busA = Registers[Ra];
    assign busB = Registers[Rb];

    always @(posedge clk)
        if (RegWr)
            Registers[Rw] = busW;

endmodule