module DataMemory(clk, ALUResult, WriteData, ReadData, MemWrite, MemRead);

    input wire clk;
    input wire MemWrite;
    input wire MemRead;
    input wire [31:0]ALUResult;
    input wire [31:0]WriteData;
    output [31:0]ReadData;
    reg [31:0]Memory[0:31];

    assign ReadData = MemRead ? Memory[ALUResult>>3] : 0;  //Não estou seguro com esse shift right aí

    initial begin
		$readmemb("entrada/dataMemory.txt", Memory);
	end

    always @(posedge clk) begin
        if(MemWrite) begin
            Memory[ALUResult>>3] <= WriteData;
        end
    end
endmodule