module RegisterModule (clk, ReadRegister1, ReadRegister2, WriteRegister, ReadData1, ReadData2, WriteSignal, WriteData, Instruction);

    input wire WriteSignal, clk;
  	input wire [4:0]ReadRegister1;
    input wire [4:0]ReadRegister2;
    input wire [4:0]WriteRegister;
 	input wire [31:0]WriteData;
    input wire [31:0]Instruction;
    reg [31:0] register [0:31];
    output reg [31:0]ReadData1, ReadData2;
    integer i;

    initial begin
        $readmemb("Entradas/registradores.txt", register);
    end


    always @(*)begin
        ReadData1 <= register[ReadRegister1];
        ReadData2 <= register[ReadRegister2];
    end
    
    always@(*)begin //Para teste e verificação apenas.
		for(i = 0; i < 32; i = i + 1)begin
			$display("Register [%d]: %d", i, register[i]);
		end
			$display("-");
	end

  	always @(posedge clk) begin 
        if (WriteSignal) begin
            if(WriteRegister != 0) begin
            register[WriteRegister] <= WriteData;
            end
        end
    end
    
 endmodule
 