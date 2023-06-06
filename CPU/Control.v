module Control (OPCode, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
    
    input wire [6:0]OPCode;
    output reg ALUSrc;
    output reg MemToReg;
    output reg RegWrite;
    output reg MemRead;
    output reg MemWrite;
    output reg Branch;
    output reg [1:0]ALUOp;

    always @(*)begin
        case (OPCode)
            7'b0000011: begin //LW
                ALUSrc = 1;
                MemToReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                ALUOp <= 2'b00;
            end
            7'b0100011: begin //SW
                ALUSrc = 1;
                MemToReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                ALUOp <= 2'b00;
            end
            7'b1100111: begin //BEQ
                ALUSrc = 0;
                MemToReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp <= 2'b01;
            end

            7'b0010011: begin //ADDI
                ALUSrc = 1;
                MemToReg = 0;
                RegWrite = 1;
                MemRead = 0;
                Branch = 0;
                ALUOp <= 2'b00;
            end

            7'b0110011: begin //R-Type
                ALUSrc = 0;
                MemToReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp <= 2'b10;
            end
            default: begin
                ALUSrc = 0;
                MemToReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp <= 2'b00;
            end
        endcase
    end
endmodule