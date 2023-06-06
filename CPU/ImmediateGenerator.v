module ImmediateGenerator(instruction, imediato);
    input [31:0] instruction;
    output reg [31:0] imediato;

    always @(*) begin
        case(instruction[6:0])   //instruction[6:0] é o OPCODE da instrução
        //LW
            7'b0000011: imediato[31:0] = {20'b0, instruction[31:20]};
        //SW
            7'b0100011: imediato[31:0] = {20'b0, instruction[31:25], instruction[11:7]};
        //ADDI
            7'b0010011: imediato[31:0] = {20'b0, instruction[31:20]};
        //BEQ
            7'b1100011: imediato[31:0] = {20'b0, instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
            default: imediato[31:0] = 32'b0;
        endcase
    end
endmodule