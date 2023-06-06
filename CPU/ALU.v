module ALU(ReadData1, aluMuxResult, ALUControl, zero, ALUResult);
    input wire [31:0]ReadData1;
    input wire [31:0]aluMuxResult;
    input wire [3:0]ALUControl;
    output reg [31:0]ALUResult;
    output reg zero;

    always @(*) begin
        case (ALUControl)
            4'b0010: ALUResult <= ReadData1 + aluMuxResult; //ADDI, LW, SW
            4'b0110: ALUResult <= ReadData1 - aluMuxResult; //SUB
            4'b0100: ALUResult <= ReadData1 ^ aluMuxResult; //XOR 
            4'b0111: ALUResult <= ReadData1 << aluMuxResult; //SRL
            
            default: ALUResult = 32'b0;
        endcase
        if(ALUResult == 0) zero = 1;
        else zero = 0;

    end

endmodule