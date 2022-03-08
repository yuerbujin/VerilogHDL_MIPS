module NPC(
    input [31:0] pc,
    input [15:0] imm16,
    input [25:0] target,
    input jump,
    input branch,
    input zero,

    output reg [31:0] result
);
    
    always @(*)
        begin
            if (jump)
                result <= {pc[31:28], target, 2'b00};
            else if (branch & zero)
                result <= pc + 4 + {{14{imm16[15]}}, imm16, 2'b00};
            else
                result <= pc + 4;
        end

endmodule