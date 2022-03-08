//`include "mips.v"
`timescale 1ns/1ps

module testbench();
    reg clk, rst;

    PROCESSOR process(clk, rst);

    initial
        begin
            clk <= 1;
            rst <= 1;

            #50 rst <= 0;
            // #75 $stop;
            #5000000 $stop;
        end

    always
        #5 clk = ~clk;

endmodule