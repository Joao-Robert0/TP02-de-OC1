module ALUCtrl(Funct7, Funct3, ALUOperation, ALUControl);
    input wire [6:0]Funct7;
    input wire [2:0]Funct3;
    input wire [1:0]ALUOperation;
    output reg [3:0]ALUControl;

    always @(*) begin  
        case (ALUOperation)
            2'b00: ALUControl <= 4'b0010; //ADD
            2'b01: ALUControl <= 4'b0110; //SUB
            2'b10: begin
                if((Funct7 == 7'b0000000)) begin
                    case (Funct3)
                    3'b000: ALUControl <= 4'b0010; //ADD
                    3'b100: ALUControl <= 4'b0100; // XOR
                    3'b101: ALUControl <= 4'b0111; // SRL
//                    3'b110: ALUControl <= 4'b0001; //OR
//                    3'b111: ALUControl <= 4'b0000; //AND
                    default: ALUControl <= 4'b1111; 
                endcase
                end
                else if(Funct7 == 7'b0100000 && Funct3 == 3'b000) begin
                    ALUControl <= 4'b0110; //SUB
                end
                else begin
                ALUControl <= 4'b1111;
                end
            end
            default: ALUControl <= 4'b1111;
        endcase
    end
endmodule