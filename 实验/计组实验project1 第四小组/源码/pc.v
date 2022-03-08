module PC(
    input clk,
    input rst,
    input [31:0] result,
    output reg [31:0] address
);

    always @(posedge clk or posedge rst)
        begin
            if (rst)
                address <= 32'h0000_3000;
            else
                address <= result;
        end

endmodule