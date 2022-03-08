module PC(
    input [31:0] next_addr,

    output reg [31:0] cur_pc,
    output wire IF_pcHigh4,

    input PC_sleep, PC_flush,    
    input clk, rst
);

    always @(posedge clk) begin
        if (PC_flush)
            cur_pc <= {32'h0000_0140, 2'b00};//nop指令地址
    end

    always @(negedge clk)
        begin
            if (rst)
                cur_pc <= 32'h0000_3000;
            else if (~PC_sleep)
                cur_pc <= next_addr;
        end

endmodule