module FORWARDING(
    input Mem_RegWr, Wr_RegWr,
    input [4:0] Mem_Rw, Ex_Rs, Ex_Rt, Wr_Rw,

    output reg [1:0] ALUSrcA, ALUSrcB
);

    initial begin
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b00;
    end

    always @(*) begin
        //ALUSrcA
        if (Mem_RegWr && (Mem_Rw == Ex_Rs)) 
            ALUSrcA = 2'b01;
        else if(Wr_RegWr && (Mem_Rw != Ex_Rs) && (Wr_Rw == Ex_Rs))
            ALUSrcA = 2'b10;
        else
            ALUSrcA = 2'b00;

        //ALUSrcB
        if (Mem_RegWr && (Mem_Rw == Ex_Rt)) 
            ALUSrcB = 2'b01;
        else if(Wr_RegWr && (Mem_Rw != Ex_Rt) && (Wr_Rw == Ex_Rt))
            ALUSrcB = 2'b10;
        else
            ALUSrcB = 2'b00;
    end
endmodule


module Loaduse(
    input Ex_MemRead, 
    input [4:0] Ex_Rt, ID_Rs, ID_Rt,

    output reg ID_Ex_flush, IF_ID_sleep, PC_sleep
);

    initial begin
        ID_Ex_flush <= 0;
        IF_ID_sleep <= 0;
        PC_sleep <= 0;
    end

    always @(*)
        if (Ex_MemRead && ((Ex_Rt == ID_Rs) || (Ex_Rt == ID_Rt)))
            begin
                ID_Ex_flush <= 1;
                IF_ID_sleep <= 1;
                PC_sleep <= 1;
            end
        else
            begin
                ID_Ex_flush <= 0;
                IF_ID_sleep <= 0;
                PC_sleep <= 0;
            end
endmodule