module BJ_Unit(
    input Mem_Zero, Mem_Sign,
    input [2:0] Mem_Branch,
    input [1:0] Ex_jump,

    output PC_flush, IF_ID_nop, ID_Ex_flush2
);

    reg [2:0] main_flush;
    assign {PC_flush, IF_ID_nop, ID_Ex_flush2} = main_flush;
    
    initial begin
        main_flush = 0;
    end

    parameter NOT_BRANCH = 3'b000;//not branch
    parameter BEQ = 3'b001;//beq
    parameter BNE = 3'b010;//bne
    parameter BGEZ = 3'b011;//bgez
    parameter BLEZ = 3'b100;//blez

    always @(*)
        begin
            case (Mem_Branch)
                NOT_BRANCH:
                    case (Ex_jump)
                        2'b00:  main_flush <= 3'b000;//not jump
                        2'b01:  main_flush <= 3'b110;//j or jal
                        2'b10:  main_flush <= 3'b110;//jr
                    endcase
                BEQ:
                    if (Mem_Zero)   main_flush <= 3'b111;
                    else            main_flush <= 3'b000;
                BNE:
                    if (~Mem_Zero)  main_flush <= 3'b111;
                    else            main_flush <= 3'b000;
                BGEZ:
                    if (~Mem_Sign || Mem_Zero)  main_flush <= 3'b111;
                    else                        main_flush <= 3'b000;
                BLEZ:
                    if (Mem_Sign || Mem_Zero)   main_flush <= 3'b111;
                    else                        main_flush <= 3'b000;
            endcase
        end
    
endmodule