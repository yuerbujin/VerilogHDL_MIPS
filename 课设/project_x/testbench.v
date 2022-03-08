`timescale 1ns/1ps

module testbench();
    reg clk, rst;

    PIPELINE_PROCESSOR pipeline_processor(clk, rst);

    initial
        begin
            clk <= 1;
            rst <= 1;

            #50 rst <= 0;
            // #75 $stop;
            #100000000 $stop;
        end

    always
        #5 clk = ~clk;

endmodule