//功能：半字0扩展、半字符号扩展、lui
module EX_EXTENDER1(
    input [15:0] Ex_imm16,
    input [1:0] Ex_ExtOp1,
    output reg [31:0] Ex_imm32
);

    always @(*)
        case (Ex_ExtOp1)
            2'b00: Ex_imm32 = {16'h0000, Ex_imm16};//zero extension
            2'b01: Ex_imm32 = {{16{Ex_imm16[15]}}, Ex_imm16};//sign extension
            2'b10: Ex_imm32 = {Ex_imm16, 16'h0000};//lui
        endcase
endmodule


//功能：不扩展、半字符号扩展、字节符号扩展
module EX_EXTENDER2(
    input [31:0] Ex_ALUB,
    input [1:0] Ex_ExtOp2,
    output reg [31:0] Ex_datain
);

    always @(*)
        case (Ex_ExtOp2)
            2'b00: Ex_datain <= Ex_ALUB;//no extention
            2'b01: Ex_datain <= {16'b0, Ex_ALUB[15:0]};//sh
            2'b10: Ex_datain <= {24'b0, Ex_ALUB[7:0]};//sb
        endcase
endmodule


//功能：不扩展、半字符号扩展、半字0扩展、字节符号扩展、字节0扩展
module Mem_Extender(
    input [31:0] Mem_Do,
    input [2:0] Mem_ExtOp3,
    output reg [31:0] Mem_dataout
);

    always @(*)
        case (Mem_ExtOp3)
            3'b000: Mem_dataout <= Mem_Do;//no extention
            3'b001: Mem_dataout <= {{16{Mem_Do[15]}}, Mem_Do[15:0]};//lh
            3'b010: Mem_dataout <= {16'b0, Mem_Do[15:0]};//lhu
            3'b011: Mem_dataout <= {{24{Mem_Do[7]}}, Mem_Do[7:0]};//lb
            3'b100: Mem_dataout <= {24'b0, Mem_Do[7:0]};//lbu
        endcase
endmodule